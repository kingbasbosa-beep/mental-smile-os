class FieldParityProfile {
  const FieldParityProfile({
    required this.parityId,
    required this.registrationField,
    required this.profileField,
    required this.publicPageField,
    required this.dashboardField,
  });

  final String parityId;
  final String registrationField;
  final String profileField;
  final String publicPageField;
  final String dashboardField;
}

class FieldParityAlignment {
  const FieldParityAlignment({
    required this.surface,
    required this.parityProfileId,
    required this.alignmentStatus,
  });

  final String surface;
  final String parityProfileId;
  final String alignmentStatus;
}
