import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterprojects/features/admin_surface/data/services/admin_booking_decision_adapter.dart';

enum BookingCommandRiskTier {
  info,
  highRisk,
  critical,
  sovereignCritical,
}

class BookingCommandValidationWarning {
  const BookingCommandValidationWarning({
    required this.code,
    required this.message,
  });

  final String code;
  final String message;
}

class BookingCommandEnvelope {
  const BookingCommandEnvelope({
    required this.commandName,
    required this.commandVersion,
    required this.riskTier,
    required this.requestedByUid,
    required this.requestedByRole,
    required this.targetCollection,
    required this.targetDocId,
    required this.sourceAdapter,
    required this.sourceRoute,
    required this.dryRun,
    required this.shadowMode,
    required this.createdAt,
    required this.correlationId,
    required this.idempotencyKey,
    this.targetClinicianId,
    this.previousStateSummary = const <String, Object?>{},
    this.requestedPatchSummary = const <String, Object?>{},
  });

  final String commandName;
  final String commandVersion;
  final BookingCommandRiskTier riskTier;
  final String requestedByUid;
  final String requestedByRole;
  final String targetCollection;
  final String targetDocId;
  final String? targetClinicianId;
  final String sourceAdapter;
  final String sourceRoute;
  final bool dryRun;
  final bool shadowMode;
  final DateTime createdAt;
  final String correlationId;
  final String idempotencyKey;
  final Map<String, Object?> previousStateSummary;
  final Map<String, Object?> requestedPatchSummary;
}

class AdminBookingCommandWrapper {
  AdminBookingCommandWrapper({
    required AdminBookingDecisionAdapter delegate,
    FirebaseFirestore? firestore,
    String sourceRoute = '/admin/booking-queue',
  })  : _delegate = delegate,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _sourceRoute = sourceRoute;

  static final Set<String> _seenIdempotencyKeys = <String>{};

  final AdminBookingDecisionAdapter _delegate;
  final FirebaseFirestore _firestore;
  final String _sourceRoute;

  Future<AdminAssignClinicianResult> assignClinician({
    required String requestId,
    required String adminUid,
  }) async {
    final snapshot = await _readSnapshotForDiagnostics(requestId);
    final data = snapshot?.data();
    final envelope = _buildAssignClinicianEnvelope(
      requestId: requestId,
      adminUid: adminUid,
      data: data,
    );
    final warnings = _assignClinicianWarnings(
      envelope: envelope,
      snapshotExists: snapshot?.exists ?? false,
      data: data,
      adminUid: adminUid,
    );

    _logShadow(
      envelope: envelope,
      warningCount: warnings.length,
      resultStatus: 'delegating',
    );

    try {
      final result = await _delegate.assignClinician(
        requestId: requestId,
        adminUid: adminUid,
      );
      _logShadow(
        envelope: envelope,
        warningCount: warnings.length,
        resultStatus: result.alreadyAssigned ? 'already_assigned' : 'completed',
        alreadyAssigned: result.alreadyAssigned,
      );
      return result;
    } catch (_) {
      _logShadow(
        envelope: envelope,
        warningCount: warnings.length,
        resultStatus: 'failed',
      );
      rethrow;
    }
  }

  Future<void> rejectRequest({
    required String requestId,
    required bool isCenterRequest,
    required String adminUid,
  }) async {
    final snapshot = await _readSnapshotForDiagnostics(requestId);
    final data = snapshot?.data();
    final envelope = _buildRejectRequestEnvelope(
      requestId: requestId,
      adminUid: adminUid,
      data: data,
    );
    final warnings = _rejectRequestWarnings(
      snapshotExists: snapshot?.exists ?? false,
      data: data,
      adminUid: adminUid,
    );

    _logShadow(
      envelope: envelope,
      warningCount: warnings.length,
      resultStatus: 'delegating',
    );

    try {
      await _delegate.rejectRequest(
        requestId: requestId,
        isCenterRequest: isCenterRequest,
        adminUid: adminUid,
      );
      _logShadow(
        envelope: envelope,
        warningCount: warnings.length,
        resultStatus: 'completed',
      );
    } catch (_) {
      _logShadow(
        envelope: envelope,
        warningCount: warnings.length,
        resultStatus: 'failed',
      );
      rethrow;
    }
  }

