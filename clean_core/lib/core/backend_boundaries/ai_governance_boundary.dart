import 'trusted_operation_contract.dart';
import 'trusted_operation_type.dart';

class AiGovernanceBoundary {
  const AiGovernanceBoundary._();

  static TrustedOperationContract contractFor(
    TrustedOperationType operationType,
  ) {
    return TrustedOperationContract(
      operationType: operationType,
      allowedCallerType: 'trusted_server',
      requiresAuthenticatedUser: true,
      protectedFields: const {
        'runtimeMode',
        'moderationOutcome',
        'policyPublished',
        'policySnapshotId',
        'outputValidated',
        'incidentCreated',
      },
      serverOwnedOutcomes: const {
        'policy_snapshot_enforced',
        'audit_trace_created',
        'fallback_only_mode_respected',
        'incident_creation_decided',
      },
      requiresAuditTrail: true,
      requiresPolicySnapshot: true,
    );
  }
}
