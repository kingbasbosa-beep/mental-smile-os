class AiSafetyPayloadSanitizer {
  const AiSafetyPayloadSanitizer._();

  static String sanitizedPreview(String value, {int maxLength = 160}) {
    final compact = value.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (compact.length <= maxLength) return compact;
    return compact.substring(0, maxLength);
  }

  static String hashPlaceholder(String seed) {
    final normalized = seed.trim();
    if (normalized.isEmpty) return 'hash_placeholder_empty';
    return 'hash_placeholder_${normalized.length}';
  }

  static List<String> sanitizedTriggers(Iterable<String> values) {
    return values
        .map((value) => sanitizedPreview(value, maxLength: 40))
        .where((value) => value.isNotEmpty)
        .toSet()
        .toList(growable: false);
  }
}
