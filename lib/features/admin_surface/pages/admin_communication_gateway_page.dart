import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_registry.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminCommunicationGatewayPage extends StatelessWidget {
  const AdminCommunicationGatewayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Communication Gateway',
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
                    'Communication Gateway',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'A gateway shell for future external communication channels and intake routing. Human case handling remains in Communications.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.obsidian.withValues(alpha: 0.72),
                        ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'This page supervises connector boundaries only. It does not replace the human communications workspace.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.obsidian.withValues(alpha: 0.70),
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ...communicationGatewayEntries.map(
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
