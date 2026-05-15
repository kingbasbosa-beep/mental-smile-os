class SecureRuntimeLock {
  const SecureRuntimeLock({
    required this.locked,
    required this.sealed,
    required this.reasonKey,
  });

  static const SecureRuntimeLock safeDefault = SecureRuntimeLock(
    locked: true,
    sealed: true,
    reasonKey: 'secure_runtime_sealed_by_default',
  );

  final bool locked;
  final bool sealed;
  final String reasonKey;
}
