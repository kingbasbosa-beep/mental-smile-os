class ProviderRegistrationProfile {
  const ProviderRegistrationProfile({
    required this.profileId,
    required this.declaredFields,
    required this.signalFields,
  });

  final String profileId;
  final Set<String> declaredFields;
  final Set<String> signalFields;
}

class ProviderRegistrationParity {
  const ProviderRegistrationParity({
    required this.registrationProfileId,
    required this.publicProfileId,
    required this.parityStatus,
  });

  final String registrationProfileId;
  final String publicProfileId;
  final String parityStatus;
}

class ProviderPublicProfileAlignment {
  const ProviderPublicProfileAlignment({
    required this.profileId,
    required this.visibleFields,
    required this.guidanceFields,
  });

  final String profileId;
  final Set<String> visibleFields;
  final Set<String> guidanceFields;
}

class CenterRegistrationProfile {
  const CenterRegistrationProfile({
    required this.profileId,
    required this.declaredFields,
    required this.signalFields,
  });

  final String profileId;
  final Set<String> declaredFields;
  final Set<String> signalFields;
}

class CenterRegistrationParity {
  const CenterRegistrationParity({
    required this.registrationProfileId,
    required this.publicProfileId,
    required this.parityStatus,
  });

  final String registrationProfileId;
  final String publicProfileId;
  final String parityStatus;
}

class CenterPublicProfileAlignment {
  const CenterPublicProfileAlignment({
    required this.profileId,
    required this.visibleFields,
    required this.guidanceFields,
  });

  final String profileId;
  final Set<String> visibleFields;
  final Set<String> guidanceFields;
}

class ClientRegistrationProfile {
  const ClientRegistrationProfile({
    required this.profileId,
    required this.privateFields,
    required this.signalFields,
  });

  final String profileId;
  final Set<String> privateFields;
  final Set<String> signalFields;
}

class ClientRegistrationParity {
  const ClientRegistrationParity({
    required this.registrationProfileId,
    required this.profileId,
    required this.parityStatus,
  });

  final String registrationProfileId;
  final String profileId;
  final String parityStatus;
}

class ClientProfileAlignment {
  const ClientProfileAlignment({
    required this.profileId,
    required this.dashboardFields,
    required this.guidanceFields,
  });

  final String profileId;
  final Set<String> dashboardFields;
  final Set<String> guidanceFields;
}
