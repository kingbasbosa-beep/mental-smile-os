import 'package:flutterprojects/features/gateway_layer/shared/gateway_health_level.dart';

class GatewayStatus {
  const GatewayStatus({
    this.key,
    this.label,
    required this.level,
    required this.summary,
    this.note,
  });

  final String? key;
  final String? label;
  final GatewayHealthLevel level;
  final String summary;
  final String? note;
}
