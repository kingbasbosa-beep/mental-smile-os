class LegalDisclaimerText {
  const LegalDisclaimerText._();

  static const String mentalSmileAiNoticeAr =
      'تنبيه مهم: أي أدوات ذكاء اصطناعي مستقبلية داخل Mental Smile ليست طبيبا، '
      'وليست علاجا نفسيا، وليست خدمة طوارئ، ولا تقدم تشخيصا أو خطة علاج. '
      'قد تحتاج دائما إلى مساعدة بشرية مؤهلة، خصوصا عند وجود خطر أو أزمة.';

  static const String mentalSmileAiNoticeEn =
      'Important notice: any future AI tools in Mental Smile are not a doctor, '
      'not therapy, not an emergency service, and do not provide diagnosis or '
      'treatment. Qualified human help may still be required, especially during '
      'risk or crisis situations.';

  static const String dataProcessingNoticeAr =
      'بالموافقة، تقر بأن بياناتك قد تستخدم لتقديم الخدمة وتحسين الأمان '
      'والامتثال، بدون تخزين محادثات ذكاء اصطناعي أو بيانات تشخيصية ضمن هذا '
      'الأساس القانوني.';

  static const String dataProcessingNoticeEn =
      'By accepting, you acknowledge that your data may be used to provide the '
      'service and support safety and compliance, without storing AI '
      'conversation content or diagnostic data in this legal foundation.';

  static String aiNotice({required bool isArabic}) {
    return isArabic ? mentalSmileAiNoticeAr : mentalSmileAiNoticeEn;
  }

  static String dataProcessingNotice({required bool isArabic}) {
    return isArabic ? dataProcessingNoticeAr : dataProcessingNoticeEn;
  }
}
