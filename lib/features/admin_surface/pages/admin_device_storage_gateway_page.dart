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
          GatewaySupervisionNote(text: _supervisionNote(entry.id)),
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
    return GatewaySectionCard(
      title: title,
      description: description,
      children: entries.map((entry) => _buildEntryBlock(context, entry)).toList(),
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
      backgroundColor: const Color(0xFF0F1316),
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Device / Storage Gateway',
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF13191D),
              Color(0xFF0F1316),
              Color(0xFF151B1F),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const GatewayPageIntroCard(
              title: 'Device / Storage Gateway',
              summary:
                  'Supervise device, storage, backup, and sync boundaries around the admin laptop as the primary control hub.',
              boundaryNote:
                  'This page clarifies monitored, planned, and disconnected hardware or storage boundaries only.',
              emphasis:
                  'Business workflows remain in Operations and Communications. Device / Storage Gateway stays focused on supervised infrastructure compartments.',
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
