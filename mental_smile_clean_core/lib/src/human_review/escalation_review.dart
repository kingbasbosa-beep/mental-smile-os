import 'escalation_audit_link.dart';
import 'escalation_state.dart';

/// Passive escalation review metadata.
///
/// `reviewerId` is metadata only. `state` does not progress workflow,
/// `sanitizedReviewNote` is not a privacy or security boundary, `auditLink`
/// remains metadata only, and `reviewedAt` does not prove backend execution or
/// review finality. This record does not approve, moderate, execute, resolve,
/// or own escalation workflow.
class EscalationReview {
  const EscalationReview({
    required this.escalationId,
    required this.reviewerId,
    required this.state,
    required this.sanitizedReviewNote,
    required this.auditLink,
    this.reviewedAt,
  });

  final String escalationId;
  final String reviewerId;
  final EscalationState state;
  final String sanitizedReviewNote;
  final EscalationAuditLink auditLink;
  final DateTime? reviewedAt;
}
