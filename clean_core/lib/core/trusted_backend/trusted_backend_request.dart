import 'trusted_backend_audit_link.dart';
import 'trusted_backend_reference.dart';
import 'trusted_backend_requirement.dart';
import 'trusted_backend_runtime_marker.dart';
import 'trusted_backend_visibility_scope.dart';

class TrustedBackendRequest {
  const TrustedBackendRequest({
    required this.requestId,
    required this.policyVersion,
    required this.visibilityScope,
    required this.requirement,
    required this.reference,
    required this.runtimeMarker,
    required this.auditLink,
    required this.signedAuthorityPlaceholder,
    required this.reviewRequired,
  });

  final String requestId;
  final String policyVersion;
  final TrustedBackendVisibilityScope visibilityScope;
  final TrustedBackendRequirement requirement;
  final TrustedBackendReference reference;
  final TrustedBackendRuntimeMarker runtimeMarker;
  final TrustedBackendAuditLink auditLink;
  final String signedAuthorityPlaceholder;
  final bool reviewRequired;

  bool get hasSignedAuthority {
    return signedAuthorityPlaceholder.trim().isNotEmpty;
  }
}
