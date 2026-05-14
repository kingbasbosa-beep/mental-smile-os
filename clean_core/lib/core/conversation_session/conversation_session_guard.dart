import 'conversation_fallback_state.dart';
import 'conversation_session.dart';
import 'conversation_session_mode.dart';
import 'conversation_session_policy.dart';
import 'conversation_session_state.dart';

class ConversationSessionGuard {
  const ConversationSessionGuard();

  ConversationFallbackState? blockReason({
    required ConversationSession session,
    required ConversationSessionPolicy policy,
  }) {
    if (session.mode.key == 'ai_disabled') {
      return ConversationFallbackState.runtimeDisabled;
    }
    if (!policy.allowedModes.contains(session.mode) ||
        !policy.allowedScopes.contains(session.scope) ||
        policy.requiredPolicyVersion != session.policyVersion) {
      return ConversationFallbackState.policyBlocked;
    }
    if (!policy.providerAllowed &&
        session.runtimeMarker.providerId.trim().isNotEmpty) {
      return ConversationFallbackState.providerBlocked;
    }
    if (policy.auditRequired && !session.auditLink.isLinked) {
      return ConversationFallbackState.auditMissing;
    }
    if (session.state == ConversationSessionState.reviewRequired) {
      return ConversationFallbackState.reviewRequired;
    }
    if (policy.failClosed) return ConversationFallbackState.failClosed;
    return null;
  }
}
