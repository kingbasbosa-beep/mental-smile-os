import 'environment_activation_audit_link.dart';
import 'environment_activation_environment.dart';
import 'environment_activation_reference.dart';
import 'environment_activation_requirement.dart';
import 'environment_activation_review_marker.dart';
import 'environment_activation_runtime_marker.dart';
import 'environment_activation_stage.dart';
import 'environment_activation_visibility_scope.dart';

class EnvironmentActivationProfile {
  const EnvironmentActivationProfile({
    required this.profileId,
    required this.stage,
    required this.visibilityScope,
    required this.policyVersion,
    required this.environment,
    required this.references,
    required this.runtimeMarker,
    required this.auditLink,
    required this.reviewMarker,
    required this.requirement,
    required this.runtimePermissionPlaceholder,
    required this.providerPermissionPlaceholder,
    required this.backendPermissionPlaceholder,
    required this.routingPermissionPlaceholder,
    required this.governancePermissionPlaceholder,
  });

  final String profileId;
  final EnvironmentActivationStage stage;
  final EnvironmentActivationVisibilityScope visibilityScope;
  final String policyVersion;
  final EnvironmentActivationEnvironment environment;
  final List<EnvironmentActivationReference> references;
  final EnvironmentActivationRuntimeMarker runtimeMarker;
  final EnvironmentActivationAuditLink auditLink;
  final EnvironmentActivationReviewMarker reviewMarker;
  final EnvironmentActivationRequirement requirement;
  final String runtimePermissionPlaceholder;
  final String providerPermissionPlaceholder;
  final String backendPermissionPlaceholder;
  final String routingPermissionPlaceholder;
  final String governancePermissionPlaceholder;

  bool get hasRuntimePermission =>
      runtimePermissionPlaceholder.trim().isNotEmpty;

  bool get hasProviderPermission =>
      providerPermissionPlaceholder.trim().isNotEmpty;

  bool get hasBackendPermission =>
      backendPermissionPlaceholder.trim().isNotEmpty;

  bool get hasRoutingPermission =>
      routingPermissionPlaceholder.trim().isNotEmpty;

  bool get hasGovernancePermission =>
      governancePermissionPlaceholder.trim().isNotEmpty;
}
