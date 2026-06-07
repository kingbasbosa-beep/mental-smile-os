import '../registry/archive_export_package_type_registry.dart';
import '../registry/archive_export_registry.dart';

class ArchivePackagingPolicy {
  const ArchivePackagingPolicy._();

  static const Set<String> forbiddenObjectTypes = <String>{
    'raw_signal',
    'raw_signals',
    'signal_package',
    'booking_requests',
    'bookingRequests',
    'assignment',
  };

  static const Set<String> forbiddenSourceTerms = <String>{
    'booking_requests',
    'bookingRequests',
    'assignment',
    'booking',
  };

  static bool isPackageTypeSupported(String packageType) {
    return ArchiveExportPackageTypeRegistry.values.contains(packageType);
  }

  static bool canPackageObjectType(String objectType) {
    final normalized = objectType.trim();
    return ArchiveExportRegistry.supportedObjectTypes.contains(normalized) &&
        !forbiddenObjectTypes.contains(normalized);
  }

  static bool canPackageSource(String sourceDomain) {
    final normalized = sourceDomain.trim();
    for (final term in forbiddenSourceTerms) {
      if (normalized.contains(term)) return false;
    }
    return normalized.isNotEmpty;
  }
}
