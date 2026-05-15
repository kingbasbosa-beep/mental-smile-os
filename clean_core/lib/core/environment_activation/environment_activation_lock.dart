class EnvironmentActivationLock {
  const EnvironmentActivationLock({
    required this.locked,
    required this.sealed,
    required this.environmentBlocked,
    required this.reasonKey,
  });

  final bool locked;
  final bool sealed;
  final bool environmentBlocked;
  final String reasonKey;

  static const safeDefault = EnvironmentActivationLock(
    locked: true,
    sealed: true,
    environmentBlocked: true,
    reasonKey: 'environment_activation_locked_by_default',
  );
}
