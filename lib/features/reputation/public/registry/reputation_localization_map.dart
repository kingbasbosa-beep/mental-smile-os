import '../models/reputation_localization_label.dart';

class ReputationLocalizationMap {
  const ReputationLocalizationMap._();

  static const String ratings = 'ratings';
  static const String comments = 'comments';
  static const String showComments = 'show_comments';
  static const String hideComments = 'hide_comments';
  static const String showMore = 'show_more';
  static const String publicRating = 'public_rating';

  static const List<ReputationLocalizationLabel> labels =
      <ReputationLocalizationLabel>[
    ReputationLocalizationLabel(
      key: ratings,
      labelAr: 'التقييمات',
      labelEn: 'Ratings',
    ),
    ReputationLocalizationLabel(
      key: comments,
      labelAr: 'التعليقات',
      labelEn: 'Comments',
    ),
    ReputationLocalizationLabel(
      key: showComments,
      labelAr: 'عرض التعليقات',
      labelEn: 'Show comments',
    ),
    ReputationLocalizationLabel(
      key: hideComments,
      labelAr: 'إخفاء التعليقات',
      labelEn: 'Hide comments',
    ),
    ReputationLocalizationLabel(
      key: showMore,
      labelAr: 'عرض المزيد',
      labelEn: 'Show more',
    ),
    ReputationLocalizationLabel(
      key: publicRating,
      labelAr: 'التقييم العام',
      labelEn: 'Public rating',
    ),
  ];

  static ReputationLocalizationLabel? byKey(String key) {
    final normalized = key.trim();
    for (final label in labels) {
      if (label.key == normalized) return label;
    }
    return null;
  }
}
