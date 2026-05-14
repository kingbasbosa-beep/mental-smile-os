class FirestoreBoundaryFixture {
  const FirestoreBoundaryFixture._();

  static const String bookingRequests = 'booking_requests';
  static const String legalConsents = 'legalConsents';
  static const String aiSafetyEvents = 'aiSafetyEvents';
  static const String chatThreads = 'chat_threads';

  static const Set<String> clientDeniedCollections = {
    aiSafetyEvents,
    chatThreads,
  };

  static const Set<String> immutableOrServerGovernedCollections = {
    legalConsents,
    aiSafetyEvents,
  };
}
