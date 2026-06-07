class ResidentialFederationProfile {
  const ResidentialFederationProfile({
    required this.residentialId,
    required this.doctrine,
    required this.supportAreas,
    required this.readinessProfileId,
  });

  final String residentialId;
  final String doctrine;
  final Set<String> supportAreas;
  final String readinessProfileId;
}

class FamilySupportProfile {
  const FamilySupportProfile({
    required this.profileId,
    required this.supportSignals,
    required this.guidanceReference,
  });

  final String profileId;
  final Set<String> supportSignals;
  final String guidanceReference;
}

class RecoverySupportProfile {
  const RecoverySupportProfile({
    required this.profileId,
    required this.supportSignals,
    required this.guidanceReference,
  });

  final String profileId;
  final Set<String> supportSignals;
  final String guidanceReference;
}

class AccessibilitySupportProfile {
  const AccessibilitySupportProfile({
    required this.profileId,
    required this.accessibilitySignals,
    required this.guidanceReference,
  });

  final String profileId;
  final Set<String> accessibilitySignals;
  final String guidanceReference;
}

class ResidentialReadinessProfile {
  const ResidentialReadinessProfile({
    required this.profileId,
    required this.readinessStatus,
    required this.requiredActions,
  });

  final String profileId;
  final String readinessStatus;
  final List<String> requiredActions;
}
