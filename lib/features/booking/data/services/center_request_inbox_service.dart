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

  static const List<String> _actionableStatuses = <String>[
    'pending_admin',
    'center_follow_up',
    'session_setup_pending',
    'session_scheduled',
    'reschedule_pending',
  ];

  void _log({
    required String operation,
    String? documentId,
    String? centerId,
    String? status,
    String? availabilityStatus,
    Object? error,
  }) {
    final user = FirebaseAuth.instance.currentUser;
    debugPrint(
      'CENTER_FLOW page=center_inbox role=center '
      'uid=${user?.uid ?? 'null'} '
      'op=$operation '
      'collection=booking_requests '
      'doc=${documentId ?? '-'} '
      'centerId=${centerId ?? '-'} '
      'status=${status ?? '-'} '
      'availabilityStatus=${availabilityStatus ?? '-'} '
      'error=${error ?? '-'}',
    );
  }

  Stream<List<CenterInboxRequest>> watchRequestsForCenter(String centerId) {
    _log(
      operation: 'stream_start',
      centerId: centerId,
      status: _actionableStatuses.join(','),
    );

    return FirebaseFirestore.instance
        .collection('booking_requests')
        .where('centerId', isEqualTo: centerId)
        .where('requestKind', isEqualTo: 'center')
        .where('status', whereIn: _actionableStatuses)
        .snapshots()
        .map((snap) {
      _log(
        operation: 'stream_data',
        centerId: centerId,
        status: _actionableStatuses.join(','),
      );

      final requests = snap.docs
          .map((doc) => CenterInboxRequest(id: doc.id, data: doc.data()))
          .toList()
        ..sort((a, b) {
          DateTime moment(Map<String, dynamic> data) {
            final value = data['updatedAt'] ?? data['createdAt'];
            if (value is Timestamp) return value.toDate();
            if (value is DateTime) return value;
            if (value is String) {
              return DateTime.tryParse(value) ?? DateTime(1970);
            }
            return DateTime(1970);
          }

          return moment(b.data).compareTo(moment(a.data));
        });

      return requests;
    }).handleError((error) {
      _log(
        operation: 'stream_error',
        centerId: centerId,
        status: _actionableStatuses.join(','),
        error: error,
      );
    });
  }

  Future<void> respondToAvailability({
    required String requestId,
    required String centerId,
    required String availabilityStatus,
  }) async {
    final normalizedAvailabilityStatus =
        availabilityStatus.trim().toLowerCase();
    if (normalizedAvailabilityStatus != 'available' &&
        normalizedAvailabilityStatus != 'unavailable') {
      throw ArgumentError(
        'Invalid availabilityStatus: $availabilityStatus',
      );
    }

    final ref = FirebaseFirestore.instance
        .collection('booking_requests')
        .doc(requestId);

    _log(
      operation: 'respond_read',
      documentId: requestId,
      centerId: centerId,
      status: 'center_follow_up',
      availabilityStatus: normalizedAvailabilityStatus,
    );

    try {
      final snap = await ref.get();
      if (!snap.exists) {
        throw Exception('Center request not found');
      }

      final data = snap.data() ?? const <String, dynamic>{};
      final requestCenterId = (data['centerId'] ?? '').toString().trim();
      final requestKind = (data['requestKind'] ?? '').toString().trim();
      if (requestCenterId != centerId || requestKind != 'center') {
        throw Exception('Center request ownership mismatch');
      }

      _log(
        operation: 'respond_update',
        documentId: requestId,
        centerId: centerId,
        status: (data['status'] ?? '').toString(),
        availabilityStatus: normalizedAvailabilityStatus,
      );

      await ref.update({
        'centerAvailabilityStatus': normalizedAvailabilityStatus,
        'centerAvailabilityUpdatedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      _log(
        operation: 'respond_success',
        documentId: requestId,
        centerId: centerId,
        status: 'center_follow_up',
        availabilityStatus: normalizedAvailabilityStatus,
      );
    } catch (e) {
      _log(
        operation: 'respond_error',
        documentId: requestId,
        centerId: centerId,
        status: 'center_follow_up',
        availabilityStatus: normalizedAvailabilityStatus,
        error: e,
      );
      rethrow;
    }
  }
}
