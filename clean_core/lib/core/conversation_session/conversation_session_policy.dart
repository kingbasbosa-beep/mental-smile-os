import 'conversation_session_mode.dart';
import 'conversation_session_scope.dart';

class ConversationSessionPolicy {
  const ConversationSessionPolicy({
    required this.requiredPolicyVersion,
    required this.allowedModes,
    required this.allowedScopes,
    required this.auditRequired,
    required this.providerAllowed,
    required this.escalationOutcomeClientWritable,
    required this.failClosed,
  });

  static const ConversationSessionPolicy safeDefault =
      ConversationSessionPolicy(
    requiredPolicyVersion: '2026-05-os4c',
    allowedModes: <ConversationSessionMode>{
      ConversationSessionMode.aiDisabled,
      ConversationSessionMode.fallbackOnly,
      ConversationSessionMode.humanPriority,
    },
    allowedScopes: <ConversationSessionScope>{
      ConversationSessionScope.safeSupport,
      ConversationSessionScope.crisisSafeCopy,
      ConversationSessionScope.auditOnly,
    },
    auditRequired: true,
    providerAllowed: false,
    escalationOutcomeClientWritable: false,
    failClosed: true,
  );

  final String requiredPolicyVersion;
  final Set<ConversationSessionMode> allowedModes;
  final Set<ConversationSessionScope> allowedScopes;
  final bool auditRequired;
  final bool providerAllowed;
  final bool escalationOutcomeClientWritable;
  final bool failClosed;
}
