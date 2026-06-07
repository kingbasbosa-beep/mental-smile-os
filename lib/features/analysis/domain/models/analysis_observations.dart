class AIObservation {
  const AIObservation({
    required this.observationId,
    required this.category,
    required this.sourceAggregate,
    required this.observationText,
    required this.confidenceLevel,
    required this.createdAt,
  });

  final String observationId;
  final String category;
  final String sourceAggregate;
  final String observationText;
  final String confidenceLevel;
  final DateTime createdAt;

  bool get isEmpty => observationText.trim().isEmpty;
}

class HumanObservation {
  const HumanObservation({
    required this.observationId,
    required this.category,
    required this.sourceAggregate,
    required this.observationText,
    required this.createdAt,
  });

  final String observationId;
  final String category;
  final String sourceAggregate;
  final String observationText;
  final DateTime createdAt;

  bool get isEmpty => observationText.trim().isEmpty;
}

class DualObservationCard {
  const DualObservationCard({
    required this.cardId,
    required this.category,
    required this.sourceAggregate,
    required this.aiObservation,
    required this.humanObservation,
    required this.createdAt,
  });

  final String cardId;
  final String category;
  final String sourceAggregate;
  final AIObservation aiObservation;
  final HumanObservation humanObservation;
  final DateTime createdAt;
}

class ObservationDraft {
  const ObservationDraft({
    required this.category,
    required this.sourceAggregate,
    required this.aiObservation,
    required this.humanObservation,
  });

  final String category;
  final String sourceAggregate;
  final AIObservation aiObservation;
  final HumanObservation? humanObservation;

  bool get needsHumanObservation {
    return humanObservation == null || humanObservation!.isEmpty;
  }
}
