import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingLegacyChatAdapter {
  BookingLegacyChatAdapter({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  bool _isMissingThreadType(Map<String, dynamic> data) {
    final threadType = (data['threadType'] ?? '').toString().trim();
    return threadType.isEmpty;
  }

  bool _isTypedBookingFollowupThread(Map<String, dynamic> data) {
    return (data['threadType'] ?? '').toString().trim() == 'booking_followup';
  }

  QueryDocumentSnapshot<Map<String, dynamic>>? _pickReusableBookingThread(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    QueryDocumentSnapshot<Map<String, dynamic>>? typed;
    QueryDocumentSnapshot<Map<String, dynamic>>? legacyMissingType;
    DateTime typedUpdatedAt = DateTime.fromMillisecondsSinceEpoch(0);
    DateTime legacyUpdatedAt = DateTime.fromMillisecondsSinceEpoch(0);

    for (final doc in docs) {
      final data = doc.data();
      final rawUpdatedAt = data['updatedAt'];
      final updatedAt = rawUpdatedAt is Timestamp
          ? rawUpdatedAt.toDate()
          : DateTime.fromMillisecondsSinceEpoch(0);

      if (_isTypedBookingFollowupThread(data)) {
        if (typed == null || updatedAt.isAfter(typedUpdatedAt)) {
          typed = doc;
          typedUpdatedAt = updatedAt;
        }
        continue;
      }

      if (_isMissingThreadType(data)) {
        if (legacyMissingType == null || updatedAt.isAfter(legacyUpdatedAt)) {
          legacyMissingType = doc;
          legacyUpdatedAt = updatedAt;
        }
      }
    }

    return typed ?? legacyMissingType;
  }

  Future<int> _nextSequenceForBookingRequest(
    DocumentReference<Map<String, dynamic>> threadRef,
  ) async {
    final latest = await threadRef
        .collection('messages')
        .orderBy('sequenceNumber', descending: true)
        .limit(1)
        .get();

    if (latest.docs.isEmpty) return 1;
    final data = latest.docs.first.data();
    final current = data['sequenceNumber'];
    if (current is int) return current + 1;
    return 2;
  }

  Future<int> _nextSequenceForAdminQueue(
    DocumentReference<Map<String, dynamic>> threadRef,
  ) async {
    final latest = await threadRef
        .collection('messages')
        .orderBy('sequenceNumber', descending: true)
        .limit(1)
        .get();

    if (latest.docs.isEmpty) return 1;
    final current = latest.docs.first.data()['sequenceNumber'];
    if (current is int) {
      return current + 1;
    }
    return (int.tryParse('$current') ?? 0) + 1;
  }

  Future<String> createOrUpdateAdminThreadForBooking({
    required String clientId,
    required String clientName,
    required String clientEmail,
    required String requestId,
    required String clinicianId,
    required String clinicianName,
    required String note,
    required bool isArabic,
  }) async {
    final existing = await _firestore
        .collection('chat_threads')
        .where('ownerUid', isEqualTo: clientId)
        .where('archived', isEqualTo: false)
        .get();

    final now = FieldValue.serverTimestamp();
    final preview = note.isNotEmpty
        ? note
        : (isArabic
            ? 'تم إنشاء طلب حجز جديد'
            : 'A new booking request was created');

    DocumentReference<Map<String, dynamic>> threadRef;

    final reusableThread = _pickReusableBookingThread(existing.docs);

    if (reusableThread != null) {
      threadRef = reusableThread.reference;
      await threadRef.update({
        'threadType': 'booking_followup',
        'updatedAt': now,
        'lastMessageAt': now,
        'lastMessagePreview': preview,
        'assignedAdminUid': '',
        'handoffState': 'admin_review',
        'lifecycleState': 'assigned_admin',
        'bookingLinked': true,
        'bookingRequestId': requestId,
      });
    } else {
      threadRef = _firestore.collection('chat_threads').doc();
      await threadRef.set({
        'ownerUid': clientId,
        'ownerType': 'registered_client',
        'displayName': clientEmail.isNotEmpty ? clientEmail : clientName,
        'status': 'active',
        'threadType': 'booking_followup',
        'sourceType': 'booking_flow',
        'createdAt': now,
        'updatedAt': now,
        'lastMessageAt': now,
        'lastMessagePreview': preview,
        'messageCount': 0,
        'isTemporary': false,
        'convertedToOfficialClient': true,
        'officialClientUid': clientId,
        'bookingLinked': true,
        'bookingRequestId': requestId,
        'assignedClinicianUid': clinicianId,
        'assignedAdminUid': '',
        'needsHumanSupport': true,
        'escalationLevel': 'recommended',
        'archived': false,
        'closedAt': null,
        'language': isArabic ? 'ar' : 'en',
        'lifecycleState': 'assigned_admin',
        'identityState': 'registered_client',
        'safetyState': 'monitor',
        'handoffState': 'admin_review',
        'riskScore': 0,
        'riskLevel': 'low',
        'strategyMode': 'containment',
        'lastEmotionalStates': const [],
        'lastDetectedRole': null,
      });
    }

    final seq = await _nextSequenceForBookingRequest(threadRef);

    await threadRef.collection('messages').add({
      'threadId': threadRef.id,
      'senderType': 'user',
      'senderUid': clientId,
      'text': note.isNotEmpty
          ? note
          : (isArabic
              ? 'تم إرسال طلب حجز إلى الإدارة'
              : 'A booking request was sent to admin'),
      'createdAt': FieldValue.serverTimestamp(),
      'sequenceNumber': seq,
      'visibleToUser': true,
      'messageKind': 'booking_request',
      'roleDetected': null,
      'statesDetected': const [],
      'riskScore': 0,
      'riskLevel': 'low',
      'strategyMode': 'containment',
      'safetyTriggered': false,
      'containsEscalationSignal': false,
      'aiModelVersion': null,
      'systemVersion': 'booking_v1',
      'metadata': {
        'requestId': requestId,
        'clinicianId': clinicianId,
        'clinicianName': clinicianName,
      },
    });

    await threadRef.update({
      'messageCount': FieldValue.increment(1),
      'updatedAt': FieldValue.serverTimestamp(),
      'lastMessageAt': FieldValue.serverTimestamp(),
      'lastMessagePreview':
          preview.length > 120 ? preview.substring(0, 120) : preview,
    });

    return threadRef.id;
  }

  Future<void> linkBookingToThread({
    required String threadId,
    required String requestId,
  }) async {
    await _firestore.collection('chat_threads').doc(threadId).update({
      'bookingLinked': true,
      'bookingRequestId': requestId,
    });
  }

  Future<bool> appendAdminQueueMessage({
    required String threadId,
    required String requestId,
    required String text,
  }) async {
    final threadRef = _firestore.collection('chat_threads').doc(threadId);
    final chatThreadsSnap = await threadRef.get();
    if (!chatThreadsSnap.exists) {
      return false;
    }

    final nextSequence = await _nextSequenceForAdminQueue(threadRef);

    await threadRef.collection('messages').add({
      'threadId': threadId,
      'senderType': 'admin',
      'senderUid': FirebaseAuth.instance.currentUser?.uid ?? '',
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
      'sequenceNumber': nextSequence,
      'visibleToUser': true,
      'messageKind': 'admin_update',
      'roleDetected': null,
      'statesDetected': const [],
      'riskScore': 0,
      'riskLevel': 'low',
      'strategyMode': 'containment',
      'safetyTriggered': false,
      'containsEscalationSignal': false,
      'aiModelVersion': null,
      'systemVersion': 'admin_queue_v1',
      'metadata': {
        'requestId': requestId,
        'source': 'admin_booking_queue',
      },
    });

    await threadRef.update({
      'lastMessagePreview': text.length > 120 ? text.substring(0, 120) : text,
      'lastMessageAt': FieldValue.serverTimestamp(),
      'messageCount': FieldValue.increment(1),
      'lastSenderType': 'admin',
      'handoffState': 'admin_replying',
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return true;
  }
}
