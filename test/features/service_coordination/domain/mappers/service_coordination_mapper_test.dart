import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/features/service_coordination/domain/mappers/service_coordination_mapper.dart';
import '../../../../../lib/features/service_coordination/domain/models/service_coordination.dart';
import '../../fixtures/service_coordination_fixtures.dart';

void main() {
  group('ServiceCoordinationMapper', () {
    test('fromRaw returns ServiceCoordination', () {
      final coordination = ServiceCoordinationMapper.fromRaw(
        ServiceCoordinationFixtures.rawActiveCoordination,
      );

      expect(coordination, isA<ServiceCoordination>());
      expect(coordination.coordinationId, 'coordination-active');
      expect(coordination.coordinationStatus, ServiceCoordination.statusActive);
      expect(coordination.lastActivityAt, ServiceCoordinationFixtures.lastActivityAt);
    });

    test('toRaw returns expected plain map', () {
      final coordination = ServiceCoordinationMapper.fromRaw(
        ServiceCoordinationFixtures.rawActiveCoordination,
      );

      expect(
        ServiceCoordinationMapper.toRaw(coordination),
        ServiceCoordinationFixtures.rawActiveCoordination,
      );
    });

    test('raw to model to raw roundtrip', () {
      final raw = ServiceCoordinationFixtures.rawFollowUpNeededCoordination;
      final coordination = ServiceCoordinationMapper.fromRaw(raw);
      final mapped = ServiceCoordinationMapper.toRaw(coordination);

      expect(mapped, raw);
    });

    test('missing optional fields handled safely', () {
      final coordination = ServiceCoordinationMapper.fromRaw(
        ServiceCoordinationFixtures.rawWithMissingOptionalFields,
      );

      expect(coordination.coordinationNotes, isNull);
      expect(coordination.preferredTimeWindow, isNull);
      expect(coordination.lastActorRole, isNull);
      expect(coordination.followUpNeededAt, isNull);
      expect(coordination.updatedAt, isNull);
    });

    test('invalid optional values do not crash', () {
      final coordination = ServiceCoordinationMapper.fromRaw(<String, dynamic>{
        'coordinationId': 'coordination-invalid',
        'createdAt': 'not-a-date',
        'lastActivityAt': 'not-a-date',
        'followUpNeededAt': 'not-a-date',
        'updatedAt': 'not-a-date',
      });

      expect(coordination.coordinationId, 'coordination-invalid');
      expect(coordination.createdAt, DateTime.fromMillisecondsSinceEpoch(0));
      expect(coordination.lastActivityAt, isNull);
      expect(coordination.followUpNeededAt, isNull);
      expect(coordination.updatedAt, isNull);
    });

    test('forbidden concepts not introduced', () {
      final mapped = ServiceCoordinationMapper.toRaw(
        ServiceCoordinationMapper.fromRaw(
          ServiceCoordinationFixtures.rawActiveCoordination,
        ),
      );
      const forbiddenKeys = <String>[
        'payment',
        'payout',
        'commission',
        'accounting',
        'review',
        'rating',
        'complaint',
        'diagnosis',
        'treatment',
        'confirmedBooking',
        'sessionLifecycle',
      ];

      for (final key in forbiddenKeys) {
        expect(mapped.containsKey(key), isFalse);
      }
    });

    test('no Firestore-like fields dependency', () {
      final coordination = ServiceCoordinationMapper.fromRaw(<String, dynamic>{
        ...ServiceCoordinationFixtures.rawActiveCoordination,
        'documentSnapshot': 'ignored',
        'timestamp': 'ignored',
        'collectionPath': 'ignored',
      });
      final mapped = ServiceCoordinationMapper.toRaw(coordination);

      expect(mapped.containsKey('documentSnapshot'), isFalse);
      expect(mapped.containsKey('timestamp'), isFalse);
      expect(mapped.containsKey('collectionPath'), isFalse);
      expect(mapped['coordinationId'], 'coordination-active');
    });
  });
}
