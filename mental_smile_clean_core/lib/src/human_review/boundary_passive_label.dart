/// Passive human-review boundary vocabulary.
///
/// These labels describe observed references only. They do not enforce policy,
/// verify audits, route review work, prove backend governance, or grant client
/// outcome write permission.
enum BoundaryPassiveLabel {
  policyReferencePresent,
  auditReferencePresent,
  reviewBoundaryObserved,
}

extension BoundaryPassiveLabelKey on BoundaryPassiveLabel {
  String get key {
    switch (this) {
      case BoundaryPassiveLabel.policyReferencePresent:
        return 'policy_reference_present';
      case BoundaryPassiveLabel.auditReferencePresent:
        return 'audit_reference_present';
      case BoundaryPassiveLabel.reviewBoundaryObserved:
        return 'review_boundary_observed';
    }
  }
}
