import 'conversation_control_mode.dart';
import 'mental_smile_policy_version.dart';
import 'mental_smile_response_contract.dart';
import 'mental_smile_response_mode.dart';
import 'mental_smile_risk_level.dart';
import 'mental_smile_risk_result.dart';

class MentalSmilePolicyEngine {
  const MentalSmilePolicyEngine();

  MentalSmileResponseContract contractFor(MentalSmileRiskResult result) {
    return MentalSmileResponseContract(
      responseMode: _modeFor(result),
      controlMode: _controlModeFor(result.riskLevel),
      outputValidated: false,
      requiresHumanReview: _requiresHumanReview(result.riskLevel),
      safetyNotice: MentalSmilePolicyVersion.current,
    );
  }

  MentalSmileResponseMode _modeFor(MentalSmileRiskResult result) {
    if (result.confidence < 0.4) return MentalSmileResponseMode.failSafe;
    switch (result.riskLevel) {
      case MentalSmileRiskLevel.normal:
        return MentalSmileResponseMode.support;
      case MentalSmileRiskLevel.emotionalDistress:
        return MentalSmileResponseMode.deEscalation;
      case MentalSmileRiskLevel.relapseUrge:
        return MentalSmileResponseMode.relapsePrevention;
      case MentalSmileRiskLevel.crisis:
        return MentalSmileResponseMode.crisisSupport;
      case MentalSmileRiskLevel.emergency:
        return MentalSmileResponseMode.emergencyEscalation;
    }
  }

  ConversationControlMode _controlModeFor(MentalSmileRiskLevel riskLevel) {
    switch (riskLevel) {
      case MentalSmileRiskLevel.normal:
      case MentalSmileRiskLevel.emotionalDistress:
        return ConversationControlMode.hybridSupport;
      case MentalSmileRiskLevel.relapseUrge:
        return ConversationControlMode.humanPriority;
      case MentalSmileRiskLevel.crisis:
      case MentalSmileRiskLevel.emergency:
        return ConversationControlMode.lockedForReview;
    }
  }

  bool _requiresHumanReview(MentalSmileRiskLevel riskLevel) {
    switch (riskLevel) {
      case MentalSmileRiskLevel.normal:
      case MentalSmileRiskLevel.emotionalDistress:
        return false;
      case MentalSmileRiskLevel.relapseUrge:
      case MentalSmileRiskLevel.crisis:
      case MentalSmileRiskLevel.emergency:
        return true;
    }
  }
}
