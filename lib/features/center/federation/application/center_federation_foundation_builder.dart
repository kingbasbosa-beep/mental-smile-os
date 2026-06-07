import '../models/center_federation_profile.dart';
import '../models/center_readiness_profile.dart';

class CenterFederationFoundationBuilder {
  const CenterFederationFoundationBuilder._();

  static CenterFederationProfile centerProfile() {
    return const CenterFederationProfile(
      centerId: 'center_foundation',
      displayName: 'Center Federation Profile',
      identityProfileId: 'center_identity',
      visibilityProfileId: 'center_visibility',
      trustProfileId: 'center_trust',
      readinessProfileId: 'center_readiness',
    );
  }

  static CenterReadinessProfile centerReadiness() {
    return const CenterReadinessProfile(
      centerId: 'center_foundation',
      readinessStatus: 'foundation_ready_no_runtime',
      requiredActions: <String>[
        'replace_legacy_residencies_with_visibility',
        'replace_legacy_reviews_with_public_reputation',
      ],
      separationMarkers: <String>{
        'legacy_cleanup_pack',
        'readiness_marker',
        'separation_marker',
      },
    );
  }
}
