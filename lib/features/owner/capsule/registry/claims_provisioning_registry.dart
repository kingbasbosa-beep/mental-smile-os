import '../models/claims_provisioning_models.dart';

class ClaimsProvisioningRegistry {
  const ClaimsProvisioningRegistry._();

  static const String owner = 'owner';
  static const String monitoringOperator = 'monitoring_operator';
  static const String registrySteward = 'registry_steward';
  static const String declarationReviewer = 'declaration_reviewer';
  static const String supportObserver = 'support_observer';

  static const Set<String> roles = <String>{
    owner,
    monitoringOperator,
    registrySteward,
    declarationReviewer,
    supportObserver,
  };

  static const List<RoleProvisioningProfile> profiles =
      <RoleProvisioningProfile>[
    RoleProvisioningProfile(
      role: owner,
      purpose: 'Sovereign custody only.',
      claimKey: 'role',
      allowedAuthority: 'identity_and_recovery_custody',
    ),
    RoleProvisioningProfile(
      role: monitoringOperator,
      purpose: 'Read monitoring snapshots and alerts.',
      claimKey: 'role',
      allowedAuthority: 'observability',
    ),
    RoleProvisioningProfile(
      role: registrySteward,
      purpose: 'Maintain federation registries.',
      claimKey: 'role',
      allowedAuthority: 'registry_stewardship',
    ),
    RoleProvisioningProfile(
      role: declarationReviewer,
      purpose: 'Review declaration completeness.',
      claimKey: 'role',
      allowedAuthority: 'visibility_review',
    ),
    RoleProvisioningProfile(
      role: supportObserver,
      purpose: 'Observe and help support flows.',
      claimKey: 'role',
      allowedAuthority: 'support_observation',
    ),
  ];
}
