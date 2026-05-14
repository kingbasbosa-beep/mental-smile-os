import 'runtime_execution_scope.dart';
import 'runtime_execution_visibility_scope.dart';

class RuntimeExecutionPolicy {
  const RuntimeExecutionPolicy({
    required this.policyVersion,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.auditRequired,
    required this.policyRequired,
    required this.backendGovernanceRequired,
    required this.providerAllowed,
    required this.failClosed,
  });

  static const RuntimeExecutionPolicy safeDefault = RuntimeExecutionPolicy(
    policyVersion: '2026-05-os4f',
    allowedScopes: <RuntimeExecutionScope>{
      RuntimeExecutionScope.policyCheck,
      RuntimeExecutionScope.fallbackExecution,
    },
    allowedVisibilityScopes: <RuntimeExecutionVisibilityScope>{
      RuntimeExecutionVisibilityScope.backendOnly,
      RuntimeExecutionVisibilityScope.auditOnly,
    },
    auditRequired: true,
    policyRequired: true,
    backendGovernanceRequired: true,
    providerAllowed: false,
    failClosed: true,
  );

  final String policyVersion;
  final Set<RuntimeExecutionScope> allowedScopes;
  final Set<RuntimeExecutionVisibilityScope> allowedVisibilityScopes;
  final bool auditRequired;
  final bool policyRequired;
  final bool backendGovernanceRequired;
  final bool providerAllowed;
  final bool failClosed;
}
