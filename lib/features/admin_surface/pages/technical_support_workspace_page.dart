import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class TechnicalSupportWorkspacePage extends StatelessWidget {
  const TechnicalSupportWorkspacePage({super.key});

  Widget _chip(
    BuildContext context, {
    required String label,
    required IconData icon,
    required String route,
  }) {
    return ActionChip(
      avatar: Icon(icon, size: 16, color: const Color(0xFFC9A75B)),
      label: Text(label),
      labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: const Color(0xFFF1E5C8),
            fontWeight: FontWeight.w700,
          ),
      backgroundColor: const Color(0xFF151C21).withValues(alpha: 0.96),
      side: BorderSide(
        color: const Color(0xFFD8B26A).withValues(alpha: 0.18),
      ),
      onPressed: () => Navigator.of(context).pushNamed(route),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.obsidian,
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Technical Support Workspace',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            AppSectionPanel(
              padding: const EdgeInsets.all(AppSpacing.lg),
              color: const Color(0xFF020617),
              borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Technical Support Workspace',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'قسم الدعم التقني والصيانة',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: const Color(0xFFEAEAEA),
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3E9B90).withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(AppRadii.pill),
                      border: Border.all(
                        color: const Color(0xFF3E9B90).withValues(alpha: 0.24),
                      ),
                    ),
                    child: Text(
                      'Manual • Future-ready • No automation',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF73C1B8),
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Handles diagnostics, issues, maintenance, system health, AI DevOps, and problem isolation.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFFEAEAEA),
                          height: 1.35,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AppSectionPanel(
              padding: const EdgeInsets.all(AppSpacing.md),
              color: const Color(0xFF0F172A),
              borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
              child: Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  _chip(
                    context,
                    label: 'Maintenance & Diagnostics',
                    icon: Icons.monitor_heart_outlined,
                    route: Routes.adminMaintenanceSystem,
                  ),
                  _chip(
                    context,
                    label: 'AI DevOps Center',
                    icon: Icons.memory_outlined,
                    route: Routes.adminAiDevOpsCenter,
                  ),
                  _chip(
                    context,
                    label: 'Domain Availability',
                    icon: Icons.policy_outlined,
                    route: Routes.adminDomainAvailability,
                  ),
                  _chip(
                    context,
                    label: 'GitHub / Firebase Tools',
                    icon: Icons.developer_board_outlined,
                    route: Routes.adminAiDevOpsCenter,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Future smart assistant is not active here. This workspace remains manual and diagnostics-focused only.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFFEAEAEA),
                    height: 1.35,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
