class ConversationSanitizedPreview {
  const ConversationSanitizedPreview({
    required this.preview,
    required this.hashPlaceholder,
  });

  factory ConversationSanitizedPreview.fromText(
    String value, {
    int maxLength = 160,
  }) {
    final compact = value.trim().replaceAll(RegExp(r'\s+'), ' ');
    final preview =
        compact.length <= maxLength ? compact : compact.substring(0, maxLength);
    return ConversationSanitizedPreview(
      preview: preview,
      hashPlaceholder: 'conversation_hash_placeholder_${compact.length}',
    );
  }

  final String preview;
  final String hashPlaceholder;

  Map<String, Object?> toMap() {
    return {
      'preview': preview,
      'hashPlaceholder': hashPlaceholder,
    };
  }
}
