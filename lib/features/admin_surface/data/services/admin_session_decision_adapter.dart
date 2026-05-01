import 'package:cloud_firestore/cloud_firestore.dart';

class AdminSessionDecisionAdapter {
  AdminSessionDecisionAdapter({FirebaseFirestore? firestore})
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

  Future<void> scheduleSession({
    required String requestId,
    required String dateText,
    required String linkText,
    required String codeText,
    required String notesText,
  }) async {
    await updateRequestEverywhere(requestId, {
      'status': 'session_scheduled',
      'sessionStatus': 'scheduled',
      'sessionDateText': dateText,
      'sessionLink': linkText,
      'sessionCode': codeText,
      'sessionAdminNotes': notesText,
      'sessionCreatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> scheduleCenterResidency({
    required String requestId,
    required String startText,
    required String endText,
    required int durationDays,
    required String durationReasonText,
    required String linkText,
    required String codeText,
    required String notesText,
    required double unitPrice,
    required String pricingUnit,
    required double baseAmount,
    required double taxPercent,
    required double taxAmount,
    required double totalAmount,
    required String paymentBreakdownText,
    required String adminUid,
  }) async {
    await updateRequestEverywhere(requestId, {
      'status': 'awaiting_payment',
      'workflowStage': 'awaiting_payment',
      'paymentStatus': 'pending_client_transfer',
      'payment_confirmed': false,
      'sessionStatus': 'not_created',
      'stayStartDateText': startText,
      'stayEndDateText': endText,
      'stayDurationDays': durationDays,
      'stayDurationReason': durationReasonText,
      'stayDurationIsPreliminary': true,
      'sessionDateText': startText,
      'sessionLink': linkText,
      'sessionCode': codeText,
      'sessionAdminNotes': notesText,
      'stayUnitPrice': unitPrice,
      'stayPricingUnit': pricingUnit,
      'stayBaseAmount': baseAmount,
      'stayTaxPercent': taxPercent,
      'stayTaxAmount': taxAmount,
      'stayTotalAmount': totalAmount,
      'grossClientPaidAmount': totalAmount,
      'paymentBreakdownText': paymentBreakdownText,
      'paymentQuotePreparedAt': FieldValue.serverTimestamp(),
      'paymentQuotePreparedBy': adminUid,
    });
  }

  Future<void> markInProgress(String requestId) async {
    await updateRequestEverywhere(requestId, {
      'status': 'session_in_progress',
      'sessionStatus': 'in_progress',
    });
  }

  Future<void> markCompleted(String requestId) async {
    await updateRequestEverywhere(requestId, {
      'status': 'session_completed_pending_reviews',
      'sessionStatus': 'completed',
      'reviewStatus': 'pending_reviews',
    });
  }

  Future<void> moveToReschedule(String requestId) async {
    await updateRequestEverywhere(requestId, {
      'status': 'reschedule_pending',
      'sessionStatus': 'reschedule_pending',
    });
  }
}
