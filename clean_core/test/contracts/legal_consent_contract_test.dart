import 'package:flutter_test/flutter_test.dart';
import 'package:flutterprojects/core/legal/legal_consent_service.dart';
import 'package:flutterprojects/core/legal/legal_consent_types.dart';
import 'package:flutterprojects/core/legal/legal_consent_version.dart';

void main() {
  group('LegalConsentService', () {
    const service = LegalConsentService();

    test('builds immutable-oriented accepted consent payload', () {
      final payload = service.buildAcceptedConsentPayload(
        uid: 'user_001',
        consentType: LegalConsentType.aiSafetyDisclosure,
        locale: 'ar',
        source: 'test_contract',
      );

      expect(payload['uid'], 'user_001');
      expect(payload['consentType'], 'ai_safety_disclosure');
      expect(payload['accepted'], isTrue);
      expect(
        payload['version'],
        LegalConsentVersion.requiredVersionFor(
          LegalConsentType.aiSafetyDisclosure,
        ),
      );
      expect(payload.containsKey('diagnosis'), isFalse);
      expect(payload.containsKey('fullRawConversation'), isFalse);
      expect(payload.containsKey('medicationRecommendation'), isFalse);
    });

    test('recognizes required accepted consent version', () {
      final data = <String, dynamic>{
        'consentType': LegalConsentType.privacyPolicy.key,
        'accepted': true,
        'version': LegalConsentVersion.requiredVersionFor(
          LegalConsentType.privacyPolicy,
        ),
      };

      expect(
        service.hasAcceptedRequiredVersion(
          consentType: LegalConsentType.privacyPolicy,
          consentData: data,
        ),
        isTrue,
      );
    });
  });
}
