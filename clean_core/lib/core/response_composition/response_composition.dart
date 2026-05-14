import 'response_audit_link.dart';
import 'response_confidence_marker.dart';
import 'response_disclaimer.dart';
import 'response_fallback.dart';
import 'response_policy_link.dart';
import 'response_review_marker.dart';
import 'response_runtime_marker.dart';
import 'response_section.dart';
import 'response_support_guidance.dart';

class ResponseComposition {
  const ResponseComposition({
    required this.compositionId,
    required this.sections,
    required this.disclaimer,
    required this.supportGuidance,
    required this.fallback,
    required this.reviewMarker,
    required this.policyLink,
    required this.auditLink,
    required this.runtimeMarker,
    required this.confidenceMarker,
  });

  static const ResponseComposition disabledFallback = ResponseComposition(
    compositionId: 'disabled_fallback',
    sections: <ResponseSection>[],
    disclaimer: ResponseDisclaimer.safeDefault,
    supportGuidance: ResponseSupportGuidance.safeDefault,
    fallback: ResponseFallback.runtimeDisabled,
    reviewMarker: ResponseReviewMarker.safeDefault,
    policyLink: ResponsePolicyLink(
      policyVersion: '2026-05-os4d',
      snapshotId: '',
      hashPlaceholder: 'response_policy_hash_placeholder',
    ),
    auditLink: ResponseAuditLink(
      auditId: '',
      traceHash: '',
      visibilityScope: 'audit_only',
    ),
    runtimeMarker: ResponseRuntimeMarker.disabled,
    confidenceMarker: ResponseConfidenceMarker.unknown,
  );

  final String compositionId;
  final List<ResponseSection> sections;
  final ResponseDisclaimer disclaimer;
  final ResponseSupportGuidance supportGuidance;
  final ResponseFallback fallback;
  final ResponseReviewMarker reviewMarker;
  final ResponsePolicyLink policyLink;
  final ResponseAuditLink auditLink;
  final ResponseRuntimeMarker runtimeMarker;
  final ResponseConfidenceMarker confidenceMarker;

  bool get isSafeForDisplay {
    return disclaimer.keys().isNotEmpty &&
        supportGuidance.emergencyGuarantee == false &&
        runtimeMarker.backendGoverned &&
        confidenceMarker.failClosed;
  }
}
