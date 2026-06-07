import '../guards/analysis_constitutional_guard.dart';
import '../models/analysis_observations.dart';
import '../registries/analysis_category_registry.dart';

class DualObservationValidator {
  const DualObservationValidator._();

  static bool canCreateFinalObservation({
    required AIObservation aiObservation,
    required HumanObservation humanObservation,
  }) {
    return failureReason(
          aiObservation: aiObservation,
          humanObservation: humanObservation,
        ) ==
        null;
  }

  static String? failureReason({
    required AIObservation aiObservation,
    required HumanObservation humanObservation,
  }) {
    if (!AnalysisCategoryRegistry.values.contains(aiObservation.category)) {
      return 'invalid_ai_observation_category';
    }
    if (!AnalysisCategoryRegistry.values.contains(humanObservation.category)) {
      return 'invalid_human_observation_category';
    }
    if (aiObservation.isEmpty) {
      return 'missing_ai_observation';
    }
    if (humanObservation.isEmpty) {
      return 'missing_human_observation';
    }
    if (aiObservation.sourceAggregate != humanObservation.sourceAggregate) {
      return 'source_aggregate_mismatch';
    }
    if (!AnalysisConstitutionalGuard.isAllowedText(
      aiObservation.observationText,
    )) {
      return 'invalid_ai_observation_text';
    }
    if (!AnalysisConstitutionalGuard.isAllowedText(
      humanObservation.observationText,
    )) {
      return 'invalid_human_observation_text';
    }
    return null;
  }

  static DualObservationCard? createFinalObservation({
    required AIObservation aiObservation,
    required HumanObservation humanObservation,
    DateTime? createdAt,
  }) {
    if (!canCreateFinalObservation(
      aiObservation: aiObservation,
      humanObservation: humanObservation,
    )) {
      return null;
    }
    final timestamp = (createdAt ?? DateTime.now()).toUtc();
    return DualObservationCard(
      cardId: 'dual_${aiObservation.observationId}_${timestamp.microsecondsSinceEpoch}',
      category: aiObservation.category,
      sourceAggregate: aiObservation.sourceAggregate,
      aiObservation: aiObservation,
      humanObservation: humanObservation,
      createdAt: timestamp,
    );
  }
}
