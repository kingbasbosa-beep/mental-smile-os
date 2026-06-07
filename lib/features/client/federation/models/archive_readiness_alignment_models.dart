class RegistrationArchiveProfile {
  const RegistrationArchiveProfile({
    required this.profileId,
    required this.archiveCode,
    required this.retentionMarker,
  });

  final String profileId;
  final String archiveCode;
  final String retentionMarker;
}

class ProfileArchiveProfile {
  const ProfileArchiveProfile({
    required this.profileId,
    required this.archiveCode,
    required this.retentionMarker,
  });

  final String profileId;
  final String archiveCode;
  final String retentionMarker;
}

class RegistrationArchiveAlignment {
  const RegistrationArchiveAlignment({
    required this.registrationReference,
    required this.profileReference,
    required this.archiveReference,
  });

  final String registrationReference;
  final String profileReference;
  final String archiveReference;
}

class RegistrationReadinessAlignment {
  const RegistrationReadinessAlignment({
    required this.readinessReference,
    required this.roadmapReference,
    required this.registrationReference,
    required this.profileReference,
  });

  final String readinessReference;
  final String roadmapReference;
  final String registrationReference;
  final String profileReference;
}

class ResidentialReadinessAlignment {
  const ResidentialReadinessAlignment({
    required this.readinessReference,
    required this.roadmapReference,
    required this.residentialReference,
  });

  final String readinessReference;
  final String roadmapReference;
  final String residentialReference;
}
