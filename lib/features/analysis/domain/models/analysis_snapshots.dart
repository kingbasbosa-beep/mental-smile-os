import 'analysis_observations.dart';

class ResidentialAnalysisSnapshot {
  const ResidentialAnalysisSnapshot({
    required this.observationDrafts,
    required this.createdAt,
  });

  final List<ObservationDraft> observationDrafts;
  final DateTime createdAt;
}

class CommercialAnalysisSnapshot {
  const CommercialAnalysisSnapshot({
    required this.observationDrafts,
    required this.createdAt,
  });

  final List<ObservationDraft> observationDrafts;
  final DateTime createdAt;
}

class FederationAnalysisSnapshot {
  const FederationAnalysisSnapshot({
    required this.residentialSnapshot,
    required this.commercialSnapshot,
    required this.createdAt,
  });

  final ResidentialAnalysisSnapshot residentialSnapshot;
  final CommercialAnalysisSnapshot commercialSnapshot;
  final DateTime createdAt;
}
