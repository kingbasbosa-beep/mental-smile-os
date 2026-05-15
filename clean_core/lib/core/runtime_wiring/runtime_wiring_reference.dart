import 'runtime_wiring_scope.dart';

class RuntimeWiringReference {
  const RuntimeWiringReference({
    required this.referenceId,
    required this.scope,
    this.hashPlaceholder,
  });

  final String referenceId;
  final RuntimeWiringScope scope;
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
