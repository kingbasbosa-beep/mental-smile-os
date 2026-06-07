import '../models/s_suffix_naming_models.dart';

class SSuffixNamingRegistry {
  const SSuffixNamingRegistry._();

  static const String suffix = 'S';
  static const String purpose =
      'Mark federation-era functions that replace or overlap older functions.';

  static const List<SSuffixNamingProfile> examples = <SSuffixNamingProfile>[
    SSuffixNamingProfile(
      profileId: 'client_guidance_card_s',
      oldName: 'ClientGuidanceCard',
      federationName: 'ClientGuidanceCardS',
      reason: 'Guidance card overlaps an older client shortcut.',
    ),
    SSuffixNamingProfile(
      profileId: 'monitoring_counter_s',
      oldName: 'MonitoringCounter',
      federationName: 'MonitoringCounterS',
      reason: 'Counter reads federation aggregates instead of old operations.',
    ),
    SSuffixNamingProfile(
      profileId: 'archive_report_card_s',
      oldName: 'ArchiveReportCard',
      federationName: 'ArchiveReportCardS',
      reason: 'Report card belongs to the federation archive package model.',
    ),
    SSuffixNamingProfile(
      profileId: 'monitoring_signals_tab_s',
      oldName: 'MonitoringSignalsTab',
      federationName: 'MonitoringSignalsTabS',
      reason: 'Tab represents clean signal monitoring.',
    ),
  ];
}
