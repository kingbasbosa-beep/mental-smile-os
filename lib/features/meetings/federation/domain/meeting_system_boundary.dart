import '../models/federation_meeting.dart';
import '../models/meeting_package_reference.dart';
import '../models/meeting_status.dart';
import '../registry/meeting_type_registry.dart';

class MeetingSystemBoundary {
  const MeetingSystemBoundary._();

  static const Set<String> forbiddenTerms = <String>{
    'booking_requests',
    'bookingRequests',
    'sessionRatings',
    'client_sessions',
    'clinician_sessions',
    'payment proof',
    'adminPayments',
    'assignment',
    'payout',
    'booking',
    'session',
    'payment',
  };

  static bool allowsSourceText(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return false;
    for (final term in forbiddenTerms) {
      if (normalized.contains(term)) return false;
    }
    return true;
  }

  static bool allowsPackageReference(MeetingPackageReference reference) {
    return allowsSourceText(reference.packageCode) &&
        allowsSourceText(reference.packageType) &&
        allowsSourceText(reference.archiveCode) &&
        allowsSourceText(reference.classification);
  }

  static bool allowsMeeting(FederationMeeting meeting) {
    if (!MeetingTypeRegistry.values.contains(meeting.meetingType)) {
      return false;
    }
    if (!MeetingStatus.values.contains(meeting.status)) {
      return false;
    }
    for (final package in meeting.relatedPackages) {
      if (!allowsPackageReference(package)) return false;
    }
    return true;
  }
}
