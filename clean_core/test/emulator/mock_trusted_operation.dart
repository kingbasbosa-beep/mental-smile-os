import 'package:flutterprojects/core/backend_boundaries/trusted_operation_type.dart';

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
