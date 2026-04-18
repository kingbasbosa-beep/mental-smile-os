import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

const String kDevClinicianUid =
    String.fromEnvironment('MK_DEV_CLINICIAN_UID', defaultValue: '');

class BookingRequestArgs {
  final String clinicianId;
  final String clinicianName;

  const BookingRequestArgs({
    required this.clinicianId,
    required this.clinicianName,
  });
}

class BookingRequestPage extends StatefulWidget {
  final BookingRequestArgs args;

  const BookingRequestPage({super.key, required this.args});

  @override
  State<BookingRequestPage> createState() => _BookingRequestPageState();
}

class _BookingRequestPageState extends State<BookingRequestPage> {
  final TextEditingController _noteCtrl = TextEditingController();
  bool _submitting = false;
  String? _result;

  bool get _isArabic =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> _readCurrentClientProfile(User user) async {
    final firestore = FirebaseFirestore.instance;
    final uid = user.uid;
    final email = (user.email ?? '').trim();

    final directDoc = await firestore.collection('clients').doc(uid).get();
    if (directDoc.exists && directDoc.data() != null) {
      return directDoc.data()!;
    }

    if (email.isNotEmpty) {
      final byEmail = await firestore
          .collection('clients')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (byEmail.docs.isNotEmpty) {
        return byEmail.docs.first.data();
      }
    }

    return <String, dynamic>{};
  }

