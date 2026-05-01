import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

typedef AdminBookingRefreshAuthCallback = Future<void> Function({
  required String stage,
  required String requestId,
});

typedef AdminBookingLogCallback = void Function({
  required String page,
  required String role,
  required String operation,
  required String collection,
  String? documentId,
  String? requestKind,
  String? status,
  String? writeStatus,
  Object? error,
});

class AdminApprovePaymentResult {
  const AdminApprovePaymentResult({required this.isCenterRequest});

  final bool isCenterRequest;
}

class AdminAssignClinicianResult {
  const AdminAssignClinicianResult({
    required this.alreadyAssigned,
    required this.clinicianName,
  });

  final bool alreadyAssigned;
  final String clinicianName;
}

class AdminBookingDecisionAdapter {
  AdminBookingDecisionAdapter({
    FirebaseFirestore? firestore,
    this.refreshAuthContextForFirestore,
    this.logFirestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;
  final AdminBookingRefreshAuthCallback? refreshAuthContextForFirestore;
  final AdminBookingLogCallback? logFirestore;

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

  void _log({
    required String operation,
    required String collection,
    String? documentId,
    String? requestKind,
    String? status,
    String? writeStatus,
    Object? error,
  }) {
    logFirestore?.call(
      page: 'admin_booking_queue',
      role: 'admin',
      operation: operation,
      collection: collection,
      documentId: documentId,
      requestKind: requestKind,
      status: status,
      writeStatus: writeStatus,
      error: error,
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> readPrimaryBookingRequest(
    String requestId,
  ) async {
    final ref = _firestore.collection('booking_requests').doc(requestId);
    _log(
      operation: 'read',
      collection: 'booking_requests',
      documentId: requestId,
    );
    return ref.get();
  }

  Future<void> updateRequestEverywhere(
    String requestId,
    Map<String, dynamic> updates,
  ) async {
    final nowUpdates = {
      ..._withCanonicalWorkflowStage(updates),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    final refs = [
      _firestore.collection('booking_requests').doc(requestId),
    ];

    debugPrint(
      'CENTER_FLOW_ASSIGN_TRACE '
      'requestId=$requestId '
      'targets=${refs.map((ref) => ref.path).join(",")} '
      'legacyMirrorAttempted=false '
      'finalUpdate=$nowUpdates',
    );

    for (final ref in refs) {
      try {
        _log(
          operation: 'read',
          collection: ref.parent.id,
          documentId: requestId,
          writeStatus: (updates['status'] ?? '').toString(),
        );
        final snap = await ref.get();
        if (snap.exists) {
          final data = snap.data() ?? <String, dynamic>{};
          debugPrint(
            'CENTER_FLOW_ASSIGN_RESOURCE_TRACE '
            'requestId=$requestId '
            'path=${ref.path} '
            'resourceSnapshot=${{
              'requestKind': data['requestKind'],
              'status': data['status'],
              'workflowStage': data['workflowStage'],
              'clientId': data['clientId'],
              'clientName': data['clientName'],
              'createdAt': data['createdAt'],
              'note': data['note'],
              'clinicianId': data['clinicianId'],
              'clinicianName': data['clinicianName'],
              'clinicianUid': data['clinicianUid'],
              'assignedClinicianId': data['assignedClinicianId'],
              'assignedClinicianName': data['assignedClinicianName'],
              'adminForwarded': data['adminForwarded'],
              'adminAssignedBy': data['adminAssignedBy'],
              'adminAssignedAt': data['adminAssignedAt'],
            }}',
          );
          _log(
            operation: 'update',
            collection: ref.parent.id,
            documentId: requestId,
            requestKind: (data['requestKind'] ?? '').toString(),
            status: (data['status'] ?? '').toString(),
            writeStatus: (updates['status'] ?? '').toString(),
          );
          await ref.update(nowUpdates);
        }
      } catch (e) {
        _log(
          operation: 'update_error',
          collection: ref.parent.id,
          documentId: requestId,
          writeStatus: (updates['status'] ?? '').toString(),
          error: e,
        );
        rethrow;
      }
    }
  }

  Future<void> updatePrimaryCenterRequest(
    String requestId,
    Map<String, dynamic> updates,
  ) async {
    final ref = _firestore.collection('booking_requests').doc(requestId);
    final nowUpdates = {
      ..._withCanonicalWorkflowStage(updates),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    try {
      if (refreshAuthContextForFirestore != null) {
        await refreshAuthContextForFirestore!(
          stage: '_updatePrimaryCenterRequest',
          requestId: requestId,
        );
      }
      final snap = await readPrimaryBookingRequest(requestId);
      if (!snap.exists) {
        throw Exception('Center request not found');
      }
      final data = snap.data() ?? <String, dynamic>{};
      print(
        'CENTER_FOLLOWUP_TRACE '
        'requestId=$requestId '
        'currentAuthUid=${FirebaseAuth.instance.currentUser?.uid ?? ''} '
        'resourceRequestKind=${(data['requestKind'] ?? '').toString()} '
        'resourceStatus=${(data['status'] ?? '').toString()} '
        'resourceClientUpdatedAfterCenterFeedback=${data['clientUpdatedAfterCenterFeedback']} '
        'writeStatus=${(nowUpdates['status'] ?? '').toString()} '
        'writeWorkflowStage=${(nowUpdates['workflowStage'] ?? '').toString()} '
        'writeAdminDecisionType=${(nowUpdates['adminDecisionType'] ?? '').toString()} '
        'writeCenterAdminHandledBy=${(nowUpdates['centerAdminHandledBy'] ?? '').toString()}',
      );
      _log(
        operation: 'update',
        collection: 'booking_requests',
        documentId: requestId,
        requestKind: (data['requestKind'] ?? '').toString(),
        status: (data['status'] ?? '').toString(),
        writeStatus: (updates['status'] ?? '').toString(),
      );
      print(
        'CENTER_AUTH_TRACE '
        'stage=_updatePrimaryCenterRequest '
        'requestId=$requestId '
        'phase=before_firestore_update '
        'currentUserExists=${FirebaseAuth.instance.currentUser != null} '
        'currentUserUid=${FirebaseAuth.instance.currentUser?.uid ?? ''} '
        'afterRefresh=true',
      );
      await ref.update(nowUpdates);
      _log(
        operation: 'transition_success',
        collection: 'booking_requests',
        documentId: requestId,
        requestKind: 'center',
        status: (data['status'] ?? '').toString(),
        writeStatus: (updates['status'] ?? '').toString(),
      );
    } catch (e) {
      print(
        'CENTER_FOLLOWUP_TRACE_ERROR '
        'requestId=$requestId '
        'currentAuthUid=${FirebaseAuth.instance.currentUser?.uid ?? ''} '
        'error=$e',
      );
      _log(
        operation: 'update_error',
        collection: 'booking_requests',
        documentId: requestId,
        requestKind: 'center',
        writeStatus: (updates['status'] ?? '').toString(),
        error: e,
      );
      rethrow;
    }
  }

  Future<void> rejectRequest({
    required String requestId,
    required bool isCenterRequest,
    required String adminUid,
  }) async {
    final payload = {
      'status': 'rejected_admin',
      'workflowStage': 'rejected_admin',
      'adminApproved': false,
      'adminRejected': true,
      'adminForwarded': false,
      'adminDecisionType': 'rejected',
      'adminDecisionBy': adminUid,
      'adminDecisionAt': FieldValue.serverTimestamp(),
      'adminAssignedBy': adminUid,
      'adminAssignedAt': FieldValue.serverTimestamp(),
      'paymentStatus': 'blocked',
      'payment_confirmed': false,
      'sessionStatus': 'cancelled',
      'reviewStatus': 'blocked',
      'payoutStatus': 'blocked',
    };
    if (isCenterRequest) {
      await updatePrimaryCenterRequest(requestId, payload);
      return;
    }
    await updateRequestEverywhere(requestId, payload);
  }

  Future<void> returnToPending({
    required String requestId,
    required String adminUid,
  }) async {
    await updateRequestEverywhere(requestId, {
      'status': 'pending_admin',
      'workflowStage': 'pending_admin',
      'adminApproved': false,
      'adminRejected': false,
      'adminForwarded': false,
      'adminAssignedBy': '',
      'adminAssignedAt': null,
      'adminDecisionType': 'returned_to_pending',
      'adminDecisionBy': adminUid,
      'adminDecisionAt': FieldValue.serverTimestamp(),
      'assignedClinicianId': '',
      'assignedClinicianName': '',
      'clinicianId': '',
      'clinicianName': '',
      'clinicianUid': '',
      'paymentStatus': 'not_started',
      'payment_confirmed': false,
      'sessionStatus': 'not_created',
      'reviewStatus': 'not_started',
      'payoutStatus': 'blocked',
    });
  }

  Future<void> moveCenterToFollowUp({
    required String requestId,
    required String adminUid,
  }) async {
    if (refreshAuthContextForFirestore != null) {
      await refreshAuthContextForFirestore!(
        stage: '_moveCenterToFollowUp',
        requestId: requestId,
      );
    }
    print(
      'CENTER_FOLLOWUP_TRACE '
      'requestId=$requestId '
      'currentAuthUid=${FirebaseAuth.instance.currentUser?.uid ?? ''} '
      'payloadCenterAdminHandledBy=${FirebaseAuth.instance.currentUser?.uid ?? ''} '
      'writeStatus=center_follow_up '
      'writeWorkflowStage=center_follow_up '
      'writeAdminDecisionType=center_follow_up '
      'afterRefresh=true',
    );
    _log(
      operation: 'action_start',
      collection: 'booking_requests',
      documentId: requestId,
      requestKind: 'center',
      status: 'pending_admin',
      writeStatus: 'center_follow_up',
    );
    await updatePrimaryCenterRequest(requestId, {
      'status': 'center_follow_up',
      'workflowStage': 'center_follow_up',
      'adminApproved': false,
      'adminRejected': false,
      'adminForwarded': false,
      'adminDecisionType': 'center_follow_up',
      'adminDecisionBy': adminUid,
      'adminDecisionAt': FieldValue.serverTimestamp(),
      'adminAssignedBy': adminUid,
      'adminAssignedAt': FieldValue.serverTimestamp(),
      'centerAdminHandledBy': adminUid,
      'centerAdminHandledAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> openCenterIntakeStep({
    required String requestId,
    required String adminUid,
  }) async {
    await updatePrimaryCenterRequest(requestId, {
      'status': 'center_intake_pending',
      'workflowStage': 'center_intake_pending',
      'adminDecisionType': 'center_intake_opened',
      'adminDecisionBy': adminUid,
      'adminDecisionAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> approveCenterRequest({
    required String requestId,
    required String adminUid,
  }) async {
    await updatePrimaryCenterRequest(requestId, {
      'status': 'session_setup_pending',
      'workflowStage': 'session_setup_pending',
      'adminApproved': true,
      'adminRejected': false,
      'adminForwarded': false,
      'adminDecisionType': 'approved',
      'adminDecisionBy': adminUid,
      'adminDecisionAt': FieldValue.serverTimestamp(),
      'adminAssignedBy': adminUid,
      'adminAssignedAt': FieldValue.serverTimestamp(),
      'paymentStatus': 'pending_client_transfer',
      'sessionStatus': 'not_created',
      'reviewStatus': 'not_started',
      'payoutStatus': 'blocked',
      'assignedClinicianId': '',
      'assignedClinicianName': '',
      'clinicianId': '',
      'clinicianName': '',
      'clinicianUid': '',
    });
  }

  Future<void> returnCenterRequestToClient({
    required String requestId,
    required Map<String, dynamic> data,
    required String adminUid,
  }) async {
    final revision = data['clientRevisionNumber'];
    final revisionNumber =
        revision is num ? revision.toInt() : int.tryParse('$revision') ?? 0;
    await updatePrimaryCenterRequest(requestId, {
      'status': 'client_update_required',
      'workflowStage': 'client_update_required',
      'lastCenterAvailabilityStatus':
          (data['centerAvailabilityStatus'] ?? '').toString(),
      'lastCenterAvailabilityNote':
          (data['centerAvailabilityNote'] ?? '').toString(),
      'lastCenterSuggestedAlternativeKey':
          (data['centerSuggestedAlternativeKey'] ?? '').toString(),
      'lastCenterSuggestedAlternativeLabelAr':
          (data['centerSuggestedAlternativeLabelAr'] ?? '').toString(),
      'lastCenterFeedbackRevisionNumber': revisionNumber,
      'adminCanApproveWithoutCenterRecheck': false,
      'adminDecisionType': 'returned_to_client',
      'adminDecisionBy': adminUid,
      'adminDecisionAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> confirmCenterAccountingReview({
    required String requestId,
    required double gross,
    required double commissionPercent,
    required String note,
    required String adminUid,
  }) async {
    final commissionAmount = gross * (commissionPercent / 100);
    final netAmount = gross - commissionAmount;
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

  Future<void> confirmCenterPayout({
    required String requestId,
  }) async {
    await updateRequestEverywhere(requestId, {
      'status': 'completed_success',
      'workflowStage': 'completed_success',
      'sessionStatus': 'completed',
      'reviewStatus': 'completed',
      'payoutStatus': 'paid_to_center',
      'payoutTransferredAt': FieldValue.serverTimestamp(),
    });
  }

  @Deprecated('Payment authority moved to AdminPaymentDecisionAdapter. Use that adapter for payment decisions.')
  Future<AdminApprovePaymentResult> approvePayment({
    required String requestId,
  }) async {
    final snap = await _firestore.collection('booking_requests').doc(requestId).get();
    final data = snap.data() ?? const <String, dynamic>{};
    final isCenterRequest =
        (data['requestKind'] ?? '').toString().trim() == 'center' ||
            (data['centerId'] ?? '').toString().trim().isNotEmpty;
    await updateRequestEverywhere(requestId, {
      'status': isCenterRequest ? 'session_scheduled' : 'session_setup_pending',
      'workflowStage':
          isCenterRequest ? 'session_scheduled' : 'session_setup_pending',
      'paymentStatus': 'approved',
      'payment_confirmed': true,
      'paymentApprovedAt': FieldValue.serverTimestamp(),
      'sessionStatus': isCenterRequest ? 'scheduled' : 'not_created',
    });
    return AdminApprovePaymentResult(isCenterRequest: isCenterRequest);
  }

  @Deprecated('Payment authority moved to AdminPaymentDecisionAdapter. Use that adapter for payment decisions.')
  Future<void> rejectPayment({
    required String requestId,
  }) async {
    await updateRequestEverywhere(requestId, {
      'status': 'awaiting_payment',
      'workflowStage': 'awaiting_payment',
      'paymentStatus': 'rejected',
      'payment_confirmed': false,
      'paymentRejectedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> confirmClinicianPayout({
    required String requestId,
  }) async {
    await updateRequestEverywhere(requestId, {
      'status': 'completed_success',
      'workflowStage': 'completed_success',
      'sessionStatus': 'completed',
      'reviewStatus': 'completed',
      'payoutStatus': 'paid_to_clinician',
      'payoutTransferredAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> sendToSessionArchive({
    required String requestId,
  }) async {
    await updateRequestEverywhere(requestId, {
      'archived': true,
      'archivedAt': FieldValue.serverTimestamp(),
      'archiveSection': 'sessions',
      'archiveReady': true,
    });
  }

  Future<void> sendToFinancialArchive({
    required String requestId,
  }) async {
    await updateRequestEverywhere(requestId, {
      'archived': true,
      'archivedAt': FieldValue.serverTimestamp(),
      'archiveSection': 'payments',
      'archiveReady': true,
    });
  }

  Future<AdminAssignClinicianResult> assignClinician({
    required String requestId,
    required String adminUid,
  }) async {
    final snap = await readPrimaryBookingRequest(requestId);
    if (!snap.exists) {
      throw Exception('Booking request not found');
    }
    final resourceSnapshot = snap.data() ?? const <String, dynamic>{};
    final currentStatus = (resourceSnapshot['status'] ?? '').toString().trim();
    final currentWorkflowStage =
        (resourceSnapshot['workflowStage'] ?? '').toString().trim();
    final clinicianId = resourceSnapshot['clinicianId'];
    final clinicianName = resourceSnapshot['clinicianName'];
    final clinicianUid = resourceSnapshot['clinicianUid'];

    debugPrint(
      'CENTER_FLOW_ASSIGN_START '
      'requestId=$requestId '
      'adminUid=$adminUid '
      'clinicianId=$clinicianId '
      'clinicianName=$clinicianName '
      'clinicianUid=$clinicianUid',
    );

    final alreadyAssigned = currentStatus == 'assigned_clinician' ||
        currentWorkflowStage == 'assigned_clinician';

    if (alreadyAssigned) {
      _log(
        operation: 'assign_skip_already_assigned',
        collection: 'booking_requests',
        documentId: requestId,
        requestKind: (resourceSnapshot['requestKind'] ?? '').toString(),
        status: currentStatus,
        writeStatus: 'assigned_clinician',
        error: 'request_already_in_assigned_clinician_state',
      );
      return const AdminAssignClinicianResult(
        alreadyAssigned: true,
        clinicianName: '',
      );
    }

    if (clinicianId is! String ||
        clinicianName is! String ||
        clinicianUid is! String ||
        clinicianId.isEmpty ||
        clinicianName.isEmpty ||
        clinicianUid.isEmpty) {
      _log(
        operation: 'assign_skip_missing_requested_clinician',
        collection: 'booking_requests',
        documentId: requestId,
        requestKind: (resourceSnapshot['requestKind'] ?? '').toString(),
        status: currentStatus,
        writeStatus: 'assigned_clinician',
        error: 'requested_clinician_target_missing',
      );
      throw Exception('Requested clinician target is missing');
    }

    await updateRequestEverywhere(requestId, {
      'status': 'assigned_clinician',
      'workflowStage': 'assigned_clinician',
      'adminApproved': true,
      'adminRejected': false,
      'adminForwarded': true,
      'assignedClinicianId': clinicianId,
      'assignedClinicianName': clinicianName,
      'adminAssignedBy': adminUid,
      'adminAssignedAt': FieldValue.serverTimestamp(),
      'adminDecisionType': 'assigned',
      'adminDecisionBy': adminUid,
      'adminDecisionAt': FieldValue.serverTimestamp(),
      'paymentStatus': 'not_started',
      'payment_confirmed': false,
      'sessionStatus': 'not_created',
      'reviewStatus': 'not_started',
      'payoutStatus': 'blocked',
    });

    return AdminAssignClinicianResult(
      alreadyAssigned: false,
      clinicianName: clinicianName,
    );
  }
}
