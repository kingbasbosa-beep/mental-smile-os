import 'provider_onboarding_block_reason.dart';
import 'provider_onboarding_state.dart';

class ProviderOnboardingFallback {
  const ProviderOnboardingFallback({
    required this.state,
    required this.reason,
    required this.messageKey,
  });

  final ProviderOnboardingState state;
  final ProviderOnboardingBlockReason reason;
  final String messageKey;

  static const locked = ProviderOnboardingFallback(
    state: ProviderOnboardingState.locked,
    reason: ProviderOnboardingBlockReason.onboardingLocked,
    messageKey: 'provider_onboarding_locked',
  );

  static const blocked = ProviderOnboardingFallback(
    state: ProviderOnboardingState.fallbackOnly,
    reason: ProviderOnboardingBlockReason.providerBlocked,
    messageKey: 'provider_onboarding_blocked',
  );
}
