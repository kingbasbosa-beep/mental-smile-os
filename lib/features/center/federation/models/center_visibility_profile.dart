class CenterVisibilityProfile {
  const CenterVisibilityProfile({
    required this.centerId,
    required this.visibilityStatus,
    required this.publicFields,
    required this.hiddenFields,
    required this.transparencyNotes,
  });

  final String centerId;
  final String visibilityStatus;
  final Set<String> publicFields;
  final Set<String> hiddenFields;
  final String transparencyNotes;
}
