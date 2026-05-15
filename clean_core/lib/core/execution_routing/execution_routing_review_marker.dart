class ExecutionRoutingReviewMarker {
  const ExecutionRoutingReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;

  static const safeDefault = ExecutionRoutingReviewMarker(
    reviewRequired: true,
    reasonKey: 'execution_routing_review_required',
    clientCanResolve: false,
  );
}
