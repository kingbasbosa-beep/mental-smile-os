enum RuntimeActivationBlockReason {
  activationBlocked,
  activationLocked,
  runtimeDisabled,
  providerBlocked,
  missingAuthority,
  policyMismatch,
  reviewRequired,
  extractionNotReady,
  unsafeActivation,
  missingAuditLink,
  restrictedEnvironment,
  failClosed,
}

extension RuntimeActivationBlockReasonKey on RuntimeActivationBlockReason {
  String get key {
    switch (this) {
      case RuntimeActivationBlockReason.activationBlocked:
        return 'activation_blocked';
      case RuntimeActivationBlockReason.activationLocked:
        return 'activation_locked';
      case RuntimeActivationBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case RuntimeActivationBlockReason.providerBlocked:
        return 'provider_blocked';
      case RuntimeActivationBlockReason.missingAuthority:
        return 'missing_authority';
      case RuntimeActivationBlockReason.policyMismatch:
        return 'policy_mismatch';
      case RuntimeActivationBlockReason.reviewRequired:
        return 'review_required';
      case RuntimeActivationBlockReason.extractionNotReady:
        return 'extraction_not_ready';
      case RuntimeActivationBlockReason.unsafeActivation:
        return 'unsafe_activation';
      case RuntimeActivationBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case RuntimeActivationBlockReason.restrictedEnvironment:
        return 'restricted_environment';
      case RuntimeActivationBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
