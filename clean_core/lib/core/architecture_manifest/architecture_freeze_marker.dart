class ArchitectureFreezeMarker {
  const ArchitectureFreezeMarker({
    required this.frozen,
    required this.locked,
    required this.reasonKey,
  });

  static const ArchitectureFreezeMarker safeDefault = ArchitectureFreezeMarker(
    frozen: true,
    locked: true,
    reasonKey: 'architecture_frozen_until_review',
  );

  final bool frozen;
  final bool locked;
  final String reasonKey;
}
