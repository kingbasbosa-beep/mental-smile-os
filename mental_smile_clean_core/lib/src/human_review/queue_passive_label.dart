/// Passive human-review queue vocabulary.
///
/// These labels are metadata only. They do not route, admit, assign,
/// notify teams, guarantee review, prove backend governance, or grant outcome
/// write permission.
enum QueuePassiveLabel {
  safetyConcernObserved,
  policyIssueObserved,
  manualSupportRequested,
  reviewStatePending,
}

extension QueuePassiveLabelKey on QueuePassiveLabel {
  String get key {
    switch (this) {
      case QueuePassiveLabel.safetyConcernObserved:
        return 'safety_concern_observed';
      case QueuePassiveLabel.policyIssueObserved:
        return 'policy_issue_observed';
      case QueuePassiveLabel.manualSupportRequested:
        return 'manual_support_requested';
      case QueuePassiveLabel.reviewStatePending:
        return 'review_state_pending';
    }
  }
}
