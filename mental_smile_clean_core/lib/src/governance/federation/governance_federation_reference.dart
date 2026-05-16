import 'governance_federation_scope.dart';

class GovernanceFederationReference {
  const GovernanceFederationReference({
    required this.referenceId,
    required this.scope,
    required this.hashPlaceholder,
  });

  final String referenceId;
  final GovernanceFederationScope scope;
  final String hashPlaceholder;

  bool get isLinked {
    return referenceId.trim().isNotEmpty && hashPlaceholder.trim().isNotEmpty;
  }
}
