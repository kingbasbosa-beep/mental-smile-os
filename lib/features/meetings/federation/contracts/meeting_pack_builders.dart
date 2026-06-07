import '../models/federation_meeting.dart';

abstract class MeetingPackBuilder {
  FederationMeeting buildMeetingPack();
}

abstract class OperationalMeetingBuilder {
  FederationMeeting buildOperationalMeeting();
}

abstract class CommercialMeetingBuilder {
  FederationMeeting buildCommercialMeeting();
}

abstract class StrategicMeetingBuilder {
  FederationMeeting buildStrategicMeeting();
}

abstract class ConstitutionalMeetingBuilder {
  FederationMeeting buildConstitutionalMeeting();
}
