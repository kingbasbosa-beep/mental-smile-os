import '../models/client_federation_profile.dart';
import '../models/registration_alignment_models.dart';
import '../reports/registration_residential_federation_report.dart';

abstract class ClientFederationProfileBuilder {
  ClientFederationProfile buildClientProfile();
}

abstract class RegistrationAlignmentBuilder {
  RegistrationAlignmentProfile buildRegistrationAlignment();
}

abstract class RegistrationResidentialReportBuilder {
  RegistrationResidentialFederationReport buildReport();
}
