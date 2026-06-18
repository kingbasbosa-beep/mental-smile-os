class ProviderContactRequestRecord {
  const ProviderContactRequestRecord({
    required this.requestId,
    required this.requesterSessionId,
    required this.providerId,
    required this.message,
    required this.goalSignals,
    required this.interestSignals,
    required this.accessibilitySignals,
    required this.createdAt,
    required this.updatedAt,
  });

  static const String collectionName = 'provider_contact_requests';

  final String requestId;
  final String requesterSessionId;
  final String providerId;
  final String message;
  final List<String> goalSignals;
  final List<String> interestSignals;
  final List<String> accessibilitySignals;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestId': requestId,
      'requesterSessionId': requesterSessionId,
      'providerId': providerId,
      'message': message,
      'goalSignals': goalSignals,
      'interestSignals': interestSignals,
      'accessibilitySignals': accessibilitySignals,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory ProviderContactRequestRecord.fromMap(Map<String, dynamic> map) {
    return ProviderContactRequestRecord(
      requestId: (map['requestId'] ?? '').toString(),
      requesterSessionId: (map['requesterSessionId'] ?? '').toString(),
      providerId: (map['providerId'] ?? '').toString(),
      message: (map['message'] ?? '').toString(),
      goalSignals: _stringList(map['goalSignals']),
      interestSignals: _stringList(map['interestSignals']),
      accessibilitySignals: _stringList(map['accessibilitySignals']),
      createdAt: _dateTime(map['createdAt']),
      updatedAt: _dateTime(map['updatedAt']),
    );
  }

  static List<String> _stringList(Object? value) {
    if (value is Iterable) {
      return value.map((item) => item.toString()).toList(growable: false);
    }
    return const <String>[];
  }

  static DateTime? _dateTime(Object? value) {
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
