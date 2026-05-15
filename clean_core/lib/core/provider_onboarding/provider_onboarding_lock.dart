class ProviderOnboardingLock {
  const ProviderOnboardingLock({
    required this.locked,
    required this.sealed,
    required this.providerBlocked,
    required this.reasonKey,
  });

  final bool locked;
  final bool sealed;
  final bool providerBlocked;
  final String reasonKey;

  static const safeDefault = ProviderOnboardingLock(
    locked: true,
    sealed: true,
    providerBlocked: true,
    reasonKey: 'provider_onboarding_locked_by_default',
  );
}
