class ObservatoryCleanupMarkerRegistry {
  const ObservatoryCleanupMarkerRegistry._();

  static const String localizationAlignment = 'localization_alignment';
  static const String identityAlignment = 'identity_alignment';
  static const String archiveAlignment = 'archive_alignment';
  static const String readinessMarker = 'readiness_marker';
  static const String separationMarker = 'separation_marker';
  static const String legacyCleanupPack = 'legacy_cleanup_pack';
  static const String monitoringLabels = 'monitoring_labels';
  static const String reportPrefixes = 'report_prefixes';
  static const String archiveLabels = 'archive_labels';

  static const Set<String> values = <String>{
    localizationAlignment,
    identityAlignment,
    archiveAlignment,
    readinessMarker,
    separationMarker,
    legacyCleanupPack,
    monitoringLabels,
    reportPrefixes,
    archiveLabels,
  };
}
