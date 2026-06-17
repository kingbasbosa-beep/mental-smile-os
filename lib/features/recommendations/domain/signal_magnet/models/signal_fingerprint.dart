class SignalFingerprint {
  const SignalFingerprint({
    required this.signalId,
    required this.signalCategory,
    required this.signalWeight,
    required this.signalTags,
    required this.signalPriority,
  });

  final String signalId;
  final String signalCategory;
  final double signalWeight;
  final List<String> signalTags;
  final int signalPriority;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'signalId': signalId,
      'signalCategory': signalCategory,
      'signalWeight': signalWeight,
      'signalTags': signalTags,
      'signalPriority': signalPriority,
    };
  }

  factory SignalFingerprint.fromMap(Map<String, dynamic> map) {
    return SignalFingerprint(
      signalId: (map['signalId'] ?? '').toString(),
      signalCategory: (map['signalCategory'] ?? '').toString(),
      signalWeight: _doubleValue(map['signalWeight']),
      signalTags: _stringList(map['signalTags']),
      signalPriority: _intValue(map['signalPriority']),
    );
  }

  static double _doubleValue(Object? value) {
    if (value is num) return value.toDouble();
    return double.tryParse((value ?? '').toString()) ?? 0;
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
