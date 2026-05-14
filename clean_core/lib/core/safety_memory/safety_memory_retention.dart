enum SafetyMemoryRetentionMode {
  noRetention,
  shortTerm,
  policyBound,
  auditLinked,
  restrictedRetention,
}

extension SafetyMemoryRetentionModeKey on SafetyMemoryRetentionMode {
  String get key {
    switch (this) {
      case SafetyMemoryRetentionMode.noRetention:
        return 'no_retention';
      case SafetyMemoryRetentionMode.shortTerm:
        return 'short_term';
      case SafetyMemoryRetentionMode.policyBound:
        return 'policy_bound';
      case SafetyMemoryRetentionMode.auditLinked:
        return 'audit_linked';
      case SafetyMemoryRetentionMode.restrictedRetention:
        return 'restricted_retention';
    }
  }
}

class SafetyMemoryRetention {
  const SafetyMemoryRetention({
    required this.mode,
    required this.maxAgeDays,
    required this.deletionRuntimeImplemented,
  });

  static const SafetyMemoryRetention noRetention = SafetyMemoryRetention(
    mode: SafetyMemoryRetentionMode.noRetention,
    maxAgeDays: 0,
    deletionRuntimeImplemented: false,
  );

  final SafetyMemoryRetentionMode mode;
  final int maxAgeDays;
  final bool deletionRuntimeImplemented;
}
