import 'monitoring_aggregate_item.dart';

class ResidentialMonitoringFeed {
  const ResidentialMonitoringFeed({
    required this.goalAggregates,
    required this.interestAggregates,
    required this.accessibilityAggregates,
    required this.destinationAggregates,
    required this.libraryAggregates,
    required this.generatedAt,
  });

  final List<MonitoringAggregateItem> goalAggregates;
  final List<MonitoringAggregateItem> interestAggregates;
  final List<MonitoringAggregateItem> accessibilityAggregates;
  final List<MonitoringAggregateItem> destinationAggregates;
  final List<MonitoringAggregateItem> libraryAggregates;
  final DateTime generatedAt;

  int get totalActivity {
    return _sum(goalAggregates) +
        _sum(interestAggregates) +
        _sum(accessibilityAggregates) +
        _sum(destinationAggregates) +
        _sum(libraryAggregates);
  }

  static int _sum(List<MonitoringAggregateItem> items) {
    return items.fold<int>(0, (total, item) => total + item.count);
  }
}

class CommercialMonitoringFeed {
  const CommercialMonitoringFeed({
    required this.providerContactAggregates,
    required this.centerContactAggregates,
    required this.contactActivityAggregates,
    required this.generatedAt,
  });

  final List<MonitoringAggregateItem> providerContactAggregates;
  final List<MonitoringAggregateItem> centerContactAggregates;
  final List<MonitoringAggregateItem> contactActivityAggregates;
  final DateTime generatedAt;

  int get totalActivity {
    return _sum(contactActivityAggregates);
  }

  static int _sum(List<MonitoringAggregateItem> items) {
    return items.fold<int>(0, (total, item) => total + item.count);
  }
}

class FederationMonitoringSnapshot {
  const FederationMonitoringSnapshot({
    required this.residentialFeed,
    required this.commercialFeed,
    required this.generatedAt,
  });

  final ResidentialMonitoringFeed residentialFeed;
  final CommercialMonitoringFeed commercialFeed;
  final DateTime generatedAt;

  int get totalFederationActivity {
    return residentialFeed.totalActivity + commercialFeed.totalActivity;
  }
}
