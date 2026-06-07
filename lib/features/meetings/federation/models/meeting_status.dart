class MeetingStatus {
  const MeetingStatus._();

  static const String draft = 'draft';
  static const String prepared = 'prepared';
  static const String reviewing = 'reviewing';
  static const String completed = 'completed';
  static const String archived = 'archived';

  static const Set<String> values = <String>{
    draft,
    prepared,
    reviewing,
    completed,
    archived,
  };
}
