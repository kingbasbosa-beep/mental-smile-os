import 'trusted_operation_type.dart';

class TrustedOperationContract {
  const TrustedOperationContract({
    required this.operationType,
    required this.allowedCallerType,
    required this.requiresAuthenticatedUser,
    required this.protectedFields,
    required this.serverOwnedOutcomes,
    required this.requiresAuditTrail,
    required this.requiresPolicySnapshot,
  });

  final TrustedOperationType operationType;
  final String allowedCallerType;
  final bool requiresAuthenticatedUser;
  final Set<String> protectedFields;
  final Set<String> serverOwnedOutcomes;
  final bool requiresAuditTrail;
  final bool requiresPolicySnapshot;

  Map<String, Object?> toMap() {
    return {
      'operationType': operationType.key,
      'allowedCallerType': allowedCallerType,
      'requiresAuthenticatedUser': requiresAuthenticatedUser,
      'protectedFields': protectedFields.toList(growable: false),
      'serverOwnedOutcomes': serverOwnedOutcomes.toList(growable: false),
      'requiresAuditTrail': requiresAuditTrail,
      'requiresPolicySnapshot': requiresPolicySnapshot,
    };
  }
}
