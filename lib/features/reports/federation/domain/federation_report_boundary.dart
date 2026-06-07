import 'package:flutterprojects/features/signals/domain/guards/forbidden_signal_source_guard.dart';

class FederationReportBoundary {
  const FederationReportBoundary._();

  static bool acceptsSource(String source) {
    return !ForbiddenSignalSourceGuard.isForbidden(source);
  }

  static void ensureAcceptedSource(String source) {
    ForbiddenSignalSourceGuard.ensureAllowed(source);
  }
}
