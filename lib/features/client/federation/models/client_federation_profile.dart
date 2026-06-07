class ClientFederationProfile {
  const ClientFederationProfile({
    required this.clientId,
    required this.identityProfileId,
    required this.visibilityProfileId,
    required this.accessibilityProfileId,
    required this.readinessProfileId,
    required this.trustProfileId,
  });

  final String clientId;
  final String identityProfileId;
  final String visibilityProfileId;
  final String accessibilityProfileId;
  final String readinessProfileId;
  final String trustProfileId;
}
