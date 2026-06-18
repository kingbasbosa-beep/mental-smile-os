import '../aggregates/residential_signal_aggregate.dart';
import '../models/residential_monitoring_snapshot.dart';

class ResidentialMonitoringSnapshotBuilder {
  const ResidentialMonitoringSnapshotBuilder._();

  static ResidentialMonitoringSnapshot build(
    Iterable<ResidentialSignalAggregate> aggregates, {
    DateTime? timestamp,
  }) {
    final items = List<ResidentialSignalAggregate>.unmodifiable(aggregates);
    return ResidentialMonitoringSnapshot(
      timestamp: (timestamp ?? DateTime.now()).toUtc(),
      goalsSummary: _summary(items, ResidentialAggregateKind.goal),
      interestsSummary: _summary(items, ResidentialAggregateKind.interest),
      accessibilitySummary: _summary(
        items,
        ResidentialAggregateKind.accessibility,
      ),
      librarySummary: _summary(items, ResidentialAggregateKind.library),
      supportSummary: _summary(items, ResidentialAggregateKind.support),
      toolsSummary: _summary(items, ResidentialAggregateKind.tool),
    );
  }

  static ResidentialAggregateSummary _summary(
    Iterable<ResidentialSignalAggregate> items,
    ResidentialAggregateKind kind,
  ) {
    return ResidentialAggregateSummary.fromItems(
      kind: kind,
      items: items.where((item) => _kindFromAggregate(item) == kind),
    );
  }

  static ResidentialAggregateKind? _kindFromAggregate(
    ResidentialSignalAggregate aggregate,
  ) {
    if (aggregate is GoalAggregate) return ResidentialAggregateKind.goal;
    if (aggregate is InterestAggregate) {
      return ResidentialAggregateKind.interest;
    }
    if (aggregate is AccessibilityAggregate) {
      return ResidentialAggregateKind.accessibility;
    }
    if (aggregate is LibraryAggregate) return ResidentialAggregateKind.library;
    if (aggregate is SupportAggregate) return ResidentialAggregateKind.support;
    if (aggregate is ToolAggregate) return ResidentialAggregateKind.tool;
    return null;
  }
}
