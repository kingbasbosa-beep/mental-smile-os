import '../models/provider_trust_summary.dart';

/// Future Trust Read Surface Contract.
///
/// No runtime implementation yet.
abstract class ProviderTrustSummaryContract {
  ProviderTrustSummary getSummaryForProvider(String providerId);
}
