import 'audit_processing_context.dart';
import 'audit_reference.dart';

/// Passive audit trace model.
///
/// This model is declarative data only. The trace hash is metadata unless
/// verified by a backend-owned integrity system, sanitized preview is not a
/// privacy boundary, processing context does not prove execution or provider
/// guarantees, and references are metadata only.
class AuditTrace {
  const AuditTrace({
    required this.traceId,
    required this.traceHash,
    required this.policyVersion,
    required this.processingContext,
    required this.references,
    required this.sanitizedPreview,
    this.createdAt,
  });

  final String traceId;
  final String traceHash;
  final String policyVersion;
  final AuditProcessingContext processingContext;
  final List<AuditReference> references;
  final String sanitizedPreview;
  final DateTime? createdAt;
}
