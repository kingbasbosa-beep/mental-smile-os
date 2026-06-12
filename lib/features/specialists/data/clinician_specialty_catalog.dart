class ClinicianSpecialty {
  const ClinicianSpecialty({
    required this.key,
    required this.labelAr,
    required this.labelEn,
    required this.categoryKey,
  });

  final String key;
  final String labelAr;
  final String labelEn;
  final String categoryKey;

  String label(bool isArabic) => isArabic ? labelAr : labelEn;
}

class ClinicianSpecialtyCategory {
  const ClinicianSpecialtyCategory({
    required this.key,
    required this.labelAr,
    required this.labelEn,
    required this.descriptionAr,
    required this.descriptionEn,
  });

  final String key;
  final String labelAr;
  final String labelEn;
  final String descriptionAr;
  final String descriptionEn;

  String label(bool isArabic) => isArabic ? labelAr : labelEn;
  String description(bool isArabic) => isArabic ? descriptionAr : descriptionEn;
}

class ClinicianSpecialtyCatalog {
  const ClinicianSpecialtyCatalog._();

  static const String psychologists = 'psychologists';
  static const String familyCounseling = 'family_counseling';
  static const String speechSpecialists = 'speech_specialists';
  static const String coaching = 'coaching';
  static const String addiction = 'addiction';

  static const categories = <ClinicianSpecialtyCategory>[
    ClinicianSpecialtyCategory(
      key: psychologists,
      labelAr: 'أخصائيون نفسيون',
      labelEn: 'Psychologists',
      descriptionAr: 'يشمل الأخصائي النفسي والدكتور الإكلينيكي',
      descriptionEn: 'Includes psychologists and clinical psychologists',
    ),
    ClinicianSpecialtyCategory(
      key: familyCounseling,
      labelAr: 'مشورة أسرية',
      labelEn: 'Family Counseling',
      descriptionAr: 'متابعة أسرية ومشكلات العلاقات',
      descriptionEn: 'Family guidance and relationship support',
    ),
    ClinicianSpecialtyCategory(
      key: speechSpecialists,
      labelAr: 'أخصائيون تخاطب',
      labelEn: 'Speech Specialists',
      descriptionAr: 'جلسات تخاطب وتواصل',
      descriptionEn: 'Speech and communication support',
    ),
    ClinicianSpecialtyCategory(
      key: coaching,
      labelAr: 'كوتشينج',
      labelEn: 'Coaching',
      descriptionAr: 'دعم تطوير وتحفيز',
      descriptionEn: 'Development and motivation support',
    ),
    ClinicianSpecialtyCategory(
      key: addiction,
      labelAr: 'علاج السلوكيات الإدمانية',
      labelEn: 'Addiction Counseling',
      descriptionAr: 'جلسات دعم وتعافٍ',
      descriptionEn: 'Recovery and addiction support',
    ),
  ];

  static const specialties = <ClinicianSpecialty>[
    ClinicianSpecialty(
      key: 'psychologist',
      labelAr: 'أخصائي نفسي',
      labelEn: 'Psychologist',
      categoryKey: psychologists,
    ),
    ClinicianSpecialty(
      key: 'clinical_psychologist',
      labelAr: 'دكتور نفسي إكلينيكي',
      labelEn: 'Clinical Psychologist',
      categoryKey: psychologists,
    ),
    ClinicianSpecialty(
      key: 'addiction_counselor',
      labelAr: 'مستشار علاج إدمان',
      labelEn: 'Addiction Counselor',
      categoryKey: addiction,
    ),
    ClinicianSpecialty(
      key: 'speech_specialist',
      labelAr: 'أخصائي تخاطب',
      labelEn: 'Speech Specialist',
      categoryKey: speechSpecialists,
    ),
    ClinicianSpecialty(
      key: 'family_counselor',
      labelAr: 'أخصائي مشورة أسرية',
      labelEn: 'Family Counselor',
      categoryKey: familyCounseling,
    ),
    ClinicianSpecialty(
      key: 'coach',
      labelAr: 'كوتش',
      labelEn: 'Coach',
      categoryKey: coaching,
    ),
  ];

  static ClinicianSpecialty? specialtyByKey(String? key) {
    final normalized = (key ?? '').trim();
    for (final specialty in specialties) {
      if (specialty.key == normalized) return specialty;
    }
    return null;
  }

  static bool specialtyMatchesCategory({
    required String? specialtyKey,
    required String? categoryKey,
  }) {
    final category = (categoryKey ?? '').trim();
    if (category.isEmpty) return true;
    final specialty = specialtyByKey(specialtyKey);
    return specialty?.categoryKey == category;
  }

  static String specialtyLabel({
    required String? specialtyKey,
    required bool isArabic,
    String fallback = '',
  }) {
    final specialty = specialtyByKey(specialtyKey);
    if (specialty != null) return specialty.label(isArabic);
    return fallback;
  }
}
