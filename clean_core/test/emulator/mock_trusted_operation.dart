import '../../../mental_smile_clean_core/lib/mental_smile_clean_core.dart';

class MockTrustedOperation {
  const MockTrustedOperation({
    required this.operationType,
    required this.uid,
    required this.payload,
  });

  final TrustedOperationType operationType;
  final String uid;
  final Map<String, Object?> payload;

  Map<String, Object?> toMap() {
    return {
      'operationType': operationType.key,
      'uid': uid,
      'payload': payload,
    };
  }
}
