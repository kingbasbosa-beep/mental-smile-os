import '../registry/metered_asset_registry.dart';
import '../registry/tool_meter_category_registry.dart';
import '../registry/tool_meter_signal_registry.dart';

class ToolMeterReadinessSnapshot {
  const ToolMeterReadinessSnapshot({
    required this.supportedAssets,
    required this.supportedSignals,
    required this.supportedCategories,
    required this.complianceStatus,
  });

  final Set<String> supportedAssets;
  final Set<String> supportedSignals;
  final Set<String> supportedCategories;
  final String complianceStatus;
}

class ToolMeterReadinessBuilder {
  const ToolMeterReadinessBuilder._();

  static ToolMeterReadinessSnapshot currentFoundationSnapshot() {
    return const ToolMeterReadinessSnapshot(
      supportedAssets: MeteredAssetRegistry.values,
      supportedSignals: ToolMeterSignalRegistry.values,
      supportedCategories: ToolMeterCategoryRegistry.values,
      complianceStatus: 'foundation_ready_no_meter_runtime',
    );
  }
}
