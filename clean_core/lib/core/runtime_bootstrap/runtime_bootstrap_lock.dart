class RuntimeBootstrapLock {
  const RuntimeBootstrapLock({
    required this.locked,
    required this.sealed,
    required this.bootstrapBlocked,
    required this.reasonKey,
  });

  final bool locked;
  final bool sealed;
  final bool bootstrapBlocked;
  final String reasonKey;

  static const safeDefault = RuntimeBootstrapLock(
    locked: true,
    sealed: true,
    bootstrapBlocked: true,
    reasonKey: 'runtime_bootstrap_locked_by_default',
  );
}
