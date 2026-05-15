import 'architecture_freeze_marker.dart';
import 'architecture_freeze_policy.dart';
import 'architecture_manifest_audit_link.dart';
import 'architecture_manifest_entry.dart';
import 'architecture_manifest_policy.dart';
import 'architecture_manifest_requirement.dart';
import 'architecture_manifest_review_marker.dart';
import 'architecture_manifest_runtime_marker.dart';
import 'architecture_manifest_state.dart';
import 'architecture_manifest_visibility_scope.dart';

class ArchitectureManifest {
  const ArchitectureManifest({
    required this.manifestId,
    required this.state,
    required this.visibilityScope,
    required this.policy,
    required this.freezePolicy,
    required this.requirement,
    required this.entries,
    required this.runtimeMarker,
    required this.auditLink,
    required this.reviewMarker,
    required this.freezeMarker,
  });

  static const ArchitectureManifest frozenDefault = ArchitectureManifest(
    manifestId: 'clean_core_frozen_manifest',
    state: ArchitectureManifestState.frozen,
    visibilityScope: ArchitectureManifestVisibilityScope.architectureInternal,
    policy: ArchitectureManifestPolicy.safeDefault,
    freezePolicy: ArchitectureFreezePolicy.safeDefault,
    requirement: ArchitectureManifestRequirement.safeDefault,
    entries: <ArchitectureManifestEntry>[],
    runtimeMarker: ArchitectureManifestRuntimeMarker.disabled,
    auditLink: ArchitectureManifestAuditLink(
      auditId: '',
      traceHash: '',
      policyVersion: '2026-05-os6g',
    ),
    reviewMarker: ArchitectureManifestReviewMarker.safeDefault,
    freezeMarker: ArchitectureFreezeMarker.safeDefault,
  );

  final String manifestId;
  final ArchitectureManifestState state;
  final ArchitectureManifestVisibilityScope visibilityScope;
  final ArchitectureManifestPolicy policy;
  final ArchitectureFreezePolicy freezePolicy;
  final ArchitectureManifestRequirement requirement;
  final List<ArchitectureManifestEntry> entries;
  final ArchitectureManifestRuntimeMarker runtimeMarker;
  final ArchitectureManifestAuditLink auditLink;
  final ArchitectureManifestReviewMarker reviewMarker;
  final ArchitectureFreezeMarker freezeMarker;
}
