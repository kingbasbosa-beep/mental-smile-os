import 'package:cloud_firestore/cloud_firestore.dart';

class AdminApprovePaymentResult {
  const AdminApprovePaymentResult({required this.isCenterRequest});

  final bool isCenterRequest;
}

class AdminPaymentDecisionAdapter {
  AdminPaymentDecisionAdapter({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Map<String, dynamic> _withCanonicalWorkflowStage(
    Map<String, dynamic> updates,
  ) {
    final status = updates['status'];
    if (status is String &&
        status.trim().isNotEmpty &&
        !updates.containsKey('workflowStage')) {
      return {
        ...updates,
        'workflowStage': status,
      };
    }
    return updates;
  }

  Future<void> updateRequestEverywhere(
    String requestId,
    Map<String, dynamic> updates,
  ) async {
    final payload = {
      ..._withCanonicalWorkflowStage(updates),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    final ref = _firestore.collection('booking_requests').doc(requestId);
    final snap = await ref.get();
    if (snap.exists) {
      await ref.update(payload);
    }
  }

  Future<AdminApprovePaymentResult> approvePayment(String requestId) async {
    final snap =
        await _firestore.collection('booking_requests').doc(requestId).get();
    final data = snap.data() ?? const <String, dynamic>{};
    final isCenterRequest =
        (data['requestKind'] ?? '').toString().trim() == 'center' ||
            (data['centerId'] ?? '').toString().trim().isNotEmpty;
    await updateRequestEverywhere(requestId, {
      'status': isCenterRequest ? 'session_scheduled' : 'session_setup_pending',
      'paymentStatus': 'approved',
      'payment_confirmed': true,
      'paymentApprovedAt': FieldValue.serverTimestamp(),
      'sessionStatus': isCenterRequest ? 'scheduled' : 'not_created',
    });
    return AdminApprovePaymentResult(isCenterRequest: isCenterRequest);
  }

  Future<void> rejectPayment(String requestId) async {
    await updateRequestEverywhere(requestId, {
      'status': 'awaiting_payment',
      'paymentStatus': 'rejected',
      'payment_confirmed': false,
      'paymentRejectedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> confirmClinicianPayout(String requestId) async {
    await updateRequestEverywhere(requestId, {
      'status': 'completed_success',
      'sessionStatus': 'completed',
      'reviewStatus': 'completed',
      'payoutStatus': 'paid_to_clinician',
      'payoutTransferredAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> confirmCenterAccountingReview({
    required String requestId,
    required double gross,
    required double baseAmount,
    required double commissionPercent,
    required String note,
    required String adminUid,
  }) async {
    final commissionAmount = baseAmount * (commissionPercent / 100);
    final netAmount = baseAmount - commissionAmount;
    await updateRequestEverywhere(requestId, {
      'status': 'payout_pending',
      'accountingReviewStatus': 'confirmed',
      'grossClientPaidAmount': gross,
      'appCommissionPercent': commissionPercent,
      'appCommissionAmount': commissionAmount,
      'netAmountDueToCenter': netAmount,
      'accountingReviewNotes': note,
      'accountingConfirmedBy': adminUid,
      'accountingConfirmedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> confirmCenterPayout(String requestId) async {
    await updateRequestEverywhere(requestId, {
      'status': 'completed_success',
      'sessionStatus': 'completed',
      'reviewStatus': 'completed',
      'payoutStatus': 'paid_to_center',
      'payoutTransferredAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> sendToSessionArchive(String requestId) async {
    await updateRequestEverywhere(requestId, {
      'archived': true,
      'archivedAt': FieldValue.serverTimestamp(),
      'archiveSection': 'sessions',
      'archiveReady': true,
    });
  }

  Future<void> sendToFinancialArchive(String requestId) async {
    await updateRequestEverywhere(requestId, {
      'archived': true,
      'archivedAt': FieldValue.serverTimestamp(),
      'archiveSection': 'payments',
      'archiveReady': true,
    });
  }
}
