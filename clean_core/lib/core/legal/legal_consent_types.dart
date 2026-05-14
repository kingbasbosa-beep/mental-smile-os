enum LegalConsentType {
  termsAndConditions,
  privacyPolicy,
  aiSafetyDisclosure,
  crisisDisclaimer,
  dataProcessingConsent,
}

extension LegalConsentTypeKey on LegalConsentType {
  String get key {
    switch (this) {
      case LegalConsentType.termsAndConditions:
        return 'terms_and_conditions';
      case LegalConsentType.privacyPolicy:
        return 'privacy_policy';
      case LegalConsentType.aiSafetyDisclosure:
        return 'ai_safety_disclosure';
      case LegalConsentType.crisisDisclaimer:
        return 'crisis_disclaimer';
      case LegalConsentType.dataProcessingConsent:
        return 'data_processing_consent';
    }
  }
}

LegalConsentType? legalConsentTypeFromKey(String value) {
  final key = value.trim();
  for (final type in LegalConsentType.values) {
    if (type.key == key) return type;
  }
  return null;
}
