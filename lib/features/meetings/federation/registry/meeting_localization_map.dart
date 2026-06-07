import '../models/meeting_localization_label.dart';

class MeetingLocalizationMap {
  const MeetingLocalizationMap._();

  static const String agenda = 'agenda';
  static const String review = 'review';
  static const String summary = 'summary';
  static const String risks = 'risks';
  static const String opportunities = 'opportunities';
  static const String recommendations = 'recommendations';
  static const String followUp = 'follow_up';
  static const String decisionNotes = 'decision_notes';

  static const List<MeetingLocalizationLabel> labels =
      <MeetingLocalizationLabel>[
    MeetingLocalizationLabel(
      key: agenda,
      labelAr: 'جدول المراجعة',
      labelEn: 'Agenda',
    ),
    MeetingLocalizationLabel(
      key: review,
      labelAr: 'مراجعة',
      labelEn: 'Review',
    ),
    MeetingLocalizationLabel(
      key: summary,
      labelAr: 'ملخص',
      labelEn: 'Summary',
    ),
    MeetingLocalizationLabel(
      key: risks,
      labelAr: 'مخاطر',
      labelEn: 'Risks',
    ),
    MeetingLocalizationLabel(
      key: opportunities,
      labelAr: 'فرص',
      labelEn: 'Opportunities',
    ),
    MeetingLocalizationLabel(
      key: recommendations,
      labelAr: 'توصيات',
      labelEn: 'Recommendations',
    ),
    MeetingLocalizationLabel(
      key: followUp,
      labelAr: 'متابعة',
      labelEn: 'Follow Up',
    ),
    MeetingLocalizationLabel(
      key: decisionNotes,
      labelAr: 'ملاحظات القرار',
      labelEn: 'Decision Notes',
    ),
  ];

  static MeetingLocalizationLabel? byKey(String key) {
    final normalized = key.trim();
    for (final label in labels) {
      if (label.key == normalized) return label;
    }
    return null;
  }
}
