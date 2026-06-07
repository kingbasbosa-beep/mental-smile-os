class LocalizedText {
  const LocalizedText({
    required this.ar,
    required this.en,
  });

  final String ar;
  final String en;
}

class FederationReportItem {
  const FederationReportItem({
    required this.itemId,
    required this.title,
    required this.summary,
    this.value,
  });

  final String itemId;
  final LocalizedText title;
  final LocalizedText summary;
  final String? value;
}

class ExecutiveSummarySection {
  const ExecutiveSummarySection({
    required this.title,
    required this.items,
  });

  final LocalizedText title;
  final List<FederationReportItem> items;
}

class SignalsSection {
  const SignalsSection({
    required this.title,
    required this.items,
  });

  final LocalizedText title;
  final List<FederationReportItem> items;
}

class AggregatesSection {
  const AggregatesSection({
    required this.title,
    required this.items,
  });

  final LocalizedText title;
  final List<FederationReportItem> items;
}

class TrendsSection {
  const TrendsSection({
    required this.title,
    required this.items,
  });

  final LocalizedText title;
  final List<FederationReportItem> items;
}

class RisksSection {
  const RisksSection({
    required this.title,
    required this.items,
  });

  final LocalizedText title;
  final List<FederationReportItem> items;
}

class OpportunitiesSection {
  const OpportunitiesSection({
    required this.title,
    required this.items,
  });

  final LocalizedText title;
  final List<FederationReportItem> items;
}

class RecommendationsSection {
  const RecommendationsSection({
    required this.title,
    required this.items,
  });

  final LocalizedText title;
  final List<FederationReportItem> items;
}

class HumanAnalysisSection {
  const HumanAnalysisSection({
    required this.title,
    required this.items,
  });

  final LocalizedText title;
  final List<FederationReportItem> items;
}

class AIAnalysisSection {
  const AIAnalysisSection({
    required this.title,
    required this.items,
  });

  final LocalizedText title;
  final List<FederationReportItem> items;
}

class ConstitutionalAlignmentSection {
  const ConstitutionalAlignmentSection({
    required this.title,
    required this.items,
  });

  final LocalizedText title;
  final List<FederationReportItem> items;
}
