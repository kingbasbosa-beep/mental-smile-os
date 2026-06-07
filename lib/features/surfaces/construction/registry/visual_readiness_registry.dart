import '../models/federation_visual_readiness.dart';

class VisualReadinessRegistry {
  const VisualReadinessRegistry._();

  static const FederationVisualReadiness current =
      FederationVisualReadiness(
    readinessId: 'federation_visual_readiness_foundation',
    identityReady: true,
    imageReady: false,
    bannerReady: false,
    cardReady: true,
    guidanceReady: true,
    notes:
        'Identity and card language exist; image and banner assets still require replacement planning.',
  );
}
