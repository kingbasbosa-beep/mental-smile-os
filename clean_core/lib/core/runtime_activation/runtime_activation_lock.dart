class RuntimeActivationLock {
  const RuntimeActivationLock({
    required this.locked,
    required this.sealed,
    required this.activationBlocked,
    required this.reasonKey,
  });

  final bool locked;
  final bool sealed;
  final bool activationBlocked;
  final String reasonKey;

  static const safeDefault = RuntimeActivationLock(
    locked: true,
    sealed: true,
    activationBlocked: true,
    reasonKey: 'runtime_activation_locked_by_default',
  );
}
