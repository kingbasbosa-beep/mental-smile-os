import 'package:mental_smile_os/features/signals/domain/registries/signal_type_registry.dart';

import '../aggregates/residential_signal_aggregate.dart';

class ResidentialMonitoringRegistry {
  const ResidentialMonitoringRegistry._();

  static const String toolAdded = 'tool_added';
  static const String toolRemoved = 'tool_removed';
  static const String toolOpened = 'tool_opened';

  static const Set<String> goalSignals = <String>{
    SignalTypeRegistry.goalSelected,
  };

  static const Set<String> interestSignals = <String>{
    SignalTypeRegistry.interestSelected,
  };

  static const Set<String> accessibilitySignals = <String>{
    SignalTypeRegistry.accessibilityInterest,
  };

  static const Set<String> supportSignals = <String>{
    SignalTypeRegistry.supportStarted,
  };

  static const Set<String> librarySignals = <String>{
    SignalTypeRegistry.libraryCategoryOpened,
  };

  static const Set<String> savedDestinationSignals = <String>{
    SignalTypeRegistry.destinationSaved,
  };

  static const Set<String> toolSignals = <String>{
    toolAdded,
    toolRemoved,
    toolOpened,
  };

  static const Set<String> allResidentialSignals = <String>{
    ...goalSignals,
    ...interestSignals,
    ...accessibilitySignals,
    ...supportSignals,
    ...librarySignals,
    ...savedDestinationSignals,
    ...toolSignals,
  };

  static ResidentialAggregateKind? aggregateKindFor(String signalType) {
    if (goalSignals.contains(signalType)) return ResidentialAggregateKind.goal;
    if (interestSignals.contains(signalType)) {
      return ResidentialAggregateKind.interest;
    }
    if (accessibilitySignals.contains(signalType)) {
      return ResidentialAggregateKind.accessibility;
    }
    if (supportSignals.contains(signalType)) {
      return ResidentialAggregateKind.support;
    }
    if (librarySignals.contains(signalType)) {
      return ResidentialAggregateKind.library;
    }
    if (savedDestinationSignals.contains(signalType)) {
      return ResidentialAggregateKind.savedDestination;
    }
    if (toolSignals.contains(signalType)) return ResidentialAggregateKind.tool;
    return null;
  }
}
