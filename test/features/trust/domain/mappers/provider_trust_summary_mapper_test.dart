import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/features/trust/domain/mappers/provider_trust_summary_mapper.dart';
import '../../fixtures/provider_trust_summary_fixtures.dart';

void main() {
  group('ProviderTrustSummaryMapper.fromRatings', () {
    test('empty list returns empty summary values', () {
      final summary = ProviderTrustSummaryMapper.fromRatings(
        ProviderTrustSummaryFixtures.rawRatingsEmpty,
        providerId: ProviderTrustSummaryFixtures.providerId,
        providerType: ProviderTrustSummaryFixtures.providerType,
      );

      expect(summary.providerId, ProviderTrustSummaryFixtures.providerId);
      expect(summary.providerType, ProviderTrustSummaryFixtures.providerType);
      expect(summary.averageRating, 0);
      expect(summary.reviewCount, 0);
      expect(summary.totalStarCount, 0);
      expect(summary.hasReviews, isFalse);
      expect(summary.displayAverage, '-');
      expect(summary.trustScore, summary.averageRating);
    });

    test('single rating calculates average and counts correctly', () {
      final summary = ProviderTrustSummaryMapper.fromRatings(
        ProviderTrustSummaryFixtures.rawRatingsSingleFiveStar,
        providerId: ProviderTrustSummaryFixtures.providerId,
        providerType: ProviderTrustSummaryFixtures.providerType,
      );

      expect(summary.averageRating, 5);
      expect(summary.reviewCount, 1);
      expect(summary.fiveStarCount, 1);
      expect(summary.fourStarCount, 0);
      expect(summary.threeStarCount, 0);
      expect(summary.twoStarCount, 0);
      expect(summary.oneStarCount, 0);
      expect(summary.totalStarCount, 1);
      expect(summary.hasReviews, isTrue);
      expect(summary.displayAverage, '5.0');
    });

    test('multiple ratings calculate average and star distribution', () {
      final summary = ProviderTrustSummaryMapper.fromRatings(
        ProviderTrustSummaryFixtures.rawRatingsMixedValid,
        providerId: ProviderTrustSummaryFixtures.providerId,
        providerType: ProviderTrustSummaryFixtures.providerType,
        sourceVersion: ProviderTrustSummaryFixtures.sourceVersion,
      );

      final expected = ProviderTrustSummaryFixtures.expectedMixedSummary;
      expect(summary.averageRating, expected.averageRating);
      expect(summary.reviewCount, expected.reviewCount);
      expect(summary.fiveStarCount, expected.fiveStarCount);
      expect(summary.fourStarCount, expected.fourStarCount);
      expect(summary.threeStarCount, expected.threeStarCount);
      expect(summary.twoStarCount, expected.twoStarCount);
      expect(summary.oneStarCount, expected.oneStarCount);
      expect(summary.sourceVersion, expected.sourceVersion);
      expect(summary.totalStarCount, summary.reviewCount);
    });

    test('invalid rating values are ignored safely', () {
      final summary = ProviderTrustSummaryMapper.fromRatings(
        ProviderTrustSummaryFixtures.rawRatingsWithInvalidValues,
        providerId: ProviderTrustSummaryFixtures.providerId,
        providerType: ProviderTrustSummaryFixtures.providerType,
      );

      expect(summary.averageRating, 4);
      expect(summary.reviewCount, 1);
      expect(summary.fourStarCount, 1);
      expect(summary.totalStarCount, 1);
      expect(summary.hasReviews, isTrue);
    });

    test('decimal ratings are counted and string ratings are ignored', () {
      final summary = ProviderTrustSummaryMapper.fromRatings(
        ProviderTrustSummaryFixtures.rawRatingsWithStringAndDecimalValues,
        providerId: ProviderTrustSummaryFixtures.providerId,
        providerType: ProviderTrustSummaryFixtures.providerType,
      );

      expect(summary.averageRating, 4.5);
      expect(summary.reviewCount, 1);
      expect(summary.fiveStarCount, 1);
      expect(summary.totalStarCount, 1);
    });

    test('trustScore currently equals averageRating', () {
      final summary = ProviderTrustSummaryMapper.fromRatings(
        ProviderTrustSummaryFixtures.rawRatingsMixedValid,
        providerId: ProviderTrustSummaryFixtures.providerId,
        providerType: ProviderTrustSummaryFixtures.providerType,
      );

      expect(summary.averageRating, 3);
      expect(summary.trustScore, summary.averageRating);
    });

    test('lastReviewAt uses the latest supported review date', () {
      final summary = ProviderTrustSummaryMapper.fromRatings(
        ProviderTrustSummaryFixtures.rawRatingsMixedValid,
        providerId: ProviderTrustSummaryFixtures.providerId,
        providerType: ProviderTrustSummaryFixtures.providerType,
      );

      expect(summary.lastReviewAt, DateTime.parse('2026-01-05T10:00:00Z'));
    });
  });
}
