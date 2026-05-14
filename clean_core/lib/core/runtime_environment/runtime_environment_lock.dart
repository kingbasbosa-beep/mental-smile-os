class RuntimeEnvironmentLock {
  const RuntimeEnvironmentLock({
    required this.locked,
    required this.reason,
    required this.lockedBy,
  });

  static const RuntimeEnvironmentLock safeDefault = RuntimeEnvironmentLock(
    locked: true,
    reason: 'runtime_disabled_by_default',
    lockedBy: 'system_placeholder',
  );

  final bool locked;
  final String reason;
  final String lockedBy;

  Map<String, Object?> toMap() {
    return {
      'locked': locked,
      'reason': reason,
      'lockedBy': lockedBy,
    };
  }
}
