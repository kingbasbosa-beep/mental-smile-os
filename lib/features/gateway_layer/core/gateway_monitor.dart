import 'package:flutterprojects/features/gateway_layer/core/gateway_alert_map.dart';
import 'package:flutterprojects/features/gateway_layer/core/gateway_health_service.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_health_level.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_registry.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_status.dart';

class GatewayMonitor {
  const GatewayMonitor({
    this.healthService = const GatewayHealthService(),
  });

  final GatewayHealthService healthService;

  List<GatewayStatus> familyStatuses() {
    return gatewayFamilyEntries.map((entry) {
      final level = healthService.evaluateLevel(entry.id);
      return GatewayStatus(
        key: entry.id,
        label: entry.title,
        level: level,
        summary: _summaryFor(entry.id, level),
        boundaryNote: _boundaryNoteFor(entry.id),
        monitoredNote: _monitoredNoteFor(entry.id),
        attentionLabel: _attentionLabelFor(level),
      );
    }).toList(growable: false);
  }

  GatewayStatus statusFor(String gatewayKey) {
    return familyStatuses().firstWhere(
      (status) => status.key == gatewayKey,
      orElse: () => GatewayStatus(
        key: gatewayKey,
        label: gatewayKey,
        level: healthService.evaluateLevel(gatewayKey),
        summary: 'Gateway shell is defined.',
        monitoredNote: 'Placeholder-only monitoring. No external checks are running.',
      ),
    );
  }

  int attentionCount() {
    return familyStatuses()
        .where((status) => status.level.name == 'attention')
        .length;
  }

  String alertTypeFor(String gatewayKey) {
    return gatewayAlertTypeMap[gatewayKey] ?? 'gateway boundary';
  }

  String _summaryFor(String gatewayKey, GatewayHealthLevel level) {
    switch (gatewayKey) {
      case 'communication':
        return switch (level.name) {
          'healthy' => 'Communication channels are supervised and stable.',
          'attention' =>
            'Some communication boundaries are mixed between ready and planned.',
          _ => 'Communication gateway remains shell-only for now.',
        };
      case 'engineering':
        return switch (level.name) {
          'healthy' => 'Engineering tools are fully represented and stable.',
          'attention' =>
            'Engineering supervision is partially represented and needs follow-up.',
          _ => 'Engineering gateway remains shell-only for now.',
        };
      case 'device_storage':
        return switch (level.name) {
          'healthy' =>
            'Devices and storage boundaries are represented cleanly.',
          'attention' =>
            'Primary hub is defined, while companion devices and storage stay planned.',
          _ => 'Device and storage gateway remains shell-only for now.',
        };
      default:
        return 'Gateway shell is defined.';
    }
  }

  String _boundaryNoteFor(String gatewayKey) {
    switch (gatewayKey) {
      case 'communication':
        return 'Channel intake and routing stay here. Human case handling stays under Communications.';
      case 'engineering':
        return 'Tool supervision stays here. Governance and business workflows stay elsewhere.';
      case 'device_storage':
        return 'Device, drive, backup, and sync boundaries stay here without affecting business pages.';
      default:
        return '';
    }
  }

  String _monitoredNoteFor(String gatewayKey) {
    switch (gatewayKey) {
      case 'communication':
        return 'Monitoring is placeholder-only. No channel connectors or inbox sync are active yet.';
      case 'engineering':
        return 'Monitoring is placeholder-only. No tooling actions, diagnostics polling, or repository checks are active yet.';
      case 'device_storage':
        return 'Monitoring is placeholder-only. No device probing, drive checks, or sync automation are active yet.';
      default:
        return 'Monitoring is placeholder-only.';
    }
  }

  String? _attentionLabelFor(GatewayHealthLevel level) {
    if (level == GatewayHealthLevel.attention) {
      return 'Needs supervised follow-up';
    }
    if (level == GatewayHealthLevel.planned) {
      return 'Planned boundary';
    }
    return null;
  }
}
