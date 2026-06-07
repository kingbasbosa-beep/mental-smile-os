class OwnerCapsuleReadiness {
  const OwnerCapsuleReadiness({
    required this.readinessId,
    required this.status,
    required this.blockers,
    required this.requiredActions,
  });

  final String readinessId;
  final String status;
  final List<String> blockers;
  final List<String> requiredActions;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'readinessId': readinessId,
      'status': status,
      'blockers': blockers,
      'requiredActions': requiredActions,
    };
  }
}
