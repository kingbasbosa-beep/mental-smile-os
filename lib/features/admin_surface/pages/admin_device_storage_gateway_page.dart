import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_entry.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_registry.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminDeviceStorageGatewayPage extends StatelessWidget {
  const AdminDeviceStorageGatewayPage({super.key});

  String _supervisionNote(String entryId) {
    return switch (entryId) {
      'windows_admin_laptop' =>
        'Supervises the primary control hub boundary. It does not replace business workflow pages or operational decision-making.',
      'android_tablet' =>
        'Supervises the future companion-device boundary. It remains separate from the primary laptop and is not connected yet.',
      'apple_devices' =>
        'Supervises future Apple-device boundaries only. It keeps platform expansion explicit without mixing it into current workflows.',
      'external_drives' =>
        'Supervises removable storage boundaries. It keeps external drives isolated from daily admin work and live workflow handling.',
      'backup_archive_storage' =>
        'Supervises backup and archive storage boundaries. It remains separate from archive browsing and direct business operations.',
      'import_export_sync_zone' =>
        'Supervises sync and transfer boundaries between tools, devices, and storage. It does not replace workflow handling or technical operations pages.',
      _ =>
        'Supervises this device or storage boundary without mixing it into direct business workflow handling.',
    };
  }

  Widget _buildEntryBlock(BuildContext context, GatewayEntry entry) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GatewayEntryCard(entry: entry),
          const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: Text(
              _supervisionNote(entry.id),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.obsidian.withValues(alpha: 0.70),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGatewayGroup(
    BuildContext context, {
    required String title,
    required String description,
    required List<GatewayEntry> entries,
  }) {
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.obsidian.withValues(alpha: 0.70),
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...entries.map((entry) => _buildEntryBlock(context, entry)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryDeviceEntries = deviceStorageGatewayEntries
        .where((entry) =>
            entry.id == 'windows_admin_laptop' ||
            entry.id == 'android_tablet' ||
            entry.id == 'apple_devices')
        .toList();
    final storageEntries = deviceStorageGatewayEntries
        .where((entry) =>
            entry.id == 'external_drives' ||
            entry.id == 'backup_archive_storage')
        .toList();
    final syncBoundaryEntries = deviceStorageGatewayEntries
        .where((entry) => entry.id == 'import_export_sync_zone')
        .toList();

    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Device / Storage Gateway',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            AppSurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Device / Storage Gateway',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'A shell for device, storage, backup, and sync boundaries around the admin laptop as the primary control hub.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.obsidian.withValues(alpha: 0.72),
                        ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'This page clarifies which hardware and storage boundaries are defined, which are planned, and which remain disconnected by design for now.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.obsidian.withValues(alpha: 0.70),
                        ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Business workflows remain in Operations and Communications. This page only supervises hardware, storage, and sync compartments.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.obsidian.withValues(alpha: 0.70),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _buildGatewayGroup(
              context,
              title: 'Primary Devices',
              description:
                  'Primary and companion device boundaries around the admin laptop as the central control hub.',
              entries: primaryDeviceEntries,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildGatewayGroup(
              context,
              title: 'Storage Units',
              description:
                  'Storage, backup, and archive-adjacent hardware boundaries that remain separate from business workflow handling.',
              entries: storageEntries,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildGatewayGroup(
              context,
              title: 'Sync / Boundaries',
              description:
                  'Transfer and sync boundaries that keep movement between devices and storage explicit and supervised.',
              entries: syncBoundaryEntries,
            ),
          ],
        ),
      ),
    );
  }
}
