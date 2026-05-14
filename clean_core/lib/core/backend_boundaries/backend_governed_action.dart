import 'trusted_operation_contract.dart';

class BackendGovernedAction {
  const BackendGovernedAction({
    required this.contract,
    required this.payloadPreview,
    required this.clientWritableFields,
  });

  final TrustedOperationContract contract;
  final Map<String, Object?> payloadPreview;
  final Set<String> clientWritableFields;

  bool get containsProtectedClientWrites {
    return payloadPreview.keys.any(
      (key) => contract.protectedFields.contains(key),
    );
  }
}
