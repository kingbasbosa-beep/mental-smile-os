import 'runtime_wiring_scope.dart';

class RuntimeWiringPath {
  const RuntimeWiringPath({
    required this.source,
    required this.target,
    required this.pathKey,
    required this.sealed,
  });

  final RuntimeWiringScope source;
  final RuntimeWiringScope target;
  final String pathKey;
  final bool sealed;

  bool get isApprovedPlaceholder =>
      pathKey.trim().isNotEmpty && sealed;
}
