class ContactCapabilityRegistry {
  const ContactCapabilityRegistry._();

  static const String contact = 'contact';
  static const String saveDestination = 'save_destination';
  static const String viewProfile = 'view_profile';
  static const String requestSupport = 'request_support';

  static const Set<String> values = <String>{
    contact,
    saveDestination,
    viewProfile,
    requestSupport,
  };
}
