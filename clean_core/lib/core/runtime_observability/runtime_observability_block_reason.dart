enum RuntimeObservabilityBlockReason {
  observabilityBlocked,
  observabilityLocked,
  runtimeDisabled,
  providerBlocked,
  missingAuthority,
  policyMismatch,
  reviewRequired,
  unsafeObservation,
  missingAuditLink,
  observationOwnerMissing,
  failClosed,
}

extension RuntimeObservabilityBlockReasonKey
    on RuntimeObservabilityBlockReason {
  String get key {
    switch (this) {
      case RuntimeObservabilityBlockReason.observabilityBlocked:
        return 'observability_blocked';
      case RuntimeObservabilityBlockReason.observabilityLocked:
        return 'observability_locked';
      case RuntimeObservabilityBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case RuntimeObservabilityBlockReason.providerBlocked:
        return 'provider_blocked';
      case RuntimeObservabilityBlockReason.missingAuthority:
        return 'missing_authority';
      case RuntimeObservabilityBlockReason.policyMismatch:
        return 'policy_mismatch';
      case RuntimeObservabilityBlockReason.reviewRequired:
        return 'review_required';
      case RuntimeObservabilityBlockReason.unsafeObservation:
        return 'unsafe_observation';
      case RuntimeObservabilityBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case RuntimeObservabilityBlockReason.observationOwnerMissing:
        return 'observation_owner_missing';
      case RuntimeObservabilityBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
