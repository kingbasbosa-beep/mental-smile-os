/// Trust-owned read surface model.
///
/// This is not a Firestore collection, projection implementation, or migration
/// target. It only describes the shape consumers may read in the future.
class ProviderTrustSummary {
  const ProviderTrustSummary({
    required this.providerId,
    required this.providerType,
    required this.averageRating,
    required this.reviewCount,
    required this.fiveStarCount,
    required this.fourStarCount,
    required this.threeStarCount,
    required this.twoStarCount,
    required this.oneStarCount,
    required this.trustScore,
    required this.lastReviewAt,
    required this.lastCalculatedAt,
    required this.sourceVersion,
  });

  final String providerId;
  final String providerType;
  final double averageRating;
  final int reviewCount;
  final int fiveStarCount;
  final int fourStarCount;
  final int threeStarCount;
  final int twoStarCount;
  final int oneStarCount;
  final double trustScore;
  final DateTime? lastReviewAt;
  final DateTime? lastCalculatedAt;
  final String sourceVersion;

  factory ProviderTrustSummary.empty({
    String providerId = '',
    String providerType = '',
    String sourceVersion = 'unversioned',
  }) {
    return ProviderTrustSummary(
      providerId: providerId,
      providerType: providerType,
      averageRating: 0,
      reviewCount: 0,
      fiveStarCount: 0,
      fourStarCount: 0,
      threeStarCount: 0,
      twoStarCount: 0,
      oneStarCount: 0,
      trustScore: 0,
      lastReviewAt: null,
      lastCalculatedAt: null,
      sourceVersion: sourceVersion,
    );
  }

  bool get hasReviews => reviewCount > 0;

  String get displayAverage =>
      hasReviews ? averageRating.toStringAsFixed(1) : '-';

  int get totalStarCount {
    return fiveStarCount +
        fourStarCount +
        threeStarCount +
        twoStarCount +
        oneStarCount;
  }

  ProviderTrustSummary copyWith({
    String? providerId,
    String? providerType,
    double? averageRating,
    int? reviewCount,
    int? fiveStarCount,
    int? fourStarCount,
    int? threeStarCount,
    int? twoStarCount,
    int? oneStarCount,
    double? trustScore,
    DateTime? lastReviewAt,
    DateTime? lastCalculatedAt,
    String? sourceVersion,
    bool clearLastReviewAt = false,
    bool clearLastCalculatedAt = false,
  }) {
    return ProviderTrustSummary(
      providerId: providerId ?? this.providerId,
      providerType: providerType ?? this.providerType,
      averageRating: averageRating ?? this.averageRating,
      reviewCount: reviewCount ?? this.reviewCount,
      fiveStarCount: fiveStarCount ?? this.fiveStarCount,
      fourStarCount: fourStarCount ?? this.fourStarCount,
      threeStarCount: threeStarCount ?? this.threeStarCount,
      twoStarCount: twoStarCount ?? this.twoStarCount,
      oneStarCount: oneStarCount ?? this.oneStarCount,
      trustScore: trustScore ?? this.trustScore,
      lastReviewAt:
          clearLastReviewAt ? null : lastReviewAt ?? this.lastReviewAt,
      lastCalculatedAt: clearLastCalculatedAt
          ? null
          : lastCalculatedAt ?? this.lastCalculatedAt,
      sourceVersion: sourceVersion ?? this.sourceVersion,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'providerId': providerId,
      'providerType': providerType,
      'averageRating': averageRating,
      'reviewCount': reviewCount,
      'fiveStarCount': fiveStarCount,
      'fourStarCount': fourStarCount,
      'threeStarCount': threeStarCount,
      'twoStarCount': twoStarCount,
      'oneStarCount': oneStarCount,
      'trustScore': trustScore,
      'lastReviewAt': lastReviewAt?.toIso8601String(),
      'lastCalculatedAt': lastCalculatedAt?.toIso8601String(),
      'sourceVersion': sourceVersion,
    };
  }

  factory ProviderTrustSummary.fromMap(Map<String, dynamic> map) {
    return ProviderTrustSummary(
      providerId: map['providerId'] as String? ?? '',
      providerType: map['providerType'] as String? ?? '',
      averageRating: _readDouble(map['averageRating']),
      reviewCount: _readInt(map['reviewCount']),
      fiveStarCount: _readInt(map['fiveStarCount']),
      fourStarCount: _readInt(map['fourStarCount']),
      threeStarCount: _readInt(map['threeStarCount']),
      twoStarCount: _readInt(map['twoStarCount']),
      oneStarCount: _readInt(map['oneStarCount']),
      trustScore: _readDouble(map['trustScore']),
      lastReviewAt: _readDateTime(map['lastReviewAt']),
      lastCalculatedAt: _readDateTime(map['lastCalculatedAt']),
      sourceVersion: map['sourceVersion'] as String? ?? 'unversioned',
    );
  }

  static int _readInt(Object? value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return 0;
  }

  static double _readDouble(Object? value) {
    if (value is double) {
      return value;
    }
    if (value is num) {
      return value.toDouble();
    }
    return 0;
  }

  static DateTime? _readDateTime(Object? value) {
    if (value is DateTime) {
      return value;
    }
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }
    return null;
  }
}
