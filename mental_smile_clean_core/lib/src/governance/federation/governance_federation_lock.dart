class GovernanceFederationLock {
  const GovernanceFederationLock({
    required this.locked,
    required this.sealed,
    required this.reasonKey,
  });

  static const GovernanceFederationLock safeDefault =
      GovernanceFederationLock(
    locked: true,
    sealed: true,
    reasonKey: 'governance_federation_locked_by_default',
  );

  final bool locked;
  final bool sealed;
  final String reasonKey;
}
