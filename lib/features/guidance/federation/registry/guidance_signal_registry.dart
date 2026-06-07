class GuidanceSignalRegistry {
  const GuidanceSignalRegistry._();

  static const String guidanceOpened = 'guidance_opened';
  static const String guidanceLearnMoreOpened = 'guidance_learn_more_opened';
  static const String guidanceAudioRequested = 'guidance_audio_requested';
  static const String guidanceEasyModeSelected = 'guidance_easy_mode_selected';
  static const String guidanceDismissed = 'guidance_dismissed';
  static const String accessibilityModeSelected = 'accessibility_mode_selected';

  static const Set<String> values = <String>{
    guidanceOpened,
    guidanceLearnMoreOpened,
    guidanceAudioRequested,
    guidanceEasyModeSelected,
    guidanceDismissed,
    accessibilityModeSelected,
  };
}
