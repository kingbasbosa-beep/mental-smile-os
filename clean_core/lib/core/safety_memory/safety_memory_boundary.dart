import 'safety_memory_policy.dart';
import 'safety_memory_runtime_marker.dart';

class SafetyMemoryBoundary {
  const SafetyMemoryBoundary({
    required this.policy,
    required this.runtimeMarker,
    required this.backendGoverned,
    required this.rawPersistenceAllowed,
  });

  static const SafetyMemoryBoundary safeDefault = SafetyMemoryBoundary(
    policy: SafetyMemoryPolicy.safeDefault,
    runtimeMarker: SafetyMemoryRuntimeMarker.disabled,
    backendGoverned: true,
    rawPersistenceAllowed: false,
  );

  final SafetyMemoryPolicy policy;
  final SafetyMemoryRuntimeMarker runtimeMarker;
  final bool backendGoverned;
  final bool rawPersistenceAllowed;
}
