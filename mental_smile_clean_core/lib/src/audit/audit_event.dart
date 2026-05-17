import 'audit_actor_type.dart';
import 'audit_event_type.dart';
import 'audit_processing_context.dart';
import 'audit_reference.dart';
import 'audit_severity.dart';
import 'audit_visibility_scope.dart';

/// Passive audit event model.
///
/// This model is declarative data only. Actor labels do not prove authority,
/// visibility does not enforce access control, processing context does not
/// prove execution, policy version is metadata only, sanitized preview is not a
/// security boundary, and references are metadata only.
class AuditEvent {
  const AuditEvent({
    required this.actorType,
    required this.eventType,
    required this.severity,
    required this.visibilityScope,
    required this.actorId,
    required this.sanitizedPreview,
    required this.policyVersion,
    required this.references,
    required this.processingContext,
    this.createdAt,
  });

  final AuditActorType actorType;
  final AuditEventType eventType;
  final AuditSeverity severity;
  final AuditVisibilityScope visibilityScope;
  final String actorId;
  final String sanitizedPreview;
  final String policyVersion;
  final List<AuditReference> references;
  final AuditProcessingContext processingContext;
  final DateTime? createdAt;
}
