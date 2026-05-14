import 'escalation_reason.dart';
import 'escalation_state.dart';
import 'review_priority.dart';
import 'review_visibility_scope.dart';

class EscalationQueue {
  const EscalationQueue({
    required this.queueId,
    required this.acceptedReasons,
    required this.acceptedPriorities,
    required this.visibleTo,
    required this.allowedStates,
  });

  static const EscalationQueue safetyReview = EscalationQueue(
    queueId: 'safety_review',
    acceptedReasons: <EscalationReason>{
      EscalationReason.safetyConcern,
      EscalationReason.crisisRisk,
      EscalationReason.policyViolation,
      EscalationReason.fallbackLoop,
    },
    acceptedPriorities: <ReviewPriority>{
      ReviewPriority.medium,
      ReviewPriority.high,
      ReviewPriority.urgent,
    },
    visibleTo: ReviewVisibilityScope.safetyTeam,
    allowedStates: <EscalationState>{
      EscalationState.pendingReview,
      EscalationState.assigned,
      EscalationState.inReview,
    },
  );

  final String queueId;
  final Set<EscalationReason> acceptedReasons;
  final Set<ReviewPriority> acceptedPriorities;
  final ReviewVisibilityScope visibleTo;
  final Set<EscalationState> allowedStates;

  bool accepts({
    required EscalationReason reason,
    required ReviewPriority priority,
    required EscalationState state,
  }) {
    return acceptedReasons.contains(reason) &&
        acceptedPriorities.contains(priority) &&
        allowedStates.contains(state);
  }
}
