class ObservatoryHealth {
  const ObservatoryHealth({
    required this.healthId,
    required this.status,
    required this.warnings,
    required this.blockers,
  });

  final String healthId;
  final String status;
  final List<String> warnings;
  final List<String> blockers;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'healthId': healthId,
      'status': status,
      'warnings': warnings,
      'blockers': blockers,
    };
  }
}
