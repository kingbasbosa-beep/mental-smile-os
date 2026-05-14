class EscalationBoundaryMarker {
  const EscalationBoundaryMarker({
    required this.backendGoverned,
    required this.clientOutcomeWritesAllowed,
    required this.emergencyGuarantee,
  });

  static const EscalationBoundaryMarker safeDefault = EscalationBoundaryMarker(
    backendGoverned: true,
    clientOutcomeWritesAllowed: false,
    emergencyGuarantee: false,
  );

  final bool backendGoverned;
  final bool clientOutcomeWritesAllowed;
  final bool emergencyGuarantee;

  Map<String, Object?> toMap() {
    return {
      'backendGoverned': backendGoverned,
      'clientOutcomeWritesAllowed': clientOutcomeWritesAllowed,
      'emergencyGuarantee': emergencyGuarantee,
    };
  }
}
