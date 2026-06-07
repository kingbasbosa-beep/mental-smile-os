import 'package:flutterprojects/features/signals/domain/guards/forbidden_signal_source_guard.dart';
import 'package:flutterprojects/features/signals/domain/models/signal_aggregate.dart';
import 'package:flutterprojects/features/signals/domain/registries/signal_aggregation_category_registry.dart';
import 'package:flutterprojects/features/signals/domain/registries/signal_type_registry.dart';

class MonitoringAggregateValidator {
  const MonitoringAggregateValidator._();

  static const Set<String> readableCategories = <String>{
    SignalAggregationCategoryRegistry.goalAggregates,
    SignalAggregationCategoryRegistry.interestAggregates,
    SignalAggregationCategoryRegistry.accessibilityAggregates,
    SignalAggregationCategoryRegistry.destinationAggregates,
    SignalAggregationCategoryRegistry.contactAggregates,
    SignalAggregationCategoryRegistry.libraryAggregates,
  };

  static const Set<String> readableSignalTypes = <String>{
    SignalTypeRegistry.goalSelected,
    SignalTypeRegistry.interestSelected,
    SignalTypeRegistry.accessibilityInterest,
    SignalTypeRegistry.destinationSaved,
    SignalTypeRegistry.providerContactStarted,
    SignalTypeRegistry.centerContactStarted,
    SignalTypeRegistry.libraryCategoryOpened,
  };

  static bool isReadable(SignalAggregate aggregate) {
    return readableSignalTypes.contains(aggregate.signalType) &&
        readableCategories.contains(_categoryFromAggregateKey(aggregate)) &&
        !_containsForbiddenResidue(aggregate.aggregateKey);
  }

  static String? categoryFromAggregateKey(SignalAggregate aggregate) {
    final category = _categoryFromAggregateKey(aggregate);
    return readableCategories.contains(category) ? category : null;
  }

  static String _categoryFromAggregateKey(SignalAggregate aggregate) {
    return aggregate.aggregateKey.split(':').first;
  }

  static bool _containsForbiddenResidue(String value) {
    final normalized = value.trim().toLowerCase();
    return ForbiddenSignalSourceGuard.forbiddenSources.any(
      (source) => normalized.contains(source.toLowerCase()),
    );
  }
}