  Future<int> _nextSequence(
      DocumentReference<Map<String, dynamic>> threadRef) async {
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

  Future<String> _createOrUpdateAdminThread({
    required String clientId,
    required String clientName,
    required String clientEmail,
    required String requestId,
    required String clinicianId,
    required String clinicianName,
    required String note,
  }) async {
    final firestore = FirebaseFirestore.instance;

    final existing = await firestore
        .collection('chat_threads')
        .where('ownerUid', isEqualTo: clientId)
        .where('archived', isEqualTo: false)
        .get();

    final now = FieldValue.serverTimestamp();
    final preview = note.isNotEmpty
        ? note
        : (_isArabic
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
      threadRef = firestore.collection('chat_threads').doc();
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
        'language': _isArabic ? 'ar' : 'en',
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

    final seq = await _nextSequence(threadRef);

    await threadRef.collection('messages').add({
      'threadId': threadRef.id,
      'senderType': 'user',
      'senderUid': clientId,
      'text': note.isNotEmpty
          ? note
          : (_isArabic
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

  Future<void> _submit() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() => _result =
          _isArabic ? 'يجب تسجيل الدخول أولًا' : 'Please sign in first');
      return;
    }

    setState(() {
      _submitting = true;
      _result = null;
    });

    try {
      final firestore = FirebaseFirestore.instance;
      final uid = user.uid;
      final profile = await _readCurrentClientProfile(user);

      final clientName = ((profile['displayName'] ??
                  profile['name'] ??
                  profile['fullName'] ??
                  user.displayName ??
                  'Client')
              .toString())
          .trim();

      final clientEmail =
          ((profile['email'] ?? user.email ?? '').toString()).trim();
      final note = _noteCtrl.text.trim();
      final now = Timestamp.now();

      final requestRef = firestore.collection('booking_requests').doc();

      final requestData = {
        'requestId': requestRef.id,
        'requestKind': 'clinician',
        'clientId': uid,
        'clientName': clientName,
        'clientEmail': clientEmail,
        // Canonical ownership field.
        'assignedClinicianId': widget.args.clinicianId,
        'assignedClinicianName': widget.args.clinicianName,
        'clinicianId': widget.args.clinicianId,
        'clinicianName': widget.args.clinicianName,
        // Legacy compatibility field.
        'clinicianUid': widget.args.clinicianId,
        'status': 'pending_admin',
        'workflowStage': 'pending_admin',
        'createdAt': now,
        'updatedAt': now,
        'note': note,
        'adminForwarded': false,
        'adminAssignedBy': '',
        'adminAssignedAt': null,
        'source': 'client_dashboard',
      };

      await requestRef.set(requestData);
      await firestore
          .collection('bookingRequests')
          .doc(requestRef.id)
          .set(requestData);

      final threadId = await _createOrUpdateAdminThread(
        clientId: uid,
        clientName: clientName,
        clientEmail: clientEmail,
        requestId: requestRef.id,
        clinicianId: widget.args.clinicianId,
        clinicianName: widget.args.clinicianName,
        note: note,
      );

      await requestRef.update({
        'threadId': threadId,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      await firestore.collection('bookingRequests').doc(requestRef.id).update({
        'threadId': threadId,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      setState(() => _result =
          _isArabic ? 'تم إرسال الطلب بنجاح' : 'Request sent successfully');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic
                ? 'تم إرسال الطلب وفتح محادثة المتابعة مع الإدارة'
                : 'Request sent and admin follow-up chat opened',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() =>
          _result = _isArabic ? 'تعذر إرسال الطلب' : 'Failed to send request');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isArabic ? 'فشل الإرسال: $e' : 'Send failed: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  String _initials(String name) {
    final parts = name.trim().split(' ').where((e) => e.isNotEmpty).toList();
    if (parts.isEmpty) return _isArabic ? 'أ' : 'S';
    if (parts.length == 1) return parts.first[0];
    return '${parts.first[0]}${parts.last[0]}';
  }

  String _safePhotoUrl(String raw) {
    final u = raw.trim();
    if (u.isEmpty) return '';
    final uri = Uri.tryParse(u);
    if (uri == null) return '';
    if (!uri.hasScheme) return '';
    return u;
  }

  String _safeAssetPath(String raw) {
    final v = raw.trim();
    if (v.isEmpty) return '';
    if (!v.startsWith('assets/')) return '';
    return v;
  }

  Widget _buildClinicianAvatar(
    BuildContext context, {
    required String clinicianName,
    required String photoAsset,
    required String photoUrl,
  }) {
    final asset = _safeAssetPath(photoAsset);
    final network = _safePhotoUrl(photoUrl);

    if (network.isNotEmpty) {
      return CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(network),
      );
    }

    if (asset.isNotEmpty) {
      return CircleAvatar(
        radius: 28,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: ClipOval(
          child: Image.asset(
            normalizeAssetPath(asset),
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Text(
                  _initials(clinicianName),
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              );
            },
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: 28,
      child: Text(
        _initials(clinicianName),
        style: const TextStyle(fontWeight: FontWeight.w800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Directionality(
      textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isArabic ? 'طلب حجز' : 'Booking request'),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('clinicians')
                  .doc(widget.args.clinicianId)
                  .snapshots(),
              builder: (context, snapshot) {
                final data = snapshot.data?.data() ?? <String, dynamic>{};
                final displayName =
                    (data['displayName'] ?? widget.args.clinicianName)
                        .toString();
                final photoAsset = (data['photoAsset'] ?? '').toString();
                final photoUrl =
                    (data['photoUrl'] ?? data['photo_url'] ?? '').toString();

                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: scheme.outline.withValues(alpha: 0.14),
                        ),
                      ),
                      child: Row(
                        children: [
                          _buildClinicianAvatar(
                            context,
                            clinicianName: displayName,
                            photoAsset: photoAsset,
                            photoUrl: photoUrl,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: _isArabic
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  displayName,
                                  textAlign: _isArabic
                                      ? TextAlign.right
                                      : TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _isArabic
                                      ? 'سيتم إرسال طلبك أولًا إلى الإدارة ثم تحويله إلى الأخصائي المناسب.'
                                      : 'Your request will be sent to admin first, then assigned to the suitable specialist.',
                                  textAlign: _isArabic
                                      ? TextAlign.right
                                      : TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: scheme.outline.withValues(alpha: 0.14),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: _isArabic
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isArabic ? 'ملاحظات إضافية' : 'Additional notes',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _isArabic
                                ? 'اكتب أي تفاصيل تريد أن تصل إلى الإدارة أو الأخصائي.'
                                : 'Write any details you want admin or the specialist to receive.',
                            textAlign:
                                _isArabic ? TextAlign.right : TextAlign.left,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _noteCtrl,
                            textDirection: _isArabic
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            decoration: InputDecoration(
                              hintText: _isArabic
                                  ? 'اكتب ملاحظتك هنا...'
                                  : 'Write your note here...',
                              border: const OutlineInputBorder(),
                            ),
                            maxLines: 5,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 54,
                      child: FilledButton.icon(
                        onPressed: _submitting ? null : _submit,
                        icon: _submitting
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.send_outlined),
                        label: Text(
                          _submitting
                              ? (_isArabic ? 'جارٍ الإرسال...' : 'Sending...')
                              : (_isArabic ? 'إرسال الطلب' : 'Send request'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_result != null)
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          _result!,
                          textAlign:
                              _isArabic ? TextAlign.right : TextAlign.left,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
