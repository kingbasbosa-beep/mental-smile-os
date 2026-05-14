class BookingLegacyChatAdapter {
  BookingLegacyChatAdapter();

  Future<String?> createOrUpdateAdminThreadForBooking({
    required String clientId,
    required String clientName,
    required String clientEmail,
    required String requestId,
    required String clinicianId,
    required String clinicianName,
    required String note,
    required bool isArabic,
  }) async {
    // TODO: Move booking chat thread/message creation behind Cloud Functions.
    // Client Firestore rules currently deny chat writes; booking requests must
    // remain valid without a threadId.
    return null;
  }

  Future<void> linkBookingToThread({
    required String threadId,
    required String requestId,
  }) async {}

  Future<bool> appendAdminQueueMessage({
    required String threadId,
    required String requestId,
    required String text,
  }) async {
    // TODO: Move booking chat message writes behind Cloud Functions.
    return false;
  }
}
