class AdoptionAggregate {
  const AdoptionAggregate({
    required this.newUsers,
    required this.returningUsers,
    required this.retentionIndicator,
  });

  final int newUsers;
  final int returningUsers;
  final num retentionIndicator;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'newUsers': newUsers,
      'returningUsers': returningUsers,
      'retentionIndicator': retentionIndicator,
    };
  }
}
