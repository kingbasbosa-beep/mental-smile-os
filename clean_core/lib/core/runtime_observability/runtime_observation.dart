class RuntimeObservation {
  const RuntimeObservation({
    required this.observationId,
    required this.ownerId,
    required this.sanitizedPreview,
    required this.traceHashPlaceholder,
    required this.telemetryRuntimeActive,
  });

  final String observationId;
  final String ownerId;
  final String sanitizedPreview;
  final String traceHashPlaceholder;
  final bool telemetryRuntimeActive;

  bool get hasOwner => ownerId.trim().isNotEmpty;

  bool get isSanitized =>
      sanitizedPreview.trim().isNotEmpty &&
      traceHashPlaceholder.trim().isNotEmpty;
}
