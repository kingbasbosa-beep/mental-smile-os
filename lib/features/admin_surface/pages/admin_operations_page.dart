import 'package:flutter/material.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminOperationsPage extends StatelessWidget {
  const AdminOperationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Operations',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: const [
            _OperationsIntroCard(),
          ],
        ),
      ),
    );
  }
}

class _OperationsIntroCard extends StatelessWidget {
  const _OperationsIntroCard();

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Operations',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'This landing page is an entry point for active business workflows only. It does not replace the deeper queue pages.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.obsidian.withValues(alpha: 0.72),
                ),
          ),
        ],
      ),
    );
  }
}
