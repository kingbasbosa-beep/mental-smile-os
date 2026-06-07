import '../models/claims_provisioning_models.dart';
import '../models/deployment_strategy_models.dart';
import '../models/owner_capsule_manifest.dart';
import '../reports/owner_governance_readiness_report.dart';

abstract class OwnerCapsuleManifestBuilder {
  OwnerCapsuleManifest buildManifest();
}

abstract class ClaimsProvisioningMapBuilder {
  ClaimsProvisioningMap buildClaimsMap();
}

abstract class FirestoreDeploymentStrategyBuilder {
  DeploymentReadiness buildDeploymentReadiness();
}

abstract class OwnerGovernanceReportBuilder {
  OwnerGovernanceReadinessReport buildOwnerGovernanceReport();
}
