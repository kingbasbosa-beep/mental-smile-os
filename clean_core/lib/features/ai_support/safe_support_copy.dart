class SafeSupportCopy {
  const SafeSupportCopy._();

  static const String calmOpeningAr = 'خلينا ناخدها بهدوء.';
  static const String calmOpeningEn = "Let's take this gently.";

  static const String notEverythingNowAr =
      'مش لازم تحل كل حاجة دلوقتي. خطوة صغيرة آمنة كفاية.';
  static const String notEverythingNowEn =
      'You do not have to solve everything right now. One small safe step is enough.';

  static const String trustedPersonAr =
      'لو تقدر، كلم شخص موثوق قريب منك أو خليك مع حد آمن.';
  static const String trustedPersonEn =
      'If you can, contact someone you trust nearby or stay with a safe person.';

  static const String saferPlaceAr =
      'لو المكان حواليك مش آمن، حاول تنتقل لمكان أهدى أو أقرب لشخص موثوق.';
  static const String saferPlaceEn =
      'If your surroundings do not feel safe, try moving somewhere calmer or closer to someone you trust.';

  static const String emergencyAr =
      'لو في خطر مباشر عليك أو على شخص آخر، اطلب مساعدة الطوارئ المحلية الآن.';
  static const String emergencyEn =
      'If there is immediate danger to you or someone else, contact local emergency support now.';

  static const String noGuaranteeAr =
      'Mental Smile ليس خدمة طوارئ ولا يقدر يضمن تدخل فوري.';
  static const String noGuaranteeEn =
      'Mental Smile is not an emergency service and cannot guarantee immediate intervention.';

  static const List<String> groundingStepsAr = [
    'خد نفس بطيء.',
    'حس برجلك على الأرض.',
    'سمّي 3 حاجات شايفها حواليك.',
    'اشرب شوية مياه لو متاح.',
  ];

  static const List<String> groundingStepsEn = [
    'Take one slow breath.',
    'Feel your feet on the ground.',
    'Name 3 things you can see around you.',
    'Sip some water if available.',
  ];

  static String calmOpening({required bool isArabic}) {
    return isArabic ? calmOpeningAr : calmOpeningEn;
  }

  static String trustedPerson({required bool isArabic}) {
    return isArabic ? trustedPersonAr : trustedPersonEn;
  }

  static String emergency({required bool isArabic}) {
    return isArabic ? emergencyAr : emergencyEn;
  }

  static List<String> groundingSteps({required bool isArabic}) {
    return isArabic ? groundingStepsAr : groundingStepsEn;
  }
}
