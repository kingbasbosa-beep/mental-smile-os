import 'package:flutter_test/flutter_test.dart';
import 'package:flutterprojects/core/ai_safety/ai_safety_payload_sanitizer.dart';
import 'package:flutterprojects/core/ai_safety/ai_safety_runtime_config.dart';
import 'package:flutterprojects/core/ai_safety/mental_smile_policy_engine.dart';
import 'package:flutterprojects/core/ai_safety/mental_smile_response_mode.dart';
import 'package:flutterprojects/core/ai_safety/mental_smile_risk_level.dart';
import 'package:flutterprojects/core/ai_safety/mental_smile_risk_result.dart';

void main() {
  group('AI safety contracts', () {
    test('unknown risk level fails closed', () {
      expect(
        mentalSmileRiskLevelFromKey('unexpected'),
        MentalSmileRiskLevel.crisis,
      );
    });

    test('low confidence policy result uses fail safe mode', () {
      const engine = MentalSmilePolicyEngine();
      const result = MentalSmileRiskResult(
        riskLevel: MentalSmileRiskLevel.normal,
        confidence: 0.1,
        triggers: ['low_confidence'],
        responseMode: MentalSmileResponseMode.support,
        escalationSuggested: false,
        policyVersion: 'test',
      );

      final contract = engine.contractFor(result);

      expect(contract.responseMode, MentalSmileResponseMode.failSafe);
      expect(contract.outputValidated, isFalse);
    });

    test('runtime config is disabled by default', () {
      final config = AiSafetyRuntimeConfig.disabled.toMap();

      expect(config['fallbackOnlyMode'], isTrue);
      expect(config['aiEnabled'], isFalse);
      expect(config['crisisDetectionEnabled'], isFalse);
      expect(config['escalationEnabled'], isFalse);
      expect(config['loggingEnabled'], isFalse);
    });

    test('sanitizer truncates previews without classification', () {
      final preview = AiSafetyPayloadSanitizer.sanitizedPreview(
        'one two three four five',
        maxLength: 7,
      );

      expect(preview, 'one two');
      expect(AiSafetyPayloadSanitizer.hashPlaceholder('abc'), contains('3'));
    });
  });
}
