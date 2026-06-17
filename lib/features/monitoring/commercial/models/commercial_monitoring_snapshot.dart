import '../aggregates/commercial_signal_aggregate.dart';

class CommercialMonitoringSnapshot {
  const CommercialMonitoringSnapshot({
    required this.providerSummary,
    required this.centerSummary,
    required this.toolSummary,
    required this.servicesSummary,
    required this.ecosystemSummary,
    required this.timestamp,
  });

  final CommercialAggregateSummary providerSummary;
  final CommercialAggregateSummary centerSummary;
  final CommercialAggregateSummary toolSummary;
  final CommercialAggregateSummary servicesSummary;
  final CommercialAggregateSummary ecosystemSummary;
  final DateTime timestamp;
}

class CommercialAggregateSummary {
  const CommercialAggregateSummary({
    required this.summaryKey,
    required this.totalCount,
    required this.items,
  });

  final String summaryKey;
  final int totalCount;
  final List<CommercialSignalAggregate> items;

  static CommercialAggregateSummary fromItems({
    required String summaryKey,
    required Iterable<CommercialSignalAggregate> items,
  }) {
    final snapshotItems = List<CommercialSignalAggregate>.unmodifiable(items);
    return CommercialAggregateSummary(
      summaryKey: summaryKey,
      totalCount: snapshotItems.fold<int>(
        0,
        (total, item) => total + item.count,
      ),
      items: snapshotItems,
    );
  }
}
