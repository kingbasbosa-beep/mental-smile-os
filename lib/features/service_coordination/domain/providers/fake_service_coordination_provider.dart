import '../contracts/service_coordination_contract.dart';
import '../models/service_coordination.dart';

/// Fake in-memory implementation for Service Coordination foundation testing
/// and design validation only.
class FakeServiceCoordinationProvider implements ServiceCoordinationContract {
  FakeServiceCoordinationProvider({
    List<ServiceCoordination>? coordinations,
  }) : _coordinations = coordinations ?? _sampleCoordinations;

  final List<ServiceCoordination> _coordinations;

  static final List<ServiceCoordination> _sampleCoordinations =
      <ServiceCoordination>[
    ServiceCoordination(
      coordinationId: 'sample-coordination-1',
      requestId: 'sample-request-1',
      clientId: 'sample-client',
      providerId: 'sample-clinician',
      providerType: 'clinician',
      serviceCategory: 'therapy',
      coordinationStatus: ServiceCoordination.statusActive,
      coordinationNotes: 'Sample coordination is active.',
      preferredTimeWindow: 'evening',
      lastActorRole: 'provider',
      lastActivityAt: DateTime.utc(2026, 1, 1, 10),
      followUpNeededAt: null,
      createdAt: DateTime.utc(2026, 1, 1, 9),
      updatedAt: DateTime.utc(2026, 1, 1, 10),
      legacyBookingRequestId: null,
    ),
    ServiceCoordination(
      coordinationId: 'sample-coordination-2',
      requestId: 'sample-request-2',
      clientId: 'sample-client',
      providerId: 'sample-center',
      providerType: 'center',
      serviceCategory: 'consultation',
      coordinationStatus: ServiceCoordination.statusAwaitingResponse,
      coordinationNotes: null,
      preferredTimeWindow: null,
      lastActorRole: 'client',
      lastActivityAt: DateTime.utc(2026, 1, 2, 10),
      followUpNeededAt: null,
      createdAt: DateTime.utc(2026, 1, 2, 9),
      updatedAt: DateTime.utc(2026, 1, 2, 10),
      legacyBookingRequestId: null,
    ),
  ];

  @override
  List<ServiceCoordination> getCoordinationsForClient(String clientId) {
    return _coordinations
        .where((coordination) => coordination.clientId == clientId)
        .toList(growable: false);
  }

  @override
  List<ServiceCoordination> getCoordinationsForProvider(String providerId) {
    return _coordinations
        .where((coordination) => coordination.providerId == providerId)
        .toList(growable: false);
  }

  @override
  ServiceCoordination getCoordinationById(String coordinationId) {
    for (final coordination in _coordinations) {
      if (coordination.coordinationId == coordinationId) {
        return coordination;
      }
    }
    return ServiceCoordination.empty(coordinationId: coordinationId);
  }

  @override
  List<ServiceCoordination> getCoordinationsForRequest(String requestId) {
    return _coordinations
        .where((coordination) => coordination.requestId == requestId)
        .toList(growable: false);
  }
}
