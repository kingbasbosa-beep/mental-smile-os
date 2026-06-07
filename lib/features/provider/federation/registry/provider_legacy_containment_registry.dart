class ProviderLegacyContainmentRegistry {
  const ProviderLegacyContainmentRegistry._();

  static const String legacySession = 'legacy_session';
  static const String legacyPayment = 'legacy_payment';
  static const String legacyBooking = 'legacy_booking';
  static const String legacyAdmin = 'legacy_admin';

  static const String ghost = 'ghost';
  static const String contained = 'contained';
  static const String replaceLater = 'replace_later';

  static const Map<String, String> containment = <String, String>{
    legacySession: ghost,
    legacyPayment: contained,
    legacyBooking: ghost,
    legacyAdmin: replaceLater,
  };
}
