class ClientVisibilityProfile {
  const ClientVisibilityProfile({
    required this.clientId,
    required this.privateFields,
    required this.dashboardFields,
    required this.signalFields,
    required this.notes,
  });

  final String clientId;
  final Set<String> privateFields;
  final Set<String> dashboardFields;
  final Set<String> signalFields;
  final String notes;
}
