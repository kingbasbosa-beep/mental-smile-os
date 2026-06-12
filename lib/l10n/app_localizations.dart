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

  /// No description provided for @appTitle.
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
  /// **'تواصل مع المركز'**
  String get centerRequestViaAdmin;

  /// No description provided for @centerInboxTitle.
  ///
  /// In ar, this message translates to:
  /// **'رسائل المركز'**
  String get centerInboxTitle;

  /// No description provided for @commonAll.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get commonAll;

  /// No description provided for @statusPending.
  ///
  /// In ar, this message translates to:
  /// **'غير مكتمل'**
  String get statusPending;

  /// No description provided for @centerSaveResponse.
  ///
  /// In ar, this message translates to:
  /// **'حفظ الرد'**
  String get centerSaveResponse;

  /// No description provided for @webCenterRegistrationPortalTitle.
  ///
  /// In ar, this message translates to:
  /// **'بوابة تسجيل المراكز'**
  String get webCenterRegistrationPortalTitle;

  /// No description provided for @webCenterRegistrationPortalSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أنشئ حساب المركز لإكمال جاهزية الإقرار.'**
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
  /// **'التالي: تكلفة الخدمة والقدرات'**
  String get webCenterNextPricingCapabilities;

  /// No description provided for @webCenterPricingCapabilitiesTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل المركز - تكلفة الخدمة والقدرات'**
  String get webCenterPricingCapabilitiesTitle;

  /// No description provided for @webCenterEnabled.
  ///
  /// In ar, this message translates to:
  /// **'مفعل'**
  String get webCenterEnabled;

  /// No description provided for @webCenterPrice.
  ///
  /// In ar, this message translates to:
  /// **'تكلفة الخدمة'**
  String get webCenterPrice;

  /// No description provided for @webCenterPricingUnit.
  ///
  /// In ar, this message translates to:
  /// **'وحدة التكلفة'**
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
  /// **'ملاحظة الإقرار (اختياري)'**
  String get webCenterReviewNoteOptional;

  /// No description provided for @webCenterSubmitForReview.
  ///
  /// In ar, this message translates to:
  /// **'إرسال الإقرار'**
  String get webCenterSubmitForReview;

  /// No description provided for @webRegistrationBrowseLibraryDuringReview.
  ///
  /// In ar, this message translates to:
  /// **'تصفح مكتبة الإرشاد أثناء فحص الجاهزية'**
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
  /// **'خطوة التسجيل غير متاحة'**
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
  /// **'تعذر حفظ معلومات تكلفة الخدمة'**
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

  /// No description provided for @webClinicianSessionPrice.
  ///
  /// In ar, this message translates to:
  /// **'معلومات تكلفة الخدمة'**
  String get webClinicianSessionPrice;

  /// No description provided for @webClinicianSessionDuration.
  ///
  /// In ar, this message translates to:
  /// **'معلومات وقت الخدمة'**
  String get webClinicianSessionDuration;

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
  /// **'خطوة التسجيل غير متاحة'**
  String get webClinicianAuthenticationSessionMissing;

  /// No description provided for @webClinicianSaveProfileFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر حفظ الملف الشخصي'**
  String get webClinicianSaveProfileFailed;

  /// No description provided for @webClinicianSubmitDocumentsFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر إرسال المستندات'**
  String get webClinicianSubmitDocumentsFailed;

  /// No description provided for @clientDashboardSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'كل خطواتك موجودة هنا بهدوء.'**
  String get clientDashboardSubtitle;

  /// No description provided for @clientSupport.
  ///
  /// In ar, this message translates to:
  /// **'الدعم'**
  String get clientSupport;

  /// No description provided for @clientSupportRequests.
  ///
  /// In ar, this message translates to:
  /// **'إشارات الدعم'**
  String get clientSupportRequests;

  /// No description provided for @clientLinksAndCodes.
  ///
  /// In ar, this message translates to:
  /// **'الروابط والأكواد'**
  String get clientLinksAndCodes;

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

  /// No description provided for @clinicianDashboard.
  ///
  /// In ar, this message translates to:
  /// **'لوحة الأخصائي'**
  String get clinicianDashboard;

  /// No description provided for @clinicianOpenCases.
  ///
  /// In ar, this message translates to:
  /// **'محادثات مفتوحة'**
  String get clinicianOpenCases;

  /// No description provided for @clinicianSendSupportRequest.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة إشارة دعم'**
  String get clinicianSendSupportRequest;

  /// No description provided for @clinicianEditProfile.
  ///
  /// In ar, this message translates to:
  /// **'تعديل بياناتي'**
  String get clinicianEditProfile;

  /// No description provided for @clinicianSupportRequest.
  ///
  /// In ar, this message translates to:
  /// **'إشارة دعم'**
  String get clinicianSupportRequest;

  /// No description provided for @clinicianCurrentSupportRequests.
  ///
  /// In ar, this message translates to:
  /// **'إشارات الدعم الحالية'**
  String get clinicianCurrentSupportRequests;

  /// No description provided for @clinicianReferredChatCases.
  ///
  /// In ar, this message translates to:
  /// **'محادثات مشتركة'**
  String get clinicianReferredChatCases;

  /// No description provided for @clinicianReferredChatCasesCount.
  ///
  /// In ar, this message translates to:
  /// **'محادثات مشتركة'**
  String get clinicianReferredChatCasesCount;

  /// No description provided for @clinicianNewRequests.
  ///
  /// In ar, this message translates to:
  /// **'إشارات جديدة'**
  String get clinicianNewRequests;

  /// No description provided for @clinicianActiveRequests.
  ///
  /// In ar, this message translates to:
  /// **'قيد المعالجة'**
  String get clinicianActiveRequests;

  /// No description provided for @clinicianCompleted.
  ///
  /// In ar, this message translates to:
  /// **'مكتملة'**
  String get clinicianCompleted;

  /// No description provided for @clinicianClosed.
  ///
  /// In ar, this message translates to:
  /// **'مغلقة'**
  String get clinicianClosed;

  /// No description provided for @clinicianAcceptRequest.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الجاهزية'**
  String get clinicianAcceptRequest;

  /// No description provided for @clinicianRejectRequest.
  ///
  /// In ar, this message translates to:
  /// **'تحديد كغير مكتمل'**
  String get clinicianRejectRequest;

  /// No description provided for @clinicianProfileChangeTitle.
  ///
  /// In ar, this message translates to:
  /// **'إقرار تحديث الصورة أو النبذة'**
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
  /// **'جارٍ مشاركة الإشارة...'**
  String get clinicianSendingRequest;

  /// No description provided for @clinicianSendChangeRequest.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة إقرار التحديث'**
  String get clinicianSendChangeRequest;

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

  /// No description provided for @clinicianInboxTitle.
  ///
  /// In ar, this message translates to:
  /// **'رسائل الأخصائي'**
  String get clinicianInboxTitle;

  /// No description provided for @clinicianReject.
  ///
  /// In ar, this message translates to:
  /// **'تحديد كغير مكتمل'**
  String get clinicianReject;

  /// No description provided for @clinicianAccept.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الجاهزية'**
  String get clinicianAccept;

  /// No description provided for @clinicianRejectRequestTitle.
  ///
  /// In ar, this message translates to:
  /// **'تحديد كغير مكتمل'**
  String get clinicianRejectRequestTitle;

  /// No description provided for @clinicianRejectReason.
  ///
  /// In ar, this message translates to:
  /// **'سبب عدم الاكتمال'**
  String get clinicianRejectReason;

  /// No description provided for @clinicianRejectReasonHint.
  ///
  /// In ar, this message translates to:
  /// **'اكتب سبب عدم الاكتمال هنا...'**
  String get clinicianRejectReasonHint;

  /// No description provided for @clinicianConfirmReject.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد حالة عدم الاكتمال'**
  String get clinicianConfirmReject;

  /// No description provided for @clinicianRejectFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحديد عدم الاكتمال'**
  String get clinicianRejectFailed;

  /// No description provided for @clinicianAcceptFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تأكيد الجاهزية'**
  String get clinicianAcceptFailed;

  /// No description provided for @statusCenterFollowUp.
  ///
  /// In ar, this message translates to:
  /// **'إشارة توفر المركز غير مكتملة'**
  String get statusCenterFollowUp;

  /// No description provided for @statusClientUpdateRequired.
  ///
  /// In ar, this message translates to:
  /// **'مطلوب تحديث معلومات المركز'**
  String get statusClientUpdateRequired;

  /// No description provided for @statusCenterIntakePending.
  ///
  /// In ar, this message translates to:
  /// **'المعلومات الأولية غير مكتملة'**
  String get statusCenterIntakePending;

  /// No description provided for @statusCenterRecommendationPending.
  ///
  /// In ar, this message translates to:
  /// **'إرشاد المركز غير متاح بعد'**
  String get statusCenterRecommendationPending;

  /// No description provided for @statusResidencySetupPending.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل الدعم السكني غير مكتملة'**
  String get statusResidencySetupPending;

  /// No description provided for @statusResidencyScheduled.
  ///
  /// In ar, this message translates to:
  /// **'تم حفظ توقيت الدعم السكني'**
  String get statusResidencyScheduled;

  /// No description provided for @statusResidencyInProgress.
  ///
  /// In ar, this message translates to:
  /// **'الدعم السكني قيد التقدم'**
  String get statusResidencyInProgress;

  /// No description provided for @statusPendingDischargeReviews.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات الاستمرارية غير مكتملة'**
  String get statusPendingDischargeReviews;

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
  /// **'تمت معالجة إشارة الدعم'**
  String get statusRequestCompleted;

  /// No description provided for @statusReschedulePending.
  ///
  /// In ar, this message translates to:
  /// **'تحديث التوقيت غير مكتمل'**
  String get statusReschedulePending;

  /// No description provided for @statusAwaitingStartConfirmations.
  ///
  /// In ar, this message translates to:
  /// **'بانتظار تأكيد البداية'**
  String get statusAwaitingStartConfirmations;

  /// No description provided for @statusRejected.
  ///
  /// In ar, this message translates to:
  /// **'غير متاح'**
  String get statusRejected;

  /// No description provided for @statusClinicianRejected.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الأخصائي غير متاح'**
  String get statusClinicianRejected;

  /// No description provided for @statusCancelled.
  ///
  /// In ar, this message translates to:
  /// **'ملغي'**
  String get statusCancelled;

  /// No description provided for @statusDisputeReceived.
  ///
  /// In ar, this message translates to:
  /// **'تم استلام الشكوى'**
  String get statusDisputeReceived;

  /// No description provided for @statusRequestCoordination.
  ///
  /// In ar, this message translates to:
  /// **'يجري إعداد إشارة الدعم'**
  String get statusRequestCoordination;

  /// No description provided for @statusRequestUpdateInProgress.
  ///
  /// In ar, this message translates to:
  /// **'يتم تحديث حالة الإشارة'**
  String get statusRequestUpdateInProgress;

  /// No description provided for @statusNewRequest.
  ///
  /// In ar, this message translates to:
  /// **'إشارة دعم جديدة'**
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

  /// No description provided for @localeLabel.
  ///
  /// In ar, this message translates to:
  /// **'اللغة: {code} (اضغط أو 🌐)'**
  String localeLabel(String code);

  /// No description provided for @clientDashboardWelcome.
  ///
  /// In ar, this message translates to:
  /// **'مرحبًا {name}'**
  String clientDashboardWelcome(String name);

  /// No description provided for @comingSoon.
  ///
  /// In ar, this message translates to:
  /// **'{title} — قريبًا'**
  String comingSoon(String title);
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
