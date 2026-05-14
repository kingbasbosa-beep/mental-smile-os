import 'package:cloud_firestore/cloud_firestore.dart';

import 'legal_consent_types.dart';
import 'legal_consent_version.dart';

class LegalConsentService {
  const LegalConsentService();

  static const String collectionPath = 'legalConsents';

  Map<String, Object?> buildAcceptedConsentPayload({
    required String uid,
    required LegalConsentType consentType,
    required String locale,
    required String source,
    String? createdBy,
    String? ipHashPlaceholder,
    String? userAgentPlaceholder,
  }) {
    final normalizedUid = uid.trim();
    final normalizedLocale = locale.trim().isEmpty ? 'ar' : locale.trim();
    final normalizedSource = source.trim().isEmpty ? 'unknown' : source.trim();

    return {
      'uid': normalizedUid,
      'consentType': consentType.key,
      'accepted': true,
      'version': LegalConsentVersion.requiredVersionFor(consentType),
      'acceptedAt': FieldValue.serverTimestamp(),
      'locale': normalizedLocale,
      'policyVersion': LegalConsentVersion.policyVersion,
      'source': normalizedSource,
      'createdBy': (createdBy ?? normalizedUid).trim(),
      'ipHashPlaceholder': _nullablePlaceholder(ipHashPlaceholder),
      'userAgentPlaceholder': _nullablePlaceholder(userAgentPlaceholder),
    };
  }

  bool hasAcceptedRequiredVersion({
    required LegalConsentType consentType,
    required Map<String, dynamic>? consentData,
  }) {
    if (consentData == null) return false;
    if (consentData['accepted'] != true) return false;
    if ((consentData['consentType'] ?? '').toString() != consentType.key) {
      return false;
    }
    return LegalConsentVersion.isAcceptedVersion(
      type: consentType,
      acceptedVersion: (consentData['version'] ?? '').toString(),
    );
  }

  List<LegalConsentType> missingRequiredConsents(
    Map<LegalConsentType, Map<String, dynamic>?> acceptedByType,
  ) {
    return LegalConsentVersion.requiredVersions.keys
        .where(
          (type) => !hasAcceptedRequiredVersion(
            consentType: type,
            consentData: acceptedByType[type],
          ),
        )
        .toList(growable: false);
  }

  String? _nullablePlaceholder(String? value) {
    final text = (value ?? '').trim();
    return text.isEmpty ? null : text;
  }
}
