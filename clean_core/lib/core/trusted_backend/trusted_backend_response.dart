import 'trusted_backend_audit_link.dart';
import 'trusted_backend_reference.dart';
import 'trusted_backend_state.dart';

class TrustedBackendResponse {
  const TrustedBackendResponse({
    required this.responseId,
    required this.state,
    required this.reference,
    required this.auditLink,
    required this.accepted,
  });

  final String responseId;
  final TrustedBackendState state;
  final TrustedBackendReference reference;
  final TrustedBackendAuditLink auditLink;
  final bool accepted;

  Map<String, Object?> toMap() {
    return {
      'responseId': responseId,
      'state': state.key,
      'reference': reference.toMap(),
      'auditLink': auditLink.toMap(),
      'accepted': accepted,
    };
  }
}
