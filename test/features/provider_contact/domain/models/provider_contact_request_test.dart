import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/features/provider_contact/domain/models/provider_contact_request.dart';
import '../../fixtures/provider_contact_request_fixtures.dart';

void main() {
  group('ProviderContactRequest', () {
    ProviderContactRequest createRequest({
      String status = ProviderContactRequest.statusSubmitted,
      String? legacyBookingRequestId = 'legacy-1',
    }) {
      return ProviderContactRequestFixtures.expectedSubmittedRequest.copyWith(
        requestId: 'request-1',
        status: status,
        legacyBookingRequestId: legacyBookingRequestId,
      );
    }

    test('constructor stores all fields correctly', () {
      final request = ProviderContactRequestFixtures.expectedSubmittedRequest;

      expect(request.requestId, 'request-submitted');
      expect(request.clientId, 'client-1');
      expect(request.providerId, 'provider-1');
      expect(request.providerType, 'clinician');
      expect(request.serviceCategory, 'therapy');
      expect(request.serviceId, 'service-1');
      expect(request.requestMessage, 'Please contact me about this service.');
      expect(request.preferredContactMethod, 'phone');
      expect(request.preferredContactWindow, 'evening');
      expect(request.status, ProviderContactRequest.statusSubmitted);
      expect(request.lastActorRole, 'client');
      expect(request.lastActivityAt,
          ProviderContactRequestFixtures.lastActivityAt);
      expect(request.createdAt, ProviderContactRequestFixtures.createdAt);
      expect(request.updatedAt, ProviderContactRequestFixtures.updatedAt);
      expect(request.legacyBookingRequestId, isNull);
    });

    test('empty returns safe default values', () {
      final request = ProviderContactRequest.empty(
        requestId: 'empty-request',
        clientId: 'client-1',
        providerId: 'provider-1',
        providerType: 'center',
        serviceCategory: 'consultation',
        createdAt: ProviderContactRequestFixtures.createdAt,
      );

      expect(request.requestId, 'empty-request');
      expect(request.clientId, 'client-1');
      expect(request.providerId, 'provider-1');
      expect(request.providerType, 'center');
      expect(request.serviceCategory, 'consultation');
      expect(request.serviceId, isNull);
      expect(request.requestMessage, '');
      expect(request.preferredContactMethod, '');
      expect(request.preferredContactWindow, isNull);
      expect(request.status, ProviderContactRequest.statusSubmitted);
      expect(request.lastActorRole, isNull);
      expect(request.lastActivityAt, isNull);
      expect(request.createdAt, ProviderContactRequestFixtures.createdAt);
      expect(request.updatedAt, isNull);
      expect(request.legacyBookingRequestId, isNull);
    });

    test('copyWith updates selected fields only', () {
      final original = createRequest();
      final updated = original.copyWith(
        status: ProviderContactRequest.statusViewed,
        requestMessage: 'Updated message.',
        clearServiceId: true,
      );

      expect(updated.requestId, original.requestId);
      expect(updated.clientId, original.clientId);
      expect(updated.providerId, original.providerId);
      expect(updated.status, ProviderContactRequest.statusViewed);
      expect(updated.requestMessage, 'Updated message.');
      expect(updated.serviceId, isNull);
      expect(updated.preferredContactMethod, original.preferredContactMethod);
      expect(updated.createdAt, original.createdAt);
    });

    test('toMap exports expected plain Dart map', () {
      final request = ProviderContactRequestFixtures.expectedSubmittedRequest;

      expect(
          request.toMap(), ProviderContactRequestFixtures.rawSubmittedRequest);
    });

    test('fromMap parses valid map correctly', () {
      final request = ProviderContactRequest.fromMap(
        ProviderContactRequestFixtures.rawWithLegacyReference,
      );

      expect(request.requestId, 'request-legacy');
      expect(request.status, ProviderContactRequest.statusSubmitted);
      expect(request.lastActorRole, 'client');
      expect(request.lastActivityAt,
          ProviderContactRequestFixtures.lastActivityAt);
      expect(request.createdAt, ProviderContactRequestFixtures.createdAt);
      expect(request.updatedAt, ProviderContactRequestFixtures.updatedAt);
      expect(request.hasLegacyReference, isTrue);
    });

    test('fromMap handles missing and invalid nullable fields defensively', () {
      final request = ProviderContactRequest.fromMap(<String, dynamic>{
        'requestId': 'request-1',
        'createdAt': 'not-a-date',
        'lastActivityAt': 'not-a-date',
        'updatedAt': null,
      });

      expect(request.requestId, 'request-1');
      expect(request.clientId, '');
      expect(request.providerId, '');
      expect(request.serviceId, isNull);
      expect(request.preferredContactWindow, isNull);
      expect(request.status, ProviderContactRequest.statusSubmitted);
      expect(request.lastActorRole, isNull);
      expect(request.lastActivityAt, isNull);
      expect(request.createdAt, DateTime.fromMillisecondsSinceEpoch(0));
      expect(request.updatedAt, isNull);
      expect(request.legacyBookingRequestId, isNull);
    });

    test('isActive is true for active contact statuses', () {
      const activeStatuses = <String>[
        ProviderContactRequest.statusSubmitted,
        ProviderContactRequest.statusViewed,
        ProviderContactRequest.statusProviderContacted,
        ProviderContactRequest.statusCoordinationPending,
      ];

      for (final status in activeStatuses) {
        expect(createRequest(status: status).isActive, isTrue);
      }
    });

    test('isClosed is true for closed contact statuses', () {
      const closedStatuses = <String>[
        ProviderContactRequest.statusCompleted,
        ProviderContactRequest.statusCancelled,
      ];

      for (final status in closedStatuses) {
        expect(createRequest(status: status).isClosed, isTrue);
      }
    });

    test('hasLegacyReference is true only when legacy id is non-empty', () {
      expect(
          createRequest(legacyBookingRequestId: 'legacy-1').hasLegacyReference,
          isTrue);
      expect(createRequest(legacyBookingRequestId: '').hasLegacyReference,
          isFalse);
      expect(createRequest(legacyBookingRequestId: null).hasLegacyReference,
          isFalse);
    });

    test('forbidden concepts are not present in the model map', () {
      final map = createRequest().toMap();
      const forbiddenKeys = <String>[
        'payment',
        'payout',
        'commission',
        'accounting',
        'rating',
        'review',
        'complaint',
        'diagnosis',
        'treatment',
      ];

      for (final key in forbiddenKeys) {
        expect(map.containsKey(key), isFalse);
      }
    });
  });
}
