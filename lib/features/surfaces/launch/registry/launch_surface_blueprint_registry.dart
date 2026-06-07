import '../models/archive_launch_surface_models.dart';
import '../models/client_launch_surface_models.dart';
import '../models/monitoring_launch_surface_models.dart';

class LaunchSurfaceBlueprintRegistry {
  const LaunchSurfaceBlueprintRegistry._();

  static const ClientLaunchSurfaceProfile client =
      ClientLaunchSurfaceProfile(
    surfaceId: 'client_launch_surface',
    sections: <ClientLaunchSection>[
      ClientLaunchSection(
        sectionId: 'client_signal_space',
        title: 'My Signals',
        purpose: 'Summarize personal signal preferences without scoring.',
      ),
      ClientLaunchSection(
        sectionId: 'client_tools_space',
        title: 'Tools',
        purpose: 'Expose assigned tools as fixed federation tool frames.',
      ),
      ClientLaunchSection(
        sectionId: 'client_saved_space',
        title: 'Saved Destinations',
        purpose: 'Show saved providers, centers, resources, and tools.',
      ),
      ClientLaunchSection(
        sectionId: 'client_guidance_space',
        title: 'Guidance',
        purpose: 'Offer support and next-step guidance without lifecycle pressure.',
      ),
    ],
    tabs: <ClientLaunchTab>[
      ClientLaunchTab(
        tabId: 'client_home_tab_s',
        title: 'Home',
        targetSection: 'client_signal_space',
      ),
      ClientLaunchTab(
        tabId: 'client_signals_tab_s',
        title: 'Signals',
        targetSection: 'client_signal_space',
      ),
      ClientLaunchTab(
        tabId: 'client_tools_tab_s',
        title: 'Tools',
        targetSection: 'client_tools_space',
      ),
      ClientLaunchTab(
        tabId: 'client_saved_tab_s',
        title: 'Saved',
        targetSection: 'client_saved_space',
      ),
    ],
    cards: <ClientLaunchCard>[
      ClientLaunchCard(
        cardId: 'client_signals_summary_card_s',
        title: 'Signal Summary',
        surfaceRole: 'residential_summary',
      ),
      ClientLaunchCard(
        cardId: 'client_guidance_card_s',
        title: 'Guidance',
        surfaceRole: 'support_guidance',
      ),
      ClientLaunchCard(
        cardId: 'client_saved_destinations_card_s',
        title: 'Saved Destinations',
        surfaceRole: 'quick_access',
      ),
    ],
    counters: <ClientLaunchCounter>[
      ClientLaunchCounter(
        counterId: 'client_saved_counter_s',
        label: 'Saved',
        countSource: 'saved_destinations_aggregate',
      ),
      ClientLaunchCounter(
        counterId: 'client_tools_counter_s',
        label: 'Tools',
        countSource: 'tool_slot_aggregate',
      ),
    ],
    notes: 'Client launch surface is signal, tool, saved, and guidance first.',
  );

  static const MonitoringLaunchSurfaceProfile monitoring =
      MonitoringLaunchSurfaceProfile(
    surfaceId: 'monitoring_launch_surface',
    sections: <MonitoringLaunchSection>[
      MonitoringLaunchSection(
        sectionId: 'monitoring_residential_section',
        title: 'Residential Monitoring',
        purpose: 'Observe aggregate residential needs.',
      ),
      MonitoringLaunchSection(
        sectionId: 'monitoring_commercial_section',
        title: 'Commercial Monitoring',
        purpose: 'Observe aggregate demand, supply, and gaps.',
      ),
      MonitoringLaunchSection(
        sectionId: 'monitoring_observatory_section',
        title: 'Operational Observatory',
        purpose: 'Expose readiness and dependency language.',
      ),
    ],
    tabs: <MonitoringLaunchTab>[
      MonitoringLaunchTab(
        tabId: 'monitoring_signals_tab_s',
        title: 'Signals',
        targetSection: 'monitoring_residential_section',
      ),
      MonitoringLaunchTab(
        tabId: 'monitoring_gaps_tab_s',
        title: 'Gaps',
        targetSection: 'monitoring_commercial_section',
      ),
      MonitoringLaunchTab(
        tabId: 'monitoring_readiness_tab_s',
        title: 'Readiness',
        targetSection: 'monitoring_observatory_section',
      ),
    ],
    cards: <MonitoringLaunchCard>[
      MonitoringLaunchCard(
        cardId: 'monitoring_residential_card_s',
        title: 'Residential Needs',
        surfaceRole: 'aggregate_observation',
      ),
      MonitoringLaunchCard(
        cardId: 'monitoring_commercial_card_s',
        title: 'Commercial Demand',
        surfaceRole: 'commercial_observation',
      ),
      MonitoringLaunchCard(
        cardId: 'monitoring_observatory_card_s',
        title: 'Observatory',
        surfaceRole: 'readiness_observation',
      ),
    ],
    counters: <MonitoringLaunchCounter>[
      MonitoringLaunchCounter(
        counterId: 'monitoring_counter_s',
        label: 'Signals',
        countSource: 'signal_aggregate_counts',
      ),
      MonitoringLaunchCounter(
        counterId: 'monitoring_gap_counter_s',
        label: 'Gaps',
        countSource: 'commercial_gap_aggregates',
      ),
    ],
    notes: 'Monitoring launch surface reads aggregates and observatory models only.',
  );

  static const ArchiveLaunchSurfaceProfile archive =
      ArchiveLaunchSurfaceProfile(
    surfaceId: 'archive_launch_surface',
    sections: <ArchiveLaunchSection>[
      ArchiveLaunchSection(
        sectionId: 'archive_packages_section',
        title: 'Archive Packages',
        purpose: 'Expose constitutional archive packages.',
      ),
      ArchiveLaunchSection(
        sectionId: 'archive_reports_section',
        title: 'Reports',
        purpose: 'Expose federation report packages.',
      ),
      ArchiveLaunchSection(
        sectionId: 'archive_sovereign_section',
        title: 'Sovereign Archive',
        purpose: 'Separate owner recovery and constitutional assets.',
      ),
    ],
    tabs: <ArchiveLaunchTab>[
      ArchiveLaunchTab(
        tabId: 'archive_packages_tab_s',
        title: 'Packages',
        targetSection: 'archive_packages_section',
      ),
      ArchiveLaunchTab(
        tabId: 'archive_report_tab_s',
        title: 'Reports',
        targetSection: 'archive_reports_section',
      ),
      ArchiveLaunchTab(
        tabId: 'archive_sovereign_tab_s',
        title: 'Sovereign',
        targetSection: 'archive_sovereign_section',
      ),
    ],
    cards: <ArchiveLaunchCard>[
      ArchiveLaunchCard(
        cardId: 'archive_report_card_s',
        title: 'Report Package',
        surfaceRole: 'report_archive',
      ),
      ArchiveLaunchCard(
        cardId: 'archive_export_card_s',
        title: 'Export Package',
        surfaceRole: 'export_archive',
      ),
      ArchiveLaunchCard(
        cardId: 'archive_sovereign_card_s',
        title: 'Sovereign Package',
        surfaceRole: 'owner_archive',
      ),
    ],
    counters: <ArchiveLaunchCounter>[
      ArchiveLaunchCounter(
        counterId: 'archive_package_counter_s',
        label: 'Packages',
        countSource: 'archive_package_registry',
      ),
      ArchiveLaunchCounter(
        counterId: 'archive_report_counter_s',
        label: 'Reports',
        countSource: 'report_category_registry',
      ),
    ],
    notes: 'Archive launch surface is package, report, and sovereign asset first.',
  );
}
