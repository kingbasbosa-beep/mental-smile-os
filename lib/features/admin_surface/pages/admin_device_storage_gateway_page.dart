import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_registry.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminDeviceStorageGatewayPage extends StatelessWidget {
  const AdminDeviceStorageGatewayPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ...deviceStorageGatewayEntries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: GatewayEntryCard(entry: entry),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
