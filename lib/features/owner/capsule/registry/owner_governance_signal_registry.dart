class OwnerGovernanceSignalRegistry {
  const OwnerGovernanceSignalRegistry._();

  static const String ownerCapsuleRegistered = 'owner_capsule_registered';
  static const String claimsProfileDefined = 'claims_profile_defined';
  static const String deploymentStageDefined = 'deployment_stage_defined';
  static const String sovereignPackageRegistered =
      'sovereign_package_registered';

  static const Set<String> values = <String>{
    ownerCapsuleRegistered,
    claimsProfileDefined,
    deploymentStageDefined,
    sovereignPackageRegistered,
  };
}
