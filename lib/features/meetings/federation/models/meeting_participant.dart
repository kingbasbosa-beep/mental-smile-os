class MeetingParticipant {
  const MeetingParticipant({
    required this.participantType,
    required this.participantRole,
    required this.displayName,
    required this.department,
  });

  final String participantType;
  final String participantRole;
  final String displayName;
  final String department;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'participantType': participantType,
      'participantRole': participantRole,
      'displayName': displayName,
      'department': department,
    };
  }
}
