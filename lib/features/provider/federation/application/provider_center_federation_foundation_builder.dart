import '../models/contact_doctrine_models.dart';
import '../models/provider_federation_profile.dart';
import '../models/provider_readiness_profile.dart';
import '../reports/provider_center_federation_report.dart';

class ProviderCenterFederationFoundationBuilder {
  const ProviderCenterFederationFoundationBuilder._();

  static ContactDoctrineProfile contactDoctrine() {
    return const ContactDoctrineProfile(
      officialNameEn: 'Contact',
      officialNameAr: 'تواصل',
      allowedAction: 'open_contact_channel',
      forbiddenActionLanguage: <String>{
        'booking',
        'request',
        'session_request',
        'appointment',
      },
    );
  }

  static ProviderFederationProfile providerProfile() {
    return const ProviderFederationProfile(
      providerId: 'provider_foundation',
      displayName: 'Provider Federation Profile',
      identityProfileId: 'provider_identity',
      visibilityProfileId: 'provider_visibility',
      trustProfileId: 'provider_trust',
      readinessProfileId: 'provider_readiness',
    );
  }

  static ProviderReadinessProfile providerReadiness() {
    return const ProviderReadinessProfile(
      providerId: 'provider_foundation',
      readinessStatus: 'foundation_ready_no_runtime',
      requiredActions: <String>[
        'replace_legacy_sessions_with_visibility',
        'replace_legacy_reviews_with_public_reputation',
      ],
      separationMarkers: <String>{
        'legacy_cleanup_pack',
        'readiness_marker',
        'separation_marker',
      },
    );
  }

  static ProviderCenterFederationReport report() {
    return const ProviderCenterFederationReport(
      providerStatus: 'provider_foundation_ready',
      centerStatus: 'center_foundation_ready',
      contactStatus: 'contact_doctrine_aligned',
      reputationStatus: 'public_reputation_aligned',
      legacyContainmentStatus: 'legacy_contained_no_delete',
    );
  }
}
