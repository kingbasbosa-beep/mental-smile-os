import 'package:mental_smile_os/features/signals/domain/models/signal_aggregate.dart';

import '../adapters/monitoring_aggregation_adapter.dart';
import '../models/monitoring_feeds.dart';

class MonitoringSnapshotBuilder {
  const MonitoringSnapshotBuilder._();

  static ResidentialMonitoringFeed residentialSnapshot(
    Iterable<SignalAggregate> aggregates, {
    DateTime? generatedAt,
  }) {
    return MonitoringAggregationAdapter.residentialFeedFromAggregates(
      aggregates,
      generatedAt: generatedAt,
    );
  }

  static CommercialMonitoringFeed commercialSnapshot(
    Iterable<SignalAggregate> aggregates, {
    DateTime? generatedAt,
  }) {
    return MonitoringAggregationAdapter.commercialFeedFromAggregates(
      aggregates,
      generatedAt: generatedAt,
    );
  }

  static FederationMonitoringSnapshot federationSnapshot(
    Iterable<SignalAggregate> aggregates, {
    DateTime? generatedAt,
  }) {
    final snapshotTime = (generatedAt ?? DateTime.now()).toUtc();
    return FederationMonitoringSnapshot(
      residentialFeed: residentialSnapshot(
        aggregates,
        generatedAt: snapshotTime,
      ),
      commercialFeed: commercialSnapshot(
        aggregates,
        generatedAt: snapshotTime,
      ),
      generatedAt: snapshotTime,
    );
  }
}
