class RegistrationResidentialFederationReport {
  const RegistrationResidentialFederationReport({
    required this.clientStatus,
    required this.residentialStatus,
    required this.registrationStatus,
    required this.parityStatus,
    required this.legacyContainmentStatus,
  });

  final String clientStatus;
  final String residentialStatus;
  final String registrationStatus;
  final String parityStatus;
  final String legacyContainmentStatus;
}
