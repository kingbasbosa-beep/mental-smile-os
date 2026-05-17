/// Passive escalation reason vocabulary.
///
/// Reason labels are metadata only. They do not prove runtime causality,
/// provider ownership, provider execution state, review approval, or backend
/// guarantees. `providerFailure` is a passive label only.
enum EscalationReason {
  safetyConcern,
  crisisRisk,
  policyViolation,
  providerFailure,
  fallbackLoop,
  manualSupportRequest,
}

extension EscalationReasonKey on EscalationReason {
  String get key {
    switch (this) {
      case EscalationReason.safetyConcern:
        return 'safety_concern';
      case EscalationReason.crisisRisk:
        return 'crisis_risk';
      case EscalationReason.policyViolation:
        return 'policy_violation';
      case EscalationReason.providerFailure:
        return 'provider_failure';
      case EscalationReason.fallbackLoop:
        return 'fallback_loop';
      case EscalationReason.manualSupportRequest:
        return 'manual_support_request';
    }
  }
}
