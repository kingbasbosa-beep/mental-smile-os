// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Mental Key';

  @override
  String get homeTitle => 'Home';

  @override
  String get changeLanguage => 'Change language';

  @override
  String localeLabel(String code) {
    return 'Locale: $code (tap or 🌐)';
  }

  @override
  String get splashTitle => 'Splash';

  @override
  String get routeNotFound => 'Route not found';

  @override
  String get moduleSpecialists => 'Specialists';

  @override
  String get moduleLearningLibrary => 'Learning Library';

  @override
  String get moduleAddictionSupport => 'Addiction Support';

  @override
  String get moduleCenters => 'Centers';

  @override
  String get moduleSpecialNeedsFamilies => 'Special Needs Families';

  @override
  String get moduleFamilyStress => 'Family Stress';

  @override
  String get commonBack => 'Back';

  @override
  String get commonClose => 'Close';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonLoading => 'Loading';

  @override
  String get commonLogout => 'Log out';

  @override
  String get menuSpecialists => 'Specialists';

  @override
  String get menuCenters => 'Centers';

  @override
  String get menuLibrary => 'Library';

  @override
  String get menuAddictionSupport => 'Recovery Support';

  @override
  String get menuSpecialNeedsFamilies => 'Special Needs Families';

  @override
  String get menuChatSupport => 'Chat Support';

  @override
  String get homeStartJourney => 'Start your healing journey';

  @override
  String get homeLogin => 'Login';

  @override
  String get homeBack => 'Back';

  @override
  String comingSoon(String title) {
    return '$title — Coming soon';
  }

  @override
  String get modulePlaceholderBody => 'Content coming soon.';
}
