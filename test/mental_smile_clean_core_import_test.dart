import 'package:flutter_test/flutter_test.dart';
import 'package:mental_smile_clean_core/mental_smile_clean_core.dart';

void main() {
  test('Proof of mental_smile_clean_core integration', () {
    // Proves that the host app can successfully import and reference
    // a pure Dart symbol from the extracted core package.
    const adminKey = AuditActorType.admin;

    expect(adminKey.key, equals('admin'));
  });
}
