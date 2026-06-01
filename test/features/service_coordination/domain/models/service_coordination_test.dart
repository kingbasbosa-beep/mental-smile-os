import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/features/service_coordination/domain/models/service_coordination.dart';
import '../../fixtures/service_coordination_fixtures.dart';

void main() {
  group('ServiceCoordination', () {
    ServiceCoordination createCoordination({
      String status = ServiceCoordination.statusInitiated,
      String? legacyBookingRequestId = 'legacy-1',
    }) {
      return ServiceCoordinationFixtures.expectedInitiatedCoordination.copyWith(
        coordinationId: 'coordination-1',
        coordinationStatus: status,
        legacyBookingRequestId: legacyBookingRequestId,
      );
    }

    test('constructor stores all fields', () {
      final coordination =
          ServiceCoordinationFixtures.expectedInitiatedCoordination;

      expect(coordination.coordinationId, 'coordination-initiated');
      expect(coordination.requestId, 'request-1');
      expect(coordination.clientId, 'client-1');
      expect(coordination.providerId, 'provider-1');
      expect(coordination.providerType, 'clinician');
      expect(coordination.serviceCategory, 'therapy');
      expect(coordination.coordinationStatus, ServiceCoordination.statusInitiated);
      expect(coordination.coordinationNotes, 'Initial coordination note.');
      expect(coordination.preferredTimeWindow, 'evening');
      expect(coordination.lastActorRole, 'client');
      expect(coordination.lastActivityAt, ServiceCoordinationFixtures.lastActivityAt);
      expect(coordination.followUpNeededAt, isNull);
      expect(coordination.createdAt, ServiceCoordinationFixtures.createdAt);
      expect(coordination.updatedAt, ServiceCoordinationFixtures.updatedAt);
      expect(coordination.legacyBookingRequestId, isNull);
    });

    test('empty returns safe defaults', () {
      final coordination = ServiceCoordination.empty(
        coordinationId: 'empty-coordination',
        requestId: 'request-1',
        clientId: 'client-1',
        providerId: 'provider-1',
        providerType: 'center',
        serviceCategory: 'consultation',
        createdAt: ServiceCoordinationFixtures.createdAt,
      );

      expect(coordination.coordinationId, 'empty-coordination');
      expect(coordination.requestId, 'request-1');
      expect(coordination.clientId, 'client-1');
      expect(coordination.providerId, 'provider-1');
      expect(coordination.providerType, 'center');
      expect(coordination.serviceCategory, 'consultation');
      expect(coordination.coordinationStatus, ServiceCoordination.statusInitiated);
      expect(coordination.coordinationNotes, isNull);
      expect(coordination.preferredTimeWindow, isNull);
      expect(coordination.lastActorRole, isNull);
      expect(coordination.lastActivityAt, isNull);
      expect(coordination.followUpNeededAt, isNull);
      expect(coordination.createdAt, ServiceCoordinationFixtures.createdAt);
      expect(coordination.updatedAt, isNull);
      expect(coordination.legacyBookingRequestId, isNull);
    });

    test('copyWith updates selected fields only', () {
      final original = createCoordination();
      final updated = original.copyWith(
        coordinationStatus: ServiceCoordination.statusActive,
        coordinationNotes: 'Updated note.',
        clearPreferredTimeWindow: true,
      );

      expect(updated.coordinationId, original.coordinationId);
      expect(updated.requestId, original.requestId);
      expect(updated.coordinationStatus, ServiceCoordination.statusActive);
      expect(updated.coordinationNotes, 'Updated note.');
      expect(updated.preferredTimeWindow, isNull);
      expect(updated.createdAt, original.createdAt);
    });

    test('toMap exports expected plain map', () {
      final coordination =
          ServiceCoordinationFixtures.expectedInitiatedCoordination;

      expect(
        coordination.toMap(),
        ServiceCoordinationFixtures.rawInitiatedCoordination,
      );
    });

    test('fromMap parses valid map', () {
      final coordination = ServiceCoordination.fromMap(
        ServiceCoordinationFixtures.rawWithLegacyReference,
      );

      expect(coordination.coordinationId, 'coordination-legacy');
      expect(coordination.requestId, 'request-1');
      expect(coordination.lastActivityAt, ServiceCoordinationFixtures.lastActivityAt);
      expect(coordination.createdAt, ServiceCoordinationFixtures.createdAt);
      expect(coordination.updatedAt, ServiceCoordinationFixtures.updatedAt);
      expect(coordination.hasLegacyReference, isTrue);
    });

    test('fromMap handles missing optional fields', () {
      final coordination = ServiceCoordination.fromMap(
        ServiceCoordinationFixtures.rawWithMissingOptionalFields,
      );

      expect(coordination.coordinationId, 'coordination-minimal');
      expect(coordination.coordinationNotes, isNull);
      expect(coordination.preferredTimeWindow, isNull);
      expect(coordination.lastActorRole, isNull);
      expect(coordination.lastActivityAt, isNull);
      expect(coordination.followUpNeededAt, isNull);
      expect(coordination.updatedAt, isNull);
      expect(coordination.legacyBookingRequestId, isNull);
    });

    test('isActive is true for active coordination statuses', () {
      const activeStatuses = <String>[
        ServiceCoordination.statusInitiated,
        ServiceCoordination.statusActive,
        ServiceCoordination.statusAwaitingResponse,
        ServiceCoordination.statusFollowUpNeeded,
      ];

      for (final status in activeStatuses) {
        expect(createCoordination(status: status).isActive, isTrue);
      }
    });

    test('isClosed is true for closed coordination statuses', () {
      const closedStatuses = <String>[
        ServiceCoordination.statusCompleted,
        ServiceCoordination.statusCancelled,
      ];

      for (final status in closedStatuses) {
        expect(createCoordination(status: status).isClosed, isTrue);
      }
    });

    test('needsFollowUp is true for follow_up_needed', () {
      expect(
        createCoordination(status: ServiceCoordination.statusFollowUpNeeded)
            .needsFollowUp,
        isTrue,
      );
    });

    test('hasLegacyReference is true only when non-empty', () {
      expect(createCoordination(legacyBookingRequestId: 'legacy-1').hasLegacyReference,
          isTrue);
      expect(createCoordination(legacyBookingRequestId: '').hasLegacyReference,
          isFalse);
      expect(createCoordination(legacyBookingRequestId: null).hasLegacyReference,
          isFalse);
    });

    test('forbidden concepts are not present in map', () {
      final map = createCoordination().toMap();
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
        expect(map.containsKey(key), isFalse);
      }
    });
  });
}
