class RuntimeWiringLock {
  const RuntimeWiringLock({
    required this.locked,
    required this.sealed,
    required this.wiringBlocked,
    required this.reasonKey,
  });

  final bool locked;
  final bool sealed;
  final bool wiringBlocked;
  final String reasonKey;

  static const safeDefault = RuntimeWiringLock(
    locked: true,
    sealed: true,
    wiringBlocked: true,
    reasonKey: 'runtime_wiring_locked_by_default',
  );
}
