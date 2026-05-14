import 'legal_consent_types.dart';

class LegalConsentVersion {
  const LegalConsentVersion._();

  static const String policyVersion = '2026-05-os2b';

  static const Map<LegalConsentType, String> requiredVersions = {
    LegalConsentType.termsAndConditions: policyVersion,
    LegalConsentType.privacyPolicy: policyVersion,
    LegalConsentType.aiSafetyDisclosure: policyVersion,
    LegalConsentType.crisisDisclaimer: policyVersion,
    LegalConsentType.dataProcessingConsent: policyVersion,
  };

  static String requiredVersionFor(LegalConsentType type) {
    return requiredVersions[type] ?? policyVersion;
  }

  static bool isAcceptedVersion({
    required LegalConsentType type,
    required String acceptedVersion,
  }) {
    return acceptedVersion.trim() == requiredVersionFor(type);
  }
}
