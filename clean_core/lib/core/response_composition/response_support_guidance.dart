class ResponseSupportGuidance {
  const ResponseSupportGuidance({
    required this.guidanceKeys,
    required this.encourageHumanSupport,
    required this.emergencyGuarantee,
  });

  static const ResponseSupportGuidance safeDefault = ResponseSupportGuidance(
    guidanceKeys: <String>{
      'slow_down',
      'grounding',
      'trusted_person',
      'local_emergency_if_immediate_danger',
    },
    encourageHumanSupport: true,
    emergencyGuarantee: false,
  );

  final Set<String> guidanceKeys;
  final bool encourageHumanSupport;
  final bool emergencyGuarantee;
}
