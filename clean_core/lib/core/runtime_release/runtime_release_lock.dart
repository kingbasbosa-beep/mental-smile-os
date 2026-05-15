class RuntimeReleaseLock {
  const RuntimeReleaseLock({
    required this.locked,
    required this.sealed,
    required this.releaseBlocked,
    required this.reasonKey,
  });

  final bool locked;
  final bool sealed;
  final bool releaseBlocked;
  final String reasonKey;

  static const safeDefault = RuntimeReleaseLock(
    locked: true,
    sealed: true,
    releaseBlocked: true,
    reasonKey: 'runtime_release_locked_by_default',
  );
}
