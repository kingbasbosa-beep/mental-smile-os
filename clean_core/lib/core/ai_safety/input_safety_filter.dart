class InputSafetyFilterResult {
  const InputSafetyFilterResult({
    required this.allowed,
    required this.blockedCategories,
    required this.sanitizedPreview,
  });

  final bool allowed;
  final List<String> blockedCategories;
  final String sanitizedPreview;
}

class InputSafetyFilter {
  const InputSafetyFilter();

  static const List<String> blockedCategoryPlaceholders = [
    'medical_diagnosis_request',
    'medication_instruction_request',
    'emergency_guarantee_request',
    'therapist_roleplay_request',
  ];

  InputSafetyFilterResult check(String input) {
    final lower = input.toLowerCase();
    final blocked = <String>[
      if (lower.contains('diagnose')) 'medical_diagnosis_request',
      if (lower.contains('medication')) 'medication_instruction_request',
      if (lower.contains('guarantee emergency')) 'emergency_guarantee_request',
      if (lower.contains('act as my therapist')) 'therapist_roleplay_request',
    ];

    return InputSafetyFilterResult(
      allowed: blocked.isEmpty,
      blockedCategories: blocked,
      sanitizedPreview: _preview(input),
    );
  }

  String _preview(String input) {
    final compact = input.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (compact.length <= 120) return compact;
    return compact.substring(0, 120);
  }
}
