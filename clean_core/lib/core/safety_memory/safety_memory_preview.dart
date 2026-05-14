class SafetyMemoryPreview {
  const SafetyMemoryPreview({
    required this.sanitizedPreview,
    required this.hashPlaceholder,
  });

  factory SafetyMemoryPreview.fromText(String value, {int maxLength = 120}) {
    final compact = value.trim().replaceAll(RegExp(r'\s+'), ' ');
    final preview =
        compact.length <= maxLength ? compact : compact.substring(0, maxLength);
    return SafetyMemoryPreview(
      sanitizedPreview: preview,
      hashPlaceholder: 'safety_memory_hash_placeholder_${compact.length}',
    );
  }

  final String sanitizedPreview;
  final String hashPlaceholder;

  Map<String, Object?> toMap() {
    return {
      'sanitizedPreview': sanitizedPreview,
      'hashPlaceholder': hashPlaceholder,
    };
  }
}
