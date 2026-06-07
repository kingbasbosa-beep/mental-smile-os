class LegacyRegistrationContainmentRegistry {
  const LegacyRegistrationContainmentRegistry._();

  static const String legacyRegistration = 'legacy_registration';
  static const String legacyProfile = 'legacy_profile';
  static const String legacyDashboard = 'legacy_dashboard';
  static const String legacyPublicProfile = 'legacy_public_profile';

  static const String ghost = 'ghost';
  static const String contained = 'contained';
  static const String replaceLater = 'replace_later';

  static const Map<String, String> containment = <String, String>{
    legacyRegistration: contained,
    legacyProfile: contained,
    legacyDashboard: replaceLater,
    legacyPublicProfile: replaceLater,
  };
}
