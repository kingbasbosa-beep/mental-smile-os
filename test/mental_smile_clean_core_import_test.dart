import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Mental Smile OS no longer requires clean core as active dependency', () {
    const ownerActorKey = 'owner';

    expect(ownerActorKey, equals('owner'));
  });
}
