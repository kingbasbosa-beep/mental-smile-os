import '../../../../lib/features/provider_contact/domain/models/provider_contact_request.dart';

/// Test-only fixtures for Provider Contact foundation.
///
/// These fixtures use plain Dart maps only. They do not represent Firestore
/// documents, collections, booking ownership, or runtime behavior.
class ProviderContactRequestFixtures {
  const ProviderContactRequestFixtures._();

  static final DateTime createdAt = DateTime.utc(2026, 1, 1, 10);
  static final DateTime updatedAt = DateTime.utc(2026, 1, 2, 10);
  static final DateTime lastActivityAt = DateTime.utc(2026, 1, 3, 10);

  static Map<String, dynamic> get rawSubmittedRequest {
    return <String, dynamic>{
      'requestId': 'request-submitted',
      'clientId': 'client-1',
      'providerId': 'provider-1',
      'providerType': 'clinician',
      'serviceCategory': 'therapy',
      'serviceId': 'service-1',
      'requestMessage': 'Please contact me about this service.',
      'preferredContactMethod': 'phone',
      'preferredContactWindow': 'evening',
      'status': ProviderContactRequest.statusSubmitted,
      'lastActorRole': 'client',
      'lastActivityAt': lastActivityAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'legacyBookingRequestId': null,
    };
  }

  static Map<String, dynamic> get rawViewedRequest {
    return <String, dynamic>{
      ...rawSubmittedRequest,
      'requestId': 'request-viewed',
      'status': ProviderContactRequest.statusViewed,
      'lastActorRole': 'provider',
    };
  }

  static Map<String, dynamic> get rawCompletedRequest {
    return <String, dynamic>{
      ...rawSubmittedRequest,
      'requestId': 'request-completed',
      'status': ProviderContactRequest.statusCompleted,
      'lastActorRole': 'provider',
    };
  }

  static Map<String, dynamic> get rawCancelledRequest {
    return <String, dynamic>{
      ...rawSubmittedRequest,
      'requestId': 'request-cancelled',
      'status': ProviderContactRequest.statusCancelled,
      'lastActorRole': 'client',
    };
  }

  static Map<String, dynamic> get rawWithLegacyReference {
    return <String, dynamic>{
      ...rawSubmittedRequest,
      'requestId': 'request-legacy',
      'legacyBookingRequestId': 'legacy-request-1',
    };
  }

  static Map<String, dynamic> get rawWithMissingOptionalFields {
    return <String, dynamic>{
      'requestId': 'request-minimal',
      'clientId': 'client-1',
      'providerId': 'provider-1',
      'providerType': 'clinician',
      'serviceCategory': 'therapy',
      'requestMessage': 'Please contact me.',
      'preferredContactMethod': 'phone',
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static ProviderContactRequest get expectedSubmittedRequest {
    return ProviderContactRequest(
      requestId: 'request-submitted',
      clientId: 'client-1',
      providerId: 'provider-1',
      providerType: 'clinician',
      serviceCategory: 'therapy',
      serviceId: 'service-1',
      requestMessage: 'Please contact me about this service.',
      preferredContactMethod: 'phone',
      preferredContactWindow: 'evening',
      status: ProviderContactRequest.statusSubmitted,
      lastActorRole: 'client',
      lastActivityAt: lastActivityAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      legacyBookingRequestId: null,
    );
  }

  static ProviderContactRequest get expectedCompletedRequest {
    return ProviderContactRequest(
      requestId: 'request-completed',
      clientId: 'client-1',
      providerId: 'provider-1',
      providerType: 'clinician',
      serviceCategory: 'therapy',
      serviceId: 'service-1',
      requestMessage: 'Please contact me about this service.',
      preferredContactMethod: 'phone',
      preferredContactWindow: 'evening',
      status: ProviderContactRequest.statusCompleted,
      lastActorRole: 'provider',
      lastActivityAt: lastActivityAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      legacyBookingRequestId: null,
    );
  }
}
