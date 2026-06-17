import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/features/trust/domain/contracts/provider_trust_summary_contract.dart';
import '../../../../../lib/features/trust/domain/models/provider_trust_summary.dart';
import '../../../../../lib/features/trust/domain/providers/fake_provider_trust_summary_provider.dart';
import '../../fixtures/provider_trust_summary_fixtures.dart';

void main() {
  group('FakeProviderTrustSummaryProvider', () {
    test('returns the correct summary for an existing provider', () {
      final expected = ProviderTrustSummaryFixtures.expectedMixedSummary;
      final provider = FakeProviderTrustSummaryProvider(
        summaries: <String, ProviderTrustSummary>{
          expected.providerId: expected,
        },
      );

      final summary = provider.getSummaryForProvider(expected.providerId);

      expect(summary.providerId, expected.providerId);
      expect(summary.providerType, expected.providerType);
      expect(summary.averageRating, expected.averageRating);
      expect(summary.reviewCount, expected.reviewCount);
      expect(summary.totalStarCount, expected.totalStarCount);
      expect(summary.sourceVersion, expected.sourceVersion);
    });

    test('returns an empty summary for a missing provider', () {
      final provider = FakeProviderTrustSummaryProvider(
        summaries: const <String, ProviderTrustSummary>{},
      );

      final summary = provider.getSummaryForProvider('missing-provider');

      expect(summary.providerId, 'missing-provider');
      expect(summary.providerType, '');
      expect(summary.averageRating, 0);
      expect(summary.reviewCount, 0);
      expect(summary.hasReviews, isFalse);
      expect(summary.sourceVersion, 'fake-v1');
    });

    test('uses custom store data passed to the constructor', () {
      final customSummary = ProviderTrustSummaryFixtures.expectedMixedSummary
          .copyWith(providerId: 'custom-provider');
      final provider = FakeProviderTrustSummaryProvider(
        summaries: <String, ProviderTrustSummary>{
          'custom-provider': customSummary,
        },
      );

      final summary = provider.getSummaryForProvider('custom-provider');

      expect(summary.providerId, 'custom-provider');
      expect(summary.averageRating, customSummary.averageRating);
      expect(summary.reviewCount, customSummary.reviewCount);
    });

    test('default sample data works without crashing', () {
      final provider = FakeProviderTrustSummaryProvider();

      final clinicianSummary =
          provider.getSummaryForProvider('sample-clinician');
      final centerSummary = provider.getSummaryForProvider('sample-center');

      expect(clinicianSummary.providerId, 'sample-clinician');
      expect(clinicianSummary.hasReviews, isTrue);
      expect(centerSummary.providerId, 'sample-center');
      expect(centerSummary.hasReviews, isTrue);
    });

    test('implements ProviderTrustSummaryContract', () {
      final contract = FakeProviderTrustSummaryProvider();

      expect(contract, isA<ProviderTrustSummaryContract>());
      expect(contract.getSummaryForProvider('unknown'),
          isA<ProviderTrustSummary>());
    });
  });
}
