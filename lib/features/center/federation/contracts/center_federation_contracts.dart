import '../models/center_federation_profile.dart';
import '../models/center_readiness_profile.dart';

abstract class CenterFederationProfileBuilder {
  CenterFederationProfile buildCenterProfile();
}

abstract class CenterReadinessProfileBuilder {
  CenterReadinessProfile buildCenterReadiness();
}
