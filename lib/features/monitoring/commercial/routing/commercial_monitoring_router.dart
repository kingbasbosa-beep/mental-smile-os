import 'package:mental_smile_os/features/signals/domain/models/signal_package.dart';

import '../aggregates/commercial_signal_aggregate.dart';
import '../domain/commercial_monitoring_boundary.dart';
import '../registry/commercial_monitoring_registry.dart';

class CommercialMonitoringRouter {
  const CommercialMonitoringRouter._();

  static CommercialMonitoringRoute? route(
    SignalPackage signal, {
    String aggregationWindow = 'daily',
  }) {
    if (!CommercialMonitoringBoundary.accepts(signal)) return null;
    final kind = CommercialMonitoringRegistry.aggregateKindFor(
      signal.signalType,
    );
    if (kind == null) return null;
    return CommercialMonitoringRoute(
      aggregateKind: kind,
      aggregateKey: aggregateKeyFor(
        signal,
        aggregateKind: kind,
        aggregationWindow: aggregationWindow,
      ),
      signalType: signal.signalType,
      signalSource: signal.signalSource,
      aggregationWindow: aggregationWindow,
    );
  }

  static String aggregateKeyFor(
    SignalPackage signal, {
    required CommercialAggregateKind aggregateKind,
    required String aggregationWindow,
  }) {
    final targetPart = _safeAggregatePart(signal.targetId);
    final bucket = _dateBucket(signal.timestamp.toUtc(), aggregationWindow);
    return 'commercial_${aggregateKind.name}:'
        '${signal.signalType}:$targetPart:$bucket';
  }

  static String _dateBucket(DateTime timestamp, String aggregationWindow) {
    if (aggregationWindow != 'daily') return aggregationWindow;
    final year = timestamp.year.toString().padLeft(4, '0');
    final month = timestamp.month.toString().padLeft(2, '0');
    final day = timestamp.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  static String _safeAggregatePart(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return 'unspecified';
    return normalized.replaceAll(RegExp(r'[^a-zA-Z0-9_\-]'), '_');
  }
}

class CommercialMonitoringRoute {
  const CommercialMonitoringRoute({
    required this.aggregateKind,
    required this.aggregateKey,
    required this.signalType,
    required this.signalSource,
    required this.aggregationWindow,
  });

  final CommercialAggregateKind aggregateKind;
  final String aggregateKey;
  final String signalType;
  final String signalSource;
  final String aggregationWindow;
}
