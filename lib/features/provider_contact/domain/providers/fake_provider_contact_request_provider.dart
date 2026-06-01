import '../contracts/provider_contact_request_contract.dart';
import '../models/provider_contact_request.dart';

/// Fake in-memory implementation for Provider Contact foundation testing and
/// design validation only.
class FakeProviderContactRequestProvider
    implements ProviderContactRequestContract {
  FakeProviderContactRequestProvider({
    Map<String, ProviderContactRequest>? requests,
  }) : _requests = requests ?? _sampleRequests;

  final Map<String, ProviderContactRequest> _requests;

  static final Map<String, ProviderContactRequest> _sampleRequests =
      <String, ProviderContactRequest>{
    'sample-contact-1': ProviderContactRequest(
      requestId: 'sample-contact-1',
      clientId: 'sample-client',
      providerId: 'sample-clinician',
      providerType: 'clinician',
      serviceCategory: 'therapy',
      serviceId: 'sample-service',
      requestMessage: 'Please contact me about this service.',
      preferredContactMethod: 'phone',
      preferredContactWindow: 'evening',
      status: ProviderContactRequest.statusSubmitted,
      lastActorRole: 'client',
      lastActivityAt: DateTime.utc(2026, 1, 1, 10),
      createdAt: DateTime.utc(2026, 1, 1, 10),
      updatedAt: null,
      legacyBookingRequestId: null,
    ),
    'sample-contact-2': ProviderContactRequest(
      requestId: 'sample-contact-2',
      clientId: 'sample-client',
      providerId: 'sample-center',
      providerType: 'center',
      serviceCategory: 'consultation',
      serviceId: null,
      requestMessage: 'I would like to ask about this service.',
      preferredContactMethod: 'email',
      preferredContactWindow: null,
      status: ProviderContactRequest.statusViewed,
      lastActorRole: 'provider',
      lastActivityAt: DateTime.utc(2026, 1, 2, 10),
      createdAt: DateTime.utc(2026, 1, 2, 9),
      updatedAt: DateTime.utc(2026, 1, 2, 10),
      legacyBookingRequestId: null,
    ),
  };

  @override
  List<ProviderContactRequest> getRequestsForClient(String clientId) {
    return _requests.values
        .where((request) => request.clientId == clientId)
        .toList(growable: false);
  }

  @override
  List<ProviderContactRequest> getRequestsForProvider(String providerId) {
    return _requests.values
        .where((request) => request.providerId == providerId)
        .toList(growable: false);
  }

  @override
  ProviderContactRequest getRequestById(String requestId) {
    return _requests[requestId] ??
        ProviderContactRequest.empty(requestId: requestId);
  }
}
