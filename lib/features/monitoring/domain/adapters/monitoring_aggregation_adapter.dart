import 'package:mental_smile_os/features/signals/domain/models/signal_aggregate.dart';
import 'package:mental_smile_os/features/signals/domain/registries/signal_type_registry.dart';

import '../models/monitoring_aggregate_item.dart';
import '../models/monitoring_feeds.dart';
import '../registries/commercial_monitoring_category_registry.dart';
import '../registries/residential_monitoring_category_registry.dart';
import '../validators/monitoring_aggregate_validator.dart';

class MonitoringAggregationAdapter {
  const MonitoringAggregationAdapter._();

  static ResidentialMonitoringFeed residentialFeedFromAggregates(
    Iterable<SignalAggregate> aggregates, {
    DateTime? generatedAt,
  }) {
    final readable = aggregates.where(MonitoringAggregateValidator.isReadable);
    return ResidentialMonitoringFeed(
      goalAggregates: const <MonitoringAggregateItem>[],
      interestAggregates: const <MonitoringAggregateItem>[],
      accessibilityAggregates: const <MonitoringAggregateItem>[],
      destinationAggregates: _itemsFor(
        readable,
        SignalTypeRegistry.destinationSaved,
        ResidentialMonitoringCategoryRegistry.savedDestinations,
      ),
      libraryAggregates: _itemsFor(
        readable,
        SignalTypeRegistry.libraryCategoryOpened,
        ResidentialMonitoringCategoryRegistry.libraryActivity,
      ),
      generatedAt: (generatedAt ?? DateTime.now()).toUtc(),
    );
  }

  static CommercialMonitoringFeed commercialFeedFromAggregates(
    Iterable<SignalAggregate> aggregates, {
    DateTime? generatedAt,
  }) {
    final readable = aggregates.where(MonitoringAggregateValidator.isReadable);
    final providerDemand = _itemsFor(
      readable,
      SignalTypeRegistry.providerContactStarted,
      CommercialMonitoringCategoryRegistry.providerDemand,
    );
    final centerDemand = _itemsFor(
      readable,
      SignalTypeRegistry.centerContactStarted,
      CommercialMonitoringCategoryRegistry.centerDemand,
    );
    final contactActivity = _itemsForAny(
      readable,
      <String>{
        SignalTypeRegistry.providerContactStarted,
        SignalTypeRegistry.centerContactStarted,
      },
      CommercialMonitoringCategoryRegistry.contactActivity,
    );

    return CommercialMonitoringFeed(
      providerContactAggregates: providerDemand,
      centerContactAggregates: centerDemand,
      contactActivityAggregates: contactActivity,
      generatedAt: (generatedAt ?? DateTime.now()).toUtc(),
    );
  }

  static List<MonitoringAggregateItem> _itemsFor(
    Iterable<SignalAggregate> aggregates,
    String signalType,
    String monitoringCategory,
  ) {
    return _itemsForAny(aggregates, <String>{signalType}, monitoringCategory);
  }

  static List<MonitoringAggregateItem> _itemsForAny(
    Iterable<SignalAggregate> aggregates,
    Set<String> signalTypes,
    String monitoringCategory,
  ) {
    final folded = <String, MonitoringAggregateItem>{};
    for (final aggregate in aggregates) {
      if (!signalTypes.contains(aggregate.signalType)) continue;
      final monitoringKey = _monitoringKey(monitoringCategory, aggregate);
      final item = MonitoringAggregateItem(
        monitoringKey: monitoringKey,
        signalType: aggregate.signalType,
        signalCategory: aggregate.signalCategory,
        count: aggregate.count,
        firstSeen: aggregate.firstSeen,
        lastSeen: aggregate.lastSeen,
        aggregationWindow: aggregate.aggregationWindow,
      );
      folded[monitoringKey] = folded[monitoringKey]?.mergedWith(item) ?? item;
    }
    final items = folded.values.toList()
      ..sort((a, b) => b.count.compareTo(a.count));
    return List<MonitoringAggregateItem>.unmodifiable(items);
  }

  static String _monitoringKey(
    String monitoringCategory,
    SignalAggregate aggregate,
  ) {
    return '$monitoringCategory:${aggregate.signalType}:'
        '${aggregate.aggregationWindow}';
  }
}
