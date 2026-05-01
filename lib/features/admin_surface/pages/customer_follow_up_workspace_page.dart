import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class CustomerFollowUpWorkspacePage extends StatelessWidget {
  const CustomerFollowUpWorkspacePage({super.key});

  static const _supportRequestsCollection = 'support_requests';

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
    final requestsStream = FirebaseFirestore.instance
        .collection(_supportRequestsCollection)
        .orderBy('createdAt', descending: true)
        .snapshots();

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
                    'Handles customer follow-up, external communication, and request tracking.',
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
            AppSectionPanel(
              padding: const EdgeInsets.all(AppSpacing.md),
              color: const Color(0xFF0F172A),
              borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Structured Support Requests',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: requestsStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Text(
                          'Unable to load support requests.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFFEAEAEA),
                              ),
                        );
                      }

                      final docs = snapshot.data?.docs ?? const [];
                      if (docs.isEmpty) {
                        return Text(
                          'No structured support requests yet.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFFEAEAEA),
                              ),
                        );
                      }

                      return Column(
                        children: docs
                            .map(
                              (doc) => Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.sm,
                                ),
                                child: _SupportRequestCard(data: doc.data()),
                              ),
                            )
                            .toList(),
                      );
                    },
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

class _SupportRequestCard extends StatelessWidget {
  const _SupportRequestCard({
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final supportType = (data['supportType'] as String? ?? '').trim();
    final issueType = (data['issueType'] as String? ?? '').trim();
    final priority = (data['priority'] as String? ?? '').trim();
    final status = (data['status'] as String? ?? '').trim();
    final createdByUid = (data['createdByUid'] as String? ?? '').trim();
    final createdAt = _formatCreatedAt(data['createdAt']);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(
          color: const Color(0xFFD8B26A).withValues(alpha: 0.14),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _metaChip(context, 'supportType: ${supportType.isEmpty ? '-' : supportType}'),
              _metaChip(context, 'issueType: ${issueType.isEmpty ? '-' : issueType}'),
              _metaChip(context, 'priority: ${priority.isEmpty ? '-' : priority}'),
              _metaChip(context, 'status: ${status.isEmpty ? '-' : status}'),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'createdByUid: ${createdByUid.isEmpty ? '-' : createdByUid}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFEAEAEA),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'createdAt: $createdAt',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFEAEAEA).withValues(alpha: 0.78),
                ),
          ),
        ],
      ),
    );
  }

  Widget _metaChip(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF151C21).withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(
          color: const Color(0xFFD8B26A).withValues(alpha: 0.18),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFFF1E5C8),
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }

  String _formatCreatedAt(dynamic value) {
    if (value is Timestamp) {
      final date = value.toDate();
      final month = date.month.toString().padLeft(2, '0');
      final day = date.day.toString().padLeft(2, '0');
      final hour = date.hour.toString().padLeft(2, '0');
      final minute = date.minute.toString().padLeft(2, '0');
      return '${date.year}-$month-$day $hour:$minute';
    }

    return '-';
  }
}
