import '../models/service_coordination.dart';

/// Future Service Coordination Read Surface Contract.
///
/// No runtime implementation yet.
abstract class ServiceCoordinationContract {
  List<ServiceCoordination> getCoordinationsForClient(String clientId);

  List<ServiceCoordination> getCoordinationsForProvider(String providerId);

  ServiceCoordination getCoordinationById(String coordinationId);

  List<ServiceCoordination> getCoordinationsForRequest(String requestId);
}
