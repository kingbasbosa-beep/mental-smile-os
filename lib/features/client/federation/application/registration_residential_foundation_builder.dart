import '../models/client_federation_profile.dart';
import '../models/client_readiness_profile.dart';
import '../models/registration_alignment_models.dart';
import '../models/residential_federation_models.dart';
import '../reports/registration_residential_federation_report.dart';

class RegistrationResidentialFoundationBuilder {
  const RegistrationResidentialFoundationBuilder._();

  static ClientFederationProfile clientProfile() {
    return const ClientFederationProfile(
      clientId: 'client_foundation',
      identityProfileId: 'client_identity',
      visibilityProfileId: 'client_visibility',
      accessibilityProfileId: 'client_accessibility',
      readinessProfileId: 'client_readiness',
      trustProfileId: 'client_trust',
    );
  }

  static ClientReadinessProfile clientReadiness() {
    return const ClientReadinessProfile(
      clientId: 'client_foundation',
      readinessStatus: 'foundation_ready_no_runtime',
      requiredActions: <String>[
        'align_registration_fields',
        'align_dashboard_fields',
        'keep_private_fields_private',
      ],
      separationMarkers: <String>{
        'legacy_cleanup_pack',
        'readiness_marker',
        'separation_marker',
      },
    );
  }

  static ResidentialFederationProfile residentialProfile() {
    return const ResidentialFederationProfile(
      residentialId: 'residential_foundation',
      doctrine: 'signal_support_and_accessibility',
      supportAreas: <String>{
        'family_support',
        'recovery_support',
        'accessibility_support',
      },
      readinessProfileId: 'residential_readiness',
    );
  }

  static RegistrationAlignmentProfile registrationAlignment() {
    return const RegistrationAlignmentProfile(
      profileId: 'registration_alignment_v1',
      registrationFields: <String>{
        'display_name',
        'goal_signals',
        'accessibility_signals',
        'capability_signals',
        'documents',
      },
      profileFields: <String>{
        'display_name',
        'goal_signals',
        'accessibility_signals',
        'capability_signals',
      },
      publicPageFields: <String>{
        'display_name',
        'capability_signals',
        'accessibility_summary',
      },
      dashboardFields: <String>{
        'display_name',
        'goal_signals',
        'accessibility_preferences',
      },
    );
  }

  static RegistrationResidentialFederationReport report() {
    return const RegistrationResidentialFederationReport(
      clientStatus: 'client_foundation_ready',
      residentialStatus: 'residential_foundation_ready',
      registrationStatus: 'registration_alignment_ready',
      parityStatus: 'field_parity_foundation_ready',
      legacyContainmentStatus: 'legacy_registration_contained_no_delete',
    );
  }
}
