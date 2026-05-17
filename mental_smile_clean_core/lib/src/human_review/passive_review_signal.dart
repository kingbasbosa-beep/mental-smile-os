/// Public low-risk passive human-review vocabulary.
///
/// These labels are passive metadata only. They are not commands,
/// permissions, workflow states, enforcement signals, routing decisions,
/// admission decisions, audit verification, policy compliance proof,
/// emergency handling, or write authority.
///
/// Consumers must not use these labels to route, admit, assign, enforce,
/// verify backend governance, guarantee emergency handling, infer
/// provider/runtime causality, recover fallback loops, or grant outcome write
/// permission.
enum PassiveReviewSignal {
  /// A possible policy issue was observed.
  ///
  /// This is not a confirmed violation, backend adjudication, enforcement
  /// signal, or policy compliance finding.
  policyIssueObserved,

  /// Manual support was requested.
  ///
  /// This is not queue admission, reviewer assignment, support availability,
  /// or workflow execution.
  manualSupportRequested,

  /// A policy reference is present.
  ///
  /// This is not policy validity, policy enforcement, or compliance proof.
  policyReferencePresent,

  /// An audit reference is present.
  ///
  /// This is not audit verification, trace validity, or backend audit
  /// enforcement.
  auditReferencePresent,

  /// The package does not guarantee emergency capability.
  ///
  /// This is negative safety posture only. It does not provide, trigger,
  /// route, or guarantee emergency response, human availability, backend
  /// intervention, provider escalation, or service-level timing.
  emergencyCapabilityNotGuaranteed,
}

extension PassiveReviewSignalKey on PassiveReviewSignal {
  String get key {
    switch (this) {
      case PassiveReviewSignal.policyIssueObserved:
        return 'policy_issue_observed';
      case PassiveReviewSignal.manualSupportRequested:
        return 'manual_support_requested';
      case PassiveReviewSignal.policyReferencePresent:
        return 'policy_reference_present';
      case PassiveReviewSignal.auditReferencePresent:
        return 'audit_reference_present';
      case PassiveReviewSignal.emergencyCapabilityNotGuaranteed:
        return 'emergency_capability_not_guaranteed';
    }
  }
}
