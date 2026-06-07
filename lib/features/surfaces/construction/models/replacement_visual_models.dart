class ReplacementVisualProfile {
  const ReplacementVisualProfile({
    required this.profileId,
    required this.oldFunction,
    required this.linkedVisual,
    required this.cardId,
    required this.replacementNeed,
  });

  final String profileId;
  final String oldFunction;
  final String linkedVisual;
  final String cardId;
  final String replacementNeed;
}

class ReplacementVisualPlan {
  const ReplacementVisualPlan({
    required this.planId,
    required this.replacements,
    required this.notes,
  });

  final String planId;
  final List<ReplacementVisualProfile> replacements;
  final String notes;
}
