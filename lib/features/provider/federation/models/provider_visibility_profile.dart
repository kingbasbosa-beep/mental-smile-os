class ProviderVisibilityProfile {
  const ProviderVisibilityProfile({
    required this.providerId,
    required this.visibilityStatus,
    required this.publicFields,
    required this.hiddenFields,
    required this.transparencyNotes,
  });

  final String providerId;
  final String visibilityStatus;
  final Set<String> publicFields;
  final Set<String> hiddenFields;
  final String transparencyNotes;
}
