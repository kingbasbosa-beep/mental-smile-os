class RuntimeReadinessLock {
  const RuntimeReadinessLock({
    required this.locked,
    required this.sealed,
    required this.reasonKey,
  });

  static const RuntimeReadinessLock safeDefault = RuntimeReadinessLock(
    locked: true,
    sealed: true,
    reasonKey: 'runtime_readiness_locked_by_default',
  );

  final bool locked;
  final bool sealed;
  final String reasonKey;
}
