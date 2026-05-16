class AuditReference {
  const AuditReference({
    required this.collectionPath,
    required this.documentId,
    required this.hashPlaceholder,
  });

  final String collectionPath;
  final String documentId;
  final String hashPlaceholder;

  Map<String, Object?> toMap() {
    return {
      'collectionPath': collectionPath,
      'documentId': documentId,
      'hashPlaceholder': hashPlaceholder,
    };
  }
}
