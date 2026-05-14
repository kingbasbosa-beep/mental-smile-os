import 'safety_decision_confidence.dart';
import 'safety_decision_fallback.dart';
import 'safety_decision_priority.dart';
import 'safety_decision_reason.dart';
import 'safety_decision_verdict.dart';

class SafetyDecisionResult {
  const SafetyDecisionResult({
    required this.verdict,
    required this.confidence,
    required this.reasons,
    required this.priority,
    required this.fallback,
  });

  static const SafetyDecisionResult failClosed = SafetyDecisionResult(
    verdict: SafetyDecisionVerdict.failSafe,
    confidence: SafetyDecisionConfidence.unknown,
    reasons: <SafetyDecisionReason>{SafetyDecisionReason.lowConfidence},
    priority: SafetyDecisionPriority.high,
    fallback: SafetyDecisionFallback.failSafe,
  );

  final SafetyDecisionVerdict verdict;
  final SafetyDecisionConfidence confidence;
  final Set<SafetyDecisionReason> reasons;
  final SafetyDecisionPriority priority;
  final SafetyDecisionFallback? fallback;

  bool get allowed {
    return verdict == SafetyDecisionVerdict.allow;
  }
}
