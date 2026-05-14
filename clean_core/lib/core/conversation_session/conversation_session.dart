import 'conversation_audit_link.dart';
import 'conversation_runtime_marker.dart';
import 'conversation_session_mode.dart';
import 'conversation_session_scope.dart';
import 'conversation_session_state.dart';

class ConversationSession {
  const ConversationSession({
    required this.sessionId,
    required this.uid,
    required this.state,
    required this.mode,
    required this.scope,
    required this.runtimeMarker,
    required this.auditLink,
    required this.policyVersion,
  });

  static const ConversationSession disabledPlaceholder = ConversationSession(
    sessionId: 'disabled_placeholder',
    uid: '',
    state: ConversationSessionState.fallbackOnly,
    mode: ConversationSessionMode.aiDisabled,
    scope: ConversationSessionScope.safeSupport,
    runtimeMarker: ConversationRuntimeMarker.disabled,
    auditLink: ConversationAuditLink(
      auditId: '',
      traceHash: '',
      policyVersion: '2026-05-os4c',
    ),
    policyVersion: '2026-05-os4c',
  );

  final String sessionId;
  final String uid;
  final ConversationSessionState state;
  final ConversationSessionMode mode;
  final ConversationSessionScope scope;
  final ConversationRuntimeMarker runtimeMarker;
  final ConversationAuditLink auditLink;
  final String policyVersion;

  Map<String, Object?> toMap() {
    return {
      'sessionId': sessionId,
      'uid': uid,
      'state': state.key,
      'mode': mode.key,
      'scope': scope.key,
      'runtimeMarker': runtimeMarker.toMap(),
      'auditLink': auditLink.toMap(),
      'policyVersion': policyVersion,
    };
  }
}
