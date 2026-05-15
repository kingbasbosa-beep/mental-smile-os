import 'architecture_manifest_scope.dart';
import 'architecture_manifest_visibility_scope.dart';

class ArchitectureManifestPolicy {
  const ArchitectureManifestPolicy({
    required this.policyVersion,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.runtimeAllowed,
    required this.providerAllowed,
    required this.backendGovernanceRequired,
    required this.extractionAllowed,
    required this.failClosed,
  });

  static const ArchitectureManifestPolicy safeDefault =
      ArchitectureManifestPolicy(
    policyVersion: '2026-05-os6g',
    allowedScopes: <ArchitectureManifestScope>{
      ArchitectureManifestScope.legalFoundation,
      ArchitectureManifestScope.aiGovernance,
      ArchitectureManifestScope.aiSafetyCore,
      ArchitectureManifestScope.backendBoundaries,
      ArchitectureManifestScope.governanceKernel,
      ArchitectureManifestScope.systemTopology,
    },
    allowedVisibilityScopes: <ArchitectureManifestVisibilityScope>{
      ArchitectureManifestVisibilityScope.auditOnly,
      ArchitectureManifestVisibilityScope.architectureInternal,
      ArchitectureManifestVisibilityScope.extractionPlanning,
    },
    runtimeAllowed: false,
    providerAllowed: false,
    backendGovernanceRequired: true,
    extractionAllowed: false,
    failClosed: true,
  );

  final String policyVersion;
  final Set<ArchitectureManifestScope> allowedScopes;
  final Set<ArchitectureManifestVisibilityScope> allowedVisibilityScopes;
  final bool runtimeAllowed;
  final bool providerAllowed;
  final bool backendGovernanceRequired;
  final bool extractionAllowed;
  final bool failClosed;
}
