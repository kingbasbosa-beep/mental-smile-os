import 'trusted_operation_contract.dart';
import 'trusted_operation_type.dart';
import 'ai_governance_boundary.dart';
import 'booking_lifecycle_boundary.dart';
import 'escalation_boundary_contract.dart';

class CloudFunctionBoundary {
  const CloudFunctionBoundary._();

  static TrustedOperationContract contractFor(
    TrustedOperationType operationType,
  ) {
    switch (operationType) {
      case TrustedOperationType.bookingOrchestration:
        return BookingLifecycleBoundary.contract;
      case TrustedOperationType.escalationCreation:
        return EscalationBoundaryContract.contract;
      case TrustedOperationType.aiSafetyEventCreation:
      case TrustedOperationType.policySnapshotPublishing:
        return AiGovernanceBoundary.contractFor(operationType);
      case TrustedOperationType.chatThreadCreation:
      case TrustedOperationType.aggregateRatingUpdate:
      case TrustedOperationType.legalConsentRecording:
      case TrustedOperationType.notificationDispatch:
        return TrustedOperationContract(
          operationType: operationType,
          allowedCallerType: 'trusted_server',
          requiresAuthenticatedUser: true,
          protectedFields: const {},
          serverOwnedOutcomes: const {},
          requiresAuditTrail: true,
          requiresPolicySnapshot: false,
        );
    }
  }
}
