import 'safety_decision_reason.dart';
import 'safety_decision_verdict.dart';

class SafetyDecisionFallback {
  const SafetyDecisionFallback({
    required this.reason,
    required this.verdict,
    required this.messageKey,
  });

  static const SafetyDecisionFallback runtimeDisabled =
      SafetyDecisionFallback(
    reason: SafetyDecisionReason.unsafeRuntime,
    verdict: SafetyDecisionVerdict.fallbackOnly,
    messageKey: 'runtime_disabled',
  );

  static const SafetyDecisionFallback failSafe = SafetyDecisionFallback(
    reason: SafetyDecisionReason.lowConfidence,
    verdict: SafetyDecisionVerdict.failSafe,
    messageKey: 'fail_safe',
  );

  final SafetyDecisionReason reason;
  final SafetyDecisionVerdict verdict;
  final String messageKey;
}
