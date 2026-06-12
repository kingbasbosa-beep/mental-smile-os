import 'package:flutter/material.dart';
import 'package:flutterprojects/core/system/domain_governance_capability.dart';
import 'package:flutterprojects/core/system/domain_registry.dart';
import 'package:flutterprojects/core/system/domain_status.dart';
import 'package:flutterprojects/core/system/domain_status_service.dart';

// [S] Registry Room runtime.
// Registry visibility only; no writes or lifecycle changes.
class SRegistryRoomPage extends StatelessWidget {
  const SRegistryRoomPage({super.key});

  static const DomainStatusService _service = DomainStatusService();

  static List<DomainDefinition> get _visibleDomains {
    return domainRegistry
        .where(
          (domain) => <DomainKey>{
            DomainKey.chat,
            DomainKey.specialistWorkspace,
            DomainKey.aiPolicy,
            DomainKey.governance,
            DomainKey.library,
            DomainKey.reportsInsights,
            DomainKey.communication,
            DomainKey.marketing,
          }.contains(domain.key),
        )
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F8),
      appBar: AppBar(
        title: const Text('Registry Room'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF17252A),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: <Widget>[
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1040),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const _RegistryRoomHero(),
                    const SizedBox(height: 18),
                    for (final domain in _visibleDomains) ...<Widget>[
                      _RegistryDomainCard(domain: domain),
                      const SizedBox(height: 14),
                    ],
                    const SizedBox(height: 10),
                    const _RegistryRoomBoundaryNote(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegistryRoomHero extends StatelessWidget {
  const _RegistryRoomHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: _cardDecoration(const Color(0xFF7AA69D)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Registry Room',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: const Color(0xFF17252A),
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Constitutional registry visibility without operational ownership',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF4A5D63),
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 14),
          const _RegistryPill(text: 'Read-only registry visibility'),
        ],
      ),
    );
  }
}

class _RegistryDomainCard extends StatelessWidget {
  const _RegistryDomainCard({required this.domain});

  final DomainDefinition domain;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DomainStatus>(
      stream: SRegistryRoomPage._service.watchDomainStatus(domain.key),
      builder: (context, snapshot) {
        final status = snapshot.data ?? DomainStatus.unknown();
        final statusText = status.isUnknown ? 'unknown' : status.status;
        final capability = domain.key.governanceCapability;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: _cardDecoration(_statusColor(statusText)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          domain.displayName,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: const Color(0xFF17252A),
                                    fontWeight: FontWeight.w900,
                                  ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _domainDescription(domain),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: const Color(0xFF52656A),
                                    height: 1.4,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  _StatusBadge(label: statusText, color: _statusColor(statusText)),
                ],
              ),
              const SizedBox(height: 14),
              _MetadataGrid(
                items: <_MetadataItem>[
                  _MetadataItem('Last updated', _formatDate(status.updatedAt)),
                  _MetadataItem(
                    'Registry source',
                    _statusSourceLabel(status.statusSource),
                  ),
                  if ((status.updatedBy ?? '').trim().isNotEmpty)
                    _MetadataItem('Updated by', status.updatedBy!.trim()),
                  if ((status.note ?? '').trim().isNotEmpty)
                    _MetadataItem('Note', status.note!.trim()),
                ],
              ),
              const SizedBox(height: 12),
              _CapabilitySection(capability: capability),
              if (_hasRegistryContext(status)) ...<Widget>[
                const SizedBox(height: 12),
                _MetadataSection(
                  title: 'Registry Context',
                  items: <_MetadataItem>[
                    _MetadataItem('sourceBy', _stringText(status.statusSetBy)),
                    _MetadataItem(
                      'sourceAt',
                      status.statusSetAt == null
                          ? '-'
                          : _formatDate(status.statusSetAt!),
                    ),
                    _MetadataItem('sourceReason', _stringText(status.statusReason)),
                  ],
                ),
              ],
              if (status.degradedFeatures.isNotEmpty) ...<Widget>[
                const SizedBox(height: 12),
                _MetadataSection(
                  title: 'Degraded Features',
                  items: status.degradedFeatures
                      .map((feature) => _MetadataItem('feature', feature))
                      .toList(growable: false),
                ),
              ],
              if (domain.key == DomainKey.aiPolicy &&
                  status.metadata.isNotEmpty) ...<Widget>[
                const SizedBox(height: 12),
                _MetadataSection(
                  title: 'Policy Health',
                  items: <_MetadataItem>[
                    _MetadataItem(
                      'draftExists',
                      _boolText(status.metadata['draftExists']),
                    ),
                    _MetadataItem(
                      'publishedExists',
                      _boolText(status.metadata['publishedExists']),
                    ),
                    _MetadataItem(
                      'draftVersion',
                      _stringText(status.metadata['draftVersion']),
                    ),
                    _MetadataItem(
                      'publishedVersion',
                      _stringText(status.metadata['publishedVersion']),
                    ),
                  ],
                ),
              ],
              if (domain.key == DomainKey.chat &&
                  status.metadata.isNotEmpty) ...<Widget>[
                const SizedBox(height: 12),
                _MetadataSection(
                  title: 'Support Signal Health',
                  items: <_MetadataItem>[
                    _MetadataItem(
                      'openSignalCount',
                      _stringText(status.metadata['openEscalationsCount']),
                    ),
                    _MetadataItem(
                      'openSupportRoomCount',
                      _stringText(status.metadata['openSupportRoomCount']),
                    ),
                    _MetadataItem(
                      'lastHealthSampleType',
                      _stringText(status.metadata['lastHealthSampleType']),
                    ),
                  ],
                ),
              ],
              if (_visibleCollections(domain).isNotEmpty) ...<Widget>[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _visibleCollections(domain)
                      .map((collection) => _RegistryPill(text: collection))
                      .toList(growable: false),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _CapabilitySection extends StatelessWidget {
  const _CapabilitySection({required this.capability});

  final DomainGovernanceCapability capability;

  @override
  Widget build(BuildContext context) {
    return _MetadataSection(
      title: 'Capability Matrix',
      items: <_MetadataItem>[
        _MetadataItem('advisoryOnly', _yesNo(capability.advisoryOnly)),
        _MetadataItem('maintenanceNotice', _yesNo(capability.maintenanceNotice)),
        _MetadataItem('editorDisable', _yesNo(capability.editorDisable)),
        _MetadataItem('entryPointHide', _yesNo(capability.entryPointHide)),
        _MetadataItem('protectedRawWrites', _yesNo(capability.protectedRawWrites)),
      ],
    );
  }
}

class _MetadataGrid extends StatelessWidget {
  const _MetadataGrid({required this.items});

  final List<_MetadataItem> items;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: items
          .map(
            (item) => _MetadataChip(label: item.label, value: item.value),
          )
          .toList(growable: false),
    );
  }
}

class _MetadataSection extends StatelessWidget {
  const _MetadataSection({
    required this.title,
    required this.items,
  });

