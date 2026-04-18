import 'package:flutter/material.dart';
import 'package:flutterprojects/core/system/domain_registry.dart';
import 'package:flutterprojects/core/system/domain_status.dart';
import 'package:flutterprojects/core/system/domain_status_service.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminDomainStatusPage extends StatelessWidget {
  const AdminDomainStatusPage({super.key});

  static const DomainStatusService _service = DomainStatusService();

  Color _statusColor(String status) {
    switch (status) {
      case 'active':
        return const Color(0xFF1F9D63);
      case 'degraded':
        return const Color(0xFFE39B2E);
      case 'maintenance':
        return const Color(0xFF2E5AAC);
      case 'disabled':
        return const Color(0xFFC74646);
      default:
        return const Color(0xFF7A7A7A);
    }
  }

  String _formatDate(DateTime value) {
    if (value.millisecondsSinceEpoch == 0) return '—';
    String two(int n) => n.toString().padLeft(2, '0');
    return '${value.year}-${two(value.month)}-${two(value.day)} ${two(value.hour)}:${two(value.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'System Domains',
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
                    'Domain Status Overview',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Read-only control-plane view for the project domains. This page does not change any runtime behavior.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ...domainRegistry.map((domain) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: StreamBuilder<DomainStatus>(
                  stream: _service.watchDomainStatus(domain.key),
                  builder: (context, snapshot) {
                    final status = snapshot.data ?? DomainStatus.unknown();
                    final statusText = status.isUnknown ? 'unknown' : status.status;

                    return AppSurfaceCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      domain.displayName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                    const SizedBox(height: AppSpacing.xs),
                                    Text(
                                      domain.description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              AppStatusBadge(
                                label: statusText,
                                color: _statusColor(statusText),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            'Last updated: ${_formatDate(status.updatedAt)}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          if ((status.updatedBy ?? '').isNotEmpty) ...[
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              'Updated by: ${status.updatedBy}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                          if ((status.note ?? '').isNotEmpty) ...[
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              'Note: ${status.note}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                          if (domain.ownedCollections.isNotEmpty) ...[
                            const SizedBox(height: AppSpacing.sm),
                            Wrap(
                              spacing: AppSpacing.xs,
                              runSpacing: AppSpacing.xs,
                              children: domain.ownedCollections.map((collection) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.sm,
                                    vertical: AppSpacing.xs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.mist,
                                    borderRadius:
                                        BorderRadius.circular(AppRadii.md),
                                  ),
                                  child: Text(collection),
                                );
                              }).toList(),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
