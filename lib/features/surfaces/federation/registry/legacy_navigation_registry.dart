import '../models/legacy_navigation_models.dart';

class LegacyNavigationRegistry {
  const LegacyNavigationRegistry._();

  static const String legacyButton = 'legacy_button';
  static const String legacyTab = 'legacy_tab';
  static const String legacyBadge = 'legacy_badge';
  static const String legacyCounter = 'legacy_counter';
  static const String legacyCard = 'legacy_card';
  static const String legacyShortcut = 'legacy_shortcut';
  static const String legacyDrawerEntry = 'legacy_drawer_entry';

  static const Set<String> entryTypes = <String>{
    legacyButton,
    legacyTab,
    legacyBadge,
    legacyCounter,
    legacyCard,
    legacyShortcut,
    legacyDrawerEntry,
  };

  static const List<LegacyNavigationEntry> knownEntries =
      <LegacyNavigationEntry>[
  ];
}
