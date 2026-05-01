import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_entry.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_health_level.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_status.dart';

const gatewayFamilyEntries = <GatewayFamilyEntry>[
  GatewayFamilyEntry(
    id: 'communication',
    title: 'Communication Gateway',
    description:
        'Channel intake, routing boundaries, and connector supervision.',
    route: Routes.adminCommunicationGateway,
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary:
          'Defined as a top-level gateway family for channel intake and routing boundaries.',
      boundaryNote:
          'Owns channel boundaries and intake routing. Human conversations stay in Communications.',
      monitoredNote:
          'Not integrated yet. No external channel connectors are active.',
      attentionLabel: 'Planned boundary',
    ),
  ),
  GatewayFamilyEntry(
    id: 'engineering',
    title: 'Engineering / Maintenance Gateway',
    description:
        'Tooling, diagnostics, repositories, and technical maintenance boundaries.',
    route: Routes.adminEngineeringGateway,
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary:
          'Defined as a top-level gateway family for tooling, diagnostics, and technical maintenance boundaries.',
      boundaryNote:
          'Owns technical tool boundaries without mixing them into daily admin workflows.',
      monitoredNote:
          'Not integrated yet. No tool actions, repo checks, or diagnostics polling are active.',
      attentionLabel: 'Planned boundary',
    ),
  ),
  GatewayFamilyEntry(
    id: 'device_storage',
    title: 'Device / Storage Gateway',
    description:
        'Devices, drives, backup units, and sync/import/export boundaries.',
    route: Routes.adminDeviceStorageGateway,
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary:
          'Defined as a top-level gateway family for devices, storage units, backup, and sync boundaries.',
      boundaryNote:
          'Owns hardware and storage compartment boundaries without mixing them into archive or operations pages.',
      monitoredNote:
          'Not integrated yet. No device probing, storage checks, or sync automation are active.',
      attentionLabel: 'Planned boundary',
    ),
  ),
];

const communicationGatewayEntries = <GatewayEntry>[
  GatewayEntry(
    id: 'website_chat',
    title: 'Website Chat',
    boundary: 'Website chat intake boundary and routing health.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Reserved for web-origin conversation intake.',
      boundaryNote: 'Separates website intake from human support handling.',
      monitoredNote: 'Not integrated yet.',
      attentionLabel: 'Planned boundary',
    ),
  ),
  GatewayEntry(
    id: 'support_email',
    title: 'Support Email',
    boundary: 'Support mailbox intake and routing boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Reserved for support mailbox intake supervision.',
      boundaryNote: 'Keeps email intake outside core business queues.',
      monitoredNote: 'Not integrated yet.',
      attentionLabel: 'Planned boundary',
    ),
  ),
  GatewayEntry(
    id: 'external_follow_up',
    title: 'External Follow-up',
    boundary: 'External outbound follow-up boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Reserved for outbound follow-up tooling.',
      boundaryNote:
          'Keeps external follow-up tooling outside direct case handling.',
      monitoredNote: 'Not integrated yet.',
      attentionLabel: 'Planned boundary',
    ),
  ),
  GatewayEntry(
    id: 'facebook_messenger',
    title: 'Facebook / Messenger',
    boundary: 'Facebook or Messenger intake supervision.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Reserved for social-channel intake supervision.',
      boundaryNote: 'Keeps social intake separate from case handling.',
      monitoredNote: 'Not integrated yet.',
      attentionLabel: 'Planned boundary',
    ),
  ),
  GatewayEntry(
    id: 'telegram',
    title: 'Telegram',
    boundary: 'Telegram intake routing boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Reserved for Telegram intake supervision.',
      boundaryNote:
          'Keeps Telegram intake isolated as its own connector boundary.',
      monitoredNote: 'Not integrated yet.',
      attentionLabel: 'Planned boundary',
    ),
  ),
  GatewayEntry(
    id: 'zoom_meet',
    title: 'Zoom / Google Meet Coordination',
    boundary:
        'Meeting-link coordination boundary for future external channels.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Reserved for external meeting-link coordination boundaries.',
      boundaryNote:
          'Operations still owns session scheduling and session state transitions.',
      monitoredNote: 'Not integrated yet.',
      attentionLabel: 'Planned boundary',
    ),
  ),
  GatewayEntry(
    id: 'external_intake',
    title: 'External Intake Routing',
    boundary: 'Routing boundary for future external support intake.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Reserved as a normalization point for future external intake.',
      boundaryNote: 'Routes future intake before Communications handling.',
      monitoredNote: 'Not integrated yet.',
      attentionLabel: 'Planned boundary',
    ),
  ),
];

