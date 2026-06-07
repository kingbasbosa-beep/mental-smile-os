import '../models/claims_provisioning_models.dart';
import '../models/deployment_strategy_models.dart';
import '../models/owner_capsule_manifest.dart';
import '../models/owner_capsule_package.dart';
import '../models/owner_identity_models.dart';
import '../models/owner_localization_models.dart';
import '../models/owner_readiness_alignment.dart';
import '../registry/claims_provisioning_registry.dart';
import '../registry/deployment_stage_registry.dart';
import '../registry/owner_capsule_registry.dart';
import '../registry/sovereign_package_registry.dart';
import '../reports/owner_governance_readiness_report.dart';

class OwnerGovernanceFoundationBuilder {
  const OwnerGovernanceFoundationBuilder._();

  static OwnerCapsuleManifest manifest() {
    return const OwnerCapsuleManifest(
      capsuleId: 'owner_capsule_foundation',
      title: 'Owner Capsule Foundation',
      purpose: 'Sovereign custody language without runtime execution.',
      version: 'v1',
      packageIds: <String>[
        OwnerCapsuleRegistry.recoveryAssets,
        OwnerCapsuleRegistry.ownershipAssets,
        OwnerCapsuleRegistry.constitutionalAssets,
      ],
      dependencyIds: <String>[
        'archive_export_foundation',
        'federation_meeting_system_foundation',
        'claims_provisioning_map',
      ],
      readinessStatus: 'foundation_ready_no_runtime_capsule',
    );
  }

  static List<OwnerCapsulePackage> capsulePackages() {
    return const <OwnerCapsulePackage>[
      OwnerCapsulePackage(
        packageId: OwnerCapsuleRegistry.recoveryAssets,
        packageType: 'recovery',
        title: 'Recovery Assets',
        classification: 'owner_only',
        archiveCode: 'OWN-REC',
      ),
      OwnerCapsulePackage(
        packageId: OwnerCapsuleRegistry.ownershipAssets,
        packageType: 'ownership',
        title: 'Ownership Assets',
        classification: 'owner_only',
        archiveCode: 'OWN-ASSET',
      ),
      OwnerCapsulePackage(
        packageId: OwnerCapsuleRegistry.constitutionalAssets,
        packageType: 'constitutional',
        title: 'Constitutional Assets',
        classification: 'constitutional',
        archiveCode: 'OWN-CON',
      ),
    ];
  }

  static ClaimsProvisioningMap claimsMap() {
    return const ClaimsProvisioningMap(
      mapId: 'claims_provisioning_map_v1',
      profiles: ClaimsProvisioningRegistry.profiles,
      dependencies: <ProvisioningDependency>[
        ProvisioningDependency(
          dependencyId: 'admin_sdk_claim_assignment',
          description: 'Claims require privileged Admin SDK assignment.',
          required: true,
        ),
        ProvisioningDependency(
          dependencyId: 'role_owner_decision_log',
          description: 'Every claim grant needs an owner decision record.',
          required: true,
        ),
      ],
      readinessStatus: 'map_ready_no_claim_execution',
    );
  }

  static DeploymentReadiness deploymentReadiness() {
    return const DeploymentReadiness(
      stage: DeploymentStageRegistry.federationReady,
      gates: <DeploymentGate>[
        DeploymentGate(
          gateId: 'rules_review_gate',
          description: 'Firestore rules must be reviewed before deployment.',
          required: true,
        ),
        DeploymentGate(
          gateId: 'claims_readiness_gate',
          description: 'Custom claims provisioning map must be ready.',
          required: true,
        ),
        DeploymentGate(
          gateId: 'legacy_freeze_gate',
          description: 'Legacy booking creation remains denied.',
          required: true,
        ),
      ],
      risks: <DeploymentRisk>[
        DeploymentRisk(
          riskId: 'claim_misprovisioning',
          severity: 'high',
          description: 'Wrong role claim may expose authority incorrectly.',
        ),
        DeploymentRisk(
          riskId: 'legacy_rule_regression',
          severity: 'high',
          description: 'Rule changes may accidentally revive legacy authority.',
        ),
      ],
      status: 'strategy_ready_no_deployment_execution',
    );
  }

  static OwnerIdentityProfile ownerIdentityProfile() {
    return const OwnerIdentityProfile(
      ownerDepartmentId: 'owner',
      identityCode: 'ID-OWN',
      reportPrefix: 'OWN',
      archivePrefix: 'OWN-ARC',
      capsulePrefix: 'OWN-CAP',
    );
  }

  static OwnerVisualProfile ownerVisualProfile() {
    return const OwnerVisualProfile(
      primaryColorToken: 'black',
      secondaryColorToken: 'gold',
      iconKey: 'verified_user',
      stripeColor: 'black',
    );
  }

  static OwnerReportProfile ownerReportProfile() {
    return const OwnerReportProfile(
      reportPrefix: 'OWN',
      reportLabel: 'Owner Governance',
      archiveStamp: 'OWNER-SOVEREIGN',
      classification: 'owner_only',
    );
  }

  static OwnerLocalizationProfile localizationProfile() {
    return const OwnerLocalizationProfile(
      labelAr: 'المالك السيادي',
      labelEn: 'Sovereign Owner',
      descriptionAr: 'حماية الهوية والذاكرة السيادية فقط.',
      descriptionEn: 'Protects sovereign identity and memory only.',
    );
  }

  static OwnerGuidanceProfile guidanceProfile() {
    return const OwnerGuidanceProfile(
      guidanceAr: 'المالك يحمي السيادة ولا يدير رحلة المستخدم.',
      guidanceEn: 'Owner protects sovereignty and does not operate journeys.',
      warningAr: 'لا تستخدم هذه المساحة كلوحة تحكم تشغيلية.',
      warningEn: 'Do not use this space as an operational control panel.',
    );
  }

  static OwnerEasyReadingProfile easyReadingProfile() {
    return const OwnerEasyReadingProfile(
      easyAr: 'هذه مساحة حماية وذاكرة، وليست إدارة يومية.',
      easyEn: 'This is a protection and memory space, not daily operations.',
    );
  }

  static OwnerReadinessAlignment readinessAlignment() {
    return const OwnerReadinessAlignment(
      readinessReference: 'owner_capsule_required',
      roadmapReference: 'build_owner_capsule_foundation',
      ownerCapsuleReference: 'owner_capsule_foundation',
      claimsReference: 'claims_provisioning_map_v1',
      deploymentReference: 'federation_ready',
    );
  }

  static OwnerGovernanceReadinessReport report() {
    return OwnerGovernanceReadinessReport(
      manifest: manifest(),
      claimsReadiness: const ClaimsReadinessSnapshot(
        roles: ClaimsProvisioningRegistry.roles,
        missingProfiles: <String>{},
        complianceStatus: 'claims_map_ready_no_provisioning_runtime',
      ),
      deploymentReadiness: deploymentReadiness(),
      sovereignPackages: SovereignPackageRegistry.packages,
      readinessAlignment: readinessAlignment(),
      complianceStatus: 'owner_governance_foundation_ready',
    );
  }
}