  Future<void> returnToPending({
    required String requestId,
    required String adminUid,
  }) async {
    final snapshot = await _readSnapshotForDiagnostics(requestId);
    final data = snapshot?.data();
    final envelope = _buildReturnToPendingEnvelope(
      requestId: requestId,
      adminUid: adminUid,
      data: data,
    );
    final warnings = _returnToPendingWarnings(
      snapshotExists: snapshot?.exists ?? false,
      data: data,
      adminUid: adminUid,
    );

    _logShadow(
      envelope: envelope,
      warningCount: warnings.length,
      resultStatus: 'delegating',
    );

    try {
      await _delegate.returnToPending(
        requestId: requestId,
        adminUid: adminUid,
      );
      _logShadow(
        envelope: envelope,
        warningCount: warnings.length,
        resultStatus: 'completed',
      );
    } catch (_) {
      _logShadow(
        envelope: envelope,
        warningCount: warnings.length,
        resultStatus: 'failed',
      );
      rethrow;
    }
  }

  Future<void> approveCenterRequest({
    required String requestId,
    required String adminUid,
  }) async {
    final snapshot = await _readSnapshotForDiagnostics(requestId);
    final data = snapshot?.data();
    final envelope = _buildApproveCenterRequestEnvelope(
      requestId: requestId,
      adminUid: adminUid,
      data: data,
    );
    final warnings = _approveCenterRequestWarnings(
      snapshotExists: snapshot?.exists ?? false,
      data: data,
      adminUid: adminUid,
    );

    _logShadow(
      envelope: envelope,
      warningCount: warnings.length,
      resultStatus: 'delegating',
    );

    try {
      await _delegate.approveCenterRequest(
        requestId: requestId,
        adminUid: adminUid,
      );
      _logShadow(
        envelope: envelope,
        warningCount: warnings.length,
        resultStatus: 'completed',
      );
    } catch (_) {
      _logShadow(
        envelope: envelope,
        warningCount: warnings.length,
        resultStatus: 'failed',
      );
      rethrow;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> _readSnapshotForDiagnostics(
    String requestId,
  ) async {
    try {
      return _firestore.collection('booking_requests').doc(requestId).get();
    } catch (_) {
      return null;
    }
  }

  BookingCommandEnvelope _buildAssignClinicianEnvelope({
    required String requestId,
    required String adminUid,
    required Map<String, dynamic>? data,
  }) {
    final clinicianId = _stringValue(data?['clinicianId']);
    final correlationId = _newCorrelationId(requestId);
    final idempotencyKey = [
      'booking.assign_clinician',
      requestId,
      adminUid,
      clinicianId ?? '',
    ].join(':');

    return BookingCommandEnvelope(
      commandName: 'booking.assign_clinician',
      commandVersion: 'v1',
      riskTier: BookingCommandRiskTier.critical,
      requestedByUid: adminUid,
      requestedByRole: 'admin',
      targetCollection: 'booking_requests',
      targetDocId: requestId,
      targetClinicianId: clinicianId,
      sourceAdapter: 'AdminBookingDecisionAdapter',
      sourceRoute: _sourceRoute,
      dryRun: true,
      shadowMode: true,
      createdAt: DateTime.now().toUtc(),
      correlationId: correlationId,
      idempotencyKey: idempotencyKey,
      previousStateSummary: _previousStateSummary(data),
      requestedPatchSummary: _requestedPatchSummary(clinicianId),
    );
  }

  BookingCommandEnvelope _buildRejectRequestEnvelope({
    required String requestId,
    required String adminUid,
    required Map<String, dynamic>? data,
  }) {
    final correlationId = _newCorrelationId(requestId);
    final idempotencyKey = [
      'booking.reject_request',
      requestId,
      adminUid,
      _stringValue(data?['status']) ?? '',
    ].join(':');

    return BookingCommandEnvelope(
      commandName: 'booking.reject_request',
      commandVersion: 'v1',
      riskTier: BookingCommandRiskTier.critical,
      requestedByUid: adminUid,
      requestedByRole: 'admin',
      targetCollection: 'booking_requests',
      targetDocId: requestId,
      targetClinicianId: _stringValue(data?['clinicianId']),
      sourceAdapter: 'AdminBookingDecisionAdapter',
      sourceRoute: _sourceRoute,
      dryRun: true,
      shadowMode: true,
      createdAt: DateTime.now().toUtc(),
      correlationId: correlationId,
      idempotencyKey: idempotencyKey,
      previousStateSummary: _previousStateSummary(data),
      requestedPatchSummary: _rejectRequestPatchSummary(),
    );
  }

  BookingCommandEnvelope _buildReturnToPendingEnvelope({
    required String requestId,
    required String adminUid,
    required Map<String, dynamic>? data,
  }) {
    final correlationId = _newCorrelationId(requestId);
    final idempotencyKey = [
      'booking.return_to_pending',
      requestId,
      adminUid,
      _stringValue(data?['status']) ?? '',
    ].join(':');

    return BookingCommandEnvelope(
      commandName: 'booking.return_to_pending',
      commandVersion: 'v1',
      riskTier: BookingCommandRiskTier.critical,
      requestedByUid: adminUid,
      requestedByRole: 'admin',
      targetCollection: 'booking_requests',
      targetDocId: requestId,
      targetClinicianId: _stringValue(data?['clinicianId']),
      sourceAdapter: 'AdminBookingDecisionAdapter',
      sourceRoute: _sourceRoute,
      dryRun: true,
      shadowMode: true,
      createdAt: DateTime.now().toUtc(),
      correlationId: correlationId,
      idempotencyKey: idempotencyKey,
      previousStateSummary: _previousStateSummary(data),
      requestedPatchSummary: _returnToPendingPatchSummary(),
    );
  }

  BookingCommandEnvelope _buildApproveCenterRequestEnvelope({
    required String requestId,
    required String adminUid,
    required Map<String, dynamic>? data,
  }) {
    final centerId = _stringValue(data?['centerId']);
    final correlationId = _newCorrelationId(requestId);
    final idempotencyKey = [
      'center_request.approve',
      requestId,
      adminUid,
      centerId ?? '',
      _stringValue(data?['status']) ?? '',
    ].join(':');

    return BookingCommandEnvelope(
      commandName: 'center_request.approve',
      commandVersion: 'v1',
      riskTier: BookingCommandRiskTier.critical,
      requestedByUid: adminUid,
      requestedByRole: 'admin',
      targetCollection: 'booking_requests',
      targetDocId: requestId,
      targetClinicianId: _stringValue(data?['clinicianId']),
      sourceAdapter: 'AdminBookingDecisionAdapter',
      sourceRoute: _sourceRoute,
      dryRun: true,
      shadowMode: true,
      createdAt: DateTime.now().toUtc(),
      correlationId: correlationId,
      idempotencyKey: idempotencyKey,
      previousStateSummary: _previousStateSummary(data),
      requestedPatchSummary: _approveCenterRequestPatchSummary(),
    );
  }

  List<BookingCommandValidationWarning> _assignClinicianWarnings({
    required BookingCommandEnvelope envelope,
    required bool snapshotExists,
    required Map<String, dynamic>? data,
    required String adminUid,
  }) {
    final warnings = <BookingCommandValidationWarning>[];
    if (!snapshotExists || data == null) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'missing_booking_snapshot',
          message:
              'Booking snapshot was unavailable during shadow diagnostics.',
        ),
      );
    }

