import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class CenterInboxRequest {
  final String id;
  final Map<String, dynamic> data;

  const CenterInboxRequest({
    required this.id,
    required this.data,
  });
}

class CenterRequestInboxService {
  const CenterRequestInboxService();

  void _log({
    required String operation,
    required String collection,
    String? documentId,
    String? requestKind,
    String? status,
    String? writeStatus,
    Object? error,
  }) {
    final user = FirebaseAuth.instance.currentUser;
    debugPrint(
      'CENTER_FLOW page=center_inbox role=center uid=${user?.uid ?? 'null'} '
      'op=$operation collection=$collection doc=${documentId ?? '-'} '
      'requestKind=${requestKind ?? '-'} status=${status ?? '-'} '
      'writeStatus=${writeStatus ?? '-'} error=${error ?? '-'}',
    );
  }

  Stream<List<CenterInboxRequest>> watchRequestsForCenter(String centerId) {
    _log(
      operation: 'stream_start',
      collection: 'booking_requests',
      requestKind: 'center',
      status: 'center_follow_up',
    );

    return FirebaseFirestore.instance
        .collection('booking_requests')
        .where('centerId', isEqualTo: centerId)
        .where('requestKind', isEqualTo: 'center')
        .where('status', isEqualTo: 'center_follow_up')
        .snapshots()
        .map((snap) {
      _log(
        operation: 'stream_data',
        collection: 'booking_requests',
        requestKind: 'center',
        status: 'center_follow_up',
      );

      final docs = snap.docs.where((doc) {
        final requestKind = (doc.data()['requestKind'] ?? '').toString().trim();
        return requestKind == 'center';
      }).toList()
        ..sort((a, b) => _moment(b.data()['createdAt'])
            .compareTo(_moment(a.data()['createdAt'])));

      return docs
          .map((doc) => CenterInboxRequest(id: doc.id, data: doc.data()))
          .toList();
    });
  }

  Future<void> respondToAvailability({
    required String requestId,
    required String responderCenterId,
    required String availabilityStatus,
    required String note,
  }) async {
    final db = FirebaseFirestore.instance;
    final payload = <String, dynamic>{
      'centerAvailabilityStatus': availabilityStatus,
      'centerAvailabilityNote': note,
      'centerAvailabilityRespondedAt': FieldValue.serverTimestamp(),
      'centerAvailabilityRespondedBy': responderCenterId,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    final refs = [
      db.collection('booking_requests').doc(requestId),
      db.collection('bookingRequests').doc(requestId),
    ];

    for (final ref in refs) {
      try {
        _log(
          operation: 'read',
          collection: ref.parent.id,
          documentId: requestId,
          requestKind: 'center',
          status: 'center_follow_up',
          writeStatus: availabilityStatus,
        );
        final snap = await ref.get();
        if (snap.exists) {
          _log(
            operation: 'update',
            collection: ref.parent.id,
            documentId: requestId,
            requestKind: (snap.data()?['requestKind'] ?? '').toString(),
            status: (snap.data()?['status'] ?? '').toString(),
            writeStatus: availabilityStatus,
          );
          await ref.update(payload);
        }
      } catch (e) {
        _log(
          operation: 'update_error',
          collection: ref.parent.id,
          documentId: requestId,
          requestKind: 'center',
          status: 'center_follow_up',
          writeStatus: availabilityStatus,
          error: e,
        );
        rethrow;
      }
    }
  }

  static DateTime _moment(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value) ?? DateTime(1970);
    return DateTime(1970);
  }
}
