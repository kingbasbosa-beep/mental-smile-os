class ControlRoomSweepRules {
  const ControlRoomSweepRules._();

  static const List<String> sweepOrder = <String>[
    'find_legacy_route',
    'find_all_references',
    'classify_reference',
    'mark_control_room_reference',
  ];

  static const Set<String> referenceTypes = <String>{
    'buttons',
    'tabs',
    'badges',
    'counters',
    'cards',
    'quick_actions',
    'drawer_entries',
    'deep_links',
    'section_maps',
  };
}
