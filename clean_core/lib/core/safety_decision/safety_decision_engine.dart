import 'safety_decision_confidence.dart';
import 'safety_decision_fallback.dart';
import 'safety_decision_guard.dart';
import 'safety_decision_priority.dart';
import 'safety_decision_reason.dart';
import 'safety_decision_result.dart';
import 'safety_decision_state.dart';
import 'safety_decision_verdict.dart';

class SafetyDecisionEngine {
  const SafetyDecisionEngine({
    this.guard = const SafetyDecisionGuard(),
  });

  final SafetyDecisionGuard guard;

  SafetyDecisionResult evaluate(SafetyDecisionState state) {
    final reasons = guard.reasonsFor(state);
    if (reasons.isEmpty && state.confidence == SafetyDecisionConfidence.high) {
      return SafetyDecisionResult(
        verdict: SafetyDecisionVerdict.allow,
        confidence: state.confidence,
        reasons: const {},
        priority: SafetyDecisionPriority.low,
        fallback: null,
      );
    }

    if (reasons.contains(SafetyDecisionReason.escalationRequired)) {
      return SafetyDecisionResult(
        verdict: SafetyDecisionVerdict.escalate,
        confidence: state.confidence,
        reasons: reasons,
        priority: SafetyDecisionPriority.urgent,
        fallback: const SafetyDecisionFallback(
          reason: SafetyDecisionReason.escalationRequired,
          verdict: SafetyDecisionVerdict.escalate,
          messageKey: 'escalation_required',
        ),
      );
    }

    if (reasons.contains(SafetyDecisionReason.lowConfidence) ||
        reasons.contains(SafetyDecisionReason.unsafeRuntime)) {
      return SafetyDecisionResult(
        verdict: SafetyDecisionVerdict.failSafe,
        confidence: state.confidence,
        reasons: reasons,
        priority: SafetyDecisionPriority.high,
        fallback: SafetyDecisionFallback.failSafe,
      );
    }

    return SafetyDecisionResult(
      verdict: SafetyDecisionVerdict.block,
      confidence: state.confidence,
      reasons: reasons,
      priority: SafetyDecisionPriority.medium,
      fallback: const SafetyDecisionFallback(
        reason: SafetyDecisionReason.policyMismatch,
        verdict: SafetyDecisionVerdict.block,
        messageKey: 'safety_decision_blocked',
      ),
    );
  }
}
