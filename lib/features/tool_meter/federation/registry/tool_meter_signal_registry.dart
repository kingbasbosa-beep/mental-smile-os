class ToolMeterSignalRegistry {
  const ToolMeterSignalRegistry._();

  static const String toolViewed = 'tool_viewed';
  static const String toolOpened = 'tool_opened';
  static const String toolCompleted = 'tool_completed';
  static const String resourceOpened = 'resource_opened';
  static const String campaignOpened = 'campaign_opened';
  static const String guidanceInteracted = 'guidance_interacted';
  static const String reputationViewed = 'reputation_viewed';

  static const Set<String> values = <String>{
    toolViewed,
    toolOpened,
    toolCompleted,
    resourceOpened,
    campaignOpened,
    guidanceInteracted,
    reputationViewed,
  };
}
