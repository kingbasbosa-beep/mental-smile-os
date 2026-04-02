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
  String comingSoon(String title) {
    return '$title — قريبًا';
  }

  @override
  String get modulePlaceholderBody => 'المحتوى قريبًا.';
}
