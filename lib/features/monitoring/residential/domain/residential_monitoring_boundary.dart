import 'package:flutterprojects/features/signals/domain/models/signal_package.dart';

class ResidentialMonitoringBoundary {
  const ResidentialMonitoringBoundary._();

  static bool accepts(SignalPackage signal) {
    return signal.signalSource.trim().isNotEmpty;
  }

  static void ensureAccepted(SignalPackage signal) {
    if (!accepts(signal)) {
      throw ArgumentError.value(
        signal.signalSource,
        'signalSource',
        'Signal source is required.',
      );
    }
  }
}
