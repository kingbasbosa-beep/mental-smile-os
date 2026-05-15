class RuntimeRollbackLock {
  const RuntimeRollbackLock({
    required this.locked,
    required this.sealed,
    required this.rollbackBlocked,
    required this.reasonKey,
  });

  final bool locked;
  final bool sealed;
  final bool rollbackBlocked;
  final String reasonKey;

  static const safeDefault = RuntimeRollbackLock(
    locked: true,
    sealed: true,
    rollbackBlocked: true,
    reasonKey: 'runtime_rollback_locked_by_default',
  );
}
