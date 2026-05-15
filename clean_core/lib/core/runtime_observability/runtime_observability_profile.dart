import 'runtime_observability_audit_link.dart';
import 'runtime_observability_reference.dart';
import 'runtime_observability_requirement.dart';
import 'runtime_observability_review_marker.dart';
import 'runtime_observability_runtime_marker.dart';
import 'runtime_observability_stage.dart';
import 'runtime_observability_visibility_scope.dart';
import 'runtime_observation.dart';

class RuntimeObservabilityProfile {
  const RuntimeObservabilityProfile({
    required this.profileId,
    required this.stage,
    required this.visibilityScope,
    required this.policyVersion,
    required this.references,
    required this.observations,
    required this.runtimeMarker,
    required this.auditLink,
    required this.reviewMarker,
    required this.requirement,
    this.signedAuthorityPlaceholder,
  });

  final String profileId;
  final RuntimeObservabilityStage stage;
  final RuntimeObservabilityVisibilityScope visibilityScope;
  final String policyVersion;
  final List<RuntimeObservabilityReference> references;
  final List<RuntimeObservation> observations;
  final RuntimeObservabilityRuntimeMarker runtimeMarker;
  final RuntimeObservabilityAuditLink auditLink;
  final RuntimeObservabilityReviewMarker reviewMarker;
  final RuntimeObservabilityRequirement requirement;
  final String? signedAuthorityPlaceholder;

  bool get hasSignedAuthority =>
      signedAuthorityPlaceholder != null &&
      signedAuthorityPlaceholder!.trim().isNotEmpty;

  bool get hasObservationOwner =>
      observations.isNotEmpty &&
      observations.every((observation) => observation.hasOwner);

  bool get hasSanitizedObservations =>
      observations.isNotEmpty &&
      observations.every((observation) => observation.isSanitized);

  bool get hasNoTelemetryRuntime =>
      observations.every((observation) => !observation.telemetryRuntimeActive);
}
