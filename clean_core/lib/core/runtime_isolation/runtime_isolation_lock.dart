class RuntimeIsolationLock {
  const RuntimeIsolationLock({
    required this.locked,
    required this.sealed,
    required this.isolationBlocked,
    required this.reasonKey,
  });

  final bool locked;
  final bool sealed;
  final bool isolationBlocked;
  final String reasonKey;

  static const safeDefault = RuntimeIsolationLock(
    locked: true,
    sealed: true,
    isolationBlocked: true,
    reasonKey: 'runtime_isolation_locked_by_default',
  );
}