  final String title;
  final List<_MetadataItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD1DDE0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: const Color(0xFF17252A),
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 10),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                '${item.label}: ${item.value}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF52656A),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MetadataChip extends StatelessWidget {
  const _MetadataChip({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F6),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFD1DDE0)),
      ),
      child: Text(
        '$label: $value',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF17252A),
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.42)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w900,
            ),
      ),
    );
  }
}

class _RegistryPill extends StatelessWidget {
  const _RegistryPill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F1EF),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFF7AA69D)),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF23443E),
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

class _RegistryRoomBoundaryNote extends StatelessWidget {
  const _RegistryRoomBoundaryNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F1EF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF7AA69D)),
      ),
      child: Text(
        'This room observes and organizes registries. It does not own people, '
        'providers, operational lifecycles, or treatment decisions.',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF23443E),
              height: 1.5,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _MetadataItem {
  const _MetadataItem(this.label, this.value);

  final String label;
  final String value;
}

BoxDecoration _cardDecoration(Color accent) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: accent.withValues(alpha: 0.28)),
  );
}

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

String _domainDescription(DomainDefinition domain) {
  if (domain.key == DomainKey.specialistWorkspace) {
    return 'Clinician-facing visibility boundaries and support context surfaces.';
  }
  return domain.description;
}

String _formatDate(DateTime value) {
  if (value.millisecondsSinceEpoch == 0) return '-';
  String two(int n) => n.toString().padLeft(2, '0');
  return '${value.year}-${two(value.month)}-${two(value.day)} ${two(value.hour)}:${two(value.minute)}';
}

String _boolText(Object? value) {
  if (value is bool) return value ? 'yes' : 'no';
  return '-';
}

String _stringText(Object? value) {
  final text = (value ?? '').toString().trim();
  return text.isEmpty ? '-' : text;
}

String _statusSourceLabel(String value) {
  switch (value) {
    case 'mixed':
      return 'Mixed Registry Source';
    case 'observed':
      return 'Observed';
    default:
      return 'Registry Source';
  }
}

String _yesNo(bool value) => value ? 'yes' : 'no';

bool _hasRegistryContext(DomainStatus status) {
  return status.statusSource != 'observed';
}

List<String> _visibleCollections(DomainDefinition domain) {
  return domain.ownedCollections
      .where(
        <String>{
          'chat_threads',
          'chat_escalations',
          'ai_policies',
          'system_domains',
          'system_alerts',
        }.contains,
      )
      .toList(growable: false);
}
