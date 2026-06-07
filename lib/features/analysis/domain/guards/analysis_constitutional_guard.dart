class AnalysisConstitutionalGuard {
  const AnalysisConstitutionalGuard._();

  static const List<String> forbiddenTerms = <String>[
    'diagnosis',
    'diagnose',
    'treatment',
    'therapy plan',
    'clinical recommendation',
    'recommendation for client',
    'recommendation for provider',
    'user profiling',
    'individual targeting',
    'client profile',
    'provider profile',
    'center profile',
    '\u062A\u0634\u062E\u064A\u0635',
    '\u0639\u0644\u0627\u062C',
    '\u062E\u0637\u0629 \u0639\u0644\u0627\u062C',
    '\u062A\u0648\u0635\u064A\u0629 \u0639\u0644\u0627\u062C\u064A\u0629',
    '\u062A\u0648\u0635\u064A\u0629 \u0644\u0644\u0639\u0645\u064A\u0644',
    '\u062A\u0648\u0635\u064A\u0629 \u0644\u0645\u0642\u062F\u0645 \u0627\u0644\u062E\u062F\u0645\u0629',
    '\u0627\u0633\u062A\u0647\u062F\u0627\u0641 \u0641\u0631\u062F\u064A',
    '\u0645\u0644\u0641 \u0627\u0644\u0639\u0645\u064A\u0644',
  ];

  static bool isAllowedText(String text) {
    final normalized = text.trim().toLowerCase();
    return forbiddenTerms.every(
      (term) => !normalized.contains(term.toLowerCase()),
    );
  }

  static String? failureReason(String text) {
    return isAllowedText(text) ? null : 'constitutional_observation_violation';
  }
}
