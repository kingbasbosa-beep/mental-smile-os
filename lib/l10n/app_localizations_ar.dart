// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'مينتال كي';

  @override
  String get homeTitle => 'الرئيسية';

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String localeLabel(String code) {
    return 'اللغة: $code (اضغط أو 🌐)';
  }

  @override
  String get splashTitle => 'شاشة البداية';

  @override
  String get routeNotFound => 'المسار غير موجود';

  @override
  String get moduleSpecialists => 'المختصون';

  @override
  String get moduleLearningLibrary => 'مكتبة المعرفة';

  @override
  String get moduleAddictionSupport => 'دعم الإدمان';

  @override
  String get moduleCenters => 'المراكز';

  @override
  String get moduleSpecialNeedsFamilies => 'أسر ذوي الاحتياجات الخاصة';

  @override
  String get moduleFamilyStress => 'ضغط الأسرة';

  @override
  String get commonBack => 'رجوع';

  @override
  String get commonClose => 'إغلاق';

  @override
  String get commonRetry => 'إعادة المحاولة';

  @override
  String get commonLoading => 'جارٍ التحميل';

  @override
  String get commonLogout => 'تسجيل الخروج';

  @override
  String get menuSpecialists => 'الأخصائيون';

  @override
  String get menuCenters => 'المراكز';

  @override
  String get menuLibrary => 'المكتبة';

  @override
  String get menuAddictionSupport => 'دعم المتعافي';

  @override
  String get menuSpecialNeedsFamilies => 'رعاية أسر ذوي الاحتياجات الخاصة';

  @override
  String get menuChatSupport => 'دعم المحادثة';

  @override
  String get homeStartJourney => 'ابدأ رحلتك نحو التعافي';

  @override
  String get homeLogin => 'تسجيل الدخول';

  @override
  String get homeBack => 'رجوع';

  @override
  String comingSoon(String title) {
    return '$title — قريبًا';
  }

  @override
  String get modulePlaceholderBody => 'المحتوى قريبًا.';
}
