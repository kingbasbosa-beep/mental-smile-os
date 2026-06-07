class ObservatoryReadiness {
  const ObservatoryReadiness({
    required this.readinessId,
    required this.status,
    required this.requiredBeforeUi,
    required this.requiredActions,
  });

  final String readinessId;
  final String status;
  final bool requiredBeforeUi;
  final List<String> requiredActions;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'readinessId': readinessId,
      'status': status,
      'requiredBeforeUi': requiredBeforeUi,
      'requiredActions': requiredActions,
    };
  }
}
