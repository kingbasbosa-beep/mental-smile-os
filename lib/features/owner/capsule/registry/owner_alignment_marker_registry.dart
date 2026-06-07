class OwnerAlignmentMarkerRegistry {
  const OwnerAlignmentMarkerRegistry._();

  static const String ownerLabel = 'owner_label';
  static const String ownerLocalization = 'owner_localization';
  static const String archiveLabel = 'archive_label';
  static const String reportPrefix = 'report_prefix';
  static const String readinessMarker = 'readiness_marker';
  static const String separationMarker = 'separation_marker';

  static const Set<String> values = <String>{
    ownerLabel,
    ownerLocalization,
    archiveLabel,
    reportPrefix,
    readinessMarker,
    separationMarker,
  };
}
