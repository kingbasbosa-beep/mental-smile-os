class AuditReference {
  const AuditReference({
    required this.collectionPath,
    required this.documentId,
    required this.hashPlaceholder,
  });

  // Passive reference metadata only. These labels do not prove backend writes,
  // document access, integrity, or trusted audit linkage.
  final String collectionPath;
  final String documentId;
  final String hashPlaceholder;
}
