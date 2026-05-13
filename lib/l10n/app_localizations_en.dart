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
  String get webCenterRegistrationPortalTitle => 'Center Registration Portal';

  @override
  String get webCenterRegistrationPortalSubtitle =>
      'Create your center account for admin review.';

  @override
  String get webCenterRegistrationBasicInfoTitle =>
      'Center Registration - Basic Info';

  @override
  String get webCenterGuidanceLibrary => 'Guidance library';

  @override
  String get webCenterCenterName => 'Center name';

  @override
  String get webCenterCategory => 'Category';

  @override
  String get webCenterType => 'Center type';

  @override
  String get webCenterConfirmPassword => 'Confirm password';

  @override
  String get webCenterNextBasicInfo => 'Next: Basic Info';

  @override
  String get webCenterManagerName => 'Manager name';

  @override
  String get webCenterArea => 'Area';

  @override
  String get webCenterDescription => 'Description';

  @override
  String get webCenterHasDetoxUnit => 'Has detox unit';

  @override
  String get webCenterNextMediaGallery => 'Next: Media & Gallery';

  @override
  String get webCenterMediaGalleryTitle =>
      'Center Registration - Media & Gallery';

  @override
  String get webCenterFrontImageUrl => 'Front image URL';

  @override
  String get webCenterReceptionImageUrl => 'Reception image URL';

  @override
  String get webCenterInsideImage1Url => 'Inside image 1 URL';

  @override
  String get webCenterInsideImage2Url => 'Inside image 2 URL';

  @override
  String get webCenterNextPricingCapabilities => 'Next: Pricing & Capabilities';

  @override
  String get webCenterPricingCapabilitiesTitle =>
      'Center Registration - Pricing & Capabilities';

  @override
  String get webCenterEnabled => 'Enabled';

  @override
  String get webCenterPrice => 'Price';

  @override
  String get webCenterPricingUnit => 'Pricing unit';

  @override
  String get webCenterAcMode => 'AC mode';

  @override
  String get webCenterTaxIncluded => 'Tax included';

  @override
  String get webCenterNextDocuments => 'Next: Documents';

  @override
  String get webCenterDocumentsTitle => 'Center Registration - Documents';

  @override
  String get webCenterFileName => 'File name';

  @override
  String get webCenterFileUrlOptional => 'File URL (optional)';

  @override
  String get webCenterReviewNoteOptional => 'Review note (optional)';

  @override
  String get webCenterSubmitForReview => 'Submit for review';

  @override
  String get webRegistrationBrowseLibraryDuringReview =>
      'Browse the guidance library while your account is reviewed';

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
  String clientDashboardWelcome(String name) {
    return 'Welcome, $name';
  }

  @override
  String get clientDashboardSubtitle => 'Your next steps are all here.';

  @override
  String get clientBookings => 'Bookings';

  @override
  String get clientBookingRequests => 'Booking requests';

  @override
  String get clientSupport => 'Support';

  @override
  String get clientSupportRequests => 'Support requests';

  @override
  String get clientPaymentProof => 'Payment proof';

  @override
  String get clientUploadPaymentProof => 'Upload transfer proof';

  @override
  String get clientMySessions => 'My sessions';

  @override
  String get clientLinksAndCodes => 'Links and codes';

  @override
  String get clientFollowUp => 'Follow-up';

  @override
  String get clientMessagePreferences => 'Message preferences';

  @override
  String get clientRatingsCount => 'Ratings count';

  @override
  String get clientAverageStars => 'Average stars';

  @override
  String get clientOverallAverage => 'Overall average';

  @override
  String get clinicianOperations => 'Operations';

  @override
  String get clinicianDashboard => 'Clinician dashboard';

  @override
  String get clinicianOpenCases => 'Open cases';

  @override
  String get clinicianSendSupportRequest => 'Send support request';

  @override
  String get clinicianEditProfile => 'Edit my profile';

  @override
  String get clinicianMySessions => 'My sessions';

  @override
  String get clinicianSupportRequest => 'Support request';

  @override
  String get clinicianCurrentSupportRequests => 'Current support requests';

  @override
  String get clinicianReferredChatCases => 'Referred chat cases';

  @override
  String get clinicianReferredChatCasesCount => 'Referred chat cases';

  @override
  String get clinicianNewRequests => 'New';

  @override
  String get clinicianActiveRequests => 'In progress';

  @override
  String get clinicianCompleted => 'Completed';

  @override
  String get clinicianClosed => 'Closed';

  @override
  String get clinicianAcceptRequest => 'Accept request';

  @override
  String get clinicianRejectRequest => 'Reject request';

  @override
  String get clinicianEndSession => 'End session';

  @override
  String get clinicianReviewSession => 'Review session';

  @override
  String get clinicianAssignedRequest => 'Request assigned to you';

  @override
  String get clinicianProfileChangeTitle => 'Request photo or bio update';

  @override
  String get clinicianNewPhotoUrl => 'New photo URL';

  @override
  String get clinicianNewBio => 'New bio';

  @override
  String get clinicianSendingRequest => 'Sending request...';

  @override
  String get clinicianSendChangeRequest => 'Send change request';

  @override
  String get clinicianRatings => 'Ratings';

  @override
  String get clinicianStars => 'Stars';

  @override
  String get clinicianOverall => 'Overall';

  @override
  String get clinicianLogout => 'Logout';

  @override
  String get clinicianPleaseSignIn => 'Please sign in first';

  @override
  String get statusPendingReview => 'Pending review';

  @override
  String get statusRequestUnderReview => 'Your request is under review';

  @override
  String get statusCenterFollowUp => 'The center is checking availability';

  @override
  String get statusClientUpdateRequired =>
      'The center requested an accommodation update';

  @override
  String get statusCenterIntakePending => 'Waiting for initial intake details';

  @override
  String get statusCenterRecommendationPending =>
      'Waiting for the center recommendation';

  @override
  String get statusApproved => 'Approved';

  @override
  String get statusRequestApproved => 'Your request was approved';

  @override
  String get statusAwaitingPayment => 'Awaiting payment';

  @override
  String get statusUploadPaymentProof => 'Please upload payment proof';

  @override
  String get statusPaymentReview => 'Payment proof under review';

  @override
  String get statusSessionSetupPending => 'Session setup pending';

  @override
  String get statusResidencySetupPending => 'Residency setup pending';

  @override
  String get statusSessionScheduled => 'Session scheduled';

  @override
  String get statusResidencyScheduled => 'Residency scheduled';

  @override
  String get statusSessionInProgress => 'Session in progress';

  @override
  String get statusResidencyInProgress => 'Residency in progress';

  @override
  String get statusPendingReviews => 'Pending reviews';

  @override
  String get statusPendingDischargeReviews => 'Pending discharge reviews';

  @override
  String get statusPayoutPending => 'Financial closing pending';

  @override
  String get statusCenterAccountingReview => 'Pending center accounting review';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusCompletedSuccessfully => 'Completed successfully';

  @override
  String get statusRequestCompleted => 'Request completed';

  @override
  String get statusReschedulePending => 'Reschedule pending';

  @override
  String get statusAwaitingStartConfirmations => 'Awaiting start confirmations';

  @override
  String get statusRejected => 'Request could not be accepted';

  @override
  String get statusClinicianRejected => 'Clinician could not confirm';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get statusCancellationPending => 'Cancellation request under review';

  @override
  String get statusDisputeReceived => 'Complaint received';

  @override
  String get statusRequestCoordination => 'Request is being coordinated';

  @override
  String get statusRequestUpdateInProgress => 'Request status is being updated';

  @override
  String get statusNewRequest => 'New request';

  @override
  String get statusCenterAvailableResponse => 'Center response: available';

  @override
  String get statusCenterUnavailableResponse => 'Center response: unavailable';

  @override
  String get statusCenterNoResponse => 'Center response: no reply yet';

  @override
  String comingSoon(String title) {
    return '$title — Coming soon';
  }

  @override
  String get modulePlaceholderBody => 'Content coming soon.';
}
