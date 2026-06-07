class FederationVisualReadiness {
  const FederationVisualReadiness({
    required this.readinessId,
    required this.identityReady,
    required this.imageReady,
    required this.bannerReady,
    required this.cardReady,
    required this.guidanceReady,
    required this.notes,
  });

  final String readinessId;
  final bool identityReady;
  final bool imageReady;
  final bool bannerReady;
  final bool cardReady;
  final bool guidanceReady;
  final String notes;
}
