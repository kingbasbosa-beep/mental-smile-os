import 'package:flutterprojects/features/signals/domain/models/signal_package.dart';

import '../domain/operational_monitoring_boundary.dart';
import '../registry/operational_signal_registry.dart';

class OperationalMonitoringRouter {
  const OperationalMonitoringRouter._();

  static OperationalMonitoringRoute? route(
    SignalPackage signal, {
    String period = 'daily',
  }) {
    if (!OperationalMonitoringBoundary.accepts(signal)) return null;
    final lane = OperationalAggregateLane.forSignal(signal.signalType);
    if (lane == null) return null;
    return OperationalMonitoringRoute(
      signalType: signal.signalType,
      signalSource: signal.signalSource,
      aggregateLane: lane,
      aggregateKey: aggregateKeyFor(signal, lane: lane, period: period),
      period: period,
    );
  }

  static String aggregateKeyFor(
    SignalPackage signal, {
    required OperationalAggregateLane lane,
    required String period,
  }) {
    final targetPart = _safeAggregatePart(signal.targetId);
    final bucket = _dateBucket(signal.timestamp.toUtc(), period);
    return 'operational_${lane.name}:${signal.signalType}:$targetPart:$bucket';
  }

  static String _dateBucket(DateTime timestamp, String period) {
    if (period != 'daily') return period;
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

class OperationalMonitoringRoute {
  const OperationalMonitoringRoute({
    required this.signalType,
    required this.signalSource,
    required this.aggregateLane,
    required this.aggregateKey,
    required this.period,
  });

  final String signalType;
  final String signalSource;
  final OperationalAggregateLane aggregateLane;
  final String aggregateKey;
  final String period;
}

enum OperationalAggregateLane {
  workCard,
  issue,
  complaint,
  reportActivity,
  departmentPerformance;

  static OperationalAggregateLane? forSignal(String signalType) {
    if (OperationalSignalRegistry.workCardSignals.contains(signalType)) {
      return OperationalAggregateLane.workCard;
    }
    if (OperationalSignalRegistry.issueSignals.contains(signalType)) {
      return OperationalAggregateLane.issue;
    }
    if (OperationalSignalRegistry.complaintSignals.contains(signalType)) {
      return OperationalAggregateLane.complaint;
    }
    if (OperationalSignalRegistry.reportActivitySignals.contains(signalType)) {
      return OperationalAggregateLane.reportActivity;
    }
    if (OperationalSignalRegistry.departmentPerformanceSignals
        .contains(signalType)) {
      return OperationalAggregateLane.departmentPerformance;
    }
    return null;
  }
}
