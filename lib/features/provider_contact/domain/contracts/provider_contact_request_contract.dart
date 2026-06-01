import '../models/provider_contact_request.dart';

/// Future Provider Contact Read Surface Contract.
///
/// No runtime implementation yet.
abstract class ProviderContactRequestContract {
  List<ProviderContactRequest> getRequestsForClient(String clientId);

  List<ProviderContactRequest> getRequestsForProvider(String providerId);

  ProviderContactRequest getRequestById(String requestId);
}
