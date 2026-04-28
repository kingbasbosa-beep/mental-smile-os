import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class CustomerFollowUpWorkspacePage extends StatelessWidget {
  const CustomerFollowUpWorkspacePage({super.key});

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
        title: 'Customer Follow-up Workspace',
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
                    'Customer Follow-up Workspace',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'قسم المتابعة وخدمة العملاء',
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
                    'Handles WhatsApp, web requests, emails, customer communication, follow-up, and request tracking.',
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
                    label: 'Communication Gateway',
                    icon: Icons.hub_outlined,
                    route: Routes.adminCommunicationGateway,
                  ),
                  _chip(
                    context,
                    label: 'WhatsApp Signals',
                    icon: Icons.mark_chat_unread_outlined,
                    route: Routes.adminCommunicationGateway,
                  ),
                  _chip(
                    context,
                    label: 'Support Email',
                    icon: Icons.email_outlined,
                    route: Routes.adminCommunicationGateway,
                  ),
                  _chip(
                    context,
                    label: 'Booking Requests',
                    icon: Icons.assignment_outlined,
                    route: Routes.adminOperations,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Future smart assistant is not active here. This workspace remains manual and staff-ready only.',
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
