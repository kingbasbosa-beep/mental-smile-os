import 'meeting_agenda_item.dart';
import 'meeting_package_reference.dart';
import 'meeting_participant.dart';

class FederationMeeting {
  const FederationMeeting({
    required this.meetingId,
    required this.meetingCode,
    required this.meetingType,
    required this.meetingPeriod,
    required this.meetingDate,
    required this.createdAt,
    required this.status,
    required this.participants,
    required this.agenda,
    required this.relatedPackages,
  });

  final String meetingId;
  final String meetingCode;
  final String meetingType;
  final String meetingPeriod;
  final DateTime meetingDate;
  final DateTime createdAt;
  final String status;
  final List<MeetingParticipant> participants;
  final List<MeetingAgendaItem> agenda;
  final List<MeetingPackageReference> relatedPackages;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'meetingId': meetingId,
      'meetingCode': meetingCode,
      'meetingType': meetingType,
      'meetingPeriod': meetingPeriod,
      'meetingDate': meetingDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'participants':
          participants.map((participant) => participant.toMap()).toList(),
      'agenda': agenda.map((item) => item.toMap()).toList(),
      'relatedPackages':
          relatedPackages.map((package) => package.toMap()).toList(),
    };
  }
}
