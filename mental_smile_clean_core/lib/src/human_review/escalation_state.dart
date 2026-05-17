/// Passive escalation state vocabulary.
///
/// State labels are metadata only. They do not progress workflow, assign
/// authority, approve outcomes, resolve cases, reject cases, archive records,
/// or prove backend transition.
enum EscalationState {
  pendingReview,
  assigned,
  inReview,
  resolved,
  rejected,
  archived,
}

extension EscalationStateKey on EscalationState {
  String get key {
    switch (this) {
      case EscalationState.pendingReview:
        return 'pending_review';
      case EscalationState.assigned:
        return 'assigned';
      case EscalationState.inReview:
        return 'in_review';
      case EscalationState.resolved:
        return 'resolved';
      case EscalationState.rejected:
        return 'rejected';
      case EscalationState.archived:
        return 'archived';
    }
  }
}
