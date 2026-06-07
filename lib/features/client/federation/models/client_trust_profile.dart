class ClientTrustProfile {
  const ClientTrustProfile({
    required this.clientId,
    required this.sovereigntyLabel,
    required this.privacyLabel,
    required this.supportLabel,
  });

  final String clientId;
  final String sovereigntyLabel;
  final String privacyLabel;
  final String supportLabel;
}
