class SignalPackage {
  const SignalPackage({
    required this.signalId,
    required this.signalType,
    required this.signalCategory,
    required this.signalDomain,
    required this.signalSource,
    required this.actorId,
    required this.actorRole,
    required this.targetType,
    required this.targetId,
    required this.timestamp,
    required this.routingTarget,
    required this.retentionClass,
    required this.privacyLevel,
    required this.signalVersion,
  });

  final String signalId;
  final String signalType;
  final String signalCategory;
  final String signalDomain;
  final String signalSource;
  final String actorId;
  final String actorRole;
  final String targetType;
  final String targetId;
  final DateTime timestamp;
  final String routingTarget;
  final String retentionClass;
  final String privacyLevel;
  final String signalVersion;

  static const String currentVersion = 'signal_package_v1';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'signalId': signalId,
      'signalType': signalType,
      'signalCategory': signalCategory,
      'signalDomain': signalDomain,
      'signalSource': signalSource,
      'actorId': actorId,
      'actorRole': actorRole,
      'targetType': targetType,
      'targetId': targetId,
      'timestamp': timestamp.toIso8601String(),
      'routingTarget': routingTarget,
      'retentionClass': retentionClass,
      'privacyLevel': privacyLevel,
      'signalVersion': signalVersion,
    };
  }

  factory SignalPackage.fromMap(Map<String, dynamic> map) {
    return SignalPackage(
      signalId: (map['signalId'] ?? '').toString(),
      signalType: (map['signalType'] ?? '').toString(),
      signalCategory: (map['signalCategory'] ?? '').toString(),
      signalDomain: (map['signalDomain'] ?? '').toString(),
      signalSource: (map['signalSource'] ?? '').toString(),
      actorId: (map['actorId'] ?? '').toString(),
      actorRole: (map['actorRole'] ?? '').toString(),
      targetType: (map['targetType'] ?? '').toString(),
      targetId: (map['targetId'] ?? '').toString(),
      timestamp: _dateTime(map['timestamp']) ?? DateTime.fromMillisecondsSinceEpoch(0),
      routingTarget: (map['routingTarget'] ?? '').toString(),
      retentionClass: (map['retentionClass'] ?? '').toString(),
      privacyLevel: (map['privacyLevel'] ?? '').toString(),
      signalVersion: (map['signalVersion'] ?? currentVersion).toString(),
    );
  }

  static DateTime? _dateTime(Object? value) {
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
