import 'package:mental_smile_os/features/signals/domain/models/signal_package.dart';

class ResidentialSignalAggregate {
  const ResidentialSignalAggregate({
    required this.aggregateKey,
    required this.signalType,
    required this.count,
    required this.firstSeen,
    required this.lastSeen,
    required this.aggregationWindow,
  });

  final String aggregateKey;
  final String signalType;
  final int count;
  final DateTime firstSeen;
  final DateTime lastSeen;
  final String aggregationWindow;

  ResidentialSignalAggregate incremented(DateTime seenAt) {
    final seenUtc = seenAt.toUtc();
    return ResidentialSignalAggregate(
      aggregateKey: aggregateKey,
      signalType: signalType,
      count: count + 1,
      firstSeen: firstSeen,
      lastSeen: seenUtc.isAfter(lastSeen) ? seenUtc : lastSeen,
      aggregationWindow: aggregationWindow,
    );
  }
}

class GoalAggregate extends ResidentialSignalAggregate {
  const GoalAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class InterestAggregate extends ResidentialSignalAggregate {
  const InterestAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class AccessibilityAggregate extends ResidentialSignalAggregate {
  const AccessibilityAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class LibraryAggregate extends ResidentialSignalAggregate {
  const LibraryAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class SupportAggregate extends ResidentialSignalAggregate {
  const SupportAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class SavedDestinationAggregate extends ResidentialSignalAggregate {
  const SavedDestinationAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class ToolAggregate extends ResidentialSignalAggregate {
  const ToolAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

ResidentialSignalAggregate residentialAggregateSeed({
  required SignalPackage signal,
  required String aggregateKey,
  required String aggregationWindow,
  required ResidentialAggregateKind kind,
}) {
  final timestamp = signal.timestamp.toUtc();
  switch (kind) {
    case ResidentialAggregateKind.goal:
      return GoalAggregate(
        aggregateKey: aggregateKey,
        signalType: signal.signalType,
        count: 1,
        firstSeen: timestamp,
        lastSeen: timestamp,
        aggregationWindow: aggregationWindow,
      );
    case ResidentialAggregateKind.interest:
      return InterestAggregate(
        aggregateKey: aggregateKey,
        signalType: signal.signalType,
        count: 1,
        firstSeen: timestamp,
        lastSeen: timestamp,
        aggregationWindow: aggregationWindow,
      );
    case ResidentialAggregateKind.accessibility:
      return AccessibilityAggregate(
        aggregateKey: aggregateKey,
        signalType: signal.signalType,
        count: 1,
        firstSeen: timestamp,
        lastSeen: timestamp,
        aggregationWindow: aggregationWindow,
      );
    case ResidentialAggregateKind.library:
      return LibraryAggregate(
        aggregateKey: aggregateKey,
        signalType: signal.signalType,
        count: 1,
        firstSeen: timestamp,
        lastSeen: timestamp,
        aggregationWindow: aggregationWindow,
      );
    case ResidentialAggregateKind.support:
      return SupportAggregate(
        aggregateKey: aggregateKey,
        signalType: signal.signalType,
        count: 1,
        firstSeen: timestamp,
        lastSeen: timestamp,
        aggregationWindow: aggregationWindow,
      );
    case ResidentialAggregateKind.savedDestination:
      return SavedDestinationAggregate(
        aggregateKey: aggregateKey,
        signalType: signal.signalType,
        count: 1,
        firstSeen: timestamp,
        lastSeen: timestamp,
        aggregationWindow: aggregationWindow,
      );
    case ResidentialAggregateKind.tool:
      return ToolAggregate(
        aggregateKey: aggregateKey,
        signalType: signal.signalType,
        count: 1,
        firstSeen: timestamp,
        lastSeen: timestamp,
        aggregationWindow: aggregationWindow,
      );
  }
}

enum ResidentialAggregateKind {
  goal,
  interest,
  accessibility,
  library,
  support,
  savedDestination,
  tool,
}
