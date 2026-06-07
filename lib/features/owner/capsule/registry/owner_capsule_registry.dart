class OwnerCapsuleRegistry {
  const OwnerCapsuleRegistry._();

  static const String recoveryAssets = 'recovery_assets';
  static const String ownershipAssets = 'ownership_assets';
  static const String legalAssets = 'legal_assets';
  static const String constitutionalAssets = 'constitutional_assets';
  static const String emergencyRecoveryAssets = 'emergency_recovery_assets';

  static const Set<String> values = <String>{
    recoveryAssets,
    ownershipAssets,
    legalAssets,
    constitutionalAssets,
    emergencyRecoveryAssets,
  };
}