const engineeringGatewayEntries = <GatewayEntry>[
  GatewayEntry(
    id: 'codex',
    title: 'Codex',
    boundary: 'AI-assisted development and maintenance workspace boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Reserved for AI-assisted development workspace supervision.',
      boundaryNote:
          'Keeps Codex-related maintenance awareness outside business workflows.',
      monitoredNote: 'Monitored as shell only. No tooling actions are active.',
      attentionLabel: 'Planned boundary',
    ),
  ),
  GatewayEntry(
    id: 'chatgpt',
    title: 'ChatGPT',
    boundary: 'AI collaboration and smart maintenance support boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Reserved for AI collaboration and smart maintenance support.',
      boundaryNote:
          'Keeps assistant tooling visible without mixing it into governance or operations.',
      monitoredNote:
          'Monitored as shell only. No automation actions are active.',
      attentionLabel: 'Planned boundary',
    ),
  ),
  GatewayEntry(
    id: 'browser_workspace',
    title: 'Browser Workspace',
    boundary: 'Browser-based admin and development tool boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Reserved for browser-based admin and maintenance workspaces.',
      boundaryNote:
          'Keeps browser tooling isolated from core business workflows.',
      monitoredNote: 'Monitored as shell only. No workspace checks are active.',
      attentionLabel: 'Planned boundary',
    ),
  ),
  GatewayEntry(
    id: 'firebase',
    title: 'Firebase',
    boundary: 'Backend console and project maintenance boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary:
          'Reserved for backend console and project maintenance awareness.',
      boundaryNote:
          'Keeps backend tooling visible without executing backend operations here.',
      monitoredNote: 'Monitored as shell only. No backend checks are active.',
      attentionLabel: 'Planned boundary',
    ),
  ),
  GatewayEntry(
    id: 'github',
    title: 'GitHub',
    boundary: 'Repository and release-maintenance boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Reserved for repository and release-maintenance awareness.',
      boundaryNote:
          'Keeps repository tooling separate from daily admin operations.',
      monitoredNote:
          'Monitored as shell only. No repository checks are active.',
      attentionLabel: 'Planned boundary',
    ),
  ),
  GatewayEntry(
    id: 'qa_logs',
    title: 'QA / Logs / Diagnostics',
    boundary: 'Diagnostics and maintenance-observability boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Reserved for diagnostics and QA observability supervision.',
      boundaryNote:
          'Keeps maintenance observability outside business workflow pages.',
      monitoredNote:
          'Monitored as shell only. No diagnostics polling is active.',
      attentionLabel: 'Planned boundary',
    ),
  ),
];

const deviceStorageGatewayEntries = <GatewayEntry>[
  GatewayEntry(
    id: 'windows_admin_laptop',
    title: 'Windows Admin Laptop',
    boundary: 'Primary control hub device boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.healthy,
      summary:
          'Primary hub is defined as the central administrative workstation.',
      boundaryNote:
          'Acts as the central control hub while other technical units remain isolatable.',
      monitoredNote:
          'Monitored as declared infrastructure only. No device probing is active.',
    ),
  ),
  GatewayEntry(
    id: 'android_tablet',
    title: 'Android Tablet',
    boundary: 'Companion device boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Reserved for the future companion device boundary.',
      boundaryNote:
          'Keeps mobile supervision separate from the primary admin laptop.',
      monitoredNote: 'Not connected yet.',
      attentionLabel: 'Planned boundary',
    ),
  ),
  GatewayEntry(
    id: 'apple_devices',
    title: 'Apple Devices',
    boundary: 'Future Apple-device boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Reserved for future Apple-device boundaries.',
      boundaryNote: 'Keeps future platform expansion explicit and isolated.',
      monitoredNote: 'Not connected yet.',
      attentionLabel: 'Planned boundary',
    ),
  ),
  GatewayEntry(
    id: 'external_drives',
    title: 'External Drives',
    boundary: 'External storage and drive isolation boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Reserved for external drive supervision boundaries.',
      boundaryNote:
          'Keeps removable storage isolated from the rest of the admin surface.',
      monitoredNote: 'Not connected yet.',
      attentionLabel: 'Planned boundary',
    ),
  ),
  GatewayEntry(
    id: 'backup_archive_storage',
    title: 'Backup / Archive Storage',
    boundary: 'Backup and archive storage boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Reserved for backup and archive storage boundaries.',
      boundaryNote: 'Archive browsing remains outside hardware supervision.',
      monitoredNote: 'Not connected yet.',
      attentionLabel: 'Planned boundary',
    ),
  ),
  GatewayEntry(
    id: 'import_export_sync_zone',
    title: 'Import / Export / Sync Zone',
    boundary: 'Sync and transfer boundary between tools and devices.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary:
          'Reserved for sync and transfer boundaries between tools and devices.',
      boundaryNote:
          'Keeps import/export and sync boundaries explicit and isolated.',
      monitoredNote: 'Not connected yet.',
      attentionLabel: 'Planned boundary',
    ),
  ),
];
