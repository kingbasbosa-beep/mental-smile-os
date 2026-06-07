class VisualAssetProfile {
  const VisualAssetProfile({
    required this.assetId,
    required this.assetType,
    required this.surfaceId,
    required this.linkedFunction,
    required this.auditStatus,
  });

  final String assetId;
  final String assetType;
  final String surfaceId;
  final String linkedFunction;
  final String auditStatus;
}

class VisualAssetAudit {
  const VisualAssetAudit({
    required this.auditId,
    required this.assets,
    required this.notes,
  });

  final String auditId;
  final List<VisualAssetProfile> assets;
  final String notes;
}
