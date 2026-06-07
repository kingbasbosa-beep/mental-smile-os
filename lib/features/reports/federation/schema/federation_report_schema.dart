import '../models/federation_report_header.dart';
import '../models/federation_report_metadata.dart';
import '../models/federation_report_sections.dart';

class FederationReportSchema {
  const FederationReportSchema({
    required this.header,
    required this.metadata,
    required this.executiveSummary,
    required this.signals,
    required this.aggregates,
    required this.trends,
    required this.risks,
    required this.opportunities,
    required this.recommendations,
    required this.humanAnalysis,
    required this.aiAnalysis,
    required this.constitutionalAlignment,
    required this.archiveCode,
    required this.retentionClass,
    required this.archiveEligibility,
    required this.reportVersion,
  });

  final FederationReportHeader header;
  final FederationReportMetadata metadata;
  final ExecutiveSummarySection executiveSummary;
  final SignalsSection signals;
  final AggregatesSection aggregates;
  final TrendsSection trends;
  final RisksSection risks;
  final OpportunitiesSection opportunities;
  final RecommendationsSection recommendations;
  final HumanAnalysisSection humanAnalysis;
  final AIAnalysisSection aiAnalysis;
  final ConstitutionalAlignmentSection constitutionalAlignment;
  final String archiveCode;
  final String retentionClass;
  final String archiveEligibility;
  final String reportVersion;
}
