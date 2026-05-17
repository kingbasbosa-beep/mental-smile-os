import 'escalation_audit_link.dart';
import 'escalation_level.dart';
import 'escalation_policy_reference.dart';
import 'escalation_reason.dart';
import 'escalation_state.dart';
import 'review_priority.dart';
import 'review_visibility_scope.dart';

/// Passive escalation request metadata.
///
/// Request metadata does not initiate escalation execution. `level` and
/// `priority` do not route or schedule, `reason` does not prove provider or
/// runtime causality, `state` does not progress workflow, and
/// `visibilityScope` does not enforce authorization. `sanitizedPreview` is not
/// a privacy or security boundary, `auditLink` and `policyReference` remain
/// metadata only, and `createdAt` does not prove backend ingestion or
/// processing.
///
/// This request record does not approve, route, execute, own, or guarantee
/// escalation handling.
class EscalationRequest {
  const EscalationRequest({
    required this.uid,
    required this.level,
    required this.reason,
    required this.state,
    required this.priority,
    required this.visibilityScope,
    required this.sanitizedPreview,
    required this.auditLink,
    required this.policyReference,
    this.createdAt,
  });

  final String uid;
  final EscalationLevel level;
  final EscalationReason reason;
  final EscalationState state;
  final ReviewPriority priority;
  final ReviewVisibilityScope visibilityScope;
  final String sanitizedPreview;
  final EscalationAuditLink auditLink;
  final EscalationPolicyReference policyReference;
  final DateTime? createdAt;
}
