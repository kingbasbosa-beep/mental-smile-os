import 'package:cloud_firestore/cloud_firestore.dart';

class LibrarySeedService {
  static Future<void> seedDemo() async {
    final db = FirebaseFirestore.instance;

    final items = <Map<String, dynamic>>[
      {
        'id': 'addiction_basics',
        'category': 'addiction',
        'type': 'article',
        'title_ar': 'فهم الإدمان داخل الأسرة',
        'title_en': 'Understanding Addiction in Families',
        'url':
            'https://www.nimh.nih.gov/health/topics/substance-use-and-mental-health',
        'enabled': true,
        'tags': ['family', 'awareness'],
      },
      {
        'id': 'stress_grounding',
        'category': 'family_stress',
        'type': 'article',
        'title_ar': 'تمارين تهدئة بسيطة وقت التوتر',
        'title_en': 'Simple Grounding During Stress',
        'url':
            'https://www.mind.org.uk/information-support/tips-for-everyday-living/relaxation/',
        'enabled': true,
        'tags': ['calm', 'breathing'],
      },
      {
        'id': 'family_boundaries',
        'category': 'family_stress',
        'type': 'article',
        'title_ar': 'حدود صحية داخل البيت',
        'title_en': 'Healthy Family Boundaries',
        'url': 'https://www.verywellmind.com/setting-boundaries-5208802',
        'enabled': true,
        'tags': ['boundaries', 'family'],
      },
      {
        'id': 'special_needs_support',
        'category': 'special_needs',
        'type': 'article',
        'title_ar': 'دعم أسر ذوي الاحتياجات الخاصة',
        'title_en': 'Supporting Special Needs Families',
        'url':
            'https://www.cdc.gov/ncbddd/childdevelopment/positiveparenting/index.html',
        'enabled': true,
        'tags': ['parents', 'support'],
      },
      {
        'id': 'relapse_prevention',
        'category': 'addiction',
        'type': 'article',
        'title_ar': 'مبادئ منع الانتكاس',
        'title_en': 'Relapse Prevention Basics',
        'url': 'https://www.samhsa.gov/find-help/recovery',
        'enabled': true,
        'tags': ['recovery', 'relapse'],
      },
      {
        'id': 'breathing_video',
        'category': 'calm',
        'type': 'video',
        'title_ar': 'فيديو تنفّس لتهدئة سريعة',
        'title_en': 'Quick Calming Breath Video',
        'url': 'https://www.youtube.com/watch?v=inpok4MKVLM',
        'enabled': true,
        'tags': ['calm', 'video'],
      },
    ];

    for (final it in items) {
      final id = it['id'] as String;
      await db.collection('resources').doc(id).set({
        ...it,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }
  }
}
