class PublicReputationProfile {
  const PublicReputationProfile({
    required this.targetType,
    required this.targetId,
    required this.generalRatingLabel,
    required this.collapsibleComments,
  });

  final String targetType;
  final String targetId;
  final String generalRatingLabel;
  final bool collapsibleComments;
}

class PublicRatingProfile {
  const PublicRatingProfile({
    required this.targetType,
    required this.label,
    required this.sessionIndependent,
  });

  final String targetType;
  final String label;
  final bool sessionIndependent;
}

class PublicCommentProfile {
  const PublicCommentProfile({
    required this.targetType,
    required this.defaultVisibility,
    required this.threadingEnabled,
  });

  final String targetType;
  final String defaultVisibility;
  final bool threadingEnabled;
}

class ReputationVisibilityAlignment {
  const ReputationVisibilityAlignment({
    required this.targetType,
    required this.summaryFirst,
    required this.commentsExpandable,
  });

  final String targetType;
  final bool summaryFirst;
  final bool commentsExpandable;
}
