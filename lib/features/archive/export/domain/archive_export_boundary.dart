import '../models/archive_export_object_reference.dart';
import '../models/archive_export_package.dart';
import 'archive_packaging_policy.dart';

class ArchiveExportBoundary {
  const ArchiveExportBoundary._();

  static bool allowsReference(ArchiveExportObjectReference reference) {
    return ArchivePackagingPolicy.canPackageObjectType(reference.objectType) &&
        ArchivePackagingPolicy.canPackageSource(reference.sourceDomain);
  }

  static bool allowsPackage(ArchiveExportPackage package) {
    if (!ArchivePackagingPolicy.isPackageTypeSupported(package.packageType)) {
      return false;
    }
    for (final reference in package.includedObjects) {
      if (!allowsReference(reference)) return false;
    }
    return true;
  }
}
