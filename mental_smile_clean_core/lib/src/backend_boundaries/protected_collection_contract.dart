class ProtectedCollectionContract {
  const ProtectedCollectionContract({
    required this.collectionPath,
    required this.serverOwnedFields,
    required this.clientCreateAllowed,
    required this.clientUpdateAllowed,
  });

  final String collectionPath;
  final Set<String> serverOwnedFields;
  final bool clientCreateAllowed;
  final bool clientUpdateAllowed;

  Map<String, Object?> toMap() {
    return {
      'collectionPath': collectionPath,
      'serverOwnedFields': serverOwnedFields.toList(growable: false),
      'clientCreateAllowed': clientCreateAllowed,
      'clientUpdateAllowed': clientUpdateAllowed,
    };
  }
}
