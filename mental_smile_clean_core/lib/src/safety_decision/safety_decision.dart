import 'safety_decision_audit_link.dart';
import 'safety_decision_confidence.dart';
import 'safety_decision_reason.dart';
import 'safety_decision_result.dart';
import 'safety_decision_state.dart';
import 'safety_decision_verdict.dart';

class SafetyDecision {
  const SafetyDecision({
    required this.decisionId,
    required this.state,
    required this.result,
    required this.auditLink,
  });

  final String decisionId;
  final SafetyDecisionState state;
  final SafetyDecisionResult result;
  final SafetyDecisionAuditLink auditLink;

  Map<String, Object?> toMap() {
    return {
      'decisionId': decisionId,
      'policyVersion': state.policyVersion,
      'runtimeMode': state.runtimeMode,
      'providerId': state.providerId,
      'environment': state.environment,
      'verdict': result.verdict.key,
      'confidence': result.confidence.key,
      'reasons': result.reasons.map((reason) => reason.key).toList(),
      'auditLink': auditLink.toMap(),
    };
  }
}
