import 'trusted_operation_contract.dart';
import 'trusted_operation_type.dart';

class BookingLifecycleBoundary {
  const BookingLifecycleBoundary._();

  static const TrustedOperationContract contract = TrustedOperationContract(
    operationType: TrustedOperationType.bookingOrchestration,
    allowedCallerType: 'trusted_server',
    requiresAuthenticatedUser: true,
    protectedFields: {
      'workflowStage',
      'paymentStatus',
      'reviewStatus',
      'sessionStatus',
      'adminDecision',
    },
    serverOwnedOutcomes: {
      'booking_state_transition',
      'payment_state_transition',
      'review_state_transition',
    },
    requiresAuditTrail: true,
    requiresPolicySnapshot: false,
  );
}
