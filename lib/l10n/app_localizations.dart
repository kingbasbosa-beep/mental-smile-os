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

  /// No description provided for @authLoginTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get authLoginTitle;

  /// No description provided for @authEmail.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get authEmail;

  /// No description provided for @authPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get authPassword;

  /// No description provided for @authLoginButton.
  ///
  /// In ar, this message translates to:
  /// **'دخول'**
  String get authLoginButton;

  /// No description provided for @authLoggingIn.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ تسجيل الدخول'**
  String get authLoggingIn;

  /// No description provided for @authInvalidCredentials.
  ///
  /// In ar, this message translates to:
  /// **'بيانات الدخول غير صحيحة'**
  String get authInvalidCredentials;

  /// No description provided for @authRequiredField.
  ///
  /// In ar, this message translates to:
  /// **'هذا الحقل مطلوب'**
  String get authRequiredField;

  /// No description provided for @authForgotPassword.
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة المرور؟'**
  String get authForgotPassword;

  /// No description provided for @authCreateAccount.
  ///
  /// In ar, this message translates to:
  /// **'للتسجيل اضغط هنا'**
  String get authCreateAccount;

  /// No description provided for @authClientRegister.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب عميل'**
  String get authClientRegister;

  /// No description provided for @authBackToHome.
  ///
  /// In ar, this message translates to:
  /// **'العودة للرئيسية'**
  String get authBackToHome;

  /// No description provided for @authLogoutConfirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد تسجيل الخروج'**
  String get authLogoutConfirm;

  /// No description provided for @authLogoutQuestion.
  ///
  /// In ar, this message translates to:
  /// **'هل تريد تسجيل الخروج؟'**
  String get authLogoutQuestion;

  /// No description provided for @authCancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get authCancel;

  /// No description provided for @authName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم'**
  String get authName;

  /// No description provided for @authConfirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get authConfirmPassword;

  /// No description provided for @authCreatingAccount.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ إنشاء الحساب...'**
  String get authCreatingAccount;

  /// No description provided for @authEmailRequired.
  ///
  /// In ar, this message translates to:
  /// **'اكتب البريد الإلكتروني'**
  String get authEmailRequired;

  /// No description provided for @authPasswordRequired.
  ///
  /// In ar, this message translates to:
  /// **'اكتب كلمة المرور'**
  String get authPasswordRequired;

  /// No description provided for @authNameRequired.
  ///
  /// In ar, this message translates to:
  /// **'اكتب الاسم'**
  String get authNameRequired;

  /// No description provided for @authPasswordsDoNotMatch.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور غير مطابق'**
  String get authPasswordsDoNotMatch;

  /// No description provided for @authInvalidEmail.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني غير صالح'**
  String get authInvalidEmail;

  /// No description provided for @authWeakPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور يجب أن تكون 6 أحرف على الأقل'**
  String get authWeakPassword;

  /// No description provided for @authLoginFailed.
  ///
  /// In ar, this message translates to:
  /// **'فشل تسجيل الدخول'**
  String get authLoginFailed;

  /// No description provided for @authRegistrationFailed.
  ///
  /// In ar, this message translates to:
  /// **'فشل إنشاء الحساب'**
  String get authRegistrationFailed;

  /// No description provided for @authUnexpectedError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ غير متوقع'**
  String get authUnexpectedError;

  /// No description provided for @authPleaseWait.
  ///
  /// In ar, this message translates to:
  /// **'من فضلك انتظر'**
  String get authPleaseWait;

  /// No description provided for @authInvalidCredentialsMessage.
  ///
  /// In ar, this message translates to:
  /// **'بيانات الدخول غير صحيحة'**
  String get authInvalidCredentialsMessage;

  /// No description provided for @authAccountCreated.
  ///
  /// In ar, this message translates to:
  /// **'تم إنشاء الحساب'**
  String get authAccountCreated;

  /// No description provided for @authTryAgain.
  ///
  /// In ar, this message translates to:
  /// **'تعذر إكمال العملية، حاول مرة أخرى'**
  String get authTryAgain;

  /// No description provided for @commonNext.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get commonNext;

  /// No description provided for @centersLoadError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ أثناء تحميل المراكز'**
  String get centersLoadError;

  /// No description provided for @centersEmpty.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد مراكز متاحة في هذه الفئة حاليًا'**
  String get centersEmpty;

  /// No description provided for @centersReadMore.
  ///
  /// In ar, this message translates to:
  /// **'اضغط للمزيد'**
  String get centersReadMore;

  /// No description provided for @centerDefaultName.
  ///
  /// In ar, this message translates to:
  /// **'مركز'**
  String get centerDefaultName;

  /// No description provided for @centerDetoxUnitAvailable.
  ///
  /// In ar, this message translates to:
  /// **'يوجد قسم أعراض انسحاب'**
  String get centerDetoxUnitAvailable;

  /// No description provided for @centerDetailsTitle.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل المركز'**
  String get centerDetailsTitle;

  /// No description provided for @centerDataNotFound.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر العثور على بيانات المركز'**
  String get centerDataNotFound;

  /// No description provided for @centerDataLoadError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ أثناء تحميل بيانات المركز'**
  String get centerDataLoadError;

  /// No description provided for @centerAvailable.
  ///
  /// In ar, this message translates to:
  /// **'متاح'**
  String get centerAvailable;

  /// No description provided for @centerUnavailable.
  ///
  /// In ar, this message translates to:
  /// **'غير متاح'**
  String get centerUnavailable;

  /// No description provided for @centerGallery.
  ///
  /// In ar, this message translates to:
  /// **'صور المركز'**
  String get centerGallery;

  /// No description provided for @centerPricing.
  ///
  /// In ar, this message translates to:
  /// **'تكلفة الإقامة'**
  String get centerPricing;

  /// No description provided for @centerTypeAndService.
  ///
  /// In ar, this message translates to:
  /// **'نوع المركز وخدمته'**
  String get centerTypeAndService;

  /// No description provided for @centerCapabilities.
  ///
  /// In ar, this message translates to:
  /// **'قدرات المركز'**
  String get centerCapabilities;

  /// No description provided for @centerContactLocation.
  ///
  /// In ar, this message translates to:
  /// **'التواصل والموقع'**
  String get centerContactLocation;

  /// No description provided for @centerAddress.
  ///
  /// In ar, this message translates to:
  /// **'العنوان'**
  String get centerAddress;

  /// No description provided for @centerCity.
  ///
  /// In ar, this message translates to:
  /// **'المدينة'**
  String get centerCity;

  /// No description provided for @centerPhone.
  ///
  /// In ar, this message translates to:
  /// **'الهاتف'**
  String get centerPhone;

  /// No description provided for @centerWhatsapp.
  ///
  /// In ar, this message translates to:
  /// **'واتساب'**
  String get centerWhatsapp;

  /// No description provided for @centerServices.
  ///
  /// In ar, this message translates to:
  /// **'الخدمات'**
  String get centerServices;

  /// No description provided for @centerAbout.
  ///
  /// In ar, this message translates to:
  /// **'نبذة عن المركز'**
  String get centerAbout;

  /// No description provided for @centerRequestViaAdmin.
  ///
  /// In ar, this message translates to:
  /// **'اطلب المركز عبر الإدارة'**
  String get centerRequestViaAdmin;

  /// No description provided for @webCenterRegistrationPortalTitle.
  ///
  /// In ar, this message translates to:
  /// **'بوابة تسجيل المراكز'**
  String get webCenterRegistrationPortalTitle;

  /// No description provided for @webCenterRegistrationPortalSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أنشئ حساب المركز ليتم مراجعته من الإدارة.'**
  String get webCenterRegistrationPortalSubtitle;

  /// No description provided for @webCenterRegistrationBasicInfoTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل المركز - البيانات الأساسية'**
  String get webCenterRegistrationBasicInfoTitle;

  /// No description provided for @webCenterGuidanceLibrary.
  ///
  /// In ar, this message translates to:
  /// **'مكتبة الإرشاد'**
  String get webCenterGuidanceLibrary;

  /// No description provided for @webCenterCenterName.
  ///
  /// In ar, this message translates to:
  /// **'اسم المركز'**
  String get webCenterCenterName;

  /// No description provided for @webCenterCategory.
  ///
  /// In ar, this message translates to:
  /// **'الفئة'**
  String get webCenterCategory;

  /// No description provided for @webCenterType.
  ///
  /// In ar, this message translates to:
  /// **'نوع المركز'**
  String get webCenterType;

  /// No description provided for @webCenterConfirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get webCenterConfirmPassword;

  /// No description provided for @webCenterNextBasicInfo.
  ///
  /// In ar, this message translates to:
  /// **'التالي: البيانات الأساسية'**
  String get webCenterNextBasicInfo;

  /// No description provided for @webCenterManagerName.
  ///
  /// In ar, this message translates to:
  /// **'اسم المسؤول'**
  String get webCenterManagerName;

  /// No description provided for @webCenterArea.
  ///
  /// In ar, this message translates to:
  /// **'المنطقة'**
  String get webCenterArea;

  /// No description provided for @webCenterDescription.
  ///
  /// In ar, this message translates to:
  /// **'الوصف'**
  String get webCenterDescription;

  /// No description provided for @webCenterHasDetoxUnit.
  ///
  /// In ar, this message translates to:
  /// **'يوجد قسم سحب سموم'**
  String get webCenterHasDetoxUnit;

  /// No description provided for @webCenterNextMediaGallery.
  ///
  /// In ar, this message translates to:
  /// **'التالي: الصور والمعرض'**
  String get webCenterNextMediaGallery;

  /// No description provided for @webCenterMediaGalleryTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل المركز - الصور والمعرض'**
  String get webCenterMediaGalleryTitle;

  /// No description provided for @webCenterFrontImageUrl.
  ///
  /// In ar, this message translates to:
  /// **'رابط صورة الواجهة'**
  String get webCenterFrontImageUrl;

  /// No description provided for @webCenterReceptionImageUrl.
  ///
  /// In ar, this message translates to:
  /// **'رابط صورة الاستقبال'**
  String get webCenterReceptionImageUrl;

  /// No description provided for @webCenterInsideImage1Url.
  ///
  /// In ar, this message translates to:
  /// **'رابط صورة داخلية 1'**
  String get webCenterInsideImage1Url;

  /// No description provided for @webCenterInsideImage2Url.
  ///
  /// In ar, this message translates to:
  /// **'رابط صورة داخلية 2'**
  String get webCenterInsideImage2Url;

  /// No description provided for @webCenterNextPricingCapabilities.
  ///
  /// In ar, this message translates to:
  /// **'التالي: التسعير والقدرات'**
  String get webCenterNextPricingCapabilities;

  /// No description provided for @webCenterPricingCapabilitiesTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل المركز - التسعير والقدرات'**
  String get webCenterPricingCapabilitiesTitle;

  /// No description provided for @webCenterEnabled.
  ///
  /// In ar, this message translates to:
  /// **'مفعل'**
  String get webCenterEnabled;

  /// No description provided for @webCenterPrice.
  ///
  /// In ar, this message translates to:
  /// **'السعر'**
  String get webCenterPrice;

  /// No description provided for @webCenterPricingUnit.
  ///
  /// In ar, this message translates to:
  /// **'وحدة التسعير'**
  String get webCenterPricingUnit;

  /// No description provided for @webCenterAcMode.
  ///
  /// In ar, this message translates to:
  /// **'نظام التكييف'**
  String get webCenterAcMode;

  /// No description provided for @webCenterTaxIncluded.
  ///
  /// In ar, this message translates to:
  /// **'يشمل الضريبة'**
  String get webCenterTaxIncluded;

  /// No description provided for @webCenterNextDocuments.
  ///
  /// In ar, this message translates to:
  /// **'التالي: المستندات'**
  String get webCenterNextDocuments;

  /// No description provided for @webCenterDocumentsTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل المركز - المستندات'**
  String get webCenterDocumentsTitle;

  /// No description provided for @webCenterFileName.
  ///
  /// In ar, this message translates to:
  /// **'اسم الملف'**
  String get webCenterFileName;

  /// No description provided for @webCenterFileUrlOptional.
  ///
  /// In ar, this message translates to:
  /// **'رابط الملف (اختياري)'**
  String get webCenterFileUrlOptional;

  /// No description provided for @webCenterReviewNoteOptional.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظة المراجعة (اختياري)'**
  String get webCenterReviewNoteOptional;

  /// No description provided for @webCenterSubmitForReview.
  ///
  /// In ar, this message translates to:
  /// **'إرسال للمراجعة'**
  String get webCenterSubmitForReview;

  /// No description provided for @webRegistrationBrowseLibraryDuringReview.
  ///
  /// In ar, this message translates to:
  /// **'تصفح مكتبة الإرشاد أثناء مراجعة حسابك'**
  String get webRegistrationBrowseLibraryDuringReview;

  /// No description provided for @webCenterCenterNameRequired.
  ///
  /// In ar, this message translates to:
  /// **'اكتب اسم المركز'**
  String get webCenterCenterNameRequired;

  /// No description provided for @webCenterRegistrationFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر إكمال التسجيل، حاول مرة أخرى.'**
  String get webCenterRegistrationFailed;

  /// No description provided for @webCenterPleaseRegisterBeforeSaving.
  ///
  /// In ar, this message translates to:
  /// **'يرجى التسجيل أو تسجيل الدخول قبل الحفظ.'**
  String get webCenterPleaseRegisterBeforeSaving;

  /// No description provided for @webCenterMissingSession.
  ///
  /// In ar, this message translates to:
  /// **'جلسة المركز غير متاحة'**
  String get webCenterMissingSession;

  /// No description provided for @webCenterSaveProfileFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر حفظ بيانات المركز'**
  String get webCenterSaveProfileFailed;

  /// No description provided for @webCenterSaveMediaFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر حفظ الصور'**
  String get webCenterSaveMediaFailed;

  /// No description provided for @webCenterSavePricingFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر حفظ التسعير'**
  String get webCenterSavePricingFailed;

  /// No description provided for @webCenterSubmitDocumentsFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر إرسال المستندات'**
  String get webCenterSubmitDocumentsFailed;

  /// No description provided for @webClinicianRegistrationAccountTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الأخصائي - الحساب'**
  String get webClinicianRegistrationAccountTitle;

  /// No description provided for @webClinicianRegistrationProfileTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الأخصائي - الملف الشخصي'**
  String get webClinicianRegistrationProfileTitle;

  /// No description provided for @webClinicianName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم'**
  String get webClinicianName;

  /// No description provided for @webClinicianProfessionalTitle.
  ///
  /// In ar, this message translates to:
  /// **'اللقب المهني'**
  String get webClinicianProfessionalTitle;

  /// No description provided for @webClinicianSpecialty.
  ///
  /// In ar, this message translates to:
  /// **'التخصص'**
  String get webClinicianSpecialty;

  /// No description provided for @webClinicianNextProfile.
  ///
  /// In ar, this message translates to:
  /// **'التالي: الملف الشخصي'**
  String get webClinicianNextProfile;

  /// No description provided for @webClinicianPhotoUrl.
  ///
  /// In ar, this message translates to:
  /// **'رابط الصورة'**
  String get webClinicianPhotoUrl;

  /// No description provided for @webClinicianBio.
  ///
  /// In ar, this message translates to:
  /// **'النبذة'**
  String get webClinicianBio;

  /// No description provided for @webClinicianNextSessions.
  ///
  /// In ar, this message translates to:
  /// **'التالي: الجلسات'**
  String get webClinicianNextSessions;

  /// No description provided for @webClinicianSessionsTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الأخصائي - الجلسات'**
  String get webClinicianSessionsTitle;

  /// No description provided for @webClinicianSessionPrice.
  ///
  /// In ar, this message translates to:
  /// **'سعر الجلسة'**
  String get webClinicianSessionPrice;

  /// No description provided for @webClinicianSessionDuration.
  ///
  /// In ar, this message translates to:
  /// **'مدة الجلسة'**
  String get webClinicianSessionDuration;

  /// No description provided for @webClinicianOnlineSessions.
  ///
  /// In ar, this message translates to:
  /// **'جلسات أونلاين'**
  String get webClinicianOnlineSessions;

  /// No description provided for @webClinicianInPersonSessions.
  ///
  /// In ar, this message translates to:
  /// **'جلسات حضورية'**
  String get webClinicianInPersonSessions;

  /// No description provided for @webClinicianGroupSessions.
  ///
  /// In ar, this message translates to:
  /// **'يقدم جلسات جماعية'**
  String get webClinicianGroupSessions;

  /// No description provided for @webClinicianDocumentsTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الأخصائي - المستندات'**
  String get webClinicianDocumentsTitle;

  /// No description provided for @webClinicianIdentityFileName.
  ///
  /// In ar, this message translates to:
  /// **'اسم ملف الهوية'**
  String get webClinicianIdentityFileName;

  /// No description provided for @webClinicianCertificateFileName.
  ///
  /// In ar, this message translates to:
  /// **'اسم ملف الشهادة'**
  String get webClinicianCertificateFileName;

  /// No description provided for @webClinicianExtraFileNameOptional.
  ///
  /// In ar, this message translates to:
  /// **'اسم ملف إضافي (اختياري)'**
  String get webClinicianExtraFileNameOptional;

  /// No description provided for @webClinicianRegistrationFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر إنشاء حساب الأخصائي'**
  String get webClinicianRegistrationFailed;

  /// No description provided for @webClinicianStartFromAccountStep.
  ///
  /// In ar, this message translates to:
  /// **'يرجى بدء التسجيل من خطوة الحساب'**
  String get webClinicianStartFromAccountStep;

  /// No description provided for @webClinicianAuthenticationSessionMissing.
  ///
  /// In ar, this message translates to:
  /// **'جلسة تسجيل الدخول غير متاحة'**
  String get webClinicianAuthenticationSessionMissing;

  /// No description provided for @webClinicianSaveProfileFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر حفظ الملف الشخصي'**
  String get webClinicianSaveProfileFailed;

  /// No description provided for @webClinicianSelectSessionMode.
  ///
  /// In ar, this message translates to:
  /// **'اختر طريقة جلسة واحدة على الأقل'**
  String get webClinicianSelectSessionMode;

  /// No description provided for @webClinicianSaveSessionsFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر حفظ بيانات الجلسات'**
  String get webClinicianSaveSessionsFailed;

  /// No description provided for @webClinicianSubmitDocumentsFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر إرسال المستندات'**
  String get webClinicianSubmitDocumentsFailed;

  /// No description provided for @bookingRequestTitle.
  ///
  /// In ar, this message translates to:
  /// **'طلب حجز'**
  String get bookingRequestTitle;

  /// No description provided for @bookingCenterRequestTitle.
  ///
  /// In ar, this message translates to:
  /// **'طلب حجز مركز'**
  String get bookingCenterRequestTitle;

  /// No description provided for @bookingMyRequestsTitle.
  ///
  /// In ar, this message translates to:
  /// **'طلباتي'**
  String get bookingMyRequestsTitle;

  /// No description provided for @bookingBookSpecialistTitle.
  ///
  /// In ar, this message translates to:
  /// **'حجز مع أخصائي'**
  String get bookingBookSpecialistTitle;

  /// No description provided for @bookingNoSpecialistsYet.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد أخصائيون بعد.'**
  String get bookingNoSpecialistsYet;

  /// No description provided for @bookingTrustedSpecialistHint.
  ///
  /// In ar, this message translates to:
  /// **'اختر أخصائيًا موثوقًا وأرسل طلبك للإدارة.'**
  String get bookingTrustedSpecialistHint;

  /// No description provided for @bookingDevUiEnabled.
  ///
  /// In ar, this message translates to:
  /// **'واجهة التطوير مفعلة'**
  String get bookingDevUiEnabled;

  /// No description provided for @bookingAdditionalNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات إضافية'**
  String get bookingAdditionalNotes;

  /// No description provided for @bookingWriteNoteHint.
  ///
  /// In ar, this message translates to:
  /// **'اكتب ملاحظتك هنا...'**
  String get bookingWriteNoteHint;

  /// No description provided for @bookingSendRequest.
  ///
  /// In ar, this message translates to:
  /// **'إرسال الطلب'**
  String get bookingSendRequest;

  /// No description provided for @bookingSendRequestToAdmin.
  ///
  /// In ar, this message translates to:
  /// **'إرسال الطلب إلى الإدارة'**
  String get bookingSendRequestToAdmin;

  /// No description provided for @bookingSending.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ الإرسال...'**
  String get bookingSending;

  /// No description provided for @bookingRequestSent.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال الطلب بنجاح'**
  String get bookingRequestSent;

  /// No description provided for @bookingRequestFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر إرسال الطلب'**
  String get bookingRequestFailed;

  /// No description provided for @bookingRequestSentAdminChat.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال الطلب وفتح محادثة المتابعة مع الإدارة'**
  String get bookingRequestSentAdminChat;

  /// No description provided for @bookingCenterRequestSent.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال طلب المركز إلى الإدارة بنجاح'**
  String get bookingCenterRequestSent;

  /// No description provided for @bookingCenterRequestSentToAdmin.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال طلب المركز إلى الإدارة'**
  String get bookingCenterRequestSentToAdmin;

  /// No description provided for @bookingUploadPaymentProof.
  ///
  /// In ar, this message translates to:
  /// **'رفع إثبات التحويل'**
  String get bookingUploadPaymentProof;

  /// No description provided for @bookingEditAccommodation.
  ///
  /// In ar, this message translates to:
  /// **'تعديل نوع الإقامة'**
  String get bookingEditAccommodation;

  /// No description provided for @bookingCompleteInitialIntake.
  ///
  /// In ar, this message translates to:
  /// **'استكمال بيانات التقييم الأولي'**
  String get bookingCompleteInitialIntake;

  /// No description provided for @bookingCreateNewRequest.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء طلب جديد'**
  String get bookingCreateNewRequest;

  /// No description provided for @bookingCreateNewFromRequest.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء طلب جديد من هذا الطلب'**
  String get bookingCreateNewFromRequest;

  /// No description provided for @bookingNewCenterRequestCreated.
  ///
  /// In ar, this message translates to:
  /// **'تم إنشاء طلب مركز جديد'**
  String get bookingNewCenterRequestCreated;

  /// No description provided for @bookingCurrent.
  ///
  /// In ar, this message translates to:
  /// **'الجارية'**
  String get bookingCurrent;

  /// No description provided for @bookingActionNeeded.
  ///
  /// In ar, this message translates to:
  /// **'تحتاج منك إجراء'**
  String get bookingActionNeeded;

  /// No description provided for @bookingCompleted.
  ///
  /// In ar, this message translates to:
  /// **'المكتملة'**
  String get bookingCompleted;

  /// No description provided for @bookingClosed.
  ///
  /// In ar, this message translates to:
  /// **'المغلقة'**
  String get bookingClosed;

  /// No description provided for @bookingEmptyCurrent.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات جارية الآن'**
  String get bookingEmptyCurrent;

  /// No description provided for @bookingEmptyActionNeeded.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات تحتاج منك إجراء الآن'**
  String get bookingEmptyActionNeeded;

  /// No description provided for @bookingEmptyCompleted.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات مكتملة بعد'**
  String get bookingEmptyCompleted;

  /// No description provided for @bookingEmptyClosed.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات مغلقة'**
  String get bookingEmptyClosed;

  /// No description provided for @bookingSpecialistFallback.
  ///
  /// In ar, this message translates to:
  /// **'الأخصائي'**
  String get bookingSpecialistFallback;

  /// No description provided for @bookingCenterRequestFallback.
  ///
  /// In ar, this message translates to:
  /// **'طلب مركز'**
  String get bookingCenterRequestFallback;

  /// No description provided for @clientDashboardWelcome.
  ///
  /// In ar, this message translates to:
  /// **'مرحبًا {name}'**
  String clientDashboardWelcome(String name);

  /// No description provided for @clientDashboardSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'كل خطواتك موجودة هنا بهدوء.'**
  String get clientDashboardSubtitle;

  /// No description provided for @clientBookings.
  ///
  /// In ar, this message translates to:
  /// **'طلبات الحجز'**
  String get clientBookings;

  /// No description provided for @clientBookingRequests.
  ///
  /// In ar, this message translates to:
  /// **'طلبات الحجز'**
  String get clientBookingRequests;

  /// No description provided for @clientSupport.
  ///
  /// In ar, this message translates to:
  /// **'الدعم'**
  String get clientSupport;

  /// No description provided for @clientSupportRequests.
  ///
  /// In ar, this message translates to:
  /// **'طلبات الدعم'**
  String get clientSupportRequests;

  /// No description provided for @clientPaymentProof.
  ///
  /// In ar, this message translates to:
  /// **'إثبات التحويل النقدي'**
  String get clientPaymentProof;

  /// No description provided for @clientUploadPaymentProof.
  ///
  /// In ar, this message translates to:
  /// **'رفع إثبات التحويل'**
  String get clientUploadPaymentProof;

  /// No description provided for @clientMySessions.
  ///
  /// In ar, this message translates to:
  /// **'جلساتي'**
  String get clientMySessions;

  /// No description provided for @clientLinksAndCodes.
  ///
  /// In ar, this message translates to:
  /// **'الروابط والأكواد'**
  String get clientLinksAndCodes;

  /// No description provided for @clientFollowUp.
  ///
  /// In ar, this message translates to:
  /// **'المتابعة'**
  String get clientFollowUp;

  /// No description provided for @clientMessagePreferences.
  ///
  /// In ar, this message translates to:
  /// **'تفضيلات الرسائل'**
  String get clientMessagePreferences;

  /// No description provided for @clientRatingsCount.
  ///
  /// In ar, this message translates to:
  /// **'عدد التقييمات'**
  String get clientRatingsCount;

  /// No description provided for @clientAverageStars.
  ///
  /// In ar, this message translates to:
  /// **'متوسط النجوم'**
  String get clientAverageStars;

  /// No description provided for @clientOverallAverage.
  ///
  /// In ar, this message translates to:
  /// **'المتوسط العام'**
  String get clientOverallAverage;

  /// No description provided for @clinicianOperations.
  ///
  /// In ar, this message translates to:
  /// **'العمليات'**
  String get clinicianOperations;

  /// No description provided for @clinicianDashboard.
  ///
  /// In ar, this message translates to:
  /// **'لوحة الأخصائي'**
  String get clinicianDashboard;

  /// No description provided for @clinicianOpenCases.
  ///
  /// In ar, this message translates to:
  /// **'فتح الحالات'**
  String get clinicianOpenCases;

  /// No description provided for @clinicianSendSupportRequest.
  ///
  /// In ar, this message translates to:
  /// **'إرسال طلب دعم'**
  String get clinicianSendSupportRequest;

  /// No description provided for @clinicianEditProfile.
  ///
  /// In ar, this message translates to:
  /// **'تعديل بياناتي'**
  String get clinicianEditProfile;

  /// No description provided for @clinicianMySessions.
  ///
  /// In ar, this message translates to:
  /// **'جلساتي'**
  String get clinicianMySessions;

  /// No description provided for @clinicianSupportRequest.
  ///
  /// In ar, this message translates to:
  /// **'طلب دعم'**
  String get clinicianSupportRequest;

  /// No description provided for @clinicianCurrentSupportRequests.
  ///
  /// In ar, this message translates to:
  /// **'عدد طلبات الدعم الحالية'**
  String get clinicianCurrentSupportRequests;

  /// No description provided for @clinicianReferredChatCases.
  ///
  /// In ar, this message translates to:
  /// **'حالات الشات المحالة'**
  String get clinicianReferredChatCases;

  /// No description provided for @clinicianReferredChatCasesCount.
  ///
  /// In ar, this message translates to:
  /// **'حالات الشات المحالة'**
  String get clinicianReferredChatCasesCount;

  /// No description provided for @clinicianNewRequests.
  ///
  /// In ar, this message translates to:
  /// **'طلبات جديدة'**
  String get clinicianNewRequests;

  /// No description provided for @clinicianActiveRequests.
  ///
  /// In ar, this message translates to:
  /// **'طلبات نشطة'**
  String get clinicianActiveRequests;

  /// No description provided for @clinicianCompleted.
  ///
  /// In ar, this message translates to:
  /// **'مكتملة'**
  String get clinicianCompleted;

  /// No description provided for @clinicianClosed.
  ///
  /// In ar, this message translates to:
  /// **'مرفوضة/مغلقة'**
  String get clinicianClosed;

  /// No description provided for @clinicianAcceptRequest.
  ///
  /// In ar, this message translates to:
  /// **'قبول الطلب'**
  String get clinicianAcceptRequest;

  /// No description provided for @clinicianRejectRequest.
  ///
  /// In ar, this message translates to:
  /// **'رفض الطلب'**
  String get clinicianRejectRequest;

  /// No description provided for @clinicianEndSession.
  ///
  /// In ar, this message translates to:
  /// **'إنهاء الجلسة'**
  String get clinicianEndSession;

  /// No description provided for @clinicianReviewSession.
  ///
  /// In ar, this message translates to:
  /// **'تقييم الجلسة'**
  String get clinicianReviewSession;

  /// No description provided for @clinicianAssignedRequest.
  ///
  /// In ar, this message translates to:
  /// **'طلب مخصص لك'**
  String get clinicianAssignedRequest;

  /// No description provided for @clinicianProfileChangeTitle.
  ///
  /// In ar, this message translates to:
  /// **'طلب تعديل الصورة أو النبذة'**
  String get clinicianProfileChangeTitle;

  /// No description provided for @clinicianNewPhotoUrl.
  ///
  /// In ar, this message translates to:
  /// **'رابط الصورة الجديدة'**
  String get clinicianNewPhotoUrl;

  /// No description provided for @clinicianNewBio.
  ///
  /// In ar, this message translates to:
  /// **'النبذة الجديدة'**
  String get clinicianNewBio;

  /// No description provided for @clinicianSendingRequest.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ إرسال الطلب...'**
  String get clinicianSendingRequest;

  /// No description provided for @clinicianSendChangeRequest.
  ///
  /// In ar, this message translates to:
  /// **'إرسال طلب التعديل'**
  String get clinicianSendChangeRequest;

  /// No description provided for @clinicianRatings.
  ///
  /// In ar, this message translates to:
  /// **'عدد التقييمات'**
  String get clinicianRatings;

  /// No description provided for @clinicianStars.
  ///
  /// In ar, this message translates to:
  /// **'متوسط النجوم'**
  String get clinicianStars;

  /// No description provided for @clinicianOverall.
  ///
  /// In ar, this message translates to:
  /// **'المتوسط العام'**
  String get clinicianOverall;

  /// No description provided for @clinicianLogout.
  ///
  /// In ar, this message translates to:
  /// **'خروج'**
  String get clinicianLogout;

  /// No description provided for @clinicianPleaseSignIn.
  ///
  /// In ar, this message translates to:
  /// **'يجب تسجيل الدخول أولًا'**
  String get clinicianPleaseSignIn;

  /// No description provided for @statusPendingReview.
  ///
  /// In ar, this message translates to:
  /// **'قيد المراجعة'**
  String get statusPendingReview;

  /// No description provided for @statusRequestUnderReview.
  ///
  /// In ar, this message translates to:
  /// **'طلبك قيد المراجعة'**
  String get statusRequestUnderReview;

  /// No description provided for @statusCenterFollowUp.
  ///
  /// In ar, this message translates to:
  /// **'الطلب لدى المركز للتحقق من التوفر'**
  String get statusCenterFollowUp;

  /// No description provided for @statusClientUpdateRequired.
  ///
  /// In ar, this message translates to:
  /// **'المركز طلب تعديل نوع الإقامة'**
  String get statusClientUpdateRequired;

  /// No description provided for @statusCenterIntakePending.
  ///
  /// In ar, this message translates to:
  /// **'بانتظار استكمال بيانات التقييم الأولي'**
  String get statusCenterIntakePending;

  /// No description provided for @statusCenterRecommendationPending.
  ///
  /// In ar, this message translates to:
  /// **'بانتظار توصية المركز بعد مراجعة الحالة'**
  String get statusCenterRecommendationPending;

  /// No description provided for @statusApproved.
  ///
  /// In ar, this message translates to:
  /// **'تمت الموافقة'**
  String get statusApproved;

  /// No description provided for @statusRequestApproved.
  ///
  /// In ar, this message translates to:
  /// **'تمت الموافقة على طلبك'**
  String get statusRequestApproved;

  /// No description provided for @statusAwaitingPayment.
  ///
  /// In ar, this message translates to:
  /// **'بانتظار الدفع'**
  String get statusAwaitingPayment;

  /// No description provided for @statusUploadPaymentProof.
  ///
  /// In ar, this message translates to:
  /// **'يرجى رفع إثبات التحويل'**
  String get statusUploadPaymentProof;

  /// No description provided for @statusPaymentReview.
  ///
  /// In ar, this message translates to:
  /// **'إثبات الدفع قيد المراجعة'**
  String get statusPaymentReview;

  /// No description provided for @statusSessionSetupPending.
  ///
  /// In ar, this message translates to:
  /// **'بانتظار تجهيز الجلسة'**
  String get statusSessionSetupPending;

  /// No description provided for @statusResidencySetupPending.
  ///
  /// In ar, this message translates to:
  /// **'بانتظار تجهيز الإقامة'**
  String get statusResidencySetupPending;

  /// No description provided for @statusSessionScheduled.
  ///
  /// In ar, this message translates to:
  /// **'جلسة مجدولة'**
  String get statusSessionScheduled;

  /// No description provided for @statusResidencyScheduled.
  ///
  /// In ar, this message translates to:
  /// **'إقامة مجدولة'**
  String get statusResidencyScheduled;

  /// No description provided for @statusSessionInProgress.
  ///
  /// In ar, this message translates to:
  /// **'الجلسة جارية'**
  String get statusSessionInProgress;

  /// No description provided for @statusResidencyInProgress.
  ///
  /// In ar, this message translates to:
  /// **'الإقامة جارية'**
  String get statusResidencyInProgress;

  /// No description provided for @statusPendingReviews.
  ///
  /// In ar, this message translates to:
  /// **'بانتظار التقييمات'**
  String get statusPendingReviews;

  /// No description provided for @statusPendingDischargeReviews.
  ///
  /// In ar, this message translates to:
  /// **'بانتظار تقارير الخروج'**
  String get statusPendingDischargeReviews;

  /// No description provided for @statusPayoutPending.
  ///
  /// In ar, this message translates to:
  /// **'بانتظار الإغلاق المالي'**
  String get statusPayoutPending;

  /// No description provided for @statusCenterAccountingReview.
  ///
  /// In ar, this message translates to:
  /// **'بانتظار المراجعة المحاسبية للمركز'**
  String get statusCenterAccountingReview;

  /// No description provided for @statusCompleted.
  ///
  /// In ar, this message translates to:
  /// **'مكتمل'**
  String get statusCompleted;

  /// No description provided for @statusCompletedSuccessfully.
  ///
  /// In ar, this message translates to:
  /// **'مكتمل بنجاح'**
  String get statusCompletedSuccessfully;

  /// No description provided for @statusRequestCompleted.
  ///
  /// In ar, this message translates to:
  /// **'اكتمل الطلب'**
  String get statusRequestCompleted;

  /// No description provided for @statusReschedulePending.
  ///
  /// In ar, this message translates to:
  /// **'بانتظار إعادة الجدولة'**
  String get statusReschedulePending;

  /// No description provided for @statusAwaitingStartConfirmations.
  ///
  /// In ar, this message translates to:
  /// **'بانتظار تأكيد البداية'**
  String get statusAwaitingStartConfirmations;

  /// No description provided for @statusRejected.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر قبول الطلب'**
  String get statusRejected;

  /// No description provided for @statusClinicianRejected.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تأكيد الأخصائي'**
  String get statusClinicianRejected;

  /// No description provided for @statusCancelled.
  ///
  /// In ar, this message translates to:
  /// **'ملغي'**
  String get statusCancelled;

  /// No description provided for @statusCancellationPending.
  ///
  /// In ar, this message translates to:
  /// **'طلب الإلغاء قيد المراجعة'**
  String get statusCancellationPending;

  /// No description provided for @statusDisputeReceived.
  ///
  /// In ar, this message translates to:
  /// **'تم استلام الشكوى'**
  String get statusDisputeReceived;

  /// No description provided for @statusRequestCoordination.
  ///
  /// In ar, this message translates to:
  /// **'يجري تنسيق الطلب'**
  String get statusRequestCoordination;

  /// No description provided for @statusRequestUpdateInProgress.
  ///
  /// In ar, this message translates to:
  /// **'يتم تحديث حالة الطلب'**
  String get statusRequestUpdateInProgress;

  /// No description provided for @statusNewRequest.
  ///
  /// In ar, this message translates to:
  /// **'طلب جديد'**
  String get statusNewRequest;

  /// No description provided for @statusCenterAvailableResponse.
  ///
  /// In ar, this message translates to:
  /// **'رد المركز: متاح'**
  String get statusCenterAvailableResponse;

  /// No description provided for @statusCenterUnavailableResponse.
  ///
  /// In ar, this message translates to:
  /// **'رد المركز: غير متاح'**
  String get statusCenterUnavailableResponse;

  /// No description provided for @statusCenterNoResponse.
  ///
  /// In ar, this message translates to:
  /// **'رد المركز: لم يرد بعد'**
  String get statusCenterNoResponse;

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
