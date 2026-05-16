import 'trusted_backend_visibility_scope.dart';

class TrustedBackendPolicy {
  const TrustedBackendPolicy({
    required this.policyVersion,
    required this.allowedVisibilityScopes,
    required this.restrictedEnvironments,
    required this.backendEnabled,
    required this.runtimeAllowed,
    required this.providerAllowed,
    required this.failClosed,
  });

  static const TrustedBackendPolicy safeDefault = TrustedBackendPolicy(
    policyVersion: '2026-05-os6a',
    allowedVisibilityScopes: <TrustedBackendVisibilityScope>{
      TrustedBackendVisibilityScope.backendOnly,
      TrustedBackendVisibilityScope.auditOnly,
      TrustedBackendVisibilityScope.governanceInternal,
    },
    restrictedEnvironments: <String>{'production'},
    backendEnabled: false,
    runtimeAllowed: false,
    providerAllowed: false,
    failClosed: true,
  );

  final String policyVersion;
  final Set<TrustedBackendVisibilityScope> allowedVisibilityScopes;
  final Set<String> restrictedEnvironments;
  final bool backendEnabled;
  final bool runtimeAllowed;
  final bool providerAllowed;
  final bool failClosed;
}
