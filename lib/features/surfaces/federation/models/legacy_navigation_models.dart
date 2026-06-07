class LegacyNavigationEntry {
  const LegacyNavigationEntry({
    required this.entryId,
    required this.entryType,
    required this.routeName,
    required this.surfaceId,
    required this.classification,
  });

  final String entryId;
  final String entryType;
  final String routeName;
  final String surfaceId;
  final String classification;
}

class LegacyNavigationAudit {
  const LegacyNavigationAudit({
    required this.auditId,
    required this.entries,
    required this.status,
  });

  final String auditId;
  final List<LegacyNavigationEntry> entries;
  final String status;
}
