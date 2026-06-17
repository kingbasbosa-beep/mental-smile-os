import 'package:flutter/foundation.dart';

import '../aggregation/signal_aggregation_engine.dart';
import '../models/signal_package.dart';
import '../validators/signal_package_validator.dart';
import 'signal_emitter.dart';

class CleanSignalRuntime {
  const CleanSignalRuntime({
    SignalEmitter emitter = const NoopSignalEmitter(),
  }) : _emitter = emitter;

  /// Default runtime with Firestore persistence.
  factory CleanSignalRuntime.firestore() {
    return CleanSignalRuntime(emitter: FirestoreSignalEmitter());
  }

  final SignalEmitter _emitter;

  Future<void> emit(SignalPackage signal) async {
    final failureReason = SignalPackageValidator.failureReason(signal);
    if (failureReason != null) {
      debugPrint(
        'Signal blocked: ${signal.signalType} '
        'source=${signal.signalSource} '
        'reason=$failureReason',
      );
      return;
    }

    debugPrint(
      'Signal Emitted: ${signal.signalType} '
      'source=${signal.signalSource} '
      'target=${signal.routingTarget}',
    );
    final aggregate = SignalAggregationEngine.aggregate(signal);
    if (aggregate != null) {
      debugPrint(
        'Signal Aggregate Updated: ${aggregate.aggregateKey} '
        'count=${aggregate.count}',
      );
    }
    await _emitter.emitSignal(signal);
  }
}
