class ForbiddenSignalSourceGuard {
  const ForbiddenSignalSourceGuard._();

  static const List<String> forbiddenSources = <String>[
    'booking_requests',
    'bookingRequests',
    'sessionRatings',
    'payment proof',
    'payment_proof',
    'payout states',
    'payout_states',
    'assignment states',
    'assignment_states',
    'session states',
    'session_states',
    'admin lifecycle decisions',
    'admin_lifecycle_decisions',
    'admin booking decisions',
    'admin_booking_decisions',
    'admin payment decisions',
    'admin_payment_decisions',
    'admin session decisions',
    'admin_session_decisions',
  ];

  static bool isForbidden(String source) {
    final normalized = source.trim().toLowerCase();
    return forbiddenSources
        .map((forbidden) => forbidden.toLowerCase())
        .contains(normalized);
  }

  static void ensureAllowed(String source) {
    if (isForbidden(source)) {
      throw ArgumentError.value(
        source,
        'source',
        'Forbidden Signal source under Signal Constitution v1.',
      );
    }
  }
}
