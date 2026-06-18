import '../models/signal_aggregate.dart';
import '../models/signal_package.dart';
import '../registries/signal_aggregation_category_registry.dart';
import '../registries/signal_category_registry.dart';
import '../validators/signal_aggregation_validator.dart';

class SignalAggregationEngine {
  const SignalAggregationEngine._();

  static const String dailyWindow = 'daily';
  static final Map<String, SignalAggregate> _aggregates =
      <String, SignalAggregate>{};

  static SignalAggregate? aggregate(
    SignalPackage signal, {
    String aggregationWindow = dailyWindow,
  }) {
    if (!SignalAggregationValidator.isAggregationEligible(signal)) {
      return null;
    }

    final key = aggregateKey(signal, aggregationWindow: aggregationWindow);
    final existing = _aggregates[key];
    final updated = existing == null
        ? SignalAggregate(
            aggregateKey: key,
            signalType: signal.signalType,
            signalCategory: signal.signalCategory,
            count: 1,
            firstSeen: signal.timestamp.toUtc(),
            lastSeen: signal.timestamp.toUtc(),
            aggregationWindow: aggregationWindow,
          )
        : existing.incremented(signal.timestamp);
    _aggregates[key] = updated;
    return updated;
  }

  static String aggregateKey(
    SignalPackage signal, {
    String aggregationWindow = dailyWindow,
  }) {
    final bucket = _dateBucket(signal.timestamp.toUtc(), aggregationWindow);
    final category = aggregationCategoryFor(signal);
    final targetPart = _safeAggregatePart(signal.targetId);
    return '$category:${signal.signalType}:$targetPart:$bucket';
  }

  static List<SignalAggregate> snapshot() {
    return List<SignalAggregate>.unmodifiable(_aggregates.values);
  }

  static String? aggregationCategoryFor(SignalPackage signal) {
    switch (signal.signalCategory) {
      case SignalCategoryRegistry.accessibility:
        return SignalAggregationCategoryRegistry.accessibilityAggregates;
      case SignalCategoryRegistry.destination:
        return SignalAggregationCategoryRegistry.destinationAggregates;
      case SignalCategoryRegistry.contact:
        return SignalAggregationCategoryRegistry.contactAggregates;
      case SignalCategoryRegistry.library:
        return SignalAggregationCategoryRegistry.libraryAggregates;
    }
    return null;
  }

  static String _dateBucket(DateTime timestamp, String aggregationWindow) {
    if (aggregationWindow != dailyWindow) return aggregationWindow;
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
