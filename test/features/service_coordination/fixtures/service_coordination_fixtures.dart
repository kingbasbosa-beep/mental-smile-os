import '../../../../lib/features/service_coordination/domain/models/service_coordination.dart';

/// Test-only fixtures for Service Coordination foundation.
///
/// These fixtures use plain Dart maps only. They do not represent Firestore
/// documents, collections, booking confirmation, or runtime behavior.
class ServiceCoordinationFixtures {
  const ServiceCoordinationFixtures._();

  static final DateTime createdAt = DateTime.utc(2026, 1, 1, 10);
  static final DateTime updatedAt = DateTime.utc(2026, 1, 2, 10);
  static final DateTime lastActivityAt = DateTime.utc(2026, 1, 3, 10);
  static final DateTime followUpNeededAt = DateTime.utc(2026, 1, 4, 10);

  static Map<String, dynamic> get rawInitiatedCoordination {
    return <String, dynamic>{
      'coordinationId': 'coordination-initiated',
      'requestId': 'request-1',
      'clientId': 'client-1',
      'providerId': 'provider-1',
      'providerType': 'clinician',
      'serviceCategory': 'therapy',
      'coordinationStatus': ServiceCoordination.statusInitiated,
      'coordinationNotes': 'Initial coordination note.',
      'preferredTimeWindow': 'evening',
      'lastActorRole': 'client',
      'lastActivityAt': lastActivityAt.toIso8601String(),
      'followUpNeededAt': null,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'legacyBookingRequestId': null,
    };
  }

  static Map<String, dynamic> get rawActiveCoordination {
    return <String, dynamic>{
      ...rawInitiatedCoordination,
      'coordinationId': 'coordination-active',
      'coordinationStatus': ServiceCoordination.statusActive,
      'lastActorRole': 'provider',
    };
  }

  static Map<String, dynamic> get rawAwaitingResponseCoordination {
    return <String, dynamic>{
      ...rawInitiatedCoordination,
      'coordinationId': 'coordination-awaiting',
      'coordinationStatus': ServiceCoordination.statusAwaitingResponse,
      'lastActorRole': 'provider',
    };
  }

  static Map<String, dynamic> get rawFollowUpNeededCoordination {
    return <String, dynamic>{
      ...rawInitiatedCoordination,
      'coordinationId': 'coordination-follow-up',
      'coordinationStatus': ServiceCoordination.statusFollowUpNeeded,
      'followUpNeededAt': followUpNeededAt.toIso8601String(),
    };
  }

  static Map<String, dynamic> get rawCompletedCoordination {
    return <String, dynamic>{
      ...rawInitiatedCoordination,
      'coordinationId': 'coordination-completed',
      'coordinationStatus': ServiceCoordination.statusCompleted,
      'lastActorRole': 'provider',
    };
  }

  static Map<String, dynamic> get rawCancelledCoordination {
    return <String, dynamic>{
      ...rawInitiatedCoordination,
      'coordinationId': 'coordination-cancelled',
      'coordinationStatus': ServiceCoordination.statusCancelled,
      'lastActorRole': 'client',
    };
  }

  static Map<String, dynamic> get rawWithLegacyReference {
    return <String, dynamic>{
      ...rawInitiatedCoordination,
      'coordinationId': 'coordination-legacy',
      'legacyBookingRequestId': 'legacy-request-1',
    };
  }

  static Map<String, dynamic> get rawWithMissingOptionalFields {
    return <String, dynamic>{
      'coordinationId': 'coordination-minimal',
      'requestId': 'request-1',
      'clientId': 'client-1',
      'providerId': 'provider-1',
      'providerType': 'clinician',
      'serviceCategory': 'therapy',
      'coordinationStatus': ServiceCoordination.statusInitiated,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static ServiceCoordination get expectedInitiatedCoordination {
    return ServiceCoordination(
      coordinationId: 'coordination-initiated',
      requestId: 'request-1',
      clientId: 'client-1',
      providerId: 'provider-1',
      providerType: 'clinician',
      serviceCategory: 'therapy',
      coordinationStatus: ServiceCoordination.statusInitiated,
      coordinationNotes: 'Initial coordination note.',
      preferredTimeWindow: 'evening',
      lastActorRole: 'client',
      lastActivityAt: lastActivityAt,
      followUpNeededAt: null,
      createdAt: createdAt,
      updatedAt: updatedAt,
      legacyBookingRequestId: null,
    );
  }

  static ServiceCoordination get expectedCompletedCoordination {
    return expectedInitiatedCoordination.copyWith(
      coordinationId: 'coordination-completed',
      coordinationStatus: ServiceCoordination.statusCompleted,
      lastActorRole: 'provider',
    );
  }

  static ServiceCoordination get expectedFollowUpNeededCoordination {
    return expectedInitiatedCoordination.copyWith(
      coordinationId: 'coordination-follow-up',
      coordinationStatus: ServiceCoordination.statusFollowUpNeeded,
      followUpNeededAt: followUpNeededAt,
    );
  }
}
