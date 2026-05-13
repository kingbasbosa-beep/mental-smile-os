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
  String get authLoginTitle => 'Log in';

  @override
  String get authEmail => 'Email';

  @override
  String get authPassword => 'Password';

  @override
  String get authLoginButton => 'Log in';

  @override
  String get authLoggingIn => 'Logging in';

  @override
  String get authInvalidCredentials => 'Invalid login details';

  @override
  String get authRequiredField => 'This field is required';

  @override
  String get authForgotPassword => 'Forgot password?';

  @override
  String get authCreateAccount => 'Tap here to register';

  @override
  String get authClientRegister => 'Create client account';

  @override
  String get authBackToHome => 'Back to home';

  @override
  String get authLogoutConfirm => 'Confirm log out';

  @override
  String get authLogoutQuestion => 'Do you want to log out?';

  @override
  String get authCancel => 'Cancel';

  @override
  String get authName => 'Name';

  @override
  String get authConfirmPassword => 'Confirm password';

  @override
  String get authCreatingAccount => 'Creating account...';

  @override
  String get authEmailRequired => 'Enter your email';

  @override
  String get authPasswordRequired => 'Enter your password';

  @override
  String get authNameRequired => 'Enter your name';

  @override
  String get authPasswordsDoNotMatch => 'Passwords do not match';

  @override
  String get authInvalidEmail => 'Invalid email address';

  @override
  String get authWeakPassword => 'Password must be at least 6 characters';

  @override
  String get authLoginFailed => 'Login failed';

  @override
  String get authRegistrationFailed => 'Could not create account';

  @override
  String get authUnexpectedError => 'Something went wrong';

  @override
  String get authPleaseWait => 'Please wait';

  @override
  String get authInvalidCredentialsMessage => 'Invalid login details';

  @override
  String get authAccountCreated => 'Account created';

  @override
  String get authTryAgain => 'Could not complete this. Please try again';

  @override
  String get commonNext => 'Next';

  @override
  String get centersLoadError => 'Something went wrong while loading centers';

  @override
  String get centersEmpty =>
      'No centers are available in this category right now';

  @override
  String get centersReadMore => 'Read more';

  @override
  String get centerDefaultName => 'Center';

  @override
  String get centerDetoxUnitAvailable => 'Includes a withdrawal unit';

  @override
  String get centerDetailsTitle => 'Center details';

  @override
  String get centerDataNotFound => 'Could not find this center\'s details';

  @override
  String get centerDataLoadError =>
      'Something went wrong while loading center details';

  @override
  String get centerAvailable => 'Available';

  @override
  String get centerUnavailable => 'Unavailable';

  @override
  String get centerGallery => 'Center photos';

  @override
  String get centerPricing => 'Cost of stay';

  @override
  String get centerTypeAndService => 'Center type and service';

  @override
  String get centerCapabilities => 'Center capabilities';

  @override
  String get centerContactLocation => 'Contact and location';

  @override
  String get centerAddress => 'Address';

  @override
  String get centerCity => 'City';

  @override
  String get centerPhone => 'Phone';

  @override
  String get centerWhatsapp => 'WhatsApp';

  @override
  String get centerServices => 'Services';

  @override
  String get centerAbout => 'About the center';

  @override
  String get centerRequestViaAdmin => 'Request this center through admin';

  @override
  String get bookingRequestTitle => 'Booking request';

  @override
  String get bookingCenterRequestTitle => 'Center booking request';

  @override
  String get bookingMyRequestsTitle => 'My requests';

  @override
  String get bookingAdditionalNotes => 'Additional notes';

  @override
  String get bookingWriteNoteHint => 'Write your note here...';

  @override
  String get bookingSendRequest => 'Send request';

  @override
  String get bookingSendRequestToAdmin => 'Send request to admin';

  @override
  String get bookingSending => 'Sending...';

  @override
  String get bookingRequestSent => 'Request sent successfully';

  @override
  String get bookingRequestFailed => 'Could not send request';

  @override
  String get bookingRequestSentAdminChat =>
      'Request sent and admin follow-up chat opened';

  @override
  String get bookingCenterRequestSent =>
      'Center request sent to admin successfully';

  @override
  String get bookingCenterRequestSentToAdmin => 'Center request sent to admin';

  @override
  String get bookingUploadPaymentProof => 'Upload payment proof';

  @override
  String get bookingEditAccommodation => 'Edit accommodation type';

  @override
  String get bookingCompleteInitialIntake => 'Complete initial intake details';

  @override
  String get bookingCreateNewRequest => 'Create new request';

  @override
  String get bookingCreateNewFromRequest =>
      'Create new request from this request';

  @override
  String get bookingNewCenterRequestCreated => 'New center request created';

  @override
  String get bookingCurrent => 'Current';

  @override
  String get bookingActionNeeded => 'Action needed';

  @override
  String get bookingCompleted => 'Completed';

  @override
  String get bookingClosed => 'Closed';

  @override
  String get bookingEmptyCurrent => 'No current requests right now';

  @override
  String get bookingEmptyActionNeeded => 'No requests need action right now';

  @override
  String get bookingEmptyCompleted => 'No completed requests yet';

  @override
  String get bookingEmptyClosed => 'No closed requests';

  @override
  String get bookingSpecialistFallback => 'Specialist';

  @override
  String get bookingCenterRequestFallback => 'Center request';

  @override
  String comingSoon(String title) {
    return '$title — Coming soon';
  }

  @override
  String get modulePlaceholderBody => 'Content coming soon.';
}
