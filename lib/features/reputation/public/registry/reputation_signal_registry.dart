class ReputationSignalRegistry {
  const ReputationSignalRegistry._();

  static const String ratingAdded = 'rating_added';
  static const String commentAdded = 'comment_added';
  static const String commentExpanded = 'comment_expanded';
  static const String reputationViewed = 'reputation_viewed';

  static const Set<String> values = <String>{
    ratingAdded,
    commentAdded,
    commentExpanded,
    reputationViewed,
  };
}
