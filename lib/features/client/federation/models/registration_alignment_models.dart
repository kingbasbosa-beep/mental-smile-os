class RegistrationFieldProfile {
  const RegistrationFieldProfile({
    required this.fieldId,
    required this.displayName,
    required this.classification,
    required this.ownerSurface,
  });

  final String fieldId;
  final String displayName;
  final String classification;
  final String ownerSurface;
}

class RegistrationAlignmentProfile {
  const RegistrationAlignmentProfile({
    required this.profileId,
    required this.registrationFields,
    required this.profileFields,
    required this.publicPageFields,
    required this.dashboardFields,
  });

  final String profileId;
  final Set<String> registrationFields;
  final Set<String> profileFields;
  final Set<String> publicPageFields;
  final Set<String> dashboardFields;
}
