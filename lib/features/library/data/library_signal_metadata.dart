// [S] Signal Native Asset
// Library signal metadata for resource discovery.
class LibrarySignalMetadata {
  const LibrarySignalMetadata({
    this.audienceSignals = const <String>[],
    this.formatSignals = const <String>[],
    this.accessibilitySignals = const <String>[],
    this.topicSignals = const <String>[],
    this.difficultySignals = const <String>[],
  });

  final List<String> audienceSignals;
  final List<String> formatSignals;
  final List<String> accessibilitySignals;
  final List<String> topicSignals;
  final List<String> difficultySignals;

  List<String> get displaySignalKeys => <String>[
        ...topicSignals.take(1),
        ...audienceSignals.take(1),
        ...formatSignals.take(1),
        ...accessibilitySignals.take(1),
      ].take(3).toList(growable: false);

  Map<String, dynamic> toMap() => <String, dynamic>{
        'audienceSignals': audienceSignals,
        'formatSignals': formatSignals,
        'accessibilitySignals': accessibilitySignals,
        'topicSignals': topicSignals,
        'difficultySignals': difficultySignals,
      };
}

class LibrarySignalLabels {
  static const Map<String, String> ar = <String, String>{
    'general_public': 'عام',
    'family': 'مناسب للأسرة',
    'children': 'مناسب للأطفال',
    'recovery': 'تعافي',
    'caregivers': 'مناسب لمقدمي الرعاية',
    'providers': 'للمختصين',
    'centers': 'للمراكز',
    'text': 'نصي',
    'audio': 'صوتي',
    'video': 'فيديو',
    'exercise': 'تمرين',
    'tool': 'أداة',
    'visual_guide': 'دليل مرئي',
    'checklist': 'قائمة تحقق',
    'captioned': 'يدعم الشرح النصي',
    'text_based': 'يدعم القراءة',
    'audio_friendly': 'مناسب صوتيًا',
    'visual_support': 'دعم بصري',
    'simplified_content': 'محتوى مبسط',
    'child_friendly': 'مناسب للأطفال',
    'low_stimulation': 'هادئ بصريًا',
    'addiction': 'إدمان',
    'family_support': 'إرشاد أسري',
    'prevention': 'وقاية',
    'mental_health': 'صحة نفسية',
    'children_support': 'دعم الأطفال',
    'special_needs': 'احتياجات خاصة',
    'communication': 'تواصل',
    'self_development': 'تطوير ذاتي',
    'basic': 'أساسي',
    'easy': 'سهل',
    'moderate': 'متوسط',
    'sensitive': 'حساس',
    'professional': 'مهني',
  };

  static const Map<String, String> en = <String, String>{
    'general_public': 'General',
    'family': 'Family',
    'children': 'Children',
    'recovery': 'Recovery',
    'caregivers': 'Caregivers',
    'providers': 'Providers',
    'centers': 'Centers',
    'text': 'Text',
    'audio': 'Audio',
    'video': 'Video',
    'exercise': 'Exercise',
    'tool': 'Tool',
    'visual_guide': 'Visual guide',
    'checklist': 'Checklist',
    'captioned': 'Captioned',
    'text_based': 'Text based',
    'audio_friendly': 'Audio friendly',
    'visual_support': 'Visual support',
    'simplified_content': 'Simplified',
    'child_friendly': 'Child friendly',
    'low_stimulation': 'Low stimulation',
    'addiction': 'Addiction',
    'family_support': 'Family support',
    'prevention': 'Prevention',
    'mental_health': 'Mental health',
    'children_support': 'Children support',
    'special_needs': 'Special needs',
    'communication': 'Communication',
    'self_development': 'Self development',
    'basic': 'Basic',
    'easy': 'Easy',
    'moderate': 'Moderate',
    'sensitive': 'Sensitive',
    'professional': 'Professional',
  };

  static String label(String key, {required bool isArabic}) {
    return (isArabic ? ar : en)[key] ?? key;
  }
}

class LibrarySignalCatalog {
  static const String schemaVersion = 'library_labels_v1';

  static const Map<String, LibrarySignalMetadata> categories =
      <String, LibrarySignalMetadata>{
    'articles': LibrarySignalMetadata(
      audienceSignals: <String>['general_public'],
      formatSignals: <String>['text'],
      accessibilitySignals: <String>['text_based'],
      difficultySignals: <String>['basic'],
    ),
    'exercises': LibrarySignalMetadata(
      audienceSignals: <String>['general_public'],
      formatSignals: <String>['exercise'],
      accessibilitySignals: <String>['simplified_content'],
      topicSignals: <String>['self_development'],
      difficultySignals: <String>['easy'],
    ),
    'audio': LibrarySignalMetadata(
      audienceSignals: <String>['general_public'],
      formatSignals: <String>['audio'],
      accessibilitySignals: <String>['audio_friendly'],
      difficultySignals: <String>['easy'],
    ),
    'videos': LibrarySignalMetadata(
      audienceSignals: <String>['general_public'],
      formatSignals: <String>['video'],
      accessibilitySignals: <String>['visual_support'],
      difficultySignals: <String>['easy'],
    ),
    'tools': LibrarySignalMetadata(
      audienceSignals: <String>['general_public'],
      formatSignals: <String>['tool'],
      accessibilitySignals: <String>['simplified_content'],
      difficultySignals: <String>['basic'],
    ),
  };

  static const Map<String, LibrarySignalMetadata> featured =
      <String, LibrarySignalMetadata>{
    'family_awareness': LibrarySignalMetadata(
      audienceSignals: <String>['family', 'caregivers'],
      formatSignals: <String>['text', 'visual_guide'],
      accessibilitySignals: <String>['simplified_content'],
      topicSignals: <String>['family_support', 'communication'],
      difficultySignals: <String>['basic'],
    ),
    'prevention_awareness': LibrarySignalMetadata(
      audienceSignals: <String>['general_public', 'children', 'family'],
      formatSignals: <String>['text', 'visual_guide'],
      accessibilitySignals: <String>['simplified_content', 'child_friendly'],
      topicSignals: <String>['prevention', 'mental_health'],
      difficultySignals: <String>['basic'],
    ),
  };

  static LibrarySignalMetadata? forKey(String key) {
    return featured[key] ?? categories[key];
  }
}
