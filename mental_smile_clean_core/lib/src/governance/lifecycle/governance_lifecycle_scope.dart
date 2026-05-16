enum GovernanceLifecycleScope {
  policy,
  runtime,
  provider,
  review,
  audit,
  memory,
  conversation,
}

extension GovernanceLifecycleScopeKey on GovernanceLifecycleScope {
  String get key {
    switch (this) {
      case GovernanceLifecycleScope.policy:
        return 'policy';
      case GovernanceLifecycleScope.runtime:
        return 'runtime';
      case GovernanceLifecycleScope.provider:
        return 'provider';
      case GovernanceLifecycleScope.review:
        return 'review';
      case GovernanceLifecycleScope.audit:
        return 'audit';
      case GovernanceLifecycleScope.memory:
        return 'memory';
      case GovernanceLifecycleScope.conversation:
        return 'conversation';
    }
  }
}
