import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/features/provider_contact/domain/mappers/provider_contact_request_mapper.dart';
import '../../../../../lib/features/provider_contact/domain/models/provider_contact_request.dart';
import '../../fixtures/provider_contact_request_fixtures.dart';

void main() {
  group('ProviderContactRequestMapper', () {
    test('fromRaw returns ProviderContactRequest from valid raw map', () {
      final request = ProviderContactRequestMapper.fromRaw(
        ProviderContactRequestFixtures.rawViewedRequest,
      );

      expect(request, isA<ProviderContactRequest>());
      expect(request.requestId, 'request-viewed');
      expect(request.clientId, 'client-1');
      expect(request.providerId, 'provider-1');
      expect(request.status, ProviderContactRequest.statusViewed);
      expect(request.lastActivityAt,
          ProviderContactRequestFixtures.lastActivityAt);
      expect(request.createdAt, ProviderContactRequestFixtures.createdAt);
      expect(request.updatedAt, ProviderContactRequestFixtures.updatedAt);
    });

    test('toRaw returns expected plain Dart map', () {
      final request = ProviderContactRequestMapper.fromRaw(
        ProviderContactRequestFixtures.rawViewedRequest,
      );

      expect(
        ProviderContactRequestMapper.toRaw(request),
        ProviderContactRequestFixtures.rawViewedRequest,
      );
    });

    test('roundtrip raw map to model and back returns expected map', () {
      final raw = ProviderContactRequestFixtures.rawViewedRequest;
      final request = ProviderContactRequestMapper.fromRaw(raw);
      final mapped = ProviderContactRequestMapper.toRaw(request);

      expect(mapped, raw);
    });

    test('missing optional fields are handled safely', () {
      final request = ProviderContactRequestMapper.fromRaw(<String, dynamic>{
        'requestId': 'request-1',
        'clientId': 'client-1',
        'providerId': 'provider-1',
        'providerType': 'clinician',
        'serviceCategory': 'therapy',
        'requestMessage': 'Please contact me.',
        'preferredContactMethod': 'phone',
        'createdAt': ProviderContactRequestFixtures.createdAt.toIso8601String(),
      });

      expect(request.serviceId, isNull);
      expect(request.preferredContactWindow, isNull);
      expect(request.status, ProviderContactRequest.statusSubmitted);
      expect(request.lastActorRole, isNull);
      expect(request.lastActivityAt, isNull);
      expect(request.updatedAt, isNull);
      expect(request.legacyBookingRequestId, isNull);
    });

    test('invalid optional values do not crash', () {
      final request = ProviderContactRequestMapper.fromRaw(<String, dynamic>{
        'requestId': 'request-1',
        'lastActivityAt': 'not-a-date',
        'updatedAt': 'not-a-date',
        'createdAt': 'not-a-date',
      });

      expect(request.requestId, 'request-1');
      expect(request.lastActivityAt, isNull);
      expect(request.updatedAt, isNull);
      expect(request.createdAt, DateTime.fromMillisecondsSinceEpoch(0));
    });

    test('forbidden concepts are not introduced', () {
      final mapped = ProviderContactRequestMapper.toRaw(
        ProviderContactRequestMapper.fromRaw(
          ProviderContactRequestFixtures.rawViewedRequest,
        ),
      );
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
        expect(mapped.containsKey(key), isFalse);
      }
    });

    test('mapper does not depend on Firestore-like fields', () {
      final request = ProviderContactRequestMapper.fromRaw(<String, dynamic>{
        ...ProviderContactRequestFixtures.rawViewedRequest,
        'documentSnapshot': 'ignored',
        'timestamp': 'ignored',
        'collectionPath': 'ignored',
      });
      final mapped = ProviderContactRequestMapper.toRaw(request);

      expect(mapped.containsKey('documentSnapshot'), isFalse);
      expect(mapped.containsKey('timestamp'), isFalse);
      expect(mapped.containsKey('collectionPath'), isFalse);
      expect(mapped['requestId'], 'request-viewed');
    });
  });
}
