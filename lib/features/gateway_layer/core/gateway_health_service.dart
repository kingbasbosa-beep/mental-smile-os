import 'package:flutterprojects/features/gateway_layer/shared/gateway_entry.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_health_level.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_registry.dart';

class GatewayHealthService {
  const GatewayHealthService();

  GatewayHealthLevel evaluateLevel(String gatewayKey) {
    switch (gatewayKey) {
      case 'communication':
        return _combineEntryLevels(communicationGatewayEntries);
      case 'engineering':
        return _combineEntryLevels(engineeringGatewayEntries);
      case 'device_storage':
        return _combineEntryLevels(deviceStorageGatewayEntries);
      default:
        return GatewayHealthLevel.planned;
    }
  }

  GatewayHealthLevel _combineEntryLevels(List<GatewayEntry> entries) {
    if (entries.isEmpty) return GatewayHealthLevel.planned;

    final hasAttention = entries.any(
      (entry) => entry.status.level == GatewayHealthLevel.attention,
    );
    if (hasAttention) return GatewayHealthLevel.attention;

    final allHealthy = entries.every(
      (entry) => entry.status.level == GatewayHealthLevel.healthy,
    );
    if (allHealthy) return GatewayHealthLevel.healthy;

    final hasHealthy = entries.any(
      (entry) => entry.status.level == GatewayHealthLevel.healthy,
    );
    if (hasHealthy) return GatewayHealthLevel.attention;

    return GatewayHealthLevel.planned;
  }
}
