class GovernanceLifecycleLock {
  const GovernanceLifecycleLock({
    required this.locked,
    required this.reasonKey,
    required this.lockedBy,
  });

  static const GovernanceLifecycleLock safeDefault = GovernanceLifecycleLock(
    locked: true,
    reasonKey: 'lifecycle_locked_by_default',
    lockedBy: 'system_placeholder',
  );

  final bool locked;
  final String reasonKey;
  final String lockedBy;
}
