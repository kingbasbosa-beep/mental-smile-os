import 'escalation_audit_link.dart';
import 'escalation_state.dart';

/// Passive escalation resolution metadata.
///
/// `resolvedBy` is metadata only. `state` does not complete workflow,
/// `outcomeKey` does not enforce policy, moderation, punishment, escalation
/// outcome, or backend action, and `sanitizedResolutionNote` is not a privacy
/// or security boundary. `auditLink` remains metadata only, and `resolvedAt`
/// does not prove backend execution, completion, closure, or finality.
///
/// This record does not approve, close, enforce, execute, resolve workflow
/// ownership, or guarantee escalation outcome.
class EscalationResolution {
  const EscalationResolution({
    required this.escalationId,
    required this.resolvedBy,
    required this.state,
    required this.outcomeKey,
    required this.sanitizedResolutionNote,
    required this.auditLink,
    this.resolvedAt,
  });

  final String escalationId;
  final String resolvedBy;
  final EscalationState state;
  final String outcomeKey;
  final String sanitizedResolutionNote;
  final EscalationAuditLink auditLink;
  final DateTime? resolvedAt;
}
