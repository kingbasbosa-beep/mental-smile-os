import 'safety_decision_reason.dart';
import 'safety_decision_scope.dart';
import 'safety_decision_state.dart';
import 'safety_decision_verdict.dart';

class SafetyDecisionRule {
  const SafetyDecisionRule({
    required this.ruleId,
    required this.scope,
    required this.reason,
    required this.verdict,
    required this.matches,
  });

  final String ruleId;
  final SafetyDecisionScope scope;
  final SafetyDecisionReason reason;
  final SafetyDecisionVerdict verdict;
  final bool Function(SafetyDecisionState state) matches;
}
