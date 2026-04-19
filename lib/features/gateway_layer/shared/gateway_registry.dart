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
          'Shell ready. External channel integrations are not connected yet.',
      note: 'Use Communications for human case handling.',
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
      summary: 'Shell ready. Tool supervision only for now.',
      note: 'No direct tooling actions yet.',
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
      summary: 'Shell ready. Device and storage supervision only.',
      note: 'No probing or sync automation yet.',
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
      summary: 'Not integrated yet.',
      note: 'Future channel entry for web-origin conversations.',
    ),
  ),
  GatewayEntry(
    id: 'support_email',
    title: 'Support Email',
    boundary: 'Support mailbox intake and routing boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Not integrated yet.',
      note: 'Keep mailbox handling outside core business queues.',
    ),
  ),
  GatewayEntry(
    id: 'whatsapp',
    title: 'WhatsApp',
    boundary: 'WhatsApp connector boundary and intake supervision.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Not integrated yet.',
      note: 'Future external support intake path.',
    ),
  ),
  GatewayEntry(
    id: 'facebook_messenger',
    title: 'Facebook / Messenger',
    boundary: 'Facebook or Messenger intake supervision.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Not integrated yet.',
      note: 'Keep social intake separate from case handling.',
    ),
  ),
  GatewayEntry(
    id: 'telegram',
    title: 'Telegram',
    boundary: 'Telegram intake routing boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Not integrated yet.',
      note: 'Placeholder for future channel supervision.',
    ),
  ),
  GatewayEntry(
    id: 'zoom_meet',
    title: 'Zoom / Google Meet Coordination',
    boundary:
        'Meeting-link coordination boundary for future external channels.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Not integrated yet.',
      note: 'Session scheduling remains under Operations.',
    ),
  ),
  GatewayEntry(
    id: 'external_intake',
    title: 'External Intake Routing',
    boundary: 'Routing boundary for future external support intake.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Not integrated yet.',
      note: 'Future normalization point before Communications handling.',
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
      summary: 'Shell only.',
      note: 'Use for supervision and maintenance visibility later.',
    ),
  ),
  GatewayEntry(
    id: 'chatgpt',
    title: 'ChatGPT',
    boundary: 'AI collaboration and smart maintenance support boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Shell only.',
      note: 'No direct automation actions yet.',
    ),
  ),
  GatewayEntry(
    id: 'browser_workspace',
    title: 'Browser Workspace',
    boundary: 'Browser-based admin and development tool boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Shell only.',
      note: 'Keep browser workflows isolated from core operations.',
    ),
  ),
  GatewayEntry(
    id: 'firebase',
    title: 'Firebase',
    boundary: 'Backend console and project maintenance boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Shell only.',
      note: 'No backend operations executed from this page.',
    ),
  ),
  GatewayEntry(
    id: 'github',
    title: 'GitHub',
    boundary: 'Repository and release-maintenance boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Shell only.',
      note: 'Future integration awareness surface.',
    ),
  ),
  GatewayEntry(
    id: 'qa_logs',
    title: 'QA / Logs / Diagnostics',
    boundary: 'Diagnostics and maintenance-observability boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Shell only.',
      note: 'Keep QA visibility separate from business operations.',
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
      summary: 'Primary hub defined.',
      note: 'This device is the central administrative workstation.',
    ),
  ),
  GatewayEntry(
    id: 'android_tablet',
    title: 'Android Tablet',
    boundary: 'Companion device boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Companion device placeholder.',
      note: 'Future mobile companion supervision surface.',
    ),
  ),
  GatewayEntry(
    id: 'apple_devices',
    title: 'Apple Devices',
    boundary: 'Future Apple-device boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Future placeholder.',
      note: 'Reserved for later ecosystem expansion.',
    ),
  ),
  GatewayEntry(
    id: 'external_drives',
    title: 'External Drives',
    boundary: 'External storage and drive isolation boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Not connected in software yet.',
      note: 'Supervision shell only.',
    ),
  ),
  GatewayEntry(
    id: 'backup_archive_storage',
    title: 'Backup / Archive Storage',
    boundary: 'Backup and archive storage boundary.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Shell only.',
      note: 'Archive browsing remains outside hardware supervision.',
    ),
  ),
  GatewayEntry(
    id: 'import_export_sync_zone',
    title: 'Import / Export / Sync Zone',
    boundary: 'Sync and transfer boundary between tools and devices.',
    status: GatewayStatus(
      level: GatewayHealthLevel.planned,
      summary: 'Shell only.',
      note: 'Keep transfer boundaries explicit and isolated.',
    ),
  ),
];
