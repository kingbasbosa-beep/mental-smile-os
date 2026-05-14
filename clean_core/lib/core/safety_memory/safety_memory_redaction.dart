class SafetyMemoryRedaction {
  const SafetyMemoryRedaction._();

  static const Set<String> forbiddenFields = {
    'diagnosis',
    'medicationMemory',
    'rawCrisisContent',
    'rawPrompt',
    'fullConversation',
    'psychologicalProfile',
    'behaviorManipulationSignal',
  };

  static Map<String, Object?> removeForbiddenFields(
    Map<String, Object?> payload,
  ) {
    return Map<String, Object?>.fromEntries(
      payload.entries.where((entry) => !forbiddenFields.contains(entry.key)),
    );
  }
}
