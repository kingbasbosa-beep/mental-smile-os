class ProviderFederationProfile {
  const ProviderFederationProfile({
    required this.providerId,
    required this.displayName,
    required this.identityProfileId,
    required this.visibilityProfileId,
    required this.trustProfileId,
    required this.readinessProfileId,
  });

  final String providerId;
  final String displayName;
  final String identityProfileId;
  final String visibilityProfileId;
  final String trustProfileId;
  final String readinessProfileId;
}
