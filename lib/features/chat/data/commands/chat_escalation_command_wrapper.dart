import 'package:flutter/foundation.dart';

enum ChatEscalationCommandRiskTier {
  info,
  highRisk,
  critical,
}

class ChatEscalationCommandValidationWarning {
  const ChatEscalationCommandValidationWarning({
    required this.code,
    required this.message,
  });

  final String code;
  final String message;
}

class ChatEscalationCommandEnvelope {
  const ChatEscalationCommandEnvelope({
    required this.commandName,
    required this.commandVersion,
    required this.riskTier,
    required this.requestedByUid,
    required this.requestedByRole,
    required this.targetCollection,
    required this.targetDocId,
    required this.sourceService,
    required this.sourceRoute,
    required this.dryRun,
    required this.shadowMode,
    required this.createdAt,
    required this.correlationId,
    required this.idempotencyKey,
    this.threadId,
    this.clientId,
    this.clinicianId,
    this.previousStateSummary = const <String, Object?>{},
    this.requestedPatchSummary = const <String, Object?>{},
  });

  final String commandName;
  final String commandVersion;
  final ChatEscalationCommandRiskTier riskTier;
  final String requestedByUid;
  final String requestedByRole;
  final String targetCollection;
  final String targetDocId;
  final String sourceService;
  final String sourceRoute;
  final bool dryRun;
  final bool shadowMode;
  final DateTime createdAt;
  final String correlationId;
  final String idempotencyKey;
  final String? threadId;
  final String? clientId;
  final String? clinicianId;
  final Map<String, Object?> previousStateSummary;
  final Map<String, Object?> requestedPatchSummary;
}

typedef ChatEscalationAssignDelegate = Future<void> Function();
typedef ChatEscalationForwardDelegate = Future<void> Function();
typedef ChatEscalationResolveDelegate = Future<void> Function();

class ChatEscalationCommandWrapper {
  const ChatEscalationCommandWrapper({
    this.sourceRoute = '/chat/escalations',
  });

  final String sourceRoute;

