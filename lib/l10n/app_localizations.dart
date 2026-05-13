import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// عنوان التطبيق
  ///
  /// In ar, this message translates to:
  /// **'مينتال كي'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get homeTitle;

  /// No description provided for @changeLanguage.
  ///
  /// In ar, this message translates to:
  /// **'تغيير اللغة'**
  String get changeLanguage;

  /// No description provided for @localeLabel.
  ///
  /// In ar, this message translates to:
  /// **'اللغة: {code} (اضغط أو 🌐)'**
  String localeLabel(String code);

  /// No description provided for @splashTitle.
  ///
  /// In ar, this message translates to:
  /// **'شاشة البداية'**
  String get splashTitle;

  /// No description provided for @routeNotFound.
  ///
  /// In ar, this message translates to:
  /// **'المسار غير موجود'**
  String get routeNotFound;

  /// No description provided for @moduleSpecialists.
  ///
  /// In ar, this message translates to:
  /// **'المختصون'**
  String get moduleSpecialists;

  /// No description provided for @moduleLearningLibrary.
  ///
  /// In ar, this message translates to:
  /// **'مكتبة المعرفة'**
  String get moduleLearningLibrary;

  /// No description provided for @moduleAddictionSupport.
  ///
  /// In ar, this message translates to:
  /// **'دعم الإدمان'**
  String get moduleAddictionSupport;

  /// No description provided for @moduleCenters.
  ///
  /// In ar, this message translates to:
  /// **'المراكز'**
  String get moduleCenters;

  /// No description provided for @moduleSpecialNeedsFamilies.
  ///
  /// In ar, this message translates to:
  /// **'أسر ذوي الاحتياجات الخاصة'**
  String get moduleSpecialNeedsFamilies;

  /// No description provided for @moduleFamilyStress.
  ///
  /// In ar, this message translates to:
  /// **'ضغط الأسرة'**
  String get moduleFamilyStress;

  /// No description provided for @commonBack.
  ///
  /// In ar, this message translates to:
  /// **'رجوع'**
  String get commonBack;

  /// No description provided for @commonClose.
  ///
  /// In ar, this message translates to:
  /// **'إغلاق'**
  String get commonClose;

  /// No description provided for @commonRetry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get commonRetry;

  /// No description provided for @commonLoading.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ التحميل'**
  String get commonLoading;

  /// No description provided for @commonLogout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get commonLogout;

  /// No description provided for @menuSpecialists.
  ///
  /// In ar, this message translates to:
  /// **'الأخصائيون'**
  String get menuSpecialists;

  /// No description provided for @menuCenters.
  ///
  /// In ar, this message translates to:
  /// **'المراكز'**
  String get menuCenters;

  /// No description provided for @menuLibrary.
  ///
  /// In ar, this message translates to:
  /// **'المكتبة'**
  String get menuLibrary;

  /// No description provided for @menuAddictionSupport.
  ///
  /// In ar, this message translates to:
  /// **'دعم المتعافي'**
  String get menuAddictionSupport;

  /// No description provided for @menuSpecialNeedsFamilies.
  ///
  /// In ar, this message translates to:
  /// **'رعاية أسر ذوي الاحتياجات الخاصة'**
  String get menuSpecialNeedsFamilies;

  /// No description provided for @menuChatSupport.
  ///
  /// In ar, this message translates to:
  /// **'دعم المحادثة'**
  String get menuChatSupport;

  /// No description provided for @homeStartJourney.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ رحلتك نحو التعافي'**
  String get homeStartJourney;

  /// No description provided for @homeLogin.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get homeLogin;

  /// No description provided for @homeBack.
  ///
  /// In ar, this message translates to:
  /// **'رجوع'**
  String get homeBack;

  /// No description provided for @comingSoon.
  ///
  /// In ar, this message translates to:
  /// **'{title} — قريبًا'**
  String comingSoon(String title);

  /// No description provided for @modulePlaceholderBody.
  ///
  /// In ar, this message translates to:
  /// **'المحتوى قريبًا.'**
  String get modulePlaceholderBody;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
