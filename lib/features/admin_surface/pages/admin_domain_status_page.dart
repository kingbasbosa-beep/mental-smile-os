import 'package:flutter/material.dart';
import 'package:flutterprojects/core/system/domain_governance_capability.dart';
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

  String _boolText(dynamic value) {
    if (value is bool) return value ? 'yes' : 'no';
    return '—';
  }

  String _stringText(dynamic value) {
    final text = (value ?? '').toString().trim();
    return text.isEmpty ? '—' : text;
  }

  String _statusSourceLabel(String value) {
    switch (value) {
      case 'admin_set':
        return 'Admin Set';
      case 'mixed':
        return 'Mixed';
      default:
        return 'Observed';
    }
  }

  Widget _buildMetadataLine(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Text(
        '$label: $value',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildMetadataSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(
          color: AppColors.mist.withValues(alpha: 0.55),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          ...children,
        ],
      ),
    );
  }

  List<Widget> _buildGovernanceCapabilityLines(
    BuildContext context,
    DomainGovernanceCapability capability,
  ) {
    return [
      _buildMetadataLine(
        context,
        label: 'advisoryOnly',
        value: capability.advisoryOnly ? 'yes' : 'no',
      ),
      _buildMetadataLine(
        context,
        label: 'maintenanceNotice',
        value: capability.maintenanceNotice ? 'yes' : 'no',
      ),
      _buildMetadataLine(
        context,
        label: 'editorDisable',
        value: capability.editorDisable ? 'yes' : 'no',
      ),
      _buildMetadataLine(
        context,
        label: 'entryPointHide',
        value: capability.entryPointHide ? 'yes' : 'no',
      ),
      _buildMetadataLine(
        context,
        label: 'protectedRawWrites',
        value: capability.protectedRawWrites ? 'yes' : 'no',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1316),
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'System Domains',
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
              color: const Color(0xFF0B1014).withValues(alpha: 0.96),
              borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.20),
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
              final capability = domain.key.governanceCapability;
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: StreamBuilder<DomainStatus>(
                  stream: _service.watchDomainStatus(domain.key),
                  builder: (context, snapshot) {
                    final status = snapshot.data ?? DomainStatus.unknown();
                    final statusText =
                        status.isUnknown ? 'unknown' : status.status;
                    final hasDegradedFeatures =
                        status.degradedFeatures.isNotEmpty;
                    final isAiPolicyDomain = domain.key == DomainKey.aiPolicy;
                    final isChatDomain = domain.key == DomainKey.chat;
                    final isBookingDomain = domain.key == DomainKey.booking;
                    final hasGovernanceContext =
                        status.statusSource == 'admin_set' ||
                            status.statusSource == 'mixed';

                    return AppSurfaceCard(
                      color: const Color(0xFF10161A).withValues(alpha: 0.94),
                      borderColor:
                          const Color(0xFFD8B26A).withValues(alpha: 0.18),
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
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Status source: ${_statusSourceLabel(status.statusSource)}',
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
                          const SizedBox(height: AppSpacing.sm),
                          _buildMetadataSection(
                            context,
                            title: 'Governance Capability Matrix',
                            children: _buildGovernanceCapabilityLines(
                              context,
                              capability,
                            ),
                          ),
                          if (hasGovernanceContext) ...[
                            const SizedBox(height: AppSpacing.sm),
                            _buildMetadataSection(
                              context,
                              title: 'Governance Context',
                              children: [
                                _buildMetadataLine(
                                  context,
                                  label: 'statusSetBy',
                                  value: _stringText(status.statusSetBy),
                                ),
                                _buildMetadataLine(
                                  context,
                                  label: 'statusSetAt',
                                  value: status.statusSetAt == null
                                      ? '—'
                                      : _formatDate(status.statusSetAt!),
                                ),
                                _buildMetadataLine(
                                  context,
                                  label: 'statusReason',
                                  value: _stringText(status.statusReason),
                                ),
                              ],
                            ),
                          ],
                          if (hasDegradedFeatures) ...[
                            const SizedBox(height: AppSpacing.sm),
                            _buildMetadataSection(
                              context,
                              title: 'Degraded Features',
                              children: status.degradedFeatures
                                  .map((feature) => _buildMetadataLine(
                                        context,
                                        label: '-',
                                        value: feature,
                                      ))
                                  .toList(),
                            ),
                          ],
                          if (isAiPolicyDomain &&
                              status.metadata.isNotEmpty) ...[
                            const SizedBox(height: AppSpacing.sm),
                            _buildMetadataSection(
                              context,
                              title: 'AI Policy Health',
                              children: [
                                _buildMetadataLine(
                                  context,
                                  label: 'draftExists',
                                  value: _boolText(
                                    status.metadata['draftExists'],
                                  ),
                                ),
                                _buildMetadataLine(
                                  context,
                                  label: 'publishedExists',
                                  value: _boolText(
                                    status.metadata['publishedExists'],
                                  ),
                                ),
                                _buildMetadataLine(
                                  context,
                                  label: 'draftVersion',
                                  value: _stringText(
                                    status.metadata['draftVersion'],
                                  ),
                                ),
                                _buildMetadataLine(
                                  context,
                                  label: 'publishedVersion',
                                  value: _stringText(
                                    status.metadata['publishedVersion'],
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (isChatDomain && status.metadata.isNotEmpty) ...[
                            const SizedBox(height: AppSpacing.sm),
                            _buildMetadataSection(
                              context,
                              title: 'Chat Health',
                              children: [
                                _buildMetadataLine(
                                  context,
                                  label: 'openEscalationsCount',
                                  value: _stringText(
                                    status.metadata['openEscalationsCount'],
                                  ),
                                ),
                                _buildMetadataLine(
                                  context,
                                  label: 'openAdminSupportCount',
                                  value: _stringText(
                                    status.metadata['openAdminSupportCount'],
                                  ),
                                ),
                                _buildMetadataLine(
                                  context,
                                  label: 'lastHealthSampleType',
                                  value: _stringText(
                                    status.metadata['lastHealthSampleType'],
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (isBookingDomain &&
                              status.metadata.isNotEmpty) ...[
                            const SizedBox(height: AppSpacing.sm),
                            _buildMetadataSection(
                              context,
                              title: 'Booking Health',
                              children: [
                                _buildMetadataLine(
                                  context,
                                  label: 'pendingRequestsCount',
                                  value: _stringText(
                                    status.metadata['pendingRequestsCount'],
                                  ),
                                ),
                                _buildMetadataLine(
                                  context,
                                  label: 'sessionSetupPendingCount',
                                  value: _stringText(
                                    status.metadata['sessionSetupPendingCount'],
                                  ),
                                ),
                                _buildMetadataLine(
                                  context,
                                  label: 'pendingReviewsCount',
                                  value: _stringText(
                                    status.metadata['pendingReviewsCount'],
                                  ),
                                ),
                                _buildMetadataLine(
                                  context,
                                  label: 'lastHealthSampleType',
                                  value: _stringText(
                                    status.metadata['lastHealthSampleType'],
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (domain.ownedCollections.isNotEmpty) ...[
                            const SizedBox(height: AppSpacing.sm),
                            Wrap(
                              spacing: AppSpacing.xs,
                              runSpacing: AppSpacing.xs,
                              children:
                                  domain.ownedCollections.map((collection) {
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
