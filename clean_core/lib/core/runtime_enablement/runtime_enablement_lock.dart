class RuntimeEnablementLock {
  const RuntimeEnablementLock({
    required this.locked,
    required this.sealed,
    required this.enablementBlocked,
    required this.reasonKey,
  });

  final bool locked;
  final bool sealed;
  final bool enablementBlocked;
  final String reasonKey;

  static const safeDefault = RuntimeEnablementLock(
    locked: true,
    sealed: true,
    enablementBlocked: true,
    reasonKey: 'runtime_enablement_locked_by_default',
  );
}
