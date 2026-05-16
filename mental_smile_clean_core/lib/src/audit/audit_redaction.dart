class AuditRedaction {
  const AuditRedaction._();

  static const Set<String> forbiddenFields = {
    'fullRawConversation',
    'diagnosis',
    'mentalDisorder',
    'rawCrisisContent',
    'medicationRecommendation',
    'therapistOpinion',
    'psychiatricLabel',
  };

  static String sanitizedPreview(String value, {int maxLength = 160}) {
    final compact = value.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (compact.length <= maxLength) return compact;
    return compact.substring(0, maxLength);
  }

  static Map<String, Object?> removeForbiddenFields(
    Map<String, Object?> payload,
  ) {
    return Map<String, Object?>.fromEntries(
      payload.entries.where((entry) => !forbiddenFields.contains(entry.key)),
    );
  }
}
