import '../models/archive_room_blueprint.dart';
import '../models/client_room_blueprint.dart';
import '../models/monitoring_room_blueprint.dart';

class RoomBlueprintRegistry {
  const RoomBlueprintRegistry._();

  static const ClientRoomBlueprint client = ClientRoomBlueprint(
    roomId: 'client_room_construction_blueprint',
    sections: <ClientSectionBlueprint>[
      ClientSectionBlueprint(
        sectionId: 'client_personal_signal_section',
        title: 'Personal Signals',
        constructionRole: 'signal_summary',
      ),
      ClientSectionBlueprint(
        sectionId: 'client_tool_frames_section',
        title: 'Tool Frames',
        constructionRole: 'tool_access',
      ),
      ClientSectionBlueprint(
        sectionId: 'client_saved_destinations_section',
        title: 'Saved Destinations',
        constructionRole: 'quick_access',
      ),
      ClientSectionBlueprint(
        sectionId: 'client_guidance_section',
        title: 'Guidance',
        constructionRole: 'support_guidance',
      ),
    ],
    cards: <ClientCardBlueprint>[
      ClientCardBlueprint(
        cardId: 'client_signal_summary_card_s',
        title: 'Signal Summary',
        visualRole: 'calm_summary_card',
        dataSource: 'client_signals',
      ),
      ClientCardBlueprint(
        cardId: 'client_tools_card_s',
        title: 'Tools',
        visualRole: 'tool_frame_card',
        dataSource: 'enabled_tools',
      ),
      ClientCardBlueprint(
        cardId: 'client_saved_card_s',
        title: 'Saved',
        visualRole: 'compact_destination_card',
        dataSource: 'saved_destinations',
      ),
    ],
    counters: <ClientCounterBlueprint>[
      ClientCounterBlueprint(
        counterId: 'client_saved_counter_s',
        label: 'Saved',
        source: 'saved_destinations_summary',
      ),
      ClientCounterBlueprint(
        counterId: 'client_tools_counter_s',
        label: 'Tools',
        source: 'tool_slot_summary',
      ),
    ],
    guidanceAreas: <ClientGuidanceBlueprint>[
      ClientGuidanceBlueprint(
        guidanceId: 'client_easy_reading_guidance_s',
        title: 'Easy Reading Guidance',
        accessibilityMode: 'easy_reading',
      ),
      ClientGuidanceBlueprint(
        guidanceId: 'client_audio_guidance_s',
        title: 'Audio Guidance',
        accessibilityMode: 'audio_assisted',
      ),
    ],
    signalConsumptionAreas: <String>[
      'goal_signals',
      'interest_signals',
      'accessibility_signals',
      'communication_signals',
    ],
  );

  static const MonitoringRoomBlueprint monitoring = MonitoringRoomBlueprint(
    roomId: 'monitoring_room_construction_blueprint',
    sections: <MonitoringSectionBlueprint>[
      MonitoringSectionBlueprint(
        sectionId: 'monitoring_residential_section_s',
        title: 'Residential',
        monitoringSource: 'residential_monitoring_feed',
      ),
      MonitoringSectionBlueprint(
        sectionId: 'monitoring_commercial_section_s',
        title: 'Commercial',
        monitoringSource: 'commercial_monitoring_feed',
      ),
      MonitoringSectionBlueprint(
        sectionId: 'monitoring_observatory_section_s',
        title: 'Observatory',
        monitoringSource: 'operational_observatory',
      ),
    ],
    cards: <MonitoringCardBlueprint>[
      MonitoringCardBlueprint(
        cardId: 'monitoring_residential_card_s',
        title: 'Residential Signals',
        aggregateSource: 'residential_aggregates',
      ),
      MonitoringCardBlueprint(
        cardId: 'monitoring_commercial_card_s',
        title: 'Commercial Signals',
        aggregateSource: 'commercial_aggregates',
      ),
      MonitoringCardBlueprint(
        cardId: 'monitoring_observatory_card_s',
        title: 'Observatory',
        aggregateSource: 'observatory_snapshot',
      ),
    ],
    counters: <MonitoringCounterBlueprint>[
      MonitoringCounterBlueprint(
        counterId: 'monitoring_residential_counter_s',
        label: 'Residential',
        aggregateSource: 'residential_aggregate_count',
      ),
      MonitoringCounterBlueprint(
        counterId: 'monitoring_commercial_counter_s',
        label: 'Commercial',
        aggregateSource: 'commercial_aggregate_count',
      ),
    ],
    reports: <MonitoringReportBlueprint>[
      MonitoringReportBlueprint(
        reportId: 'monitoring_weekly_report_s',
        title: 'Weekly Monitoring',
        reportSource: 'federation_report_schema',
      ),
    ],
  );

  static const ArchiveRoomBlueprint archive = ArchiveRoomBlueprint(
    roomId: 'archive_room_construction_blueprint',
    packages: <ArchivePackageBlueprint>[
      ArchivePackageBlueprint(
        packageId: 'archive_monitoring_package_s',
        title: 'Monitoring Package',
        packageType: 'monitoring_pack',
      ),
      ArchivePackageBlueprint(
        packageId: 'archive_reputation_package_s',
        title: 'Reputation Package',
        packageType: 'reputation_pack',
      ),
      ArchivePackageBlueprint(
        packageId: 'archive_sovereign_package_s',
        title: 'Sovereign Package',
        packageType: 'sovereign_package',
      ),
    ],
    cards: <ArchiveCardBlueprint>[
      ArchiveCardBlueprint(
        cardId: 'archive_package_card_s',
        title: 'Packages',
        archiveRole: 'package_access',
      ),
      ArchiveCardBlueprint(
        cardId: 'archive_report_card_s',
        title: 'Reports',
        archiveRole: 'report_access',
      ),
    ],
    reports: <ArchiveReportBlueprint>[
      ArchiveReportBlueprint(
        reportId: 'archive_federation_report_s',
        title: 'Federation Report',
        reportCategory: 'federation_report',
      ),
    ],
    sovereignArchive: SovereignArchiveBlueprint(
      blueprintId: 'owner_sovereign_archive_s',
      allowedPackageTypes: <String>[
        'constitutional',
        'recovery',
        'owner_only',
      ],
      visibilityScope: 'owner_capsule_only',
    ),
  );
}
