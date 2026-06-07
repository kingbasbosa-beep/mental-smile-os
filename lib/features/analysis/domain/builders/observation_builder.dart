import 'package:flutterprojects/features/monitoring/monitoring.dart';

import '../models/analysis_observations.dart';
import '../models/analysis_snapshots.dart';
import '../registries/analysis_category_registry.dart';

class ObservationBuilder {
  const ObservationBuilder._();

  static ResidentialAnalysisSnapshot residentialSnapshot(
    ResidentialMonitoringFeed feed, {
    DateTime? createdAt,
  }) {
    final timestamp = (createdAt ?? DateTime.now()).toUtc();
    return ResidentialAnalysisSnapshot(
      observationDrafts: <ObservationDraft>[
        ..._draftsFor(
          feed.goalAggregates,
          AnalysisCategoryRegistry.goalAnalysis,
          timestamp,
        ),
        ..._draftsFor(
          feed.interestAggregates,
          AnalysisCategoryRegistry.interestAnalysis,
          timestamp,
        ),
        ..._draftsFor(
          feed.accessibilityAggregates,
          AnalysisCategoryRegistry.accessibilityAnalysis,
          timestamp,
        ),
        ..._draftsFor(
          feed.destinationAggregates,
          AnalysisCategoryRegistry.destinationAnalysis,
          timestamp,
        ),
        ..._draftsFor(
          feed.libraryAggregates,
          AnalysisCategoryRegistry.libraryAnalysis,
          timestamp,
        ),
      ],
      createdAt: timestamp,
    );
  }

  static CommercialAnalysisSnapshot commercialSnapshot(
    CommercialMonitoringFeed feed, {
    DateTime? createdAt,
  }) {
    final timestamp = (createdAt ?? DateTime.now()).toUtc();
    return CommercialAnalysisSnapshot(
      observationDrafts: <ObservationDraft>[
        ..._draftsFor(
          feed.providerContactAggregates,
          AnalysisCategoryRegistry.providerDemandAnalysis,
          timestamp,
        ),
        ..._draftsFor(
          feed.centerContactAggregates,
          AnalysisCategoryRegistry.centerDemandAnalysis,
          timestamp,
        ),
      ],
      createdAt: timestamp,
    );
  }

  static FederationAnalysisSnapshot federationSnapshot(
    FederationMonitoringSnapshot snapshot, {
    DateTime? createdAt,
  }) {
    final timestamp = (createdAt ?? DateTime.now()).toUtc();
    return FederationAnalysisSnapshot(
      residentialSnapshot: residentialSnapshot(
        snapshot.residentialFeed,
        createdAt: timestamp,
      ),
      commercialSnapshot: commercialSnapshot(
        snapshot.commercialFeed,
        createdAt: timestamp,
      ),
      createdAt: timestamp,
    );
  }

  static List<ObservationDraft> _draftsFor(
    Iterable<MonitoringAggregateItem> items,
    String category,
    DateTime createdAt,
  ) {
    return items
        .map(
          (item) => ObservationDraft(
            category: category,
            sourceAggregate: item.monitoringKey,
            aiObservation: AIObservation(
              observationId:
                  'ai_${category}_${createdAt.microsecondsSinceEpoch}',
              category: category,
              sourceAggregate: item.monitoringKey,
              observationText: _placeholderObservationText(item),
              confidenceLevel: 'placeholder',
              createdAt: createdAt,
            ),
            humanObservation: null,
          ),
        )
        .toList(growable: false);
  }

  static String _placeholderObservationText(MonitoringAggregateItem item) {
    return 'Collective activity observed for ${item.signalType} '
        'within ${item.aggregationWindow} window.';
  }
}
