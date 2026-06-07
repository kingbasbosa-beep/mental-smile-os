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
/// To configure the locales supported by your app, youâ€™ll need to edit this
/// file.
///
/// First, open your projectâ€™s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// projectâ€™s Runner folder.
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

  /// Ø¹Ù†ÙˆØ§Ù† Ø§Ù„ØªØ·Ø¨ÙŠÙ‚
  ///
  /// In ar, this message translates to:
  /// **'Ù…ÙŠÙ†ØªØ§Ù„ ÙƒÙŠ'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ø±Ø¦ÙŠØ³ÙŠØ©'**
  String get homeTitle;

  /// No description provided for @changeLanguage.
  ///
  /// In ar, this message translates to:
  /// **'ØªØºÙŠÙŠØ± Ø§Ù„Ù„ØºØ©'**
  String get changeLanguage;

  /// No description provided for @localeLabel.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ù„ØºØ©: {code} (Ø§Ø¶ØºØ· Ø£Ùˆ ðŸŒ)'**
  String localeLabel(String code);

  /// No description provided for @splashTitle.
  ///
  /// In ar, this message translates to:
  /// **'Ø´Ø§Ø´Ø© Ø§Ù„Ø¨Ø¯Ø§ÙŠØ©'**
  String get splashTitle;

  /// No description provided for @routeNotFound.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ù…Ø³Ø§Ø± ØºÙŠØ± Ù…ÙˆØ¬ÙˆØ¯'**
  String get routeNotFound;

  /// No description provided for @moduleSpecialists.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ù…Ø®ØªØµÙˆÙ†'**
  String get moduleSpecialists;

  /// No description provided for @moduleLearningLibrary.
  ///
  /// In ar, this message translates to:
  /// **'Ù…ÙƒØªØ¨Ø© Ø§Ù„Ù…Ø¹Ø±ÙØ©'**
  String get moduleLearningLibrary;

  /// No description provided for @moduleAddictionSupport.
  ///
  /// In ar, this message translates to:
  /// **'Ø¯Ø¹Ù… Ø§Ù„Ø¥Ø¯Ù…Ø§Ù†'**
  String get moduleAddictionSupport;

  /// No description provided for @moduleCenters.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ù…Ø±Ø§ÙƒØ²'**
  String get moduleCenters;

  /// No description provided for @moduleSpecialNeedsFamilies.
  ///
  /// In ar, this message translates to:
  /// **'Ø£Ø³Ø± Ø°ÙˆÙŠ Ø§Ù„Ø§Ø­ØªÙŠØ§Ø¬Ø§Øª Ø§Ù„Ø®Ø§ØµØ©'**
  String get moduleSpecialNeedsFamilies;

  /// No description provided for @moduleFamilyStress.
  ///
  /// In ar, this message translates to:
  /// **'Ø¶ØºØ· Ø§Ù„Ø£Ø³Ø±Ø©'**
  String get moduleFamilyStress;

  /// No description provided for @commonBack.
  ///
  /// In ar, this message translates to:
  /// **'Ø±Ø¬ÙˆØ¹'**
  String get commonBack;

  /// No description provided for @commonClose.
  ///
  /// In ar, this message translates to:
  /// **'Ø¥ØºÙ„Ø§Ù‚'**
  String get commonClose;

  /// No description provided for @commonRetry.
  ///
  /// In ar, this message translates to:
  /// **'Ø¥Ø¹Ø§Ø¯Ø© Ø§Ù„Ù…Ø­Ø§ÙˆÙ„Ø©'**
  String get commonRetry;

  /// No description provided for @commonLoading.
  ///
  /// In ar, this message translates to:
  /// **'Ø¬Ø§Ø±Ù Ø§Ù„ØªØ­Ù…ÙŠÙ„'**
  String get commonLoading;

  /// No description provided for @commonLogout.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø®Ø±ÙˆØ¬'**
  String get commonLogout;

  /// No description provided for @menuSpecialists.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠÙˆÙ†'**
  String get menuSpecialists;

  /// No description provided for @menuCenters.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ù…Ø±Ø§ÙƒØ²'**
  String get menuCenters;

  /// No description provided for @menuLibrary.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ù…ÙƒØªØ¨Ø©'**
  String get menuLibrary;

  /// No description provided for @menuAddictionSupport.
  ///
  /// In ar, this message translates to:
  /// **'Ø¯Ø¹Ù… Ø§Ù„Ù…ØªØ¹Ø§ÙÙŠ'**
  String get menuAddictionSupport;

  /// No description provided for @menuSpecialNeedsFamilies.
  ///
  /// In ar, this message translates to:
  /// **'Ø±Ø¹Ø§ÙŠØ© Ø£Ø³Ø± Ø°ÙˆÙŠ Ø§Ù„Ø§Ø­ØªÙŠØ§Ø¬Ø§Øª Ø§Ù„Ø®Ø§ØµØ©'**
  String get menuSpecialNeedsFamilies;

  /// No description provided for @menuChatSupport.
  ///
  /// In ar, this message translates to:
  /// **'Ø¯Ø¹Ù… Ø§Ù„Ù…Ø­Ø§Ø¯Ø«Ø©'**
  String get menuChatSupport;

  /// No description provided for @homeStartJourney.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ø¨Ø¯Ø£ Ø±Ø­Ù„ØªÙƒ Ù†Ø­Ùˆ Ø§Ù„ØªØ¹Ø§ÙÙŠ'**
  String get homeStartJourney;

  /// No description provided for @homeLogin.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø¯Ø®ÙˆÙ„'**
  String get homeLogin;

  /// No description provided for @homeBack.
  ///
  /// In ar, this message translates to:
  /// **'Ø±Ø¬ÙˆØ¹'**
  String get homeBack;

  /// No description provided for @authLoginTitle.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø¯Ø®ÙˆÙ„'**
  String get authLoginTitle;

  /// No description provided for @authEmail.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ø¨Ø±ÙŠØ¯ Ø§Ù„Ø¥Ù„ÙƒØªØ±ÙˆÙ†ÙŠ'**
  String get authEmail;

  /// No description provided for @authPassword.
  ///
  /// In ar, this message translates to:
  /// **'ÙƒÙ„Ù…Ø© Ø§Ù„Ù…Ø±ÙˆØ±'**
  String get authPassword;

  /// No description provided for @authLoginButton.
  ///
  /// In ar, this message translates to:
  /// **'Ø¯Ø®ÙˆÙ„'**
  String get authLoginButton;

  /// No description provided for @authLoggingIn.
  ///
  /// In ar, this message translates to:
  /// **'Ø¬Ø§Ø±Ù ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø¯Ø®ÙˆÙ„'**
  String get authLoggingIn;

  /// No description provided for @authInvalidCredentials.
  ///
  /// In ar, this message translates to:
  /// **'Ø¨ÙŠØ§Ù†Ø§Øª Ø§Ù„Ø¯Ø®ÙˆÙ„ ØºÙŠØ± ØµØ­ÙŠØ­Ø©'**
  String get authInvalidCredentials;

  /// No description provided for @authRequiredField.
  ///
  /// In ar, this message translates to:
  /// **'Ù‡Ø°Ø§ Ø§Ù„Ø­Ù‚Ù„ Ù…Ø·Ù„ÙˆØ¨'**
  String get authRequiredField;

  /// No description provided for @authForgotPassword.
  ///
  /// In ar, this message translates to:
  /// **'Ù†Ø³ÙŠØª ÙƒÙ„Ù…Ø© Ø§Ù„Ù…Ø±ÙˆØ±ØŸ'**
  String get authForgotPassword;

  /// No description provided for @authCreateAccount.
  ///
  /// In ar, this message translates to:
  /// **'Ù„Ù„ØªØ³Ø¬ÙŠÙ„ Ø§Ø¶ØºØ· Ù‡Ù†Ø§'**
  String get authCreateAccount;

  /// No description provided for @authClientRegister.
  ///
  /// In ar, this message translates to:
  /// **'Ø¥Ù†Ø´Ø§Ø¡ Ø­Ø³Ø§Ø¨ Ø¹Ù…ÙŠÙ„'**
  String get authClientRegister;

  /// No description provided for @authBackToHome.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ø¹ÙˆØ¯Ø© Ù„Ù„Ø±Ø¦ÙŠØ³ÙŠØ©'**
  String get authBackToHome;

  /// No description provided for @authLogoutConfirm.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ£ÙƒÙŠØ¯ ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø®Ø±ÙˆØ¬'**
  String get authLogoutConfirm;

  /// No description provided for @authLogoutQuestion.
  ///
  /// In ar, this message translates to:
  /// **'Ù‡Ù„ ØªØ±ÙŠØ¯ ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø®Ø±ÙˆØ¬ØŸ'**
  String get authLogoutQuestion;

  /// No description provided for @authCancel.
  ///
  /// In ar, this message translates to:
  /// **'Ø¥Ù„ØºØ§Ø¡'**
  String get authCancel;

  /// No description provided for @authName.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ø§Ø³Ù…'**
  String get authName;

  /// No description provided for @authConfirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ£ÙƒÙŠØ¯ ÙƒÙ„Ù…Ø© Ø§Ù„Ù…Ø±ÙˆØ±'**
  String get authConfirmPassword;

  /// No description provided for @authCreatingAccount.
  ///
  /// In ar, this message translates to:
  /// **'Ø¬Ø§Ø±Ù Ø¥Ù†Ø´Ø§Ø¡ Ø§Ù„Ø­Ø³Ø§Ø¨...'**
  String get authCreatingAccount;

  /// No description provided for @authEmailRequired.
  ///
  /// In ar, this message translates to:
  /// **'Ø§ÙƒØªØ¨ Ø§Ù„Ø¨Ø±ÙŠØ¯ Ø§Ù„Ø¥Ù„ÙƒØªØ±ÙˆÙ†ÙŠ'**
  String get authEmailRequired;

  /// No description provided for @authPasswordRequired.
  ///
  /// In ar, this message translates to:
  /// **'Ø§ÙƒØªØ¨ ÙƒÙ„Ù…Ø© Ø§Ù„Ù…Ø±ÙˆØ±'**
  String get authPasswordRequired;

  /// No description provided for @authNameRequired.
  ///
  /// In ar, this message translates to:
  /// **'Ø§ÙƒØªØ¨ Ø§Ù„Ø§Ø³Ù…'**
  String get authNameRequired;

  /// No description provided for @authPasswordsDoNotMatch.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ£ÙƒÙŠØ¯ ÙƒÙ„Ù…Ø© Ø§Ù„Ù…Ø±ÙˆØ± ØºÙŠØ± Ù…Ø·Ø§Ø¨Ù‚'**
  String get authPasswordsDoNotMatch;

  /// No description provided for @authInvalidEmail.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ø¨Ø±ÙŠØ¯ Ø§Ù„Ø¥Ù„ÙƒØªØ±ÙˆÙ†ÙŠ ØºÙŠØ± ØµØ§Ù„Ø­'**
  String get authInvalidEmail;

  /// No description provided for @authWeakPassword.
  ///
  /// In ar, this message translates to:
  /// **'ÙƒÙ„Ù…Ø© Ø§Ù„Ù…Ø±ÙˆØ± ÙŠØ¬Ø¨ Ø£Ù† ØªÙƒÙˆÙ† 6 Ø£Ø­Ø±Ù Ø¹Ù„Ù‰ Ø§Ù„Ø£Ù‚Ù„'**
  String get authWeakPassword;

  /// No description provided for @authLoginFailed.
  ///
  /// In ar, this message translates to:
  /// **'ÙØ´Ù„ ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø¯Ø®ÙˆÙ„'**
  String get authLoginFailed;

  /// No description provided for @authRegistrationFailed.
  ///
  /// In ar, this message translates to:
  /// **'ÙØ´Ù„ Ø¥Ù†Ø´Ø§Ø¡ Ø§Ù„Ø­Ø³Ø§Ø¨'**
  String get authRegistrationFailed;

  /// No description provided for @authUnexpectedError.
  ///
  /// In ar, this message translates to:
  /// **'Ø­Ø¯Ø« Ø®Ø·Ø£ ØºÙŠØ± Ù…ØªÙˆÙ‚Ø¹'**
  String get authUnexpectedError;

  /// No description provided for @authPleaseWait.
  ///
  /// In ar, this message translates to:
  /// **'Ù…Ù† ÙØ¶Ù„Ùƒ Ø§Ù†ØªØ¸Ø±'**
  String get authPleaseWait;

  /// No description provided for @authInvalidCredentialsMessage.
  ///
  /// In ar, this message translates to:
  /// **'Ø¨ÙŠØ§Ù†Ø§Øª Ø§Ù„Ø¯Ø®ÙˆÙ„ ØºÙŠØ± ØµØ­ÙŠØ­Ø©'**
  String get authInvalidCredentialsMessage;

  /// No description provided for @authAccountCreated.
  ///
  /// In ar, this message translates to:
  /// **'ØªÙ… Ø¥Ù†Ø´Ø§Ø¡ Ø§Ù„Ø­Ø³Ø§Ø¨'**
  String get authAccountCreated;

  /// No description provided for @authTryAgain.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ¹Ø°Ø± Ø¥ÙƒÙ…Ø§Ù„ Ø§Ù„Ø¹Ù…Ù„ÙŠØ©ØŒ Ø­Ø§ÙˆÙ„ Ù…Ø±Ø© Ø£Ø®Ø±Ù‰'**
  String get authTryAgain;

  /// No description provided for @commonNext.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„ØªØ§Ù„ÙŠ'**
  String get commonNext;

  /// No description provided for @centersLoadError.
  ///
  /// In ar, this message translates to:
  /// **'Ø­Ø¯Ø« Ø®Ø·Ø£ Ø£Ø«Ù†Ø§Ø¡ ØªØ­Ù…ÙŠÙ„ Ø§Ù„Ù…Ø±Ø§ÙƒØ²'**
  String get centersLoadError;

  /// No description provided for @centersEmpty.
  ///
  /// In ar, this message translates to:
  /// **'Ù„Ø§ ØªÙˆØ¬Ø¯ Ù…Ø±Ø§ÙƒØ² Ù…ØªØ§Ø­Ø© ÙÙŠ Ù‡Ø°Ù‡ Ø§Ù„ÙØ¦Ø© Ø­Ø§Ù„ÙŠÙ‹Ø§'**
  String get centersEmpty;

  /// No description provided for @centersReadMore.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ø¶ØºØ· Ù„Ù„Ù…Ø²ÙŠØ¯'**
  String get centersReadMore;

  /// No description provided for @centerDefaultName.
  ///
  /// In ar, this message translates to:
  /// **'Ù…Ø±ÙƒØ²'**
  String get centerDefaultName;

  /// No description provided for @centerDetoxUnitAvailable.
  ///
  /// In ar, this message translates to:
  /// **'ÙŠÙˆØ¬Ø¯ Ù‚Ø³Ù… Ø£Ø¹Ø±Ø§Ø¶ Ø§Ù†Ø³Ø­Ø§Ø¨'**
  String get centerDetoxUnitAvailable;

  /// No description provided for @centerDetailsTitle.
  ///
  /// In ar, this message translates to:
  /// **'ØªÙØ§ØµÙŠÙ„ Ø§Ù„Ù…Ø±ÙƒØ²'**
  String get centerDetailsTitle;

  /// No description provided for @centerDataNotFound.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ¹Ø°Ù‘Ø± Ø§Ù„Ø¹Ø«ÙˆØ± Ø¹Ù„Ù‰ Ø¨ÙŠØ§Ù†Ø§Øª Ø§Ù„Ù…Ø±ÙƒØ²'**
  String get centerDataNotFound;

  /// No description provided for @centerDataLoadError.
  ///
  /// In ar, this message translates to:
  /// **'Ø­Ø¯Ø« Ø®Ø·Ø£ Ø£Ø«Ù†Ø§Ø¡ ØªØ­Ù…ÙŠÙ„ Ø¨ÙŠØ§Ù†Ø§Øª Ø§Ù„Ù…Ø±ÙƒØ²'**
  String get centerDataLoadError;

  /// No description provided for @centerAvailable.
  ///
  /// In ar, this message translates to:
  /// **'Ù…ØªØ§Ø­'**
  String get centerAvailable;

  /// No description provided for @centerUnavailable.
  ///
  /// In ar, this message translates to:
  /// **'ØºÙŠØ± Ù…ØªØ§Ø­'**
  String get centerUnavailable;

  /// No description provided for @centerGallery.
  ///
  /// In ar, this message translates to:
  /// **'ØµÙˆØ± Ø§Ù„Ù…Ø±ÙƒØ²'**
  String get centerGallery;

  /// No description provided for @centerPricing.
  ///
  /// In ar, this message translates to:
  /// **'ØªÙƒÙ„ÙØ© Ø§Ù„Ø¥Ù‚Ø§Ù…Ø©'**
  String get centerPricing;

  /// No description provided for @centerTypeAndService.
  ///
  /// In ar, this message translates to:
  /// **'Ù†ÙˆØ¹ Ø§Ù„Ù…Ø±ÙƒØ² ÙˆØ®Ø¯Ù…ØªÙ‡'**
  String get centerTypeAndService;

  /// No description provided for @centerCapabilities.
  ///
  /// In ar, this message translates to:
  /// **'Ù‚Ø¯Ø±Ø§Øª Ø§Ù„Ù…Ø±ÙƒØ²'**
  String get centerCapabilities;

  /// No description provided for @centerContactLocation.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„ØªÙˆØ§ØµÙ„ ÙˆØ§Ù„Ù…ÙˆÙ‚Ø¹'**
  String get centerContactLocation;

  /// No description provided for @centerAddress.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ø¹Ù†ÙˆØ§Ù†'**
  String get centerAddress;

  /// No description provided for @centerCity.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ù…Ø¯ÙŠÙ†Ø©'**
  String get centerCity;

  /// No description provided for @centerPhone.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ù‡Ø§ØªÙ'**
  String get centerPhone;

  /// No description provided for @centerWhatsapp.
  ///
  /// In ar, this message translates to:
  /// **'ÙˆØ§ØªØ³Ø§Ø¨'**
  String get centerWhatsapp;

  /// No description provided for @centerServices.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ø®Ø¯Ù…Ø§Øª'**
  String get centerServices;

  /// No description provided for @centerAbout.
  ///
  /// In ar, this message translates to:
  /// **'Ù†Ø¨Ø°Ø© Ø¹Ù† Ø§Ù„Ù…Ø±ÙƒØ²'**
  String get centerAbout;

  /// No description provided for @centerRequestViaAdmin.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ø·Ù„Ø¨ Ø§Ù„Ù…Ø±ÙƒØ² Ø¹Ø¨Ø± Ø§Ù„Ø¥Ø¯Ø§Ø±Ø©'**
  String get centerRequestViaAdmin;

  /// No description provided for @centerInboxTitle.
  ///
  /// In ar, this message translates to:
  /// **'ÙˆØ§Ø±Ø¯ Ø§Ù„Ù…Ø±ÙƒØ²'**
  String get centerInboxTitle;

  /// No description provided for @commonAll.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„ÙƒÙ„'**
  String get commonAll;

  /// No description provided for @statusPending.
  ///
  /// In ar, this message translates to:
  /// **'Ø¨Ø§Ù†ØªØ¸Ø§Ø± Ø§Ù„Ø±Ø¯'**
  String get statusPending;

  /// No description provided for @centerSaveResponse.
  ///
  /// In ar, this message translates to:
  /// **'Ø­ÙØ¸ Ø§Ù„Ø±Ø¯'**
  String get centerSaveResponse;

  /// No description provided for @webCenterRegistrationPortalTitle.
  ///
  /// In ar, this message translates to:
  /// **'Ø¨ÙˆØ§Ø¨Ø© ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ù…Ø±Ø§ÙƒØ²'**
  String get webCenterRegistrationPortalTitle;

  /// No description provided for @webCenterRegistrationPortalSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'Ø£Ù†Ø´Ø¦ Ø­Ø³Ø§Ø¨ Ø§Ù„Ù…Ø±ÙƒØ² Ù„ÙŠØªÙ… Ù…Ø±Ø§Ø¬Ø¹ØªÙ‡ Ù…Ù† Ø§Ù„Ø¥Ø¯Ø§Ø±Ø©.'**
  String get webCenterRegistrationPortalSubtitle;

  /// No description provided for @webCenterRegistrationBasicInfoTitle.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ù…Ø±ÙƒØ² - Ø§Ù„Ø¨ÙŠØ§Ù†Ø§Øª Ø§Ù„Ø£Ø³Ø§Ø³ÙŠØ©'**
  String get webCenterRegistrationBasicInfoTitle;

  /// No description provided for @webCenterGuidanceLibrary.
  ///
  /// In ar, this message translates to:
  /// **'Ù…ÙƒØªØ¨Ø© Ø§Ù„Ø¥Ø±Ø´Ø§Ø¯'**
  String get webCenterGuidanceLibrary;

  /// No description provided for @webCenterCenterName.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ø³Ù… Ø§Ù„Ù…Ø±ÙƒØ²'**
  String get webCenterCenterName;

  /// No description provided for @webCenterCategory.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„ÙØ¦Ø©'**
  String get webCenterCategory;

  /// No description provided for @webCenterType.
  ///
  /// In ar, this message translates to:
  /// **'Ù†ÙˆØ¹ Ø§Ù„Ù…Ø±ÙƒØ²'**
  String get webCenterType;

  /// No description provided for @webCenterConfirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ£ÙƒÙŠØ¯ ÙƒÙ„Ù…Ø© Ø§Ù„Ù…Ø±ÙˆØ±'**
  String get webCenterConfirmPassword;

  /// No description provided for @webCenterNextBasicInfo.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„ØªØ§Ù„ÙŠ: Ø§Ù„Ø¨ÙŠØ§Ù†Ø§Øª Ø§Ù„Ø£Ø³Ø§Ø³ÙŠØ©'**
  String get webCenterNextBasicInfo;

  /// No description provided for @webCenterManagerName.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ø³Ù… Ø§Ù„Ù…Ø³Ø¤ÙˆÙ„'**
  String get webCenterManagerName;

  /// No description provided for @webCenterArea.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ù…Ù†Ø·Ù‚Ø©'**
  String get webCenterArea;

  /// No description provided for @webCenterDescription.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„ÙˆØµÙ'**
  String get webCenterDescription;

  /// No description provided for @webCenterHasDetoxUnit.
  ///
  /// In ar, this message translates to:
  /// **'ÙŠÙˆØ¬Ø¯ Ù‚Ø³Ù… Ø³Ø­Ø¨ Ø³Ù…ÙˆÙ…'**
  String get webCenterHasDetoxUnit;

  /// No description provided for @webCenterNextMediaGallery.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„ØªØ§Ù„ÙŠ: Ø§Ù„ØµÙˆØ± ÙˆØ§Ù„Ù…Ø¹Ø±Ø¶'**
  String get webCenterNextMediaGallery;

  /// No description provided for @webCenterMediaGalleryTitle.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ù…Ø±ÙƒØ² - Ø§Ù„ØµÙˆØ± ÙˆØ§Ù„Ù…Ø¹Ø±Ø¶'**
  String get webCenterMediaGalleryTitle;

  /// No description provided for @webCenterFrontImageUrl.
  ///
  /// In ar, this message translates to:
  /// **'Ø±Ø§Ø¨Ø· ØµÙˆØ±Ø© Ø§Ù„ÙˆØ§Ø¬Ù‡Ø©'**
  String get webCenterFrontImageUrl;

  /// No description provided for @webCenterReceptionImageUrl.
  ///
  /// In ar, this message translates to:
  /// **'Ø±Ø§Ø¨Ø· ØµÙˆØ±Ø© Ø§Ù„Ø§Ø³ØªÙ‚Ø¨Ø§Ù„'**
  String get webCenterReceptionImageUrl;

  /// No description provided for @webCenterInsideImage1Url.
  ///
  /// In ar, this message translates to:
  /// **'Ø±Ø§Ø¨Ø· ØµÙˆØ±Ø© Ø¯Ø§Ø®Ù„ÙŠØ© 1'**
  String get webCenterInsideImage1Url;

  /// No description provided for @webCenterInsideImage2Url.
  ///
  /// In ar, this message translates to:
  /// **'Ø±Ø§Ø¨Ø· ØµÙˆØ±Ø© Ø¯Ø§Ø®Ù„ÙŠØ© 2'**
  String get webCenterInsideImage2Url;

  /// No description provided for @webCenterNextPricingCapabilities.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„ØªØ§Ù„ÙŠ: Ø§Ù„ØªØ³Ø¹ÙŠØ± ÙˆØ§Ù„Ù‚Ø¯Ø±Ø§Øª'**
  String get webCenterNextPricingCapabilities;

  /// No description provided for @webCenterPricingCapabilitiesTitle.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ù…Ø±ÙƒØ² - Ø§Ù„ØªØ³Ø¹ÙŠØ± ÙˆØ§Ù„Ù‚Ø¯Ø±Ø§Øª'**
  String get webCenterPricingCapabilitiesTitle;

  /// No description provided for @webCenterEnabled.
  ///
  /// In ar, this message translates to:
  /// **'Ù…ÙØ¹Ù„'**
  String get webCenterEnabled;

  /// No description provided for @webCenterPrice.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ø³Ø¹Ø±'**
  String get webCenterPrice;

  /// No description provided for @webCenterPricingUnit.
  ///
  /// In ar, this message translates to:
  /// **'ÙˆØ­Ø¯Ø© Ø§Ù„ØªØ³Ø¹ÙŠØ±'**
  String get webCenterPricingUnit;

  /// No description provided for @webCenterAcMode.
  ///
  /// In ar, this message translates to:
  /// **'Ù†Ø¸Ø§Ù… Ø§Ù„ØªÙƒÙŠÙŠÙ'**
  String get webCenterAcMode;

  /// No description provided for @webCenterTaxIncluded.
  ///
  /// In ar, this message translates to:
  /// **'ÙŠØ´Ù…Ù„ Ø§Ù„Ø¶Ø±ÙŠØ¨Ø©'**
  String get webCenterTaxIncluded;

  /// No description provided for @webCenterNextDocuments.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„ØªØ§Ù„ÙŠ: Ø§Ù„Ù…Ø³ØªÙ†Ø¯Ø§Øª'**
  String get webCenterNextDocuments;

  /// No description provided for @webCenterDocumentsTitle.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ù…Ø±ÙƒØ² - Ø§Ù„Ù…Ø³ØªÙ†Ø¯Ø§Øª'**
  String get webCenterDocumentsTitle;

  /// No description provided for @webCenterFileName.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ø³Ù… Ø§Ù„Ù…Ù„Ù'**
  String get webCenterFileName;

  /// No description provided for @webCenterFileUrlOptional.
  ///
  /// In ar, this message translates to:
  /// **'Ø±Ø§Ø¨Ø· Ø§Ù„Ù…Ù„Ù (Ø§Ø®ØªÙŠØ§Ø±ÙŠ)'**
  String get webCenterFileUrlOptional;

  /// No description provided for @webCenterReviewNoteOptional.
  ///
  /// In ar, this message translates to:
  /// **'Ù…Ù„Ø§Ø­Ø¸Ø© Ø§Ù„Ù…Ø±Ø§Ø¬Ø¹Ø© (Ø§Ø®ØªÙŠØ§Ø±ÙŠ)'**
  String get webCenterReviewNoteOptional;

  /// No description provided for @webCenterSubmitForReview.
  ///
  /// In ar, this message translates to:
  /// **'Ø¥Ø±Ø³Ø§Ù„ Ù„Ù„Ù…Ø±Ø§Ø¬Ø¹Ø©'**
  String get webCenterSubmitForReview;

  /// No description provided for @webRegistrationBrowseLibraryDuringReview.
  ///
  /// In ar, this message translates to:
  /// **'ØªØµÙØ­ Ù…ÙƒØªØ¨Ø© Ø§Ù„Ø¥Ø±Ø´Ø§Ø¯ Ø£Ø«Ù†Ø§Ø¡ Ù…Ø±Ø§Ø¬Ø¹Ø© Ø­Ø³Ø§Ø¨Ùƒ'**
  String get webRegistrationBrowseLibraryDuringReview;

  /// No description provided for @webCenterCenterNameRequired.
  ///
  /// In ar, this message translates to:
  /// **'Ø§ÙƒØªØ¨ Ø§Ø³Ù… Ø§Ù„Ù…Ø±ÙƒØ²'**
  String get webCenterCenterNameRequired;

  /// No description provided for @webCenterRegistrationFailed.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ¹Ø°Ø± Ø¥ÙƒÙ…Ø§Ù„ Ø§Ù„ØªØ³Ø¬ÙŠÙ„ØŒ Ø­Ø§ÙˆÙ„ Ù…Ø±Ø© Ø£Ø®Ø±Ù‰.'**
  String get webCenterRegistrationFailed;

  /// No description provided for @webCenterPleaseRegisterBeforeSaving.
  ///
  /// In ar, this message translates to:
  /// **'ÙŠØ±Ø¬Ù‰ Ø§Ù„ØªØ³Ø¬ÙŠÙ„ Ø£Ùˆ ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø¯Ø®ÙˆÙ„ Ù‚Ø¨Ù„ Ø§Ù„Ø­ÙØ¸.'**
  String get webCenterPleaseRegisterBeforeSaving;

  /// No description provided for @webCenterMissingSession.
  ///
  /// In ar, this message translates to:
  /// **'Ø¬Ù„Ø³Ø© Ø§Ù„Ù…Ø±ÙƒØ² ØºÙŠØ± Ù…ØªØ§Ø­Ø©'**
  String get webCenterMissingSession;

  /// No description provided for @webCenterSaveProfileFailed.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ¹Ø°Ø± Ø­ÙØ¸ Ø¨ÙŠØ§Ù†Ø§Øª Ø§Ù„Ù…Ø±ÙƒØ²'**
  String get webCenterSaveProfileFailed;

  /// No description provided for @webCenterSaveMediaFailed.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ¹Ø°Ø± Ø­ÙØ¸ Ø§Ù„ØµÙˆØ±'**
  String get webCenterSaveMediaFailed;

  /// No description provided for @webCenterSavePricingFailed.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ¹Ø°Ø± Ø­ÙØ¸ Ø§Ù„ØªØ³Ø¹ÙŠØ±'**
  String get webCenterSavePricingFailed;

  /// No description provided for @webCenterSubmitDocumentsFailed.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ¹Ø°Ø± Ø¥Ø±Ø³Ø§Ù„ Ø§Ù„Ù…Ø³ØªÙ†Ø¯Ø§Øª'**
  String get webCenterSubmitDocumentsFailed;

  /// No description provided for @webClinicianRegistrationAccountTitle.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ - Ø§Ù„Ø­Ø³Ø§Ø¨'**
  String get webClinicianRegistrationAccountTitle;

  /// No description provided for @webClinicianRegistrationProfileTitle.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ - Ø§Ù„Ù…Ù„Ù Ø§Ù„Ø´Ø®ØµÙŠ'**
  String get webClinicianRegistrationProfileTitle;

  /// No description provided for @webClinicianName.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ø§Ø³Ù…'**
  String get webClinicianName;

  /// No description provided for @webClinicianProfessionalTitle.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ù„Ù‚Ø¨ Ø§Ù„Ù…Ù‡Ù†ÙŠ'**
  String get webClinicianProfessionalTitle;

  /// No description provided for @webClinicianSpecialty.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„ØªØ®ØµØµ'**
  String get webClinicianSpecialty;

  /// No description provided for @webClinicianNextProfile.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„ØªØ§Ù„ÙŠ: Ø§Ù„Ù…Ù„Ù Ø§Ù„Ø´Ø®ØµÙŠ'**
  String get webClinicianNextProfile;

  /// No description provided for @webClinicianPhotoUrl.
  ///
  /// In ar, this message translates to:
  /// **'Ø±Ø§Ø¨Ø· Ø§Ù„ØµÙˆØ±Ø©'**
  String get webClinicianPhotoUrl;

  /// No description provided for @webClinicianBio.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ù†Ø¨Ø°Ø©'**
  String get webClinicianBio;

  /// No description provided for @webClinicianSessionPrice.
  ///
  /// In ar, this message translates to:
  /// **'Ø³Ø¹Ø± Ø§Ù„Ø¬Ù„Ø³Ø©'**
  String get webClinicianSessionPrice;

  /// No description provided for @webClinicianSessionDuration.
  ///
  /// In ar, this message translates to:
  /// **'Ù…Ø¯Ø© Ø§Ù„Ø¬Ù„Ø³Ø©'**
  String get webClinicianSessionDuration;

  /// No description provided for @webClinicianDocumentsTitle.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ - Ø§Ù„Ù…Ø³ØªÙ†Ø¯Ø§Øª'**
  String get webClinicianDocumentsTitle;

  /// No description provided for @webClinicianIdentityFileName.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ø³Ù… Ù…Ù„Ù Ø§Ù„Ù‡ÙˆÙŠØ©'**
  String get webClinicianIdentityFileName;

  /// No description provided for @webClinicianCertificateFileName.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ø³Ù… Ù…Ù„Ù Ø§Ù„Ø´Ù‡Ø§Ø¯Ø©'**
  String get webClinicianCertificateFileName;

  /// No description provided for @webClinicianExtraFileNameOptional.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ø³Ù… Ù…Ù„Ù Ø¥Ø¶Ø§ÙÙŠ (Ø§Ø®ØªÙŠØ§Ø±ÙŠ)'**
  String get webClinicianExtraFileNameOptional;

  /// No description provided for @webClinicianRegistrationFailed.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ¹Ø°Ø± Ø¥Ù†Ø´Ø§Ø¡ Ø­Ø³Ø§Ø¨ Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ'**
  String get webClinicianRegistrationFailed;

  /// No description provided for @webClinicianStartFromAccountStep.
  ///
  /// In ar, this message translates to:
  /// **'ÙŠØ±Ø¬Ù‰ Ø¨Ø¯Ø¡ Ø§Ù„ØªØ³Ø¬ÙŠÙ„ Ù…Ù† Ø®Ø·ÙˆØ© Ø§Ù„Ø­Ø³Ø§Ø¨'**
  String get webClinicianStartFromAccountStep;

  /// No description provided for @webClinicianAuthenticationSessionMissing.
  ///
  /// In ar, this message translates to:
  /// **'Ø¬Ù„Ø³Ø© ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø¯Ø®ÙˆÙ„ ØºÙŠØ± Ù…ØªØ§Ø­Ø©'**
  String get webClinicianAuthenticationSessionMissing;

  /// No description provided for @webClinicianSaveProfileFailed.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ¹Ø°Ø± Ø­ÙØ¸ Ø§Ù„Ù…Ù„Ù Ø§Ù„Ø´Ø®ØµÙŠ'**
  String get webClinicianSaveProfileFailed;

  /// No description provided for @webClinicianSelectSessionMode.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ø®ØªØ± Ø·Ø±ÙŠÙ‚Ø© Ø¬Ù„Ø³Ø© ÙˆØ§Ø­Ø¯Ø© Ø¹Ù„Ù‰ Ø§Ù„Ø£Ù‚Ù„'**
  String get webClinicianSelectSessionMode;

  /// No description provided for @webClinicianSubmitDocumentsFailed.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ¹Ø°Ø± Ø¥Ø±Ø³Ø§Ù„ Ø§Ù„Ù…Ø³ØªÙ†Ø¯Ø§Øª'**
  String get webClinicianSubmitDocumentsFailed;


  /// No description provided for @bookingEditAccommodation.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ¹Ø¯ÙŠÙ„ Ù†ÙˆØ¹ Ø§Ù„Ø¥Ù‚Ø§Ù…Ø©'**
  String get bookingEditAccommodation;

  /// No description provided for @bookingCompleteInitialIntake.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ø³ØªÙƒÙ…Ø§Ù„ Ø¨ÙŠØ§Ù†Ø§Øª Ø§Ù„ØªÙ‚ÙŠÙŠÙ… Ø§Ù„Ø£ÙˆÙ„ÙŠ'**
  String get bookingCompleteInitialIntake;

  /// No description provided for @bookingCurrent.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ø¬Ø§Ø±ÙŠØ©'**
  String get bookingCurrent;

  /// No description provided for @bookingActionNeeded.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ­ØªØ§Ø¬ Ù…Ù†Ùƒ Ø¥Ø¬Ø±Ø§Ø¡'**
  String get bookingActionNeeded;

  /// No description provided for @bookingCompleted.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ù…ÙƒØªÙ…Ù„Ø©'**
  String get bookingCompleted;

  /// No description provided for @bookingClosed.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ù…ØºÙ„Ù‚Ø©'**
  String get bookingClosed;

  /// No description provided for @bookingEmptyCurrent.
  ///
  /// In ar, this message translates to:
  /// **'Ù„Ø§ ØªÙˆØ¬Ø¯ Ø·Ù„Ø¨Ø§Øª Ø¬Ø§Ø±ÙŠØ© Ø§Ù„Ø¢Ù†'**
  String get bookingEmptyCurrent;

  /// No description provided for @bookingEmptyActionNeeded.
  ///
  /// In ar, this message translates to:
  /// **'Ù„Ø§ ØªÙˆØ¬Ø¯ Ø·Ù„Ø¨Ø§Øª ØªØ­ØªØ§Ø¬ Ù…Ù†Ùƒ Ø¥Ø¬Ø±Ø§Ø¡ Ø§Ù„Ø¢Ù†'**
  String get bookingEmptyActionNeeded;

  /// No description provided for @bookingEmptyCompleted.
  ///
  /// In ar, this message translates to:
  /// **'Ù„Ø§ ØªÙˆØ¬Ø¯ Ø·Ù„Ø¨Ø§Øª Ù…ÙƒØªÙ…Ù„Ø© Ø¨Ø¹Ø¯'**
  String get bookingEmptyCompleted;

  /// No description provided for @bookingEmptyClosed.
  ///
  /// In ar, this message translates to:
  /// **'Ù„Ø§ ØªÙˆØ¬Ø¯ Ø·Ù„Ø¨Ø§Øª Ù…ØºÙ„Ù‚Ø©'**
  String get bookingEmptyClosed;

  /// No description provided for @bookingSpecialistFallback.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ'**
  String get bookingSpecialistFallback;

  /// No description provided for @clientDashboardWelcome.
  ///
  /// In ar, this message translates to:
  /// **'Ù…Ø±Ø­Ø¨Ù‹Ø§ {name}'**
  String clientDashboardWelcome(String name);

  /// No description provided for @clientDashboardSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'ÙƒÙ„ Ø®Ø·ÙˆØ§ØªÙƒ Ù…ÙˆØ¬ÙˆØ¯Ø© Ù‡Ù†Ø§ Ø¨Ù‡Ø¯ÙˆØ¡.'**
  String get clientDashboardSubtitle;

  /// No description provided for @clientSupport.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ø¯Ø¹Ù…'**
  String get clientSupport;

  /// No description provided for @clientSupportRequests.
  ///
  /// In ar, this message translates to:
  /// **'Ø·Ù„Ø¨Ø§Øª Ø§Ù„Ø¯Ø¹Ù…'**
  String get clientSupportRequests;



  /// No description provided for @clientLinksAndCodes.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ø±ÙˆØ§Ø¨Ø· ÙˆØ§Ù„Ø£ÙƒÙˆØ§Ø¯'**
  String get clientLinksAndCodes;

  /// No description provided for @clientFollowUp.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ù…ØªØ§Ø¨Ø¹Ø©'**
  String get clientFollowUp;

  /// No description provided for @clientMessagePreferences.
  ///
  /// In ar, this message translates to:
  /// **'ØªÙØ¶ÙŠÙ„Ø§Øª Ø§Ù„Ø±Ø³Ø§Ø¦Ù„'**
  String get clientMessagePreferences;

  /// No description provided for @clientRatingsCount.
  ///
  /// In ar, this message translates to:
  /// **'Ø¹Ø¯Ø¯ Ø§Ù„ØªÙ‚ÙŠÙŠÙ…Ø§Øª'**
  String get clientRatingsCount;

  /// No description provided for @clientAverageStars.
  ///
  /// In ar, this message translates to:
  /// **'Ù…ØªÙˆØ³Ø· Ø§Ù„Ù†Ø¬ÙˆÙ…'**
  String get clientAverageStars;

  /// No description provided for @clientOverallAverage.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ù…ØªÙˆØ³Ø· Ø§Ù„Ø¹Ø§Ù…'**
  String get clientOverallAverage;

  /// No description provided for @clinicianOperations.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ø¹Ù…Ù„ÙŠØ§Øª'**
  String get clinicianOperations;

  /// No description provided for @clinicianDashboard.
  ///
  /// In ar, this message translates to:
  /// **'Ù„ÙˆØ­Ø© Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ'**
  String get clinicianDashboard;

  /// No description provided for @clinicianOpenCases.
  ///
  /// In ar, this message translates to:
  /// **'ÙØªØ­ Ø§Ù„Ø­Ø§Ù„Ø§Øª'**
  String get clinicianOpenCases;

  /// No description provided for @clinicianSendSupportRequest.
  ///
  /// In ar, this message translates to:
  /// **'Ø¥Ø±Ø³Ø§Ù„ Ø·Ù„Ø¨ Ø¯Ø¹Ù…'**
  String get clinicianSendSupportRequest;

  /// No description provided for @clinicianEditProfile.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ¹Ø¯ÙŠÙ„ Ø¨ÙŠØ§Ù†Ø§ØªÙŠ'**
  String get clinicianEditProfile;

  /// No description provided for @clinicianSupportRequest.
  ///
  /// In ar, this message translates to:
  /// **'Ø·Ù„Ø¨ Ø¯Ø¹Ù…'**
  String get clinicianSupportRequest;

  /// No description provided for @clinicianCurrentSupportRequests.
  ///
  /// In ar, this message translates to:
  /// **'Ø¹Ø¯Ø¯ Ø·Ù„Ø¨Ø§Øª Ø§Ù„Ø¯Ø¹Ù… Ø§Ù„Ø­Ø§Ù„ÙŠØ©'**
  String get clinicianCurrentSupportRequests;

  /// No description provided for @clinicianReferredChatCases.
  ///
  /// In ar, this message translates to:
  /// **'Ø­Ø§Ù„Ø§Øª Ø§Ù„Ø´Ø§Øª Ø§Ù„Ù…Ø­Ø§Ù„Ø©'**
  String get clinicianReferredChatCases;

  /// No description provided for @clinicianReferredChatCasesCount.
  ///
  /// In ar, this message translates to:
  /// **'Ø­Ø§Ù„Ø§Øª Ø§Ù„Ø´Ø§Øª Ø§Ù„Ù…Ø­Ø§Ù„Ø©'**
  String get clinicianReferredChatCasesCount;

  /// No description provided for @clinicianNewRequests.
  ///
  /// In ar, this message translates to:
  /// **'Ø·Ù„Ø¨Ø§Øª Ø¬Ø¯ÙŠØ¯Ø©'**
  String get clinicianNewRequests;

  /// No description provided for @clinicianActiveRequests.
  ///
  /// In ar, this message translates to:
  /// **'Ø·Ù„Ø¨Ø§Øª Ù†Ø´Ø·Ø©'**
  String get clinicianActiveRequests;

  /// No description provided for @clinicianCompleted.
  ///
  /// In ar, this message translates to:
  /// **'Ù…ÙƒØªÙ…Ù„Ø©'**
  String get clinicianCompleted;

  /// No description provided for @clinicianClosed.
  ///
  /// In ar, this message translates to:
  /// **'Ù…Ø±ÙÙˆØ¶Ø©/Ù…ØºÙ„Ù‚Ø©'**
  String get clinicianClosed;

  /// No description provided for @clinicianAcceptRequest.
  ///
  /// In ar, this message translates to:
  /// **'Ù‚Ø¨ÙˆÙ„ Ø§Ù„Ø·Ù„Ø¨'**
  String get clinicianAcceptRequest;

  /// No description provided for @clinicianRejectRequest.
  ///
  /// In ar, this message translates to:
  /// **'Ø±ÙØ¶ Ø§Ù„Ø·Ù„Ø¨'**
  String get clinicianRejectRequest;

  /// No description provided for @clinicianAssignedRequest.
  ///
  /// In ar, this message translates to:
  /// **'Ø·Ù„Ø¨ Ù…Ø®ØµØµ Ù„Ùƒ'**
  String get clinicianAssignedRequest;

  /// No description provided for @clinicianProfileChangeTitle.
  ///
  /// In ar, this message translates to:
  /// **'Ø·Ù„Ø¨ ØªØ¹Ø¯ÙŠÙ„ Ø§Ù„ØµÙˆØ±Ø© Ø£Ùˆ Ø§Ù„Ù†Ø¨Ø°Ø©'**
  String get clinicianProfileChangeTitle;

  /// No description provided for @clinicianNewPhotoUrl.
  ///
  /// In ar, this message translates to:
  /// **'Ø±Ø§Ø¨Ø· Ø§Ù„ØµÙˆØ±Ø© Ø§Ù„Ø¬Ø¯ÙŠØ¯Ø©'**
  String get clinicianNewPhotoUrl;

  /// No description provided for @clinicianNewBio.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ù†Ø¨Ø°Ø© Ø§Ù„Ø¬Ø¯ÙŠØ¯Ø©'**
  String get clinicianNewBio;

  /// No description provided for @clinicianSendingRequest.
  ///
  /// In ar, this message translates to:
  /// **'Ø¬Ø§Ø±Ù Ø¥Ø±Ø³Ø§Ù„ Ø§Ù„Ø·Ù„Ø¨...'**
  String get clinicianSendingRequest;

  /// No description provided for @clinicianSendChangeRequest.
  ///
  /// In ar, this message translates to:
  /// **'Ø¥Ø±Ø³Ø§Ù„ Ø·Ù„Ø¨ Ø§Ù„ØªØ¹Ø¯ÙŠÙ„'**
  String get clinicianSendChangeRequest;

  /// No description provided for @clinicianLogout.
  ///
  /// In ar, this message translates to:
  /// **'Ø®Ø±ÙˆØ¬'**
  String get clinicianLogout;

  /// No description provided for @clinicianPleaseSignIn.
  ///
  /// In ar, this message translates to:
  /// **'ÙŠØ¬Ø¨ ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø¯Ø®ÙˆÙ„ Ø£ÙˆÙ„Ù‹Ø§'**
  String get clinicianPleaseSignIn;

  /// No description provided for @clinicianInboxTitle.
  ///
  /// In ar, this message translates to:
  /// **'ÙˆØ§Ø±Ø¯ Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ'**
  String get clinicianInboxTitle;


  /// No description provided for @clinicianReject.
  ///
  /// In ar, this message translates to:
  /// **'Ø±ÙØ¶'**
  String get clinicianReject;

  /// No description provided for @clinicianAccept.
  ///
  /// In ar, this message translates to:
  /// **'Ù‚Ø¨ÙˆÙ„'**
  String get clinicianAccept;

  /// No description provided for @clinicianRejectRequestTitle.
  ///
  /// In ar, this message translates to:
  /// **'Ø±ÙØ¶ Ø§Ù„Ø·Ù„Ø¨'**
  String get clinicianRejectRequestTitle;

  /// No description provided for @clinicianRejectReason.
  ///
  /// In ar, this message translates to:
  /// **'Ø³Ø¨Ø¨ Ø§Ù„Ø±ÙØ¶'**
  String get clinicianRejectReason;

  /// No description provided for @clinicianRejectReasonHint.
  ///
  /// In ar, this message translates to:
  /// **'Ø§ÙƒØªØ¨ Ø³Ø¨Ø¨ Ø§Ù„Ø±ÙØ¶ Ù‡Ù†Ø§...'**
  String get clinicianRejectReasonHint;

  /// No description provided for @clinicianConfirmReject.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ£ÙƒÙŠØ¯ Ø§Ù„Ø±ÙØ¶'**
  String get clinicianConfirmReject;


  /// No description provided for @clinicianRejectFailed.
  ///
  /// In ar, this message translates to:
  /// **'ÙØ´Ù„ Ø§Ù„Ø±ÙØ¶'**
  String get clinicianRejectFailed;

  /// No description provided for @clinicianAcceptFailed.
  ///
  /// In ar, this message translates to:
  /// **'ÙØ´Ù„ Ø§Ù„Ù‚Ø¨ÙˆÙ„'**
  String get clinicianAcceptFailed;

  /// No description provided for @clinicianRequestRejected.
  ///
  /// In ar, this message translates to:
  /// **'ØªÙ… Ø±ÙØ¶ Ø§Ù„Ø·Ù„Ø¨'**
  String get clinicianRequestRejected;

  /// No description provided for @statusPendingReview.
  ///
  /// In ar, this message translates to:
  /// **'Ù‚ÙŠØ¯ Ø§Ù„Ù…Ø±Ø§Ø¬Ø¹Ø©'**
  String get statusPendingReview;

  /// No description provided for @statusRequestUnderReview.
  ///
  /// In ar, this message translates to:
  /// **'Ø·Ù„Ø¨Ùƒ Ù‚ÙŠØ¯ Ø§Ù„Ù…Ø±Ø§Ø¬Ø¹Ø©'**
  String get statusRequestUnderReview;

  /// No description provided for @statusCenterFollowUp.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ø·Ù„Ø¨ Ù„Ø¯Ù‰ Ø§Ù„Ù…Ø±ÙƒØ² Ù„Ù„ØªØ­Ù‚Ù‚ Ù…Ù† Ø§Ù„ØªÙˆÙØ±'**
  String get statusCenterFollowUp;

  /// No description provided for @statusClientUpdateRequired.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ù…Ø±ÙƒØ² Ø·Ù„Ø¨ ØªØ¹Ø¯ÙŠÙ„ Ù†ÙˆØ¹ Ø§Ù„Ø¥Ù‚Ø§Ù…Ø©'**
  String get statusClientUpdateRequired;

  /// No description provided for @statusCenterIntakePending.
  ///
  /// In ar, this message translates to:
  /// **'Ø¨Ø§Ù†ØªØ¸Ø§Ø± Ø§Ø³ØªÙƒÙ…Ø§Ù„ Ø¨ÙŠØ§Ù†Ø§Øª Ø§Ù„ØªÙ‚ÙŠÙŠÙ… Ø§Ù„Ø£ÙˆÙ„ÙŠ'**
  String get statusCenterIntakePending;

  /// No description provided for @statusCenterRecommendationPending.
  ///
  /// In ar, this message translates to:
  /// **'Ø¨Ø§Ù†ØªØ¸Ø§Ø± ØªÙˆØµÙŠØ© Ø§Ù„Ù…Ø±ÙƒØ² Ø¨Ø¹Ø¯ Ù…Ø±Ø§Ø¬Ø¹Ø© Ø§Ù„Ø­Ø§Ù„Ø©'**
  String get statusCenterRecommendationPending;

  /// No description provided for @statusApproved.
  ///
  /// In ar, this message translates to:
  /// **'ØªÙ…Øª Ø§Ù„Ù…ÙˆØ§ÙÙ‚Ø©'**
  String get statusApproved;

  /// No description provided for @statusRequestApproved.
  ///
  /// In ar, this message translates to:
  /// **'ØªÙ…Øª Ø§Ù„Ù…ÙˆØ§ÙÙ‚Ø© Ø¹Ù„Ù‰ Ø·Ù„Ø¨Ùƒ'**
  String get statusRequestApproved;




  /// No description provided for @statusSessionSetupPending.
  ///
  /// In ar, this message translates to:
  /// **'Ø¨Ø§Ù†ØªØ¸Ø§Ø± ØªØ¬Ù‡ÙŠØ² Ø§Ù„Ø¬Ù„Ø³Ø©'**
  String get statusSessionSetupPending;

  /// No description provided for @statusResidencySetupPending.
  ///
  /// In ar, this message translates to:
  /// **'Ø¨Ø§Ù†ØªØ¸Ø§Ø± ØªØ¬Ù‡ÙŠØ² Ø§Ù„Ø¥Ù‚Ø§Ù…Ø©'**
  String get statusResidencySetupPending;

  /// No description provided for @statusSessionScheduled.
  ///
  /// In ar, this message translates to:
  /// **'Ø¬Ù„Ø³Ø© Ù…Ø¬Ø¯ÙˆÙ„Ø©'**
  String get statusSessionScheduled;

  /// No description provided for @statusResidencyScheduled.
  ///
  /// In ar, this message translates to:
  /// **'Ø¥Ù‚Ø§Ù…Ø© Ù…Ø¬Ø¯ÙˆÙ„Ø©'**
  String get statusResidencyScheduled;

  /// No description provided for @statusSessionInProgress.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ø¬Ù„Ø³Ø© Ø¬Ø§Ø±ÙŠØ©'**
  String get statusSessionInProgress;

  /// No description provided for @statusResidencyInProgress.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ø¥Ù‚Ø§Ù…Ø© Ø¬Ø§Ø±ÙŠØ©'**
  String get statusResidencyInProgress;

  /// No description provided for @statusPendingReviews.
  ///
  /// In ar, this message translates to:
  /// **'Ø¨Ø§Ù†ØªØ¸Ø§Ø± Ø§Ù„ØªÙ‚ÙŠÙŠÙ…Ø§Øª'**
  String get statusPendingReviews;

  /// No description provided for @statusPendingDischargeReviews.
  ///
  /// In ar, this message translates to:
  /// **'Ø¨Ø§Ù†ØªØ¸Ø§Ø± ØªÙ‚Ø§Ø±ÙŠØ± Ø§Ù„Ø®Ø±ÙˆØ¬'**
  String get statusPendingDischargeReviews;



  /// No description provided for @statusCompleted.
  ///
  /// In ar, this message translates to:
  /// **'Ù…ÙƒØªÙ…Ù„'**
  String get statusCompleted;

  /// No description provided for @statusCompletedSuccessfully.
  ///
  /// In ar, this message translates to:
  /// **'Ù…ÙƒØªÙ…Ù„ Ø¨Ù†Ø¬Ø§Ø­'**
  String get statusCompletedSuccessfully;

  /// No description provided for @statusRequestCompleted.
  ///
  /// In ar, this message translates to:
  /// **'Ø§ÙƒØªÙ…Ù„ Ø§Ù„Ø·Ù„Ø¨'**
  String get statusRequestCompleted;

  /// No description provided for @statusReschedulePending.
  ///
  /// In ar, this message translates to:
  /// **'Ø¨Ø§Ù†ØªØ¸Ø§Ø± Ø¥Ø¹Ø§Ø¯Ø© Ø§Ù„Ø¬Ø¯ÙˆÙ„Ø©'**
  String get statusReschedulePending;

  /// No description provided for @statusAwaitingStartConfirmations.
  ///
  /// In ar, this message translates to:
  /// **'Ø¨Ø§Ù†ØªØ¸Ø§Ø± ØªØ£ÙƒÙŠØ¯ Ø§Ù„Ø¨Ø¯Ø§ÙŠØ©'**
  String get statusAwaitingStartConfirmations;

  /// No description provided for @statusRejected.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ¹Ø°Ù‘Ø± Ù‚Ø¨ÙˆÙ„ Ø§Ù„Ø·Ù„Ø¨'**
  String get statusRejected;

  /// No description provided for @statusClinicianRejected.
  ///
  /// In ar, this message translates to:
  /// **'ØªØ¹Ø°Ù‘Ø± ØªØ£ÙƒÙŠØ¯ Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ'**
  String get statusClinicianRejected;

  /// No description provided for @statusCancelled.
  ///
  /// In ar, this message translates to:
  /// **'Ù…Ù„ØºÙŠ'**
  String get statusCancelled;

  /// No description provided for @statusCancellationPending.
  ///
  /// In ar, this message translates to:
  /// **'Ø·Ù„Ø¨ Ø§Ù„Ø¥Ù„ØºØ§Ø¡ Ù‚ÙŠØ¯ Ø§Ù„Ù…Ø±Ø§Ø¬Ø¹Ø©'**
  String get statusCancellationPending;

  /// No description provided for @statusDisputeReceived.
  ///
  /// In ar, this message translates to:
  /// **'ØªÙ… Ø§Ø³ØªÙ„Ø§Ù… Ø§Ù„Ø´ÙƒÙˆÙ‰'**
  String get statusDisputeReceived;

  /// No description provided for @statusRequestCoordination.
  ///
  /// In ar, this message translates to:
  /// **'ÙŠØ¬Ø±ÙŠ ØªÙ†Ø³ÙŠÙ‚ Ø§Ù„Ø·Ù„Ø¨'**
  String get statusRequestCoordination;

  /// No description provided for @statusRequestUpdateInProgress.
  ///
  /// In ar, this message translates to:
  /// **'ÙŠØªÙ… ØªØ­Ø¯ÙŠØ« Ø­Ø§Ù„Ø© Ø§Ù„Ø·Ù„Ø¨'**
  String get statusRequestUpdateInProgress;

  /// No description provided for @statusNewRequest.
  ///
  /// In ar, this message translates to:
  /// **'Ø·Ù„Ø¨ Ø¬Ø¯ÙŠØ¯'**
  String get statusNewRequest;

  /// No description provided for @statusCenterAvailableResponse.
  ///
  /// In ar, this message translates to:
  /// **'Ø±Ø¯ Ø§Ù„Ù…Ø±ÙƒØ²: Ù…ØªØ§Ø­'**
  String get statusCenterAvailableResponse;

  /// No description provided for @statusCenterUnavailableResponse.
  ///
  /// In ar, this message translates to:
  /// **'Ø±Ø¯ Ø§Ù„Ù…Ø±ÙƒØ²: ØºÙŠØ± Ù…ØªØ§Ø­'**
  String get statusCenterUnavailableResponse;

  /// No description provided for @statusCenterNoResponse.
  ///
  /// In ar, this message translates to:
  /// **'Ø±Ø¯ Ø§Ù„Ù…Ø±ÙƒØ²: Ù„Ù… ÙŠØ±Ø¯ Ø¨Ø¹Ø¯'**
  String get statusCenterNoResponse;

  /// No description provided for @comingSoon.
  ///
  /// In ar, this message translates to:
  /// **'{title} â€” Ù‚Ø±ÙŠØ¨Ù‹Ø§'**
  String comingSoon(String title);

  /// No description provided for @modulePlaceholderBody.
  ///
  /// In ar, this message translates to:
  /// **'Ø§Ù„Ù…Ø­ØªÙˆÙ‰ Ù‚Ø±ÙŠØ¨Ù‹Ø§.'**
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



