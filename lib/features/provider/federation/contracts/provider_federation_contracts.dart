import '../models/provider_federation_profile.dart';
import '../models/provider_readiness_profile.dart';
import '../reports/provider_center_federation_report.dart';

abstract class ProviderFederationProfileBuilder {
  ProviderFederationProfile buildProviderProfile();
}

abstract class ProviderReadinessProfileBuilder {
  ProviderReadinessProfile buildProviderReadiness();
}

abstract class ProviderCenterFederationReportBuilder {
  ProviderCenterFederationReport buildReport();
}
