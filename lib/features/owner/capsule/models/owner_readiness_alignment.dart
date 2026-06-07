class OwnerReadinessAlignment {
  const OwnerReadinessAlignment({
    required this.readinessReference,
    required this.roadmapReference,
    required this.ownerCapsuleReference,
    required this.claimsReference,
    required this.deploymentReference,
  });

  final String readinessReference;
  final String roadmapReference;
  final String ownerCapsuleReference;
  final String claimsReference;
  final String deploymentReference;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'readinessReference': readinessReference,
      'roadmapReference': roadmapReference,
      'ownerCapsuleReference': ownerCapsuleReference,
      'claimsReference': claimsReference,
      'deploymentReference': deploymentReference,
    };
  }
}
