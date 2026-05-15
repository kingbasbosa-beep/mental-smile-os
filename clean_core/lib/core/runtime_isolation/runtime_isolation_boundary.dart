class RuntimeIsolationBoundary {
  const RuntimeIsolationBoundary({
    required this.boundaryId,
    required this.runtimeIsolated,
    required this.providerIsolated,
    required this.environmentIsolated,
    required this.fallbackIsolated,
    required this.reviewIsolated,
    required this.auditIsolated,
    required this.sealed,
  });

  final String boundaryId;
  final bool runtimeIsolated;
  final bool providerIsolated;
  final bool environmentIsolated;
  final bool fallbackIsolated;
  final bool reviewIsolated;
  final bool auditIsolated;
  final bool sealed;

  bool get isCompletePlaceholder =>
      boundaryId.trim().isNotEmpty &&
      runtimeIsolated &&
      providerIsolated &&
      environmentIsolated &&
      fallbackIsolated &&
      reviewIsolated &&
      auditIsolated &&
      sealed;
}
