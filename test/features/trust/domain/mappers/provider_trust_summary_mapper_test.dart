import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/features/trust/domain/mappers/provider_trust_summary_mapper.dart';

void main() {
  group('ProviderTrustSummaryMapper.fromRatings', () {
    test('empty list returns empty summary values', () {
      final summary = ProviderTrustSummaryMapper.fromRatings(
        const <Map<String, dynamic>>[],
        providerId: 'provider-1',
        providerType: 'clinician',
      );

      expect(summary.providerId, 'provider-1');
      expect(summary.providerType, 'clinician');
      expect(summary.averageRating, 0);
      expect(summary.reviewCount, 0);
      expect(summary.totalStarCount, 0);
      expect(summary.hasReviews, isFalse);
      expect(summary.displayAverage, '-');
      expect(summary.trustScore, summary.averageRating);
    });

    test('single rating calculates average and counts correctly', () {
      final summary = ProviderTrustSummaryMapper.fromRatings(
        <Map<String, dynamic>>[
          <String, dynamic>{'rating': 5, 'createdAt': '2026-01-01T10:00:00Z'},
        ],
        providerId: 'provider-1',
        providerType: 'clinician',
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
        <Map<String, dynamic>>[
          <String, dynamic>{'rating': 5},
          <String, dynamic>{'score': 4},
          <String, dynamic>{'stars': 3},
          <String, dynamic>{'rating': 2},
          <String, dynamic>{'rating': 1},
        ],
        providerId: 'provider-1',
        providerType: 'clinician',
      );

      expect(summary.averageRating, 3);
      expect(summary.reviewCount, 5);
      expect(summary.fiveStarCount, 1);
      expect(summary.fourStarCount, 1);
      expect(summary.threeStarCount, 1);
      expect(summary.twoStarCount, 1);
      expect(summary.oneStarCount, 1);
      expect(summary.totalStarCount, summary.reviewCount);
    });

    test('invalid rating values are ignored safely', () {
      final summary = ProviderTrustSummaryMapper.fromRatings(
        <Map<String, dynamic>>[
          <String, dynamic>{'rating': 0},
          <String, dynamic>{'rating': 6},
          <String, dynamic>{'rating': null},
          <String, dynamic>{'rating': '5'},
          <String, dynamic>{'rating': true},
          <String, dynamic>{'rating': 4},
        ],
        providerId: 'provider-1',
        providerType: 'clinician',
      );

      expect(summary.averageRating, 4);
      expect(summary.reviewCount, 1);
      expect(summary.fourStarCount, 1);
      expect(summary.totalStarCount, 1);
      expect(summary.hasReviews, isTrue);
    });

    test('decimal ratings are counted and string ratings are ignored', () {
      final summary = ProviderTrustSummaryMapper.fromRatings(
        <Map<String, dynamic>>[
          <String, dynamic>{'rating': 4.5},
          <String, dynamic>{'rating': '3'},
        ],
        providerId: 'provider-1',
        providerType: 'clinician',
      );

      expect(summary.averageRating, 4.5);
      expect(summary.reviewCount, 1);
      expect(summary.fiveStarCount, 1);
      expect(summary.totalStarCount, 1);
    });

    test('trustScore currently equals averageRating', () {
      final summary = ProviderTrustSummaryMapper.fromRatings(
        <Map<String, dynamic>>[
          <String, dynamic>{'rating': 4},
          <String, dynamic>{'rating': 2},
        ],
        providerId: 'provider-1',
        providerType: 'clinician',
      );

      expect(summary.averageRating, 3);
      expect(summary.trustScore, summary.averageRating);
    });

    test('lastReviewAt uses the latest supported review date', () {
      final summary = ProviderTrustSummaryMapper.fromRatings(
        <Map<String, dynamic>>[
          <String, dynamic>{
            'rating': 4,
            'createdAt': '2026-01-01T10:00:00Z',
          },
          <String, dynamic>{
            'rating': 5,
            'reviewDate': DateTime.utc(2026, 1, 2),
          },
        ],
        providerId: 'provider-1',
        providerType: 'clinician',
      );

      expect(summary.lastReviewAt, DateTime.utc(2026, 1, 2));
    });
  });
}
