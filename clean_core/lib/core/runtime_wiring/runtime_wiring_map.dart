import 'runtime_wiring_audit_link.dart';
import 'runtime_wiring_path.dart';
import 'runtime_wiring_reference.dart';
import 'runtime_wiring_requirement.dart';
import 'runtime_wiring_review_marker.dart';
import 'runtime_wiring_runtime_marker.dart';
import 'runtime_wiring_visibility_scope.dart';
import 'runtime_wiring_owner.dart';

class RuntimeWiringMap {
  const RuntimeWiringMap({
    required this.mapId,
    required this.visibilityScope,
    required this.policyVersion,
    required this.references,
    required this.paths,
    required this.owners,
    required this.runtimeMarker,
    required this.auditLink,
    required this.reviewMarker,
    required this.requirement,
  });

  final String mapId;
  final RuntimeWiringVisibilityScope visibilityScope;
  final String policyVersion;
  final List<RuntimeWiringReference> references;
  final List<RuntimeWiringPath> paths;
  final List<RuntimeWiringOwner> owners;
  final RuntimeWiringRuntimeMarker runtimeMarker;
  final RuntimeWiringAuditLink auditLink;
  final RuntimeWiringReviewMarker reviewMarker;
  final RuntimeWiringRequirement requirement;

  bool get hasTrustedOwner => owners.any((owner) => owner.isTrusted);
}
