typedef JourneyType = String;
typedef CanonicalStatus = String;
typedef WorkflowStep = String;

enum JourneyStage {
  entry,
  context_building,
  guided_support,
  care_matching,
  care_pending,
  care_active,
  follow_up,
  escalation_pending,
  escalation_active,
  closure,
  archived,
}

enum TransitionOwner {
  user_owned,
  family_owned,
  provider_owned,
  admin_owned,
  ai_detected_admin_confirmed,
  ops_detected_admin_confirmed,
  system_locked,
}

class CanonicalState {
  final JourneyType journeyType;
  final JourneyStage journeyStage;
  final CanonicalStatus? status;
  final WorkflowStep? workflowStep;
  final TransitionOwner? transitionOwner;
  final DateTime updatedAt;

  const CanonicalState({
    required this.journeyType,
    required this.journeyStage,
    this.status,
    this.workflowStep,
    this.transitionOwner,
    required this.updatedAt,
  });
}
