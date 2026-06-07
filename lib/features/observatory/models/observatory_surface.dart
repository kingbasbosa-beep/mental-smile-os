class ObservatorySurface {
  const ObservatorySurface({
    required this.surfaceId,
    required this.surfaceType,
    required this.department,
    required this.observable,
    required this.notes,
  });

  final String surfaceId;
  final String surfaceType;
  final String department;
  final bool observable;
  final String notes;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'surfaceId': surfaceId,
      'surfaceType': surfaceType,
      'department': department,
      'observable': observable,
      'notes': notes,
    };
  }
}
