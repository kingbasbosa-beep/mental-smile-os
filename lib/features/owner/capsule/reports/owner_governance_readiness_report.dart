import '../models/claims_provisioning_models.dart';
import '../models/deployment_strategy_models.dart';
import '../models/owner_capsule_manifest.dart';
import '../models/owner_readiness_alignment.dart';
import '../models/sovereign_archive_package.dart';

class OwnerGovernanceReadinessReport {
  const OwnerGovernanceReadinessReport({
    required this.manifest,
    required this.claimsReadiness,
    required this.deploymentReadiness,
    required this.sovereignPackages,
    required this.readinessAlignment,
    required this.complianceStatus,
  });

  final OwnerCapsuleManifest manifest;
  final ClaimsReadinessSnapshot claimsReadiness;
  final DeploymentReadiness deploymentReadiness;
  final List<SovereignArchivePackage> sovereignPackages;
  final OwnerReadinessAlignment readinessAlignment;
  final String complianceStatus;
}
