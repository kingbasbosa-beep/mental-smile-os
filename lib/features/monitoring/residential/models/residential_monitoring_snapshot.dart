import '../aggregates/residential_signal_aggregate.dart';

class ResidentialMonitoringSnapshot {
  const ResidentialMonitoringSnapshot({
    required this.timestamp,
    required this.goalsSummary,
    required this.interestsSummary,
    required this.accessibilitySummary,
    required this.librarySummary,
    required this.supportSummary,
    required this.toolsSummary,
  });

  final DateTime timestamp;
  final ResidentialAggregateSummary goalsSummary;
  final ResidentialAggregateSummary interestsSummary;
  final ResidentialAggregateSummary accessibilitySummary;
  final ResidentialAggregateSummary librarySummary;
  final ResidentialAggregateSummary supportSummary;
  final ResidentialAggregateSummary toolsSummary;
}

class ResidentialAggregateSummary {
  const ResidentialAggregateSummary({
    required this.kind,
    required this.totalCount,
    required this.items,
  });

  final ResidentialAggregateKind kind;
  final int totalCount;
  final List<ResidentialSignalAggregate> items;

  static ResidentialAggregateSummary fromItems({
    required ResidentialAggregateKind kind,
    required Iterable<ResidentialSignalAggregate> items,
  }) {
    final snapshotItems = List<ResidentialSignalAggregate>.unmodifiable(items);
    return ResidentialAggregateSummary(
      kind: kind,
      totalCount: snapshotItems.fold<int>(
        0,
        (total, item) => total + item.count,
      ),
      items: snapshotItems,
    );
  }
}
