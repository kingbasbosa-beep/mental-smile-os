import 'canonical_state.dart';

bool isValidTransition(JourneyStage from, JourneyStage to) {
  const allowedTransitions = <JourneyStage, Set<JourneyStage>>{
    JourneyStage.entry: {
      JourneyStage.entry,
      JourneyStage.context_building,
    },
    JourneyStage.context_building: {
      JourneyStage.context_building,
      JourneyStage.guided_support,
    },
    JourneyStage.guided_support: {
      JourneyStage.guided_support,
      JourneyStage.care_matching,
    },
    JourneyStage.care_matching: {
      JourneyStage.care_matching,
      JourneyStage.care_pending,
    },
    JourneyStage.care_pending: {
      JourneyStage.care_pending,
      JourneyStage.care_active,
    },
    JourneyStage.care_active: {
      JourneyStage.care_active,
      JourneyStage.follow_up,
    },
    JourneyStage.follow_up: {
      JourneyStage.follow_up,
      JourneyStage.closure,
    },
    JourneyStage.escalation_pending: {
      JourneyStage.escalation_pending,
    },
    JourneyStage.escalation_active: {
      JourneyStage.escalation_active,
    },
    JourneyStage.closure: {
      JourneyStage.closure,
      JourneyStage.archived,
    },
    JourneyStage.archived: {
      JourneyStage.archived,
    },
  };

  return allowedTransitions[from]?.contains(to) ?? false;
}
