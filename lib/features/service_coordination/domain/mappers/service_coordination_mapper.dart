import '../models/service_coordination.dart';

/// Maps plain raw maps to ServiceCoordination and back.
///
/// This mapper does not know about Firestore documents, collections, routes, or
/// runtime data sources.
class ServiceCoordinationMapper {
  const ServiceCoordinationMapper._();

  static ServiceCoordination fromRaw(Map<String, dynamic> raw) {
    return ServiceCoordination.fromMap(raw);
  }

  static Map<String, dynamic> toRaw(ServiceCoordination coordination) {
    return coordination.toMap();
  }
}
