import '../contracts/provider_trust_summary_contract.dart';
import '../models/provider_trust_summary.dart';

/// Fake in-memory implementation for Trust Foundation testing and design
/// validation only.
class FakeProviderTrustSummaryProvider implements ProviderTrustSummaryContract {
  FakeProviderTrustSummaryProvider({
    Map<String, ProviderTrustSummary>? summaries,
  }) : _summaries = summaries ?? _sampleSummaries;

  final Map<String, ProviderTrustSummary> _summaries;

  static final Map<String, ProviderTrustSummary> _sampleSummaries =
      <String, ProviderTrustSummary>{
    'sample-clinician': ProviderTrustSummary(
      providerId: 'sample-clinician',
      providerType: 'clinician',
      averageRating: 4.6,
      reviewCount: 12,
      fiveStarCount: 8,
      fourStarCount: 3,
      threeStarCount: 1,
      twoStarCount: 0,
      oneStarCount: 0,
      trustScore: 4.6,
      lastReviewAt: DateTime.utc(2026, 1, 15),
      lastCalculatedAt: DateTime.utc(2026, 1, 16),
      sourceVersion: 'fake-v1',
    ),
    'sample-center': ProviderTrustSummary(
      providerId: 'sample-center',
      providerType: 'center',
      averageRating: 4.2,
      reviewCount: 5,
      fiveStarCount: 2,
      fourStarCount: 2,
      threeStarCount: 1,
      twoStarCount: 0,
      oneStarCount: 0,
      trustScore: 4.2,
      lastReviewAt: DateTime.utc(2026, 1, 10),
      lastCalculatedAt: DateTime.utc(2026, 1, 11),
      sourceVersion: 'fake-v1',
    ),
  };

  @override
  ProviderTrustSummary getSummaryForProvider(String providerId) {
    return _summaries[providerId] ??
        ProviderTrustSummary.empty(
          providerId: providerId,
          sourceVersion: 'fake-v1',
        );
  }
}
