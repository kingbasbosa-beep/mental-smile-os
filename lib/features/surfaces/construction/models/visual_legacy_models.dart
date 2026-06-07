class VisualLegacyProfile {
  const VisualLegacyProfile({
    required this.profileId,
    required this.assetId,
    required this.surfaceId,
    required this.classification,
    required this.recommendedAction,
  });

  final String profileId;
  final String assetId;
  final String surfaceId;
  final String classification;
  final String recommendedAction;
}

class VisualLegacyAudit {
  const VisualLegacyAudit({
    required this.auditId,
    required this.legacyProfiles,
    required this.notes,
  });

  final String auditId;
  final List<VisualLegacyProfile> legacyProfiles;
  final String notes;
}
