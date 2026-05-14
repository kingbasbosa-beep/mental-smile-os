import 'trusted_operation_contract.dart';
import 'trusted_operation_type.dart';

class EscalationBoundaryContract {
  const EscalationBoundaryContract._();

  static const TrustedOperationContract contract = TrustedOperationContract(
    operationType: TrustedOperationType.escalationCreation,
    allowedCallerType: 'trusted_server',
    requiresAuthenticatedUser: true,
    protectedFields: {
      'escalationStatus',
      'crisisSeverity',
      'safetyLocked',
      'moderationOutcome',
    },
    serverOwnedOutcomes: {
      'escalation_case_created',
      'incident_linked',
      'review_required',
    },
    requiresAuditTrail: true,
    requiresPolicySnapshot: true,
  );
}
