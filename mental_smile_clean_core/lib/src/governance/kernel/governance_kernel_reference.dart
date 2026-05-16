import 'governance_kernel_scope.dart';

class GovernanceKernelReference {
  const GovernanceKernelReference({
    required this.referenceId,
    required this.scope,
    required this.hashPlaceholder,
  });

  final String referenceId;
  final GovernanceKernelScope scope;
  final String hashPlaceholder;

  Map<String, Object?> toMap() {
    return {
      'referenceId': referenceId,
      'scope': scope.key,
      'hashPlaceholder': hashPlaceholder,
    };
  }
}
