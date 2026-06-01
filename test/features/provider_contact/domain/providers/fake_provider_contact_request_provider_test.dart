import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/features/provider_contact/domain/contracts/provider_contact_request_contract.dart';
import '../../../../../lib/features/provider_contact/domain/models/provider_contact_request.dart';
import '../../../../../lib/features/provider_contact/domain/providers/fake_provider_contact_request_provider.dart';
import '../../fixtures/provider_contact_request_fixtures.dart';

void main() {
  group('FakeProviderContactRequestProvider', () {
    test('implements ProviderContactRequestContract', () {
      final contract = FakeProviderContactRequestProvider();

      expect(contract, isA<ProviderContactRequestContract>());
    });

    test('getRequestsForClient returns matching requests', () {
      final first = ProviderContactRequestFixtures.expectedSubmittedRequest;
      final second = ProviderContactRequestFixtures.expectedCompletedRequest;
      final other = first.copyWith(
        requestId: 'other-client-request',
        clientId: 'other-client',
      );
      final provider = FakeProviderContactRequestProvider(
        requests: <String, ProviderContactRequest>{
          first.requestId: first,
          second.requestId: second,
          other.requestId: other,
        },
      );

      final requests = provider.getRequestsForClient('client-1');

      expect(requests, hasLength(2));
      expect(requests.map((request) => request.requestId), <String>[
        first.requestId,
        second.requestId,
      ]);
    });

    test('getRequestsForProvider returns matching requests', () {
      final first = ProviderContactRequestFixtures.expectedSubmittedRequest;
      final second = ProviderContactRequestFixtures.expectedCompletedRequest;
      final other = first.copyWith(
        requestId: 'other-provider-request',
        providerId: 'other-provider',
      );
      final provider = FakeProviderContactRequestProvider(
        requests: <String, ProviderContactRequest>{
          first.requestId: first,
          second.requestId: second,
          other.requestId: other,
        },
      );

      final requests = provider.getRequestsForProvider('provider-1');

      expect(requests, hasLength(2));
      expect(requests.map((request) => request.requestId), <String>[
        first.requestId,
        second.requestId,
      ]);
    });

    test('getRequestById returns an existing request', () {
      final expected = ProviderContactRequestFixtures.expectedSubmittedRequest;
      final provider = FakeProviderContactRequestProvider(
        requests: <String, ProviderContactRequest>{
          expected.requestId: expected,
        },
      );

      final request = provider.getRequestById(expected.requestId);

      expect(request.requestId, expected.requestId);
      expect(request.clientId, expected.clientId);
      expect(request.providerId, expected.providerId);
      expect(request.status, expected.status);
    });

    test('getRequestById returns empty request for missing id', () {
      final provider = FakeProviderContactRequestProvider(
        requests: const <String, ProviderContactRequest>{},
      );

      final request = provider.getRequestById('missing-request');

      expect(request.requestId, 'missing-request');
      expect(request.clientId, '');
      expect(request.providerId, '');
      expect(request.status, ProviderContactRequest.statusSubmitted);
      expect(request.hasLegacyReference, isFalse);
    });

    test('custom store is used by the provider', () {
      final custom = ProviderContactRequestFixtures.expectedCompletedRequest
          .copyWith(requestId: 'custom-request');
      final provider = FakeProviderContactRequestProvider(
        requests: <String, ProviderContactRequest>{
          custom.requestId: custom,
        },
      );

      final requests = provider.getRequestsForClient(custom.clientId);
      final request = provider.getRequestById(custom.requestId);

      expect(requests, hasLength(1));
      expect(request.requestId, 'custom-request');
      expect(request.isClosed, isTrue);
    });

    test('default sample data works without crashing', () {
      final provider = FakeProviderContactRequestProvider();

      final clientRequests = provider.getRequestsForClient('sample-client');
      final clinicianRequests =
          provider.getRequestsForProvider('sample-clinician');
      final centerRequests = provider.getRequestsForProvider('sample-center');
      final request = provider.getRequestById('sample-contact-1');

      expect(clientRequests, isNotEmpty);
      expect(clinicianRequests, hasLength(1));
      expect(centerRequests, hasLength(1));
      expect(request.requestId, 'sample-contact-1');
    });
  });
}
