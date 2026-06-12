class MagnetResource {
  const MagnetResource({
    required this.resourceId,
    required this.resourceType,
    required this.resourceSignals,
    required this.resourceFingerprintIds,
    required this.resourcePriority,
    required this.resourceStatus,
  });

  final String resourceId;
  final String resourceType;
  final List<String> resourceSignals;
  final List<String> resourceFingerprintIds;
  final int resourcePriority;
  final String resourceStatus;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'resourceId': resourceId,
      'resourceType': resourceType,
      'resourceSignals': resourceSignals,
      'resourceFingerprintIds': resourceFingerprintIds,
      'resourcePriority': resourcePriority,
      'resourceStatus': resourceStatus,
    };
  }

  factory MagnetResource.fromMap(Map<String, dynamic> map) {
    return MagnetResource(
      resourceId: (map['resourceId'] ?? '').toString(),
      resourceType: (map['resourceType'] ?? '').toString(),
      resourceSignals: _stringList(map['resourceSignals']),
      resourceFingerprintIds: _stringList(map['resourceFingerprintIds']),
      resourcePriority: _intValue(map['resourcePriority']),
      resourceStatus: (map['resourceStatus'] ?? '').toString(),
    );
  }

  static int _intValue(Object? value) {
    if (value is num) return value.toInt();
    return int.tryParse((value ?? '').toString()) ?? 0;
  }

  static List<String> _stringList(Object? value) {
    if (value is Iterable) {
      return value
          .map((item) => item.toString().trim())
          .where((item) => item.isNotEmpty)
          .toList(growable: false);
    }
    return const <String>[];
  }
}
