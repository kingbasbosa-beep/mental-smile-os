class AccessibilityPreference {
  const AccessibilityPreference({
    required this.mode,
    required this.preferredTextComplexity,
    required this.audioEnabled,
    required this.visualIconsEnabled,
    required this.screenReaderOptimized,
    required this.largeTextPreferred,
  });

  final String mode;
  final String preferredTextComplexity;
  final bool audioEnabled;
  final bool visualIconsEnabled;
  final bool screenReaderOptimized;
  final bool largeTextPreferred;
}
