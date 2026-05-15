class RuntimeObservabilityLock {
  const RuntimeObservabilityLock({
    required this.locked,
    required this.sealed,
    required this.observabilityBlocked,
    required this.reasonKey,
  });

  final bool locked;
  final bool sealed;
  final bool observabilityBlocked;
  final String reasonKey;

  static const safeDefault = RuntimeObservabilityLock(
    locked: true,
    sealed: true,
    observabilityBlocked: true,
    reasonKey: 'runtime_observability_locked_by_default',
  );
}
