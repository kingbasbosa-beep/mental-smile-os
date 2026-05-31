import '../../../../lib/features/trust/domain/models/provider_trust_summary.dart';

/// Test-only fixtures for Trust read surface model and mapper tests.
///
/// These values are plain Dart data. They do not represent Firestore documents,
/// collection names, or runtime projection behavior.
class ProviderTrustSummaryFixtures {
  const ProviderTrustSummaryFixtures._();

  static const String providerId = 'provider-1';
  static const String providerType = 'clinician';
  static const String sourceVersion = 'fixture-v1';

  static const List<Map<String, dynamic>> rawRatingsEmpty =
      <Map<String, dynamic>>[];

  static final List<Map<String, dynamic>> rawRatingsSingleFiveStar =
      <Map<String, dynamic>>[
    <String, dynamic>{
      'rating': 5,
      'createdAt': '2026-01-01T10:00:00Z',
    },
  ];

  static final List<Map<String, dynamic>> rawRatingsMixedValid =
      <Map<String, dynamic>>[
    <String, dynamic>{'rating': 5, 'createdAt': '2026-01-01T10:00:00Z'},
    <String, dynamic>{'score': 4, 'createdAt': '2026-01-02T10:00:00Z'},
    <String, dynamic>{'stars': 3, 'createdAt': '2026-01-03T10:00:00Z'},
    <String, dynamic>{'rating': 2, 'createdAt': '2026-01-04T10:00:00Z'},
    <String, dynamic>{'rating': 1, 'createdAt': '2026-01-05T10:00:00Z'},
  ];

  static final List<Map<String, dynamic>> rawRatingsWithInvalidValues =
      <Map<String, dynamic>>[
    <String, dynamic>{'rating': 0},
    <String, dynamic>{'rating': 6},
    <String, dynamic>{'rating': null},
    <String, dynamic>{'rating': true},
    <String, dynamic>{'rating': 4},
  ];

  static final List<Map<String, dynamic>> rawRatingsWithStringAndDecimalValues =
      <Map<String, dynamic>>[
    <String, dynamic>{'rating': '3'},
    <String, dynamic>{'rating': 4.5},
  ];

  static ProviderTrustSummary get expectedEmptySummary {
    return ProviderTrustSummary.empty(
      providerId: providerId,
      providerType: providerType,
      sourceVersion: sourceVersion,
    );
  }

  static ProviderTrustSummary get expectedMixedSummary {
    return ProviderTrustSummary(
      providerId: providerId,
      providerType: providerType,
      averageRating: 3,
      reviewCount: 5,
      fiveStarCount: 1,
      fourStarCount: 1,
      threeStarCount: 1,
      twoStarCount: 1,
      oneStarCount: 1,
      trustScore: 3,
      lastReviewAt: DateTime.parse('2026-01-05T10:00:00Z'),
      lastCalculatedAt: null,
      sourceVersion: sourceVersion,
    );
  }
}
