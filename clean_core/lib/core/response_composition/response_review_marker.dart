class ResponseReviewMarker {
  const ResponseReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  static const ResponseReviewMarker safeDefault = ResponseReviewMarker(
    reviewRequired: true,
    reasonKey: 'backend_review_required',
    clientCanResolve: false,
  );

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;

  Map<String, Object?> toMap() {
    return {
      'reviewRequired': reviewRequired,
      'reasonKey': reasonKey,
      'clientCanResolve': clientCanResolve,
    };
  }
}
