import 'runtime_enablement_scope.dart';

class RuntimeEnablementReference {
  const RuntimeEnablementReference({
    required this.referenceId,
    required this.scope,
    this.hashPlaceholder,
  });

  final String referenceId;
  final RuntimeEnablementScope scope;
  final String? hashPlaceholder;

  bool get isLinked => referenceId.trim().isNotEmpty;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'referenceId': referenceId,
      'scope': scope.key,
      'hashPlaceholder': hashPlaceholder,
    };
  }
}