  Future<void> assignEscalationToAdmin({
    required String escalationId,
    required String adminUid,
    required ChatEscalationAssignDelegate delegate,
    String? threadId,
    String? clientId,
    String? clinicianId,
    String? currentStatus,
    bool alreadyAssigned = false,
  }) async {
    final envelope = _buildAssignEnvelope(
      escalationId: escalationId,
      adminUid: adminUid,
      threadId: threadId,
      clientId: clientId,
      clinicianId: clinicianId,
      currentStatus: currentStatus,
    );
    final warnings = _assignWarnings(
      escalationId: escalationId,
      adminUid: adminUid,
      threadId: threadId,
      clientId: clientId,
      clinicianId: clinicianId,
      currentStatus: currentStatus,
      alreadyAssigned: alreadyAssigned,
    );

    _logShadow(
      envelope: envelope,
      warningCount: warnings.length,
      resultStatus: 'delegating',
    );

    try {
      await delegate();
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

  Future<void> forwardEscalationToClinician({
    required String escalationId,
    required String threadId,
    required String clinicianUid,
    required ChatEscalationForwardDelegate delegate,
    String? currentStatus,
    bool alreadyForwarded = false,
  }) async {
    final envelope = _buildForwardEnvelope(
      escalationId: escalationId,
      threadId: threadId,
      clinicianUid: clinicianUid,
      currentStatus: currentStatus,
    );
    final warnings = _forwardWarnings(
      escalationId: escalationId,
      threadId: threadId,
      clinicianUid: clinicianUid,
      currentStatus: currentStatus,
      alreadyForwarded: alreadyForwarded,
    );

    _logShadow(
      envelope: envelope,
      warningCount: warnings.length,
      resultStatus: 'delegating',
    );

    try {
      await delegate();
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

  Future<void> resolveEscalation({
    required String escalationId,
    required String threadId,
    required String resolverUid,
    required ChatEscalationResolveDelegate delegate,
    String? currentStatus,
    bool alreadyResolved = false,
  }) async {
    final envelope = _buildResolveEnvelope(
      escalationId: escalationId,
      threadId: threadId,
      resolverUid: resolverUid,
      currentStatus: currentStatus,
    );
    final warnings = _resolveWarnings(
      escalationId: escalationId,
      threadId: threadId,
      resolverUid: resolverUid,
      currentStatus: currentStatus,
      alreadyResolved: alreadyResolved,
    );

    _logShadow(
      envelope: envelope,
      warningCount: warnings.length,
      resultStatus: 'delegating',
    );

    try {
      await delegate();
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

  ChatEscalationCommandEnvelope _buildAssignEnvelope({
    required String escalationId,
    required String adminUid,
    String? threadId,
    String? clientId,
    String? clinicianId,
    String? currentStatus,
  }) {
    final correlationId = _newCorrelationId(escalationId);
    final idempotencyKey = [
      'chat.escalation.assign',
      escalationId,
      adminUid,
      threadId ?? '',
      currentStatus ?? '',
    ].join(':');

    return ChatEscalationCommandEnvelope(
      commandName: 'chat.escalation.assign',
      commandVersion: 'v1',
      riskTier: ChatEscalationCommandRiskTier.highRisk,
      requestedByUid: adminUid,
      requestedByRole: 'admin',
      targetCollection: 'chat_escalations',
      targetDocId: escalationId,
      threadId: threadId,
      clientId: clientId,
      clinicianId: clinicianId,
      sourceService: 'ChatFirestoreService',
      sourceRoute: sourceRoute,
      dryRun: true,
      shadowMode: true,
      createdAt: DateTime.now().toUtc(),
      correlationId: correlationId,
      idempotencyKey: idempotencyKey,
      previousStateSummary: <String, Object?>{
        'status': currentStatus,
        'threadIdPresent': (threadId ?? '').isNotEmpty,
        'clientIdPresent': (clientId ?? '').isNotEmpty,
        'clinicianIdPresent': (clinicianId ?? '').isNotEmpty,
      },
      requestedPatchSummary: const <String, Object?>{
        'assignmentCommand': true,
      },
    );
  }

  ChatEscalationCommandEnvelope _buildForwardEnvelope({
    required String escalationId,
    required String threadId,
    required String clinicianUid,
    String? currentStatus,
  }) {
    final correlationId = _newCorrelationId(escalationId);
    final idempotencyKey = [
      'chat.escalation.forward_to_clinician',
      escalationId,
      threadId,
      clinicianUid,
      currentStatus ?? '',
    ].join(':');

    return ChatEscalationCommandEnvelope(
      commandName: 'chat.escalation.forward_to_clinician',
      commandVersion: 'v1',
      riskTier: ChatEscalationCommandRiskTier.highRisk,
      requestedByUid: '',
      requestedByRole: 'admin',
      targetCollection: 'chat_escalations',
      targetDocId: escalationId,
      threadId: threadId,
      clinicianId: clinicianUid,
      sourceService: 'ChatFirestoreService',
      sourceRoute: sourceRoute,
      dryRun: true,
      shadowMode: true,
      createdAt: DateTime.now().toUtc(),
      correlationId: correlationId,
      idempotencyKey: idempotencyKey,
      previousStateSummary: <String, Object?>{
        'status': currentStatus,
        'threadIdPresent': threadId.isNotEmpty,
        'clinicianIdPresent': clinicianUid.isNotEmpty,
      },
      requestedPatchSummary: const <String, Object?>{
        'assignedToType': 'clinician',
        'status': 'forwarded_to_clinician',
        'threadType': 'clinician_case',
        'handoffState': 'clinician_review',
        'lifecycleState': 'assigned_clinician',
      },
    );
  }

  ChatEscalationCommandEnvelope _buildResolveEnvelope({
    required String escalationId,
    required String threadId,
    required String resolverUid,
    String? currentStatus,
  }) {
    final correlationId = _newCorrelationId(escalationId);
    final idempotencyKey = [
      'chat.escalation.resolve',
      escalationId,
      threadId,
      resolverUid,
      currentStatus ?? '',
    ].join(':');

    return ChatEscalationCommandEnvelope(
      commandName: 'chat.escalation.resolve',
      commandVersion: 'v1',
      riskTier: ChatEscalationCommandRiskTier.highRisk,
      requestedByUid: resolverUid,
      requestedByRole: 'admin',
      targetCollection: 'chat_escalations',
      targetDocId: escalationId,
      threadId: threadId,
      sourceService: 'ChatFirestoreService',
      sourceRoute: sourceRoute,
      dryRun: true,
      shadowMode: true,
      createdAt: DateTime.now().toUtc(),
      correlationId: correlationId,
      idempotencyKey: idempotencyKey,
      previousStateSummary: <String, Object?>{
        'status': currentStatus,
        'threadIdPresent': threadId.isNotEmpty,
      },
      requestedPatchSummary: const <String, Object?>{
        'status': 'resolved',
        'handoffState': 'resolved',
        'lifecycleState': 'resolved',
        'needsHumanSupport': false,
      },
    );
  }

  List<ChatEscalationCommandValidationWarning> _assignWarnings({
    required String escalationId,
    required String adminUid,
    String? threadId,
    String? clientId,
    String? clinicianId,
    String? currentStatus,
    required bool alreadyAssigned,
  }) {
    final warnings = <ChatEscalationCommandValidationWarning>[];
    if (escalationId.trim().isEmpty) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'missing_escalation_id',
          message: 'Escalation id is missing.',
        ),
      );
    }
    if (adminUid.trim().isEmpty) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'missing_admin_uid',
          message: 'Admin uid is missing.',
        ),
      );
    }
    if (currentStatus != null &&
        currentStatus.isNotEmpty &&
        !_isExpectedAssignableStatus(currentStatus)) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'assignment_from_unexpected_status',
          message: 'Escalation status is not an expected assignment state.',
        ),
      );
    }
    if (alreadyAssigned) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'already_assigned',
          message: 'Escalation appears already assigned.',
        ),
      );
    }
    if ((threadId ?? '').trim().isEmpty) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'thread_id_missing',
          message: 'Thread id is missing.',
        ),
      );
    }
    if ((clientId ?? '').trim().isEmpty) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'client_id_missing',
          message: 'Client id is missing.',
        ),
      );
    }
    if ((clinicianId ?? '').trim().isEmpty) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'clinician_id_missing',
          message: 'Clinician id is missing.',
        ),
      );
    }
    if (sourceRoute.trim().isEmpty) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'source_route_missing',
          message: 'Source route is missing.',
        ),
      );
    }
    return warnings;
  }

  List<ChatEscalationCommandValidationWarning> _forwardWarnings({
    required String escalationId,
    required String threadId,
    required String clinicianUid,
    String? currentStatus,
    required bool alreadyForwarded,
  }) {
    final warnings = <ChatEscalationCommandValidationWarning>[];
    if (escalationId.trim().isEmpty) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'missing_escalation_id',
          message: 'Escalation id is missing.',
        ),
      );
    }
    if (threadId.trim().isEmpty) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'thread_id_missing',
          message: 'Thread id is missing.',
        ),
      );
    }
    if (clinicianUid.trim().isEmpty) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'clinician_id_missing',
          message: 'Clinician id is missing.',
        ),
      );
    }
    if (currentStatus != null &&
        currentStatus.isNotEmpty &&
        !_isExpectedForwardableStatus(currentStatus)) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'forward_from_unexpected_status',
          message: 'Escalation status is not an expected forward state.',
        ),
      );
    }
    if (alreadyForwarded) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'already_forwarded',
          message: 'Escalation appears already forwarded.',
        ),
      );
    }
    if (sourceRoute.trim().isEmpty) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'source_route_missing',
          message: 'Source route is missing.',
        ),
      );
    }
    return warnings;
  }

  List<ChatEscalationCommandValidationWarning> _resolveWarnings({
    required String escalationId,
    required String threadId,
    required String resolverUid,
    String? currentStatus,
    required bool alreadyResolved,
  }) {
    final warnings = <ChatEscalationCommandValidationWarning>[];
    if (escalationId.trim().isEmpty) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'missing_escalation_id',
          message: 'Escalation id is missing.',
        ),
      );
    }
    if (threadId.trim().isEmpty) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'thread_id_missing',
          message: 'Thread id is missing.',
        ),
      );
    }
    if (resolverUid.trim().isEmpty) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'missing_admin_uid',
          message: 'Admin uid is missing.',
        ),
      );
    }
    if (currentStatus != null &&
        currentStatus.isNotEmpty &&
        !_isExpectedResolvableStatus(currentStatus)) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'resolve_from_unexpected_status',
          message: 'Escalation status is not an expected resolve state.',
        ),
      );
    }
    if (alreadyResolved) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'already_resolved',
          message: 'Escalation appears already resolved.',
        ),
      );
    }
    if (sourceRoute.trim().isEmpty) {
      warnings.add(
        const ChatEscalationCommandValidationWarning(
          code: 'source_route_missing',
          message: 'Source route is missing.',
        ),
      );
    }
    return warnings;
  }

  bool _isExpectedAssignableStatus(String status) {
    return const <String>{
      'open',
      'pending',
      'new',
      'unassigned',
      'created',
      'escalated',
    }.contains(status);
  }

  bool _isExpectedForwardableStatus(String status) {
    return const <String>{
      'open',
      'pending',
      'assigned',
      'admin_review',
      'escalated',
    }.contains(status);
  }

  bool _isExpectedResolvableStatus(String status) {
    return const <String>{
      'open',
      'pending',
      'assigned',
      'admin_review',
      'forwarded_to_clinician',
      'escalated',
    }.contains(status);
  }

  void _logShadow({
    required ChatEscalationCommandEnvelope envelope,
    required int warningCount,
    required String resultStatus,
  }) {
    debugPrint(
      'CHAT_ESCALATION_COMMAND_SHADOW '
      'commandName=${envelope.commandName} '
      'escalationId=${envelope.targetDocId} '
      'correlationId=${envelope.correlationId} '
      'warningCount=$warningCount '
      'resultStatus=$resultStatus '
      'sourceService=${envelope.sourceService} '
      'sourceRoute=${envelope.sourceRoute}',
    );
  }

  String _newCorrelationId(String escalationId) {
    final stamp = DateTime.now().toUtc().microsecondsSinceEpoch;
    return 'chat-escalation-assign-$stamp-${escalationId.hashCode}';
  }
}
