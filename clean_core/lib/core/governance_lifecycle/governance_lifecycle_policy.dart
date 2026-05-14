import 'governance_lifecycle_scope.dart';
import 'governance_lifecycle_state.dart';
import 'governance_lifecycle_visibility_scope.dart';

class GovernanceLifecyclePolicy {
  const GovernanceLifecyclePolicy({
    required this.policyVersion,
    required this.allowedStates,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.auditRequired,
    required this.reviewRequired,
    required this.backendGovernanceRequired,
    required this.providerAllowed,
    required this.failClosed,
  });

  static const GovernanceLifecyclePolicy safeDefault =
      GovernanceLifecyclePolicy(
    policyVersion: '2026-05-os5b',
    allowedStates: <GovernanceLifecycleState>{
      GovernanceLifecycleState.inactive,
      GovernanceLifecycleState.fallbackOnly,
      GovernanceLifecycleState.reviewRequired,
      GovernanceLifecycleState.locked,
    },
    allowedScopes: <GovernanceLifecycleScope>{
      GovernanceLifecycleScope.policy,
      GovernanceLifecycleScope.audit,
      GovernanceLifecycleScope.review,
    },
    allowedVisibilityScopes: <GovernanceLifecycleVisibilityScope>{
      GovernanceLifecycleVisibilityScope.backendOnly,
      GovernanceLifecycleVisibilityScope.auditOnly,
    },
    auditRequired: true,
    reviewRequired: true,
    backendGovernanceRequired: true,
    providerAllowed: false,
    failClosed: true,
  );

  final String policyVersion;
  final Set<GovernanceLifecycleState> allowedStates;
  final Set<GovernanceLifecycleScope> allowedScopes;
  final Set<GovernanceLifecycleVisibilityScope> allowedVisibilityScopes;
  final bool auditRequired;
  final bool reviewRequired;
  final bool backendGovernanceRequired;
  final bool providerAllowed;
  final bool failClosed;
}
