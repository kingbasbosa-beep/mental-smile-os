import 'safety_decision_confidence.dart';
import 'safety_decision_reason.dart';
import 'safety_decision_state.dart';

class SafetyDecisionGuard {
  const SafetyDecisionGuard();

  Set<SafetyDecisionReason> reasonsFor(SafetyDecisionState state) {
    return {
      if (state.policyVersion.trim().isEmpty)
        SafetyDecisionReason.policyMismatch,
      if (state.enabledSafetyModules.isEmpty)
        SafetyDecisionReason.missingSafetyModule,
      if (state.providerId.trim().isEmpty) SafetyDecisionReason.blockedProvider,
      if (state.environment.trim() == 'production')
        SafetyDecisionReason.restrictedEnvironment,
      if (state.escalationSuggested) SafetyDecisionReason.escalationRequired,
      if (state.runtimeMode.trim() == 'disabled_placeholder')
        SafetyDecisionReason.unsafeRuntime,
      if (!state.auditLink.isLinked)
        SafetyDecisionReason.auditRequirementMissing,
      if (state.confidence == SafetyDecisionConfidence.unknown ||
          state.confidence == SafetyDecisionConfidence.low)
        SafetyDecisionReason.lowConfidence,
      if (!state.backendGoverned) SafetyDecisionReason.backendUnavailable,
    };
  }
}
