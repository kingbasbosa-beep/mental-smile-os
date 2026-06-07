class PublicComment {
  const PublicComment({
    required this.commentId,
    required this.targetType,
    required this.targetId,
    required this.commentText,
    required this.createdAt,
    required this.classification,
  });

  final String commentId;
  final String targetType;
  final String targetId;
  final String commentText;
  final DateTime createdAt;
  final String classification;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'commentId': commentId,
      'targetType': targetType,
      'targetId': targetId,
      'commentText': commentText,
      'createdAt': createdAt.toIso8601String(),
      'classification': classification,
    };
  }
}
