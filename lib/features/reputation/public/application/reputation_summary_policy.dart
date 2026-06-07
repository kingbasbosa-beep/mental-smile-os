import '../models/comment_visibility_mode.dart';

class ReputationSummaryPolicy {
  const ReputationSummaryPolicy._();

  static const String defaultCommentVisibility =
      CommentVisibilityMode.collapsed;

  static bool startsCollapsed(String visibilityMode) {
    return visibilityMode == CommentVisibilityMode.collapsed;
  }
}
