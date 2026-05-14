class PromptInjectionGuardResult {
  const PromptInjectionGuardResult({
    required this.allowed,
    required this.detectedPatterns,
  });

  final bool allowed;
  final List<String> detectedPatterns;
}

class PromptInjectionGuard {
  const PromptInjectionGuard();

  PromptInjectionGuardResult check(String input) {
    final lower = input.toLowerCase();
    final patterns = <String>[
      if (lower.contains('ignore rules')) 'ignore_rules',
      if (lower.contains('act as doctor')) 'act_as_doctor',
      if (lower.contains('bypass policy')) 'bypass_policy',
      if (lower.contains('reveal prompt')) 'reveal_prompt',
      if (lower.contains('disable safety')) 'disable_safety',
    ];

    return PromptInjectionGuardResult(
      allowed: patterns.isEmpty,
      detectedPatterns: patterns,
    );
  }
}
