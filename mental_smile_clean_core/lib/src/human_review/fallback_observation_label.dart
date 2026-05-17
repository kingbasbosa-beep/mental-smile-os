/// Passive fallback observation vocabulary.
///
/// This label records an observed fallback condition only. It does not route,
/// activate fallback, recover loops, prove runtime enforcement, or guarantee
/// emergency handling.
enum FallbackObservationLabel {
  fallbackLoopObserved,
}

extension FallbackObservationLabelKey on FallbackObservationLabel {
  String get key {
    switch (this) {
      case FallbackObservationLabel.fallbackLoopObserved:
        return 'fallback_loop_observed';
    }
  }
}
