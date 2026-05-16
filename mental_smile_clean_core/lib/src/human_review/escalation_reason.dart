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
