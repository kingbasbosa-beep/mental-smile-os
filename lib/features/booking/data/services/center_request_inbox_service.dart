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
    required String note,
    required String suggestedAlternativeLabelAr,
  }) async {
    final ref =
        FirebaseFirestore.instance.collection('booking_requests').doc(requestId);

    _log(
      operation: 'respond_read',
      documentId: requestId,
      centerId: centerId,
      status: 'center_follow_up',
      availabilityStatus: availabilityStatus,
    );

    try {
      final snap = await ref.get();
      if (!snap.exists) {
        throw Exception('Center request not found');
      }

      final data = snap.data() ?? const <String, dynamic>{};
      _log(
        operation: 'respond_update',
        documentId: requestId,
        centerId: centerId,
        status: (data['status'] ?? '').toString(),
        availabilityStatus: availabilityStatus,
      );

      await ref.update({
        'status': availabilityStatus == 'available'
            ? 'center_intake_pending'
            : (data['status'] ?? 'center_follow_up'),
        'workflowStage': availabilityStatus == 'available'
            ? 'center_intake_pending'
            : (data['workflowStage'] ?? data['status'] ?? 'center_follow_up'),
        'centerAvailabilityStatus': availabilityStatus,
        'centerAvailabilityNote': note.trim(),
        'centerSuggestedAlternativeKey':
            suggestedAlternativeLabelAr.trim().isEmpty
                ? ''
                : suggestedAlternativeLabelAr.trim(),
        'centerSuggestedAlternativeLabelAr': suggestedAlternativeLabelAr.trim(),
        'centerAvailabilityRespondedAt': FieldValue.serverTimestamp(),
        'centerAvailabilityRespondedBy': centerId,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      _log(
        operation: 'respond_success',
        documentId: requestId,
        centerId: centerId,
        status: 'center_follow_up',
        availabilityStatus: availabilityStatus,
      );
    } catch (e) {
      _log(
        operation: 'respond_error',
        documentId: requestId,
        centerId: centerId,
        status: 'center_follow_up',
        availabilityStatus: availabilityStatus,
        error: e,
      );
      rethrow;
    }
  }
}
