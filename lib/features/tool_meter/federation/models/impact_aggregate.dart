class ImpactAggregate {
  const ImpactAggregate({
    required this.guidanceInteractions,
    required this.resourceInteractions,
    required this.followThroughIndicator,
  });

  final int guidanceInteractions;
  final int resourceInteractions;
  final num followThroughIndicator;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'guidanceInteractions': guidanceInteractions,
      'resourceInteractions': resourceInteractions,
      'followThroughIndicator': followThroughIndicator,
    };
  }
}
