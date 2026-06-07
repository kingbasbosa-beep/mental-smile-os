import '../models/visual_asset_models.dart';

class VisualAssetRegistry {
  const VisualAssetRegistry._();

  static const String cardImage = 'card_image';
  static const String background = 'background';
  static const String banner = 'banner';
  static const String illustration = 'illustration';
  static const String icon = 'icon';
  static const String embeddedTextAsset = 'embedded_text_asset';

  static const Set<String> assetTypes = <String>{
    cardImage,
    background,
    banner,
    illustration,
    icon,
    embeddedTextAsset,
  };

  static const List<VisualAssetProfile> assets = <VisualAssetProfile>[
    VisualAssetProfile(
      assetId: 'client_signal_card_visual_s',
      assetType: cardImage,
      surfaceId: 'client',
      linkedFunction: 'ClientSignalsSummaryCardS',
      auditStatus: 'needs_federation_visual',
    ),
    VisualAssetProfile(
      assetId: 'monitoring_observatory_banner_s',
      assetType: banner,
      surfaceId: 'monitoring',
      linkedFunction: 'MonitoringObservatoryCardS',
      auditStatus: 'identity_ready',
    ),
    VisualAssetProfile(
      assetId: 'archive_sovereign_icon_s',
      assetType: icon,
      surfaceId: 'archive',
      linkedFunction: 'SovereignArchiveCardS',
      auditStatus: 'safe',
    ),
  ];
}
