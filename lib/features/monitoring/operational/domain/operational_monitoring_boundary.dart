import 'package:flutterprojects/features/signals/domain/guards/forbidden_signal_source_guard.dart';
import 'package:flutterprojects/features/signals/domain/models/signal_package.dart';

class OperationalMonitoringBoundary {
  const OperationalMonitoringBoundary._();

  static bool accepts(SignalPackage signal) {
    return !ForbiddenSignalSourceGuard.isForbidden(signal.signalSource);
  }

  static void ensureAccepted(SignalPackage signal) {
    ForbiddenSignalSourceGuard.ensureAllowed(signal.signalSource);
  }
}
