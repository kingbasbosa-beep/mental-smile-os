import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class CustomerFollowUpWorkspacePage extends StatelessWidget {
  const CustomerFollowUpWorkspacePage({super.key});

  static const _supportRequestsCollection = 'support_requests';

  @override
  Widget build(BuildContext context) {
    final requestsStream = FirebaseFirestore.instance
        .collection(_supportRequestsCollection)
        .orderBy('createdAt', descending: true)
        .snapshots();

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: AppColors.obsidian,
        appBar: AppShellActions.buildAppBar(
          context,
          title: 'Customer Follow-up Workspace',
        ),
        body: AppPageBackground(
          child: Column(
            children: [
              const Material(
                color: Colors.transparent,
                child: TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(text: 'دعم التعافي'),
                    Tab(text: 'دعم الأسرة'),
                    Tab(text: 'العملاء'),
                    Tab(text: 'المراكز'),
                    Tab(text: 'الأخصائيين'),
                    Tab(text: 'بلاغات خطر'),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: requestsStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          child: Text(
                            'Unable to load support requests.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: const Color(0xFFEAEAEA),
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    final docs = snapshot.data?.docs ?? const [];
                    final requests = docs.map((doc) => doc.data()).toList();

                    return TabBarView(
                      children: [
                        _SupportRequestsTab(
                          requests: _filterBySupportType(
                            requests,
                            'recovery_support',
                          ),
                        ),
                        _SupportRequestsTab(
                          requests: _filterBySupportType(
                            requests,
                            'family_support',
                          ),
                        ),
                        _SupportRequestsTab(
                          requests: _filterBySupportType(
                            requests,
                            'client_support',
                          ),
                        ),
                        _SupportRequestsTab(
                          requests: _filterBySupportType(
                            requests,
                            'center_support',
                          ),
                        ),
                        _SupportRequestsTab(
                          requests: _filterBySupportType(
                            requests,
                            'clinician_support',
                          ),
                        ),
                        _SupportRequestsTab(
                          requests: _filterRiskRequests(requests),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _filterBySupportType(
    List<Map<String, dynamic>> requests,
    String supportType,
  ) {
    return requests.where((request) {
      return (request['supportType'] as String? ?? '').trim() == supportType;
    }).toList();
  }

  List<Map<String, dynamic>> _filterRiskRequests(
    List<Map<String, dynamic>> requests,
  ) {
    return requests.where((request) {
      final priority = (request['priority'] as String? ?? '').trim();
      final issueType = (request['issueType'] as String? ?? '').trim();
      return priority == 'high' || issueType == 'risk_report';
    }).toList();
  }
}

class _SupportRequestsTab extends StatelessWidget {
  const _SupportRequestsTab({
    required this.requests,
  });

  final List<Map<String, dynamic>> requests;

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                'Structured support viewer only',
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
                  'Manual • No chat • No processing yet',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF73C1B8),
                        fontWeight: FontWeight.w800,
                      ),
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
              _WorkspaceChip(
                label: 'Communication Gateway',
                icon: Icons.hub_outlined,
                route: Routes.adminCommunicationGateway,
              ),
              _WorkspaceChip(
                label: 'Support Email',
                icon: Icons.email_outlined,
                route: Routes.adminCommunicationGateway,
              ),
              _WorkspaceChip(
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
              if (requests.isEmpty)
                Text(
                  'No structured support requests yet.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFFEAEAEA),
                      ),
                )
              else
                Column(
                  children: requests
                      .map(
                        (request) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: _SupportRequestCard(data: request),
                        ),
                      )
                      .toList(),
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
    );
  }
}

class _WorkspaceChip extends StatelessWidget {
  const _WorkspaceChip({
    required this.label,
    required this.icon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
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
}

class _SupportRequestCard extends StatelessWidget {
  const _SupportRequestCard({
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final supportType = _supportTypeLabel(
      (data['supportType'] as String? ?? '').trim(),
    );
    final issueType = _issueTypeLabel(
      (data['issueType'] as String? ?? '').trim(),
    );
    final priority = _priorityLabel(
      (data['priority'] as String? ?? '').trim(),
    );
    final status = _statusLabel(
      (data['status'] as String? ?? '').trim(),
    );
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
              _metaChip(
                context,
                'القسم: ${supportType.isEmpty ? '-' : supportType}',
              ),
              _metaChip(
                context,
                'نوع الطلب: ${issueType.isEmpty ? '-' : issueType}',
              ),
              _metaChip(
                context,
                'الأولوية: ${priority.isEmpty ? '-' : priority}',
              ),
              _metaChip(
                context,
                'الحالة: ${status.isEmpty ? '-' : status}',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'المستخدم: ${createdByUid.isEmpty ? '-' : createdByUid}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFEAEAEA),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'وقت الإنشاء: $createdAt',
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

  String _supportTypeLabel(String value) {
    switch (value) {
      case 'recovery_support':
        return 'دعم التعافي';
      case 'family_support':
        return 'دعم الأسرة';
      case 'client_support':
        return 'العملاء';
      case 'center_support':
        return 'المراكز';
      case 'clinician_support':
        return 'الأخصائيين';
      default:
        return value;
    }
  }

  String _issueTypeLabel(String value) {
    switch (value) {
      case 'risk_report':
        return 'بلاغ خطر';
      case 'general_help':
        return 'طلب مساعدة عامة';
      default:
        return value;
    }
  }

  String _priorityLabel(String value) {
    switch (value) {
      case 'normal':
        return 'عادية';
      case 'high':
        return 'عالية';
      default:
        return value;
    }
  }

  String _statusLabel(String value) {
    switch (value) {
      case 'new':
        return 'جديد';
      default:
        return value;
    }
  }
}
