import 'mental_smile_policy_version.dart';
import 'mental_smile_response_mode.dart';
import 'mental_smile_risk_level.dart';

class MentalSmileRiskResult {
  const MentalSmileRiskResult({
    required this.riskLevel,
    required this.confidence,
    required this.triggers,
    required this.responseMode,
    required this.escalationSuggested,
    required this.policyVersion,
  });

  factory MentalSmileRiskResult.failClosed({
    List<String> triggers = const ['unknown_state'],
  }) {
    return MentalSmileRiskResult(
      riskLevel: MentalSmileRiskLevel.crisis,
      confidence: 0,
      triggers: triggers,
      responseMode: MentalSmileResponseMode.failSafe,
      escalationSuggested: true,
      policyVersion: MentalSmilePolicyVersion.current,
    );
  }

  final MentalSmileRiskLevel riskLevel;
  final double confidence;
  final List<String> triggers;
  final MentalSmileResponseMode responseMode;
  final bool escalationSuggested;
  final String policyVersion;

  Map<String, Object?> toMap() {
    return {
      'riskLevel': riskLevel.key,
      'confidence': confidence,
      'triggers': triggers,
      'responseMode': responseMode.key,
      'escalationSuggested': escalationSuggested,
      'policyVersion': policyVersion,
    };
  }
}
