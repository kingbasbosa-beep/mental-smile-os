import 'safety_decision_audit_link.dart';
import 'safety_decision_confidence.dart';

class SafetyDecisionState {
  const SafetyDecisionState({
    required this.policyVersion,
    required this.runtimeMode,
    required this.providerId,
    required this.environment,
    required this.enabledSafetyModules,
    required this.confidence,
    required this.escalationSuggested,
    required this.backendGoverned,
    required this.auditLink,
  });

  static const SafetyDecisionState safeDefault = SafetyDecisionState(
    policyVersion: '',
    runtimeMode: 'disabled_placeholder',
    providerId: '',
    environment: 'fallback_only',
    enabledSafetyModules: <String>{},
    confidence: SafetyDecisionConfidence.unknown,
    escalationSuggested: false,
    backendGoverned: true,
    auditLink: SafetyDecisionAuditLink(
      auditId: '',
      traceHash: '',
      policyVersion: '',
    ),
  );

  final String policyVersion;
  final String runtimeMode;
  final String providerId;
  final String environment;
  final Set<String> enabledSafetyModules;
  final SafetyDecisionConfidence confidence;
  final bool escalationSuggested;
  final bool backendGoverned;
  final SafetyDecisionAuditLink auditLink;
}
