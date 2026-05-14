class OutputSafetyValidatorResult {
  const OutputSafetyValidatorResult({
    required this.valid,
    required this.violations,
  });

  final bool valid;
  final List<String> violations;
}

class OutputSafetyValidator {
  const OutputSafetyValidator();

  OutputSafetyValidatorResult validate(String output) {
    final lower = output.toLowerCase();
    final violations = <String>[
      if (lower.contains('you are diagnosed')) 'diagnosis_behavior',
      if (lower.contains('take this medication')) 'medication_authority',
      if (lower.contains('i am your therapist')) 'therapist_roleplay',
      if (lower.contains('emergency help is guaranteed'))
        'emergency_guarantee',
    ];

    return OutputSafetyValidatorResult(
      valid: violations.isEmpty,
      violations: violations,
    );
  }
}
