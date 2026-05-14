import 'safety_memory_audit_link.dart';
import 'safety_memory_reference.dart';
import 'safety_memory_runtime_marker.dart';
import 'safety_memory_scope.dart';
import 'safety_memory_visibility_scope.dart';

class SafetyMemoryContext {
  const SafetyMemoryContext({
    required this.contextId,
    required this.scope,
    required this.visibilityScope,
    required this.references,
    required this.auditLink,
    required this.runtimeMarker,
    required this.policyVersion,
    required this.reviewRequired,
  });

  final String contextId;
  final SafetyMemoryScope scope;
  final SafetyMemoryVisibilityScope visibilityScope;
  final List<SafetyMemoryReference> references;
  final SafetyMemoryAuditLink auditLink;
  final SafetyMemoryRuntimeMarker runtimeMarker;
  final String policyVersion;
  final bool reviewRequired;
}
