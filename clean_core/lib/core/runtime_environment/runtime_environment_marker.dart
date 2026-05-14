import 'runtime_environment_scope.dart';
import 'runtime_environment_type.dart';

class RuntimeEnvironmentMarker {
  const RuntimeEnvironmentMarker({
    required this.environmentType,
    required this.scope,
    required this.runtimeMode,
    required this.policyVersion,
  });

  final RuntimeEnvironmentType environmentType;
  final RuntimeEnvironmentScope scope;
  final String runtimeMode;
  final String policyVersion;

  Map<String, Object?> toMap() {
    return {
      'environmentType': environmentType.key,
      'scope': scope.key,
      'runtimeMode': runtimeMode,
      'policyVersion': policyVersion,
    };
  }
}
