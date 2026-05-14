import 'ai_safety_fields.dart';

class AiSafetyRuntimeConfig {
  const AiSafetyRuntimeConfig({
    required this.fallbackOnlyMode,
    required this.escalationEnabled,
    required this.aiEnabled,
    required this.crisisDetectionEnabled,
    required this.loggingEnabled,
    required this.runtimeMode,
  });

  static const AiSafetyRuntimeConfig disabled = AiSafetyRuntimeConfig(
    fallbackOnlyMode: true,
    escalationEnabled: false,
    aiEnabled: false,
    crisisDetectionEnabled: false,
    loggingEnabled: false,
    runtimeMode: 'disabled_placeholder',
  );

  final bool fallbackOnlyMode;
  final bool escalationEnabled;
  final bool aiEnabled;
  final bool crisisDetectionEnabled;
  final bool loggingEnabled;
  final String runtimeMode;

  Map<String, Object?> toMap() {
    return {
      AiSafetyFields.fallbackOnlyMode: fallbackOnlyMode,
      AiSafetyFields.escalationEnabled: escalationEnabled,
      AiSafetyFields.aiEnabled: aiEnabled,
      AiSafetyFields.crisisDetectionEnabled: crisisDetectionEnabled,
      AiSafetyFields.loggingEnabled: loggingEnabled,
      AiSafetyFields.runtimeMode: runtimeMode,
    };
  }
}
