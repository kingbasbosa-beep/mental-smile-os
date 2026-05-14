class ConversationMessageReference {
  const ConversationMessageReference({
    required this.sessionId,
    required this.messageId,
    required this.hashPlaceholder,
  });

  final String sessionId;
  final String messageId;
  final String hashPlaceholder;

  Map<String, Object?> toMap() {
    return {
      'sessionId': sessionId,
      'messageId': messageId,
      'hashPlaceholder': hashPlaceholder,
    };
  }
}
