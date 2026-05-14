import 'safety_registry_audit_link.dart';
import 'safety_registry_reference.dart';
import 'safety_registry_review_marker.dart';
import 'safety_registry_runtime_marker.dart';
import 'safety_registry_scope.dart';
import 'safety_registry_state.dart';
import 'safety_registry_visibility_scope.dart';

class SafetyRegistryEntry {
  const SafetyRegistryEntry({
    required this.moduleId,
    required this.state,
    required this.scope,
    required this.visibilityScope,
    required this.policyVersion,
    required this.reference,
    required this.runtimeMarker,
    required this.auditLink,
    required this.reviewMarker,
  });

  final String moduleId;
  final SafetyRegistryState state;
  final SafetyRegistryScope scope;
  final SafetyRegistryVisibilityScope visibilityScope;
  final String policyVersion;
  final SafetyRegistryReference reference;
  final SafetyRegistryRuntimeMarker runtimeMarker;
  final SafetyRegistryAuditLink auditLink;
  final SafetyRegistryReviewMarker reviewMarker;
}
