class GuidanceCategoryRegistry {
  const GuidanceCategoryRegistry._();

  static const String definition = 'definition';
  static const String howItHelps = 'how_it_helps';
  static const String whenToUse = 'when_to_use';
  static const String limits = 'limits';
  static const String safetyNotice = 'safety_notice';
  static const String complaintGuidance = 'complaint_guidance';
  static const String accessibilityGuidance = 'accessibility_guidance';
  static const String sponsoredKnowledge = 'sponsored_knowledge';
  static const String departmentInstruction = 'department_instruction';
  static const String operationalInstruction = 'operational_instruction';

  static const Set<String> values = <String>{
    definition,
    howItHelps,
    whenToUse,
    limits,
    safetyNotice,
    complaintGuidance,
    accessibilityGuidance,
    sponsoredKnowledge,
    departmentInstruction,
    operationalInstruction,
  };
}
