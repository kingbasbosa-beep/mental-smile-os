import 'secure_runtime_scope.dart';
import 'secure_runtime_visibility_scope.dart';

class SecureRuntimePolicy {
  const SecureRuntimePolicy({
    required this.policyVersion,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.restrictedEnvironments,
    required this.runtimeAllowed,
    required this.providerAllowed,
    required this.backendGovernanceRequired,
    required this.failClosed,
  });

  static const SecureRuntimePolicy safeDefault = SecureRuntimePolicy(
    policyVersion: '2026-05-os6c',
    allowedScopes: <SecureRuntimeScope>{
      SecureRuntimeScope.governance,
      SecureRuntimeScope.audit,
      SecureRuntimeScope.review,
      SecureRuntimeScope.fallback,
    },
    allowedVisibilityScopes: <SecureRuntimeVisibilityScope>{
      SecureRuntimeVisibilityScope.backendOnly,
      SecureRuntimeVisibilityScope.auditOnly,
      SecureRuntimeVisibilityScope.governanceInternal,
    },
    restrictedEnvironments: <String>{'production'},
    runtimeAllowed: false,
    providerAllowed: false,
    backendGovernanceRequired: true,
    failClosed: true,
  );

  final String policyVersion;
  final Set<SecureRuntimeScope> allowedScopes;
  final Set<SecureRuntimeVisibilityScope> allowedVisibilityScopes;
  final Set<String> restrictedEnvironments;
  final bool runtimeAllowed;
  final bool providerAllowed;
  final bool backendGovernanceRequired;
  final bool failClosed;
}
