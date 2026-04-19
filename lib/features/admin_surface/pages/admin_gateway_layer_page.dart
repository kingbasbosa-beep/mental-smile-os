import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/core/gateway_monitor.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_registry.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminGatewayLayerPage extends StatelessWidget {
  const AdminGatewayLayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    const gatewayMonitor = GatewayMonitor();
    final statusesByKey = {
      for (final status in gatewayMonitor.familyStatuses()) status.key!: status,
    };

    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Gateway Layer',
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
                    'Gateway Layer',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Connect, isolate, and maintain channels, tools, devices, and storage without mixing them into business workflows.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.obsidian.withValues(alpha: 0.72),
                        ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Each gateway family is a technical compartment. It exists to make supervision, isolation, and later integration safer.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.obsidian.withValues(alpha: 0.70),
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ...gatewayFamilyEntries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: GatewayFamilyCard(
                  entry: entry,
                  statusOverride: statusesByKey[entry.id],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
