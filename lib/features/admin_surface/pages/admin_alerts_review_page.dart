import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminAlertsReviewPage extends StatelessWidget {
  const AdminAlertsReviewPage({super.key});

  String _dateText(dynamic value) {
    if (value is Timestamp) {
      return value.toDate().toIso8601String();
    }
    return value?.toString().trim() ?? '';
  }

  Color _statusColor(String status) {
    switch (status.trim().toLowerCase()) {
      case 'ok':
        return const Color(0xFF1F9D63);
      case 'warning':
        return const Color(0xFFE39B2E);
      case 'error':
        return const Color(0xFFC74646);
      default:
        return AppColors.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1316),
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Alerts Review',
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
            AppSurfaceCard(
              color: const Color(0xFF10161A).withValues(alpha: 0.94),
              borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('system_alerts')
                    .doc('latest')
                    .snapshots(),
                builder: (context, snapshot) {
                  final headerChildren = <Widget>[
                    const Text(
                      'Alerts Review',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Python-generated operational alerts',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.obsidian.withValues(alpha: 0.68),
                          ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ];

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...headerChildren,
                        const Text('Loading alerts snapshot...'),
                      ],
                    );
                  }

                  if (!snapshot.hasData ||
                      snapshot.data == null ||
                      !snapshot.data!.exists) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...headerChildren,
                        const Text('No alerts snapshot available'),
                      ],
                    );
                  }

                  final data = snapshot.data!.data();
                  if (data == null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...headerChildren,
                        const Text('No alerts snapshot available'),
                      ],
                    );
                  }

                  final status = (data['status'] ?? 'unknown').toString();
                  final severity = (data['severity'] ?? 'unknown').toString();
                  final alertsCount = (data['alertsCount'] ?? 0).toString();
                  final centerFollowUpCount =
                      (data['centerFollowUpCount'] ?? 0).toString();
                  final clientUpdateRequiredCount =
                      (data['clientUpdateRequiredCount'] ?? 0).toString();
                  final summary = (data['summary'] ?? '').toString().trim();
                  final timestamp = _dateText(data['timestamp']);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...headerChildren,
                      AppStatusBadge(
                        label: 'Status: $status',
                        color: _statusColor(status),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Severity: $severity',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Wrap(
                        spacing: AppSpacing.md,
                        runSpacing: AppSpacing.md,
                        children: [
                          _AlertsCountChip(label: 'Alerts', value: alertsCount),
                          _AlertsCountChip(
                            label: 'Center Follow-up',
                            value: centerFollowUpCount,
                          ),
                          _AlertsCountChip(
                            label: 'Client Update Required',
                            value: clientUpdateRequiredCount,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text('Summary: $summary'),
                      if (timestamp.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.sm),
                        Text('Last Scan: $timestamp'),
                      ],
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertsCountChip extends StatelessWidget {
  const _AlertsCountChip({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.mist,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(
          color: AppColors.info.withValues(alpha: 0.20),
        ),
      ),
      child: Text(
        '$label: $value',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
