import 'governance_kernel_scope.dart';
import 'governance_kernel_visibility_scope.dart';

class GovernanceKernelPolicy {
  const GovernanceKernelPolicy({
    required this.policyVersion,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.auditRequired,
    required this.backendGovernanceRequired,
    required this.providerAllowed,
    required this.memoryAllowed,
    required this.conversationAllowed,
    required this.failClosed,
  });

  static const GovernanceKernelPolicy safeDefault = GovernanceKernelPolicy(
    policyVersion: '2026-05-os5a',
    allowedScopes: <GovernanceKernelScope>{
      GovernanceKernelScope.policyRuntime,
      GovernanceKernelScope.executionBoundary,
      GovernanceKernelScope.audit,
    },
    allowedVisibilityScopes: <GovernanceKernelVisibilityScope>{
      GovernanceKernelVisibilityScope.backendOnly,
      GovernanceKernelVisibilityScope.auditOnly,
    },
    auditRequired: true,
    backendGovernanceRequired: true,
    providerAllowed: false,
    memoryAllowed: false,
    conversationAllowed: false,
    failClosed: true,
  );

  final String policyVersion;
  final Set<GovernanceKernelScope> allowedScopes;
  final Set<GovernanceKernelVisibilityScope> allowedVisibilityScopes;
  final bool auditRequired;
  final bool backendGovernanceRequired;
  final bool providerAllowed;
  final bool memoryAllowed;
  final bool conversationAllowed;
  final bool failClosed;
}
