class CenterFederationProfile {
  const CenterFederationProfile({
    required this.centerId,
    required this.displayName,
    required this.identityProfileId,
    required this.visibilityProfileId,
    required this.trustProfileId,
    required this.readinessProfileId,
  });

  final String centerId;
  final String displayName;
  final String identityProfileId;
  final String visibilityProfileId;
  final String trustProfileId;
  final String readinessProfileId;
}
