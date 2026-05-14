import 'conversation_control_mode.dart';
import 'mental_smile_response_mode.dart';

class MentalSmileResponseContract {
  const MentalSmileResponseContract({
    required this.responseMode,
    required this.controlMode,
    required this.outputValidated,
    required this.requiresHumanReview,
    required this.safetyNotice,
  });

  final MentalSmileResponseMode responseMode;
  final ConversationControlMode controlMode;
  final bool outputValidated;
  final bool requiresHumanReview;
  final String safetyNotice;

  Map<String, Object?> toMap() {
    return {
      'responseMode': responseMode.key,
      'controlMode': controlMode.key,
      'outputValidated': outputValidated,
      'requiresHumanReview': requiresHumanReview,
      'safetyNotice': safetyNotice,
    };
  }
}
