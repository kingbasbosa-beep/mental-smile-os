import 'package:flutterprojects/features/gateway_layer/shared/gateway_status.dart';

class GatewayEntry {
  const GatewayEntry({
    required this.id,
    required this.title,
    required this.boundary,
    required this.status,
  });

  final String id;
  final String title;
  final String boundary;
  final GatewayStatus status;
}

class GatewayFamilyEntry {
  const GatewayFamilyEntry({
    required this.id,
    required this.title,
    required this.description,
    required this.route,
    required this.status,
  });

  final String id;
  final String title;
  final String description;
  final String route;
  final GatewayStatus status;
}
