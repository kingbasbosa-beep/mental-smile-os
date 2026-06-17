import '../models/provider_trust_summary.dart';

/// Maps raw rating-like data into a Trust read surface model.
///
/// This mapper does not know about Firestore, routes, repositories, services, or
/// runtime projection flows.
class ProviderTrustSummaryMapper {
  const ProviderTrustSummaryMapper._();

  static ProviderTrustSummary fromRatings(
    List<Map<String, dynamic>> ratings, {
    required String providerId,
    required String providerType,
    String sourceVersion = 'ratings-list-v1',
  }) {
    var totalRating = 0.0;
    var reviewCount = 0;
    var fiveStarCount = 0;
    var fourStarCount = 0;
    var threeStarCount = 0;
    var twoStarCount = 0;
    var oneStarCount = 0;
    DateTime? lastReviewAt;

    for (final rating in ratings) {
      final score = _readRatingScore(rating);
      if (score == null) {
        continue;
      }

      reviewCount += 1;
      totalRating += score;

      switch (score.round().clamp(1, 5)) {
        case 5:
          fiveStarCount += 1;
        case 4:
          fourStarCount += 1;
        case 3:
          threeStarCount += 1;
        case 2:
          twoStarCount += 1;
        case 1:
          oneStarCount += 1;
      }

      final reviewDate = _readReviewDate(rating);
      if (reviewDate != null &&
          (lastReviewAt == null || reviewDate.isAfter(lastReviewAt))) {
        lastReviewAt = reviewDate;
      }
    }

    final averageRating = reviewCount == 0 ? 0.0 : totalRating / reviewCount;

    return ProviderTrustSummary(
      providerId: providerId,
      providerType: providerType,
      averageRating: averageRating,
      reviewCount: reviewCount,
      fiveStarCount: fiveStarCount,
      fourStarCount: fourStarCount,
      threeStarCount: threeStarCount,
      twoStarCount: twoStarCount,
      oneStarCount: oneStarCount,
      // TODO: Replace with a policy-backed trust score calculation.
      trustScore: averageRating,
      lastReviewAt: lastReviewAt,
      lastCalculatedAt: DateTime.now(),
      sourceVersion: sourceVersion,
    );
  }

  static double? _readRatingScore(Map<String, dynamic> rating) {
    final value = rating['rating'] ?? rating['score'] ?? rating['stars'];
    if (value is num) {
      final score = value.toDouble();
      if (score >= 1 && score <= 5) {
        return score;
      }
    }
    return null;
  }

  static DateTime? _readReviewDate(Map<String, dynamic> rating) {
    final value =
        rating['reviewDate'] ?? rating['createdAt'] ?? rating['lastReviewAt'];
    if (value is DateTime) {
      return value;
    }
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }
    return null;
  }
}
