import '../aggregates/commercial_signal_aggregate.dart';
import '../models/commercial_monitoring_snapshot.dart';

class CommercialMonitoringSnapshotBuilder {
  const CommercialMonitoringSnapshotBuilder._();

  static CommercialMonitoringSnapshot build(
    Iterable<CommercialSignalAggregate> aggregates, {
    DateTime? timestamp,
  }) {
    final items = List<CommercialSignalAggregate>.unmodifiable(aggregates);
    return CommercialMonitoringSnapshot(
      providerSummary: _summary(
        'provider_summary',
        items.where(_isProviderAggregate),
      ),
      centerSummary: _summary(
        'center_summary',
        items.where(_isCenterAggregate),
      ),
      toolSummary: _summary(
        'tool_summary',
        items.where(_isToolAggregate),
      ),
      servicesSummary: _summary(
        'services_summary',
        items.where(_isServiceAggregate),
      ),
      ecosystemSummary: _summary(
        'ecosystem_summary',
        items.where(_isEcosystemAggregate),
      ),
      timestamp: (timestamp ?? DateTime.now()).toUtc(),
    );
  }

  static CommercialAggregateSummary _summary(
    String summaryKey,
    Iterable<CommercialSignalAggregate> items,
  ) {
    return CommercialAggregateSummary.fromItems(
      summaryKey: summaryKey,
      items: items,
    );
  }

  static bool _isProviderAggregate(CommercialSignalAggregate aggregate) {
    return aggregate is ProviderDemandAggregate ||
        aggregate is ProviderCapabilityAggregate ||
        aggregate is ProviderVerificationAggregate;
  }

  static bool _isCenterAggregate(CommercialSignalAggregate aggregate) {
    return aggregate is CenterDemandAggregate ||
        aggregate is CenterCapabilityAggregate ||
        aggregate is CenterVerificationAggregate;
  }

  static bool _isToolAggregate(CommercialSignalAggregate aggregate) {
    return aggregate is ToolDemandAggregate ||
        aggregate is ToolAdoptionAggregate ||
        aggregate is ToolOpportunityAggregate;
  }

  static bool _isServiceAggregate(CommercialSignalAggregate aggregate) {
    return aggregate is MarketingServiceAggregate ||
        aggregate is TechnicalServiceAggregate ||
        aggregate is VerificationServiceAggregate;
  }

  static bool _isEcosystemAggregate(CommercialSignalAggregate aggregate) {
    return aggregate is ExternalAppAggregate ||
        aggregate is ExternalKnowledgeAggregate ||
        aggregate is PartnerResourceAggregate;
  }
}
