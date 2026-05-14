enum ProviderBlockReason {
  providerBlocked,
  trustLevelInsufficient,
  capabilityBlocked,
  runtimeModeBlocked,
  environmentBlocked,
  auditScopeRestricted,
  escalationRestricted,
  crisisHandlingRestricted,
  policyLinkMissing,
  failClosed,
}

extension ProviderBlockReasonKey on ProviderBlockReason {
  String get key {
    switch (this) {
      case ProviderBlockReason.providerBlocked:
        return 'provider_blocked';
      case ProviderBlockReason.trustLevelInsufficient:
        return 'trust_level_insufficient';
      case ProviderBlockReason.capabilityBlocked:
        return 'capability_blocked';
      case ProviderBlockReason.runtimeModeBlocked:
        return 'runtime_mode_blocked';
      case ProviderBlockReason.environmentBlocked:
        return 'environment_blocked';
      case ProviderBlockReason.auditScopeRestricted:
        return 'audit_scope_restricted';
      case ProviderBlockReason.escalationRestricted:
        return 'escalation_restricted';
      case ProviderBlockReason.crisisHandlingRestricted:
        return 'crisis_handling_restricted';
      case ProviderBlockReason.policyLinkMissing:
        return 'policy_link_missing';
      case ProviderBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