    final clinicianId = _stringValue(data?['clinicianId']);
    final clinicianName = _stringValue(data?['clinicianName']);
    final clinicianUid = _stringValue(data?['clinicianUid']);
    final status = _stringValue(data?['status']) ?? '';
    final workflowStage = _stringValue(data?['workflowStage']) ?? '';

    if (clinicianId == null || clinicianId.isEmpty) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'missing_requested_clinician_id',
          message: 'Requested clinician id is missing.',
        ),
      );
    }
    if (clinicianName == null || clinicianName.isEmpty) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'missing_requested_clinician_name',
          message: 'Requested clinician name is missing.',
        ),
      );
    }
    if (clinicianUid == null || clinicianUid.isEmpty) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'missing_requested_clinician_uid',
          message: 'Requested clinician uid is missing.',
        ),
      );
    }
    if (status == 'assigned_clinician' ||
        workflowStage == 'assigned_clinician') {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'already_assigned',
          message: 'Booking is already assigned to a clinician.',
        ),
      );
    }
    if (status.isNotEmpty && status != 'pending_admin') {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'unexpected_booking_status',
          message: 'Booking status is not the expected pending_admin state.',
        ),
      );
    }
    if (adminUid.trim().isEmpty) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'missing_admin_uid',
          message: 'Admin uid is missing.',
        ),
      );
    }
    warnings.add(
      const BookingCommandValidationWarning(
        code: 'target_clinician_active_status_unknown',
        message: 'Target clinician active/approved status was not checked.',
      ),
    );
    if (!_seenIdempotencyKeys.add(envelope.idempotencyKey)) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'possible_duplicate_command',
          message: 'A matching shadow idempotency key was already observed.',
        ),
      );
    }
    if (_sourceRoute.trim().isEmpty) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'missing_source_route',
          message: 'Source route is missing.',
        ),
      );
    }

    return warnings;
  }

  List<BookingCommandValidationWarning> _rejectRequestWarnings({
    required bool snapshotExists,
    required Map<String, dynamic>? data,
    required String adminUid,
  }) {
    final warnings = <BookingCommandValidationWarning>[];
    if (!snapshotExists || data == null) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'missing_booking_snapshot',
          message:
              'Booking snapshot was unavailable during shadow diagnostics.',
        ),
      );
    }

    final status = _stringValue(data?['status']) ?? '';
    final paymentStatus = _stringValue(data?['paymentStatus']) ?? '';
    final sessionStatus = _stringValue(data?['sessionStatus']) ?? '';
    final payoutStatus = _stringValue(data?['payoutStatus']) ?? '';

    if (adminUid.trim().isEmpty) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'missing_admin_uid',
          message: 'Admin uid is missing.',
        ),
      );
    }
    if (status.isNotEmpty && !_isExpectedRejectableStatus(status)) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'rejection_from_unexpected_status',
          message: 'Booking status is not an expected rejection state.',
        ),
      );
    }
    if (paymentStatus == 'approved' || paymentStatus == 'paid') {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'payment_already_finalized',
          message: 'Payment appears finalized before rejection.',
        ),
      );
    }
    if (sessionStatus == 'completed') {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'session_already_completed',
          message: 'Session appears completed before rejection.',
        ),
      );
    }
    if (payoutStatus == 'paid_to_center' ||
        payoutStatus == 'paid_to_clinician') {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'payout_already_confirmed',
          message: 'Payout appears confirmed before rejection.',
        ),
      );
    }
    warnings.add(
      const BookingCommandValidationWarning(
        code: 'missing_rejection_reason',
        message: 'Current rejectRequest contract does not include a reason.',
      ),
    );
    if (_sourceRoute.trim().isEmpty) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'missing_source_route',
          message: 'Source route is missing.',
        ),
      );
    }

    return warnings;
  }

  List<BookingCommandValidationWarning> _returnToPendingWarnings({
    required bool snapshotExists,
    required Map<String, dynamic>? data,
    required String adminUid,
  }) {
    final warnings = <BookingCommandValidationWarning>[];
    if (!snapshotExists || data == null) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'missing_booking_snapshot',
          message:
              'Booking snapshot was unavailable during shadow diagnostics.',
        ),
      );
    }

    final status = _stringValue(data?['status']) ?? '';
    final paymentStatus = _stringValue(data?['paymentStatus']) ?? '';
    final sessionStatus = _stringValue(data?['sessionStatus']) ?? '';
    final payoutStatus = _stringValue(data?['payoutStatus']) ?? '';

    if (adminUid.trim().isEmpty) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'missing_admin_uid',
          message: 'Admin uid is missing.',
        ),
      );
    }
    if (status.isNotEmpty && !_isExpectedReturnToPendingStatus(status)) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'return_from_unexpected_status',
          message: 'Booking status is not an expected return-to-pending state.',
        ),
      );
    }
    if (paymentStatus == 'approved' || paymentStatus == 'paid') {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'payment_already_finalized',
          message: 'Payment appears finalized before return to pending.',
        ),
      );
    }
    if (sessionStatus == 'completed') {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'session_already_completed',
          message: 'Session appears completed before return to pending.',
        ),
      );
    }
    if (payoutStatus == 'paid_to_center' ||
        payoutStatus == 'paid_to_clinician') {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'payout_already_confirmed',
          message: 'Payout appears confirmed before return to pending.',
        ),
      );
    }
    if (_sourceRoute.trim().isEmpty) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'missing_source_route',
          message: 'Source route is missing.',
        ),
      );
    }

    return warnings;
  }

  List<BookingCommandValidationWarning> _approveCenterRequestWarnings({
    required bool snapshotExists,
    required Map<String, dynamic>? data,
    required String adminUid,
  }) {
    final warnings = <BookingCommandValidationWarning>[];
    if (!snapshotExists || data == null) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'missing_booking_snapshot',
          message:
              'Booking snapshot was unavailable during shadow diagnostics.',
        ),
      );
    }

    final status = _stringValue(data?['status']) ?? '';
    final requestKind = _stringValue(data?['requestKind']) ?? '';
    final centerId = _stringValue(data?['centerId']);
    final centerName = _stringValue(data?['centerName']);
    final paymentStatus = _stringValue(data?['paymentStatus']) ?? '';
    final sessionStatus = _stringValue(data?['sessionStatus']) ?? '';
    final payoutStatus = _stringValue(data?['payoutStatus']) ?? '';

    if (adminUid.trim().isEmpty) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'missing_admin_uid',
          message: 'Admin uid is missing.',
        ),
      );
    }
    if (status.isNotEmpty && !_isExpectedCenterApprovalStatus(status)) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'approval_from_unexpected_status',
          message: 'Booking status is not an expected center approval state.',
        ),
      );
    }
    if (requestKind != 'center' && (centerId == null || centerId.isEmpty)) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'request_is_not_center_request',
          message: 'Request does not appear to be a center request.',
        ),
      );
    }
    if (centerId == null || centerId.isEmpty) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'missing_center_id',
          message: 'Center id is missing.',
        ),
      );
    }
    if (centerName == null || centerName.isEmpty) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'missing_center_name',
          message: 'Center name is missing.',
        ),
      );
    }
    if (paymentStatus == 'approved' || paymentStatus == 'paid') {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'payment_already_finalized',
          message: 'Payment appears finalized before center approval.',
        ),
      );
    }
    if (sessionStatus == 'scheduled' ||
        sessionStatus == 'in_progress' ||
        sessionStatus == 'completed') {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'session_already_created_or_completed',
          message:
              'Session appears created or completed before center approval.',
        ),
      );
    }
    if (payoutStatus == 'paid_to_center' ||
        payoutStatus == 'paid_to_clinician') {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'payout_already_confirmed',
          message: 'Payout appears confirmed before center approval.',
        ),
      );
    }
    if (_sourceRoute.trim().isEmpty) {
      warnings.add(
        const BookingCommandValidationWarning(
          code: 'missing_source_route',
          message: 'Source route is missing.',
        ),
      );
    }

    return warnings;
  }

  Map<String, Object?> _previousStateSummary(Map<String, dynamic>? data) {
    if (data == null) return const <String, Object?>{};
    return <String, Object?>{
      'status': _stringValue(data['status']),
      'workflowStage': _stringValue(data['workflowStage']),
      'requestKind': _stringValue(data['requestKind']),
      'clinicianId': _stringValue(data['clinicianId']),
      'clinicianNamePresent':
          (_stringValue(data['clinicianName']) ?? '').isNotEmpty,
      'clinicianUidPresent':
          (_stringValue(data['clinicianUid']) ?? '').isNotEmpty,
      'assignedClinicianId': _stringValue(data['assignedClinicianId']),
      'adminForwarded': data['adminForwarded'] == true,
    };
  }

  Map<String, Object?> _requestedPatchSummary(String? clinicianId) {
    return <String, Object?>{
      'status': 'assigned_clinician',
      'workflowStage': 'assigned_clinician',
      'adminApproved': true,
      'adminForwarded': true,
      'assignedClinicianId': clinicianId,
      'assignedClinicianNamePresent': true,
      'paymentStatus': 'not_started',
      'sessionStatus': 'not_created',
      'reviewStatus': 'not_started',
      'payoutStatus': 'blocked',
    };
  }

  Map<String, Object?> _rejectRequestPatchSummary() {
    return const <String, Object?>{
      'status': 'rejected_admin',
      'workflowStage': 'rejected_admin',
      'adminApproved': false,
      'adminRejected': true,
      'adminForwarded': false,
      'adminDecisionType': 'rejected',
      'paymentStatus': 'blocked',
      'payment_confirmed': false,
      'sessionStatus': 'cancelled',
      'reviewStatus': 'blocked',
      'payoutStatus': 'blocked',
    };
  }

  Map<String, Object?> _returnToPendingPatchSummary() {
    return const <String, Object?>{
      'status': 'pending_admin',
      'workflowStage': 'pending_admin',
      'adminApproved': false,
      'adminRejected': false,
      'adminForwarded': false,
      'adminAssignedBy': '',
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
    };
  }

  Map<String, Object?> _approveCenterRequestPatchSummary() {
    return const <String, Object?>{
      'status': 'session_setup_pending',
      'workflowStage': 'session_setup_pending',
      'adminApproved': true,
      'adminRejected': false,
      'adminForwarded': false,
      'adminDecisionType': 'approved',
      'paymentStatus': 'pending_client_transfer',
      'sessionStatus': 'not_created',
      'reviewStatus': 'not_started',
      'payoutStatus': 'blocked',
      'assignedClinicianId': '',
      'assignedClinicianName': '',
      'clinicianId': '',
      'clinicianName': '',
      'clinicianUid': '',
    };
  }

  bool _isExpectedRejectableStatus(String status) {
    return const <String>{
      'pending_admin',
      'assigned_clinician',
      'center_follow_up',
      'center_intake_pending',
      'client_update_required',
      'session_setup_pending',
      'awaiting_payment',
      'payment_review',
    }.contains(status);
  }

  bool _isExpectedReturnToPendingStatus(String status) {
    return const <String>{
      'rejected_admin',
      'assigned_clinician',
      'center_follow_up',
      'center_intake_pending',
      'client_update_required',
      'session_setup_pending',
      'awaiting_payment',
      'payment_review',
    }.contains(status);
  }

  bool _isExpectedCenterApprovalStatus(String status) {
    return const <String>{
      'center_follow_up',
      'center_intake_pending',
      'client_update_required',
      'pending_admin',
    }.contains(status);
  }

  void _logShadow({
    required BookingCommandEnvelope envelope,
    required int warningCount,
    required String resultStatus,
    bool? alreadyAssigned,
  }) {
    debugPrint(
      'BOOKING_COMMAND_SHADOW '
      'commandName=${envelope.commandName} '
      'requestId=${envelope.targetDocId} '
      'correlationId=${envelope.correlationId} '
      'warningCount=$warningCount '
      'resultStatus=$resultStatus '
      'alreadyAssigned=${alreadyAssigned ?? ''} '
      'sourceAdapter=${envelope.sourceAdapter} '
      'sourceRoute=${envelope.sourceRoute}',
    );
  }

  String _newCorrelationId(String requestId) {
    final stamp = DateTime.now().toUtc().microsecondsSinceEpoch;
    return 'booking-assign-$stamp-${requestId.hashCode}';
  }

  String? _stringValue(Object? value) {
    if (value == null) return null;
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }
}
