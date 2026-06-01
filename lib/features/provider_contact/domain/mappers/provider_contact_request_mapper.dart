import '../models/provider_contact_request.dart';

/// Maps plain raw maps to ProviderContactRequest and back.
///
/// This mapper does not know about Firestore documents, collections, routes, or
/// runtime data sources.
class ProviderContactRequestMapper {
  const ProviderContactRequestMapper._();

  static ProviderContactRequest fromRaw(Map<String, dynamic> raw) {
    return ProviderContactRequest.fromMap(raw);
  }

  static Map<String, dynamic> toRaw(ProviderContactRequest request) {
    return request.toMap();
  }
}
