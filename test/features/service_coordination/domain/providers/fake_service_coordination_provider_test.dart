import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/features/service_coordination/domain/contracts/service_coordination_contract.dart';
import '../../../../../lib/features/service_coordination/domain/models/service_coordination.dart';
import '../../../../../lib/features/service_coordination/domain/providers/fake_service_coordination_provider.dart';
import '../../fixtures/service_coordination_fixtures.dart';

void main() {
  group('FakeServiceCoordinationProvider', () {
    test('implements ServiceCoordinationContract', () {
      final contract = FakeServiceCoordinationProvider();

      expect(contract, isA<ServiceCoordinationContract>());
    });

    test('getCoordinationsForClient filters correctly', () {
      final first = ServiceCoordinationFixtures.expectedInitiatedCoordination;
      final second = ServiceCoordinationFixtures.expectedCompletedCoordination;
      final other = first.copyWith(
        coordinationId: 'other-client-coordination',
        clientId: 'other-client',
      );
      final provider = FakeServiceCoordinationProvider(
        coordinations: <ServiceCoordination>[first, second, other],
      );

      final coordinations = provider.getCoordinationsForClient('client-1');

      expect(coordinations, hasLength(2));
      expect(coordinations.map((item) => item.coordinationId), <String>[
        first.coordinationId,
        second.coordinationId,
      ]);
    });

    test('getCoordinationsForProvider filters correctly', () {
      final first = ServiceCoordinationFixtures.expectedInitiatedCoordination;
      final second = ServiceCoordinationFixtures.expectedCompletedCoordination;
      final other = first.copyWith(
        coordinationId: 'other-provider-coordination',
        providerId: 'other-provider',
      );
      final provider = FakeServiceCoordinationProvider(
        coordinations: <ServiceCoordination>[first, second, other],
      );

      final coordinations = provider.getCoordinationsForProvider('provider-1');

      expect(coordinations, hasLength(2));
      expect(coordinations.map((item) => item.coordinationId), <String>[
        first.coordinationId,
        second.coordinationId,
      ]);
    });

    test('getCoordinationsForRequest filters correctly', () {
      final first = ServiceCoordinationFixtures.expectedInitiatedCoordination;
      final second = first.copyWith(
        coordinationId: 'same-request-coordination',
        coordinationStatus: ServiceCoordination.statusActive,
      );
      final other = first.copyWith(
        coordinationId: 'other-request-coordination',
        requestId: 'other-request',
      );
      final provider = FakeServiceCoordinationProvider(
        coordinations: <ServiceCoordination>[first, second, other],
      );

      final coordinations = provider.getCoordinationsForRequest('request-1');

      expect(coordinations, hasLength(2));
      expect(coordinations.map((item) => item.coordinationId), <String>[
        first.coordinationId,
        second.coordinationId,
      ]);
    });

    test('getCoordinationById returns existing item', () {
      final expected = ServiceCoordinationFixtures.expectedInitiatedCoordination;
      final provider = FakeServiceCoordinationProvider(
        coordinations: <ServiceCoordination>[expected],
      );

      final coordination = provider.getCoordinationById(expected.coordinationId);

      expect(coordination.coordinationId, expected.coordinationId);
      expect(coordination.requestId, expected.requestId);
      expect(coordination.clientId, expected.clientId);
      expect(coordination.providerId, expected.providerId);
    });

    test('missing id returns empty coordination', () {
      final provider = FakeServiceCoordinationProvider(
        coordinations: const <ServiceCoordination>[],
      );

      final coordination = provider.getCoordinationById('missing-coordination');

      expect(coordination.coordinationId, 'missing-coordination');
      expect(coordination.requestId, '');
      expect(coordination.clientId, '');
      expect(coordination.providerId, '');
      expect(coordination.coordinationStatus, ServiceCoordination.statusInitiated);
    });

    test('custom store works', () {
      final custom = ServiceCoordinationFixtures.expectedCompletedCoordination
          .copyWith(coordinationId: 'custom-coordination');
      final provider = FakeServiceCoordinationProvider(
        coordinations: <ServiceCoordination>[custom],
      );

      final coordinations = provider.getCoordinationsForClient(custom.clientId);
      final coordination =
          provider.getCoordinationById('custom-coordination');

      expect(coordinations, hasLength(1));
      expect(coordination.coordinationId, 'custom-coordination');
      expect(coordination.isClosed, isTrue);
    });

    test('default sample data works without crash', () {
      final provider = FakeServiceCoordinationProvider();

      final clientItems = provider.getCoordinationsForClient('sample-client');
      final clinicianItems =
          provider.getCoordinationsForProvider('sample-clinician');
      final centerItems = provider.getCoordinationsForProvider('sample-center');
      final requestItems =
          provider.getCoordinationsForRequest('sample-request-1');
      final item = provider.getCoordinationById('sample-coordination-1');

      expect(clientItems, isNotEmpty);
      expect(clinicianItems, hasLength(1));
      expect(centerItems, hasLength(1));
      expect(requestItems, hasLength(1));
      expect(item.coordinationId, 'sample-coordination-1');
    });
  });
}
