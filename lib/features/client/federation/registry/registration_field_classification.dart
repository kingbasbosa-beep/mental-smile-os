class RegistrationFieldClassification {
  const RegistrationFieldClassification._();

  static const String privateOnly = 'private_only';
  static const String publicVisible = 'public_visible';
  static const String dashboardVisible = 'dashboard_visible';
  static const String reviewOnly = 'review_only';
  static const String signalSource = 'signal_source';
  static const String guidanceSource = 'guidance_source';

  static const Set<String> values = <String>{
    privateOnly,
    publicVisible,
    dashboardVisible,
    reviewOnly,
    signalSource,
    guidanceSource,
  };
}
