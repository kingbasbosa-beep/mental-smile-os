import '../models/sovereign_archive_package.dart';

class SovereignPackageClassification {
  const SovereignPackageClassification._();

  static const String constitutional = 'constitutional';
  static const String operational = 'operational';
  static const String recovery = 'recovery';
  static const String ownerOnly = 'owner_only';

  static const Set<String> values = <String>{
    constitutional,
    operational,
    recovery,
    ownerOnly,
  };
}

class SovereignPackageRegistry {
  const SovereignPackageRegistry._();

  static const List<SovereignArchivePackage> packages =
      <SovereignArchivePackage>[
    SovereignArchivePackage(
      packageId: 'constitutional_memory',
      packageCode: 'OWN-CON',
      classification: SovereignPackageClassification.constitutional,
      title: 'Constitutional Memory',
      archiveReady: true,
    ),
    SovereignArchivePackage(
      packageId: 'recovery_capsule',
      packageCode: 'OWN-REC',
      classification: SovereignPackageClassification.recovery,
      title: 'Recovery Capsule',
      archiveReady: true,
    ),
    SovereignArchivePackage(
      packageId: 'ownership_assets',
      packageCode: 'OWN-ASSET',
      classification: SovereignPackageClassification.ownerOnly,
      title: 'Ownership Assets',
      archiveReady: true,
    ),
  ];
}
