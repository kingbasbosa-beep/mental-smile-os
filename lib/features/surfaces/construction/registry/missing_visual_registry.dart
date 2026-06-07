import '../models/missing_visual_models.dart';

class MissingVisualRegistry {
  const MissingVisualRegistry._();

  static const List<MissingVisualMarker> markers = <MissingVisualMarker>[
    MissingVisualMarker(
      markerId: 'client_guidance_missing_visual',
      surfaceId: 'client',
      cardId: 'client_guidance_card_s',
      reason: 'Guidance card needs a federation visual before UI construction.',
    ),
    MissingVisualMarker(
      markerId: 'monitoring_gap_missing_visual',
      surfaceId: 'monitoring',
      cardId: 'monitoring_commercial_card_s',
      reason: 'Commercial gap card needs visual identity alignment.',
    ),
    MissingVisualMarker(
      markerId: 'archive_sovereign_missing_visual',
      surfaceId: 'archive',
      cardId: 'archive_sovereign_card_s',
      reason: 'Sovereign archive card needs owner identity visual.',
    ),
  ];
}
