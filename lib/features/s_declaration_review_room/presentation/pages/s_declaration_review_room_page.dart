import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/features/centers/data/models/center_pricing.dart';
import 'package:flutterprojects/features/centers/presentation/center_document_requirements.dart';
import 'package:url_launcher/url_launcher.dart';

// [S] Readiness Observatory runtime.
// Read-only declaration visibility only; no writes or ownership changes.
class SDeclarationReviewRoomPage extends StatefulWidget {
  const SDeclarationReviewRoomPage({super.key});

  @override
  State<SDeclarationReviewRoomPage> createState() =>
      _SDeclarationReviewRoomPageState();
}

class _SDeclarationReviewRoomPageState
    extends State<SDeclarationReviewRoomPage> {
  final TextEditingController _searchController = TextEditingController();
  _DeclarationStream _stream = _DeclarationStream.clinicians;
  String _statusFilter = 'all';
  String _sort = 'newest';
  String _search = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _watchCurrentStream() {
    switch (_stream) {
      case _DeclarationStream.clinicians:
        return FirebaseFirestore.instance
            .collection('clinicians')
            .orderBy('createdAt', descending: true)
            .snapshots();
      case _DeclarationStream.centers:
        return FirebaseFirestore.instance.collection('centers').snapshots();
      case _DeclarationStream.clinicianProfileChanges:
        return FirebaseFirestore.instance
            .collection('clinician_profile_change_requests')
            .snapshots();
      case _DeclarationStream.centerProfileChanges:
        return FirebaseFirestore.instance
            .collection('center_profile_change_requests')
            .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F8),
      appBar: AppBar(
        title: const Text('Readiness Observatory'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF17252A),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _watchCurrentStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const _DeclarationLoadingState();
            }

            if (snapshot.hasError) {
              return _DeclarationErrorState(error: snapshot.error);
            }

            final docs = snapshot.data?.docs ??
                const <QueryDocumentSnapshot<Map<String, dynamic>>>[];
            final records = docs
                .map(
                  (doc) => _DeclarationRecord(
                    id: doc.id,
                    data: doc.data(),
                    stream: _stream,
                  ),
                )
                .where(_matchesSearch)
                .where(_matchesStatus)
                .toList(growable: false)
              ..sort(_compareRecords);

            return ListView(
              padding: const EdgeInsets.all(24),
              children: <Widget>[
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1080),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const _DeclarationRoomHero(),
                        const SizedBox(height: 18),
                        _DeclarationFilters(
                          selectedStream: _stream,
                          statusFilter: _statusFilter,
                          sort: _sort,
                          searchController: _searchController,
                          onStreamChanged: (value) {
                            setState(() {
                              _stream = value;
                              _statusFilter = 'all';
                            });
                          },
                          onStatusChanged: (value) {
                            setState(() => _statusFilter = value);
                          },
                          onSortChanged: (value) {
                            setState(() => _sort = value);
                          },
                          onSearchChanged: (value) {
                            setState(() => _search = value);
                          },
                        ),
                        const SizedBox(height: 18),
                        _DeclarationSummaryStrip(
                          records: docs
                              .map(
                                (doc) => _DeclarationRecord(
                                  id: doc.id,
                                  data: doc.data(),
                                  stream: _stream,
                                ),
                              )
                              .toList(growable: false),
                        ),
                        const SizedBox(height: 18),
                        if (records.isEmpty)
                          _DeclarationEmptyState(
                            message: _emptyMessage,
                          )
                        else
                          for (final record in records) ...<Widget>[
                            _DeclarationRecordCard(record: record),
                            const SizedBox(height: 14),
                          ],
                        const SizedBox(height: 8),
                        const _DeclarationRoomBoundaryNote(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String get _emptyMessage {
    switch (_stream) {
      case _DeclarationStream.clinicians:
        return 'No clinician declarations match these filters.';
      case _DeclarationStream.centers:
        return 'No center declarations match these filters.';
      case _DeclarationStream.clinicianProfileChanges:
        return 'No clinician profile update declarations match these filters.';
      case _DeclarationStream.centerProfileChanges:
        return 'No center profile update declarations match these filters.';
    }
  }

  bool _matchesSearch(_DeclarationRecord record) {
    final q = _search.trim().toLowerCase();
    if (q.isEmpty) return true;
    return record.searchText.contains(q);
  }

  bool _matchesStatus(_DeclarationRecord record) {
    if (_statusFilter == 'all') return true;
    return record.status == _statusFilter;
  }

  int _compareRecords(_DeclarationRecord a, _DeclarationRecord b) {
    final aDate = a.createdAt;
    final bDate = b.createdAt;
    return _sort == 'oldest'
        ? aDate.compareTo(bDate)
        : bDate.compareTo(aDate);
  }
}

enum _DeclarationStream {
  clinicians,
  centers,
  clinicianProfileChanges,
  centerProfileChanges,
}

class _DeclarationRecord {
  const _DeclarationRecord({
    required this.id,
    required this.data,
    required this.stream,
  });

  final String id;
  final Map<String, dynamic> data;
  final _DeclarationStream stream;

  String get title {
    switch (stream) {
      case _DeclarationStream.clinicians:
        return _firstText(
          data,
          const [
            'displayName',
            'fullDisplayNameEn',
            'fullDisplayNameAr',
            'name',
            'email',
          ],
          fallback: 'Clinician declaration',
        );
      case _DeclarationStream.centers:
        return _firstText(
          data,
          const ['centerName', 'displayName', 'name', 'email'],
          fallback: 'Center declaration',
        );
      case _DeclarationStream.clinicianProfileChanges:
        return _firstText(
          data,
          const ['clinicianName', 'clinicianEmail'],
          fallback: 'Clinician profile update declaration',
        );
      case _DeclarationStream.centerProfileChanges:
        return _firstText(
          data,
          const ['centerName', 'centerEmail'],
          fallback: 'Center profile update declaration',
        );
    }
  }

  String get status {
    switch (stream) {
      case _DeclarationStream.clinicians:
      case _DeclarationStream.centers:
        final readiness =
            (data['visibilityReadiness'] ?? '').toString().trim();
        if (readiness.isNotEmpty) return readiness;
        return 'incomplete';
      case _DeclarationStream.clinicianProfileChanges:
      case _DeclarationStream.centerProfileChanges:
        return _declarationStatus(
          (data['status'] ?? 'submitted').toString().trim(),
        );
    }
  }

  String get statusLabel {
    switch (status) {
      case 'ready':
      case 'processed':
        return 'Processed';
      case 'incomplete':
        return 'Incomplete';
      case 'blocked':
        return 'Blocked';
      case 'withdrawn':
        return 'Withdrawn';
      case 'stored':
        return 'Stored';
      case 'center_follow_up':
        return 'Continuity check';
      case 'draft':
        return 'Draft';
      case 'submitted':
      default:
        return 'Submitted';
    }
  }

  DateTime get createdAt {
    final raw = data['createdAt'] ?? data['updatedAt'];
    if (raw is Timestamp) return raw.toDate();
    if (raw is DateTime) return raw;
    if (raw is String) return DateTime.tryParse(raw) ?? DateTime(1970);
    return DateTime(1970);
  }

  Color get statusColor {
    switch (status) {
      case 'ready':
      case 'processed':
        return const Color(0xFF2B7A4B);
      case 'blocked':
      case 'stored':
        return const Color(0xFFB64B4B);
      case 'withdrawn':
      case 'center_follow_up':
        return const Color(0xFF9A6B32);
      case 'incomplete':
      case 'submitted':
      case 'draft':
      default:
        return const Color(0xFF6D5A9A);
    }
  }

  String get streamLabel {
    switch (stream) {
      case _DeclarationStream.clinicians:
        return 'Clinician Declarations';
      case _DeclarationStream.centers:
        return 'Center Declarations';
      case _DeclarationStream.clinicianProfileChanges:
        return 'Clinician Profile Declarations';
      case _DeclarationStream.centerProfileChanges:
        return 'Center Profile Declarations';
    }
  }

  String get searchText {
    final values = <String>[
      id,
      title,
      status,
      for (final value in data.values) _searchValue(value),
    ];
    return values.join(' ').toLowerCase();
  }
}

class _DeclarationRoomHero extends StatelessWidget {
  const _DeclarationRoomHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: _cardDecoration(const Color(0xFF8CB6AE)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Readiness Observatory',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: const Color(0xFF17252A),
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Signal readiness observation for provider and center declarations without operational authority',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF4A5D63),
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
          ),
          const SizedBox(height: 14),
          const _Pill(text: 'Read-only declaration stream'),
        ],
      ),
    );
  }
}

class _DeclarationFilters extends StatelessWidget {
  const _DeclarationFilters({
    required this.selectedStream,
    required this.statusFilter,
    required this.sort,
    required this.searchController,
    required this.onStreamChanged,
    required this.onStatusChanged,
    required this.onSortChanged,
    required this.onSearchChanged,
  });

  final _DeclarationStream selectedStream;
  final String statusFilter;
  final String sort;
  final TextEditingController searchController;
  final ValueChanged<_DeclarationStream> onStreamChanged;
  final ValueChanged<String> onStatusChanged;
  final ValueChanged<String> onSortChanged;
  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(const Color(0xFFCADBD8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: searchController,
            onChanged: onSearchChanged,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: 'Search declarations',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 300,
                child: DropdownButtonFormField<_DeclarationStream>(
                  value: selectedStream,
                  decoration: const InputDecoration(
                    labelText: 'Declaration type',
                    border: OutlineInputBorder(),
                  ),
                  items: const <DropdownMenuItem<_DeclarationStream>>[
                    DropdownMenuItem(
                      value: _DeclarationStream.clinicians,
                      child: Text('Clinician declarations'),
                    ),
                    DropdownMenuItem(
                      value: _DeclarationStream.centers,
                      child: Text('Center declarations'),
                    ),
                    DropdownMenuItem(
                      value: _DeclarationStream.clinicianProfileChanges,
                      child: Text('Clinician profile declarations'),
                    ),
                    DropdownMenuItem(
                      value: _DeclarationStream.centerProfileChanges,
                      child: Text('Center profile declarations'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) onStreamChanged(value);
                  },
                ),
              ),
              SizedBox(
                width: 280,
                child: DropdownButtonFormField<String>(
                  value: statusFilter,
                  decoration: const InputDecoration(
                    labelText: 'Readiness status',
                    border: OutlineInputBorder(),
                  ),
                  items: _statusOptions(selectedStream),
                  onChanged: (value) {
                    if (value != null) onStatusChanged(value);
                  },
                ),
              ),
              SizedBox(
                width: 180,
                child: DropdownButtonFormField<String>(
                  value: sort,
                  decoration: const InputDecoration(
                    labelText: 'Order',
                    border: OutlineInputBorder(),
                  ),
                  items: const <DropdownMenuItem<String>>[
                    DropdownMenuItem(value: 'newest', child: Text('Newest')),
                    DropdownMenuItem(value: 'oldest', child: Text('Oldest')),
                  ],
                  onChanged: (value) {
                    if (value != null) onSortChanged(value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static List<DropdownMenuItem<String>> _statusOptions(
    _DeclarationStream stream,
  ) {
    final isProviderStream = stream == _DeclarationStream.clinicians ||
        stream == _DeclarationStream.centers;
    final values = isProviderStream
        ? const <MapEntry<String, String>>[
            MapEntry('all', 'All readiness states'),
            MapEntry('incomplete', 'Incomplete'),
            MapEntry('ready', 'Ready'),
            MapEntry('blocked', 'Blocked'),
            MapEntry('withdrawn', 'Withdrawn'),
          ]
        : const <MapEntry<String, String>>[
            MapEntry('all', 'All declaration states'),
            MapEntry('draft', 'Draft'),
            MapEntry('submitted', 'Submitted'),
            MapEntry('processed', 'Processed'),
            MapEntry('stored', 'Stored'),
          ];

    return values
        .map(
          (entry) => DropdownMenuItem<String>(
            value: entry.key,
            child: Text(entry.value),
          ),
        )
        .toList(growable: false);
  }
}

class _DeclarationSummaryStrip extends StatelessWidget {
  const _DeclarationSummaryStrip({required this.records});

  final List<_DeclarationRecord> records;

  @override
  Widget build(BuildContext context) {
    final incomplete = records
        .where((record) =>
            record.status == 'incomplete' ||
            record.status == 'draft' ||
            record.status == 'submitted')
        .length;
    final ready = records
        .where(
          (record) => record.status == 'ready' || record.status == 'processed',
        )
        .length;
    final blocked = records
        .where(
          (record) =>
              record.status == 'blocked' || record.status == 'stored',
        )
        .length;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width =
            constraints.maxWidth >= 760 ? (constraints.maxWidth - 28) / 3 : null;
        return Wrap(
          spacing: 14,
          runSpacing: 14,
          children: <Widget>[
            _SummaryCard(
              width: width,
              label: 'Total declarations',
              value: '${records.length}',
              color: const Color(0xFF2B7A78),
            ),
            _SummaryCard(
              width: width,
              label: 'Draft / incomplete',
              value: '$incomplete',
              color: const Color(0xFF6D5A9A),
            ),
            _SummaryCard(
              width: width,
              label: 'Ready / blocked',
              value: '$ready / $blocked',
              color: const Color(0xFF3F6C91),
            ),
          ],
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.width,
    required this.label,
    required this.value,
    required this.color,
  });

  final double? width;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        constraints: const BoxConstraints(minWidth: 220),
        padding: const EdgeInsets.all(18),
        decoration: _cardDecoration(color),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: const Color(0xFF17252A),
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF52656A),
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeclarationRecordCard extends StatelessWidget {
  const _DeclarationRecordCard({required this.record});

  final _DeclarationRecord record;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(record.statusColor),
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
                      record.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: const Color(0xFF17252A),
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      record.streamLabel,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF52656A),
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _Pill(
                text: record.statusLabel,
                color: record.statusColor,
              ),
            ],
          ),
          const SizedBox(height: 14),
          _MetadataGrid(items: _metadataFor(record)),
          if (_readinessFor(record).isNotEmpty) ...<Widget>[
            const SizedBox(height: 14),
            _ReadinessSummary(items: _readinessFor(record)),
          ],
          if (_comparisonItems(record).isNotEmpty) ...<Widget>[
            const SizedBox(height: 14),
            _ComparisonView(items: _comparisonItems(record)),
          ],
          if (_documentItems(record).isNotEmpty) ...<Widget>[
            const SizedBox(height: 14),
            _DocumentLinks(items: _documentItems(record)),
          ],
        ],
      ),
    );
  }
}

class _ReadinessSummary extends StatelessWidget {
  const _ReadinessSummary({required this.items});

  final List<_MetadataItem> items;

  @override
  Widget build(BuildContext context) {
    return _MetadataSection(title: 'Visibility Readiness', items: items);
  }
}

class _ComparisonView extends StatelessWidget {
  const _ComparisonView({required this.items});

  final List<_ComparisonItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Read-only Comparison',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: const Color(0xFF17252A),
                fontWeight: FontWeight.w900,
              ),
        ),
        const SizedBox(height: 10),
        for (final item in items) ...<Widget>[
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FBFA),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFD6E3E0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.label,
                  style: const TextStyle(
                    color: Color(0xFF17252A),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Current: ${item.current}'),
                const SizedBox(height: 4),
                Text('Declared: ${item.requested}'),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _DocumentLinks extends StatelessWidget {
  const _DocumentLinks({required this.items});

  final List<_DocumentItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Document Review Signals',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: const Color(0xFF17252A),
                fontWeight: FontWeight.w900,
              ),
        ),
        const SizedBox(height: 10),
        for (final item in items) ...<Widget>[
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FBFA),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFD6E3E0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.label,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Readiness state: ${_readinessStatusText(item.status)}',
                      ),
                      if (item.uploadedAt.isNotEmpty) ...<Widget>[
                        const SizedBox(height: 4),
                        Text('Uploaded at: ${item.uploadedAt}'),
                      ],
                    ],
                  ),
                ),
                if (item.url.isNotEmpty) ...<Widget>[
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () => _openUrl(item.url),
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Open'),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _MetadataGrid extends StatelessWidget {
  const _MetadataGrid({required this.items});

  final List<_MetadataItem> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: items
          .where((item) => item.value.trim().isNotEmpty)
          .map(
            (item) => Container(
              constraints: const BoxConstraints(minWidth: 180, maxWidth: 320),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FBFA),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFD6E3E0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.label,
                    style: const TextStyle(
                      color: Color(0xFF52656A),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.value,
                    style: const TextStyle(
                      color: Color(0xFF17252A),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
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
        color: const Color(0xFFEAF2F0),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFCADBD8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF17252A),
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 10),
          _MetadataGrid(items: items),
        ],
      ),
    );
  }
}

class _DeclarationRoomBoundaryNote extends StatelessWidget {
  const _DeclarationRoomBoundaryNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF2F0),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF8CB6AE)),
      ),
      child: Text(
        'This room observes submitted declaration signals and visibility readiness. '
        'It observes readiness signals only. It does not own people, journeys, '
        'or treatment decisions.',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF284B4A),
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
      ),
    );
  }
}

class _DeclarationLoadingState extends StatelessWidget {
  const _DeclarationLoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _DeclarationErrorState extends StatelessWidget {
  const _DeclarationErrorState({required this.error});

  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'Unable to load declaration stream.\n$error',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _DeclarationEmptyState extends StatelessWidget {
  const _DeclarationEmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: _cardDecoration(const Color(0xFFCADBD8)),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: const Color(0xFF52656A),
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.text,
    this.color = const Color(0xFF2B7A78),
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w800,
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

class _ComparisonItem {
  const _ComparisonItem({
    required this.label,
    required this.current,
    required this.requested,
  });

  final String label;
  final String current;
  final String requested;
}

class _DocumentItem {
  const _DocumentItem({
    required this.label,
    required this.status,
    required this.url,
    required this.uploadedAt,
  });

  final String label;
  final String status;
  final String url;
  final String uploadedAt;
}

List<_MetadataItem> _metadataFor(_DeclarationRecord record) {
  final data = record.data;
  switch (record.stream) {
    case _DeclarationStream.clinicians:
      return <_MetadataItem>[
        _MetadataItem('Email', _text(data['email'])),
        _MetadataItem('Phone', _firstText(data, const ['phone', 'phoneNumber'])),
        _MetadataItem('Specialty', _text(data['specialty'])),
        _MetadataItem('Professional title', _text(data['professionalTitleLabelAr'])),
        _MetadataItem('Created at', _dateText(data['createdAt'])),
        _MetadataItem('Visibility readiness', record.statusLabel),
      ];
    case _DeclarationStream.centers:
      return <_MetadataItem>[
        _MetadataItem('Email', _text(data['email'])),
        _MetadataItem('Phone', _firstText(data, const ['phone', 'phoneNumber'])),
        _MetadataItem('City', _text(data['city'])),
        _MetadataItem('Area', _text(data['area'])),
        _MetadataItem('Category', _text(data['category'])),
        _MetadataItem('Created at', _dateText(data['createdAt'])),
        _MetadataItem('Visibility readiness', record.statusLabel),
      ];
    case _DeclarationStream.clinicianProfileChanges:
      return <_MetadataItem>[
        _MetadataItem('Clinician email', _text(data['clinicianEmail'])),
        _MetadataItem('Declaration type', _profileChangeType(data, false)),
        _MetadataItem('Created at', _dateText(data['createdAt'])),
        _MetadataItem('Readiness state', record.statusLabel),
      ];
    case _DeclarationStream.centerProfileChanges:
      return <_MetadataItem>[
        _MetadataItem('Center email', _text(data['centerEmail'])),
        _MetadataItem('Declaration type', _profileChangeType(data, true)),
        _MetadataItem('Created at', _dateText(data['createdAt'])),
        _MetadataItem('Readiness state', record.statusLabel),
      ];
  }
}

List<_MetadataItem> _readinessFor(_DeclarationRecord record) {
  final data = record.data;
  switch (record.stream) {
    case _DeclarationStream.clinicians:
      return <_MetadataItem>[
        _MetadataItem('Readiness', record.statusLabel),
        _MetadataItem(
          'Missing signals',
          _stringListText(data['missingSignals']),
        ),
        _MetadataItem(
          'Completed signals',
          _stringListText(data['completedSignals']),
        ),
        _MetadataItem(
          'Readiness source',
          _text(
            data['readinessSource'],
            fallback: 'readiness_signals',
          ),
        ),
        _MetadataItem(
          'Readiness updated',
          _dateText(data['readinessUpdatedAt']),
        ),
        _MetadataItem('Identity file', _presence(data['identityFileName'])),
        _MetadataItem('Certificate file', _presence(data['certificateFileName'])),
      ];
    case _DeclarationStream.centers:
      final docs = _mapList(data['documentItems']);
      final summary = _requiredDocumentSignalSummary(docs);
      return <_MetadataItem>[
        _MetadataItem('Readiness', record.statusLabel),
        _MetadataItem(
          'Missing signals',
          _stringListText(data['missingSignals']),
        ),
        _MetadataItem(
          'Completed signals',
          _stringListText(data['completedSignals']),
        ),
        _MetadataItem(
          'Readiness source',
          _text(
            data['readinessSource'],
            fallback: 'readiness_signals',
          ),
        ),
        _MetadataItem(
          'Readiness updated',
          _dateText(data['readinessUpdatedAt']),
        ),
        _MetadataItem('Uploaded documents', '${docs.length}'),
        _MetadataItem(
          'Required document readiness',
          '${summary['completed']} / ${summary['required']}',
        ),
        _MetadataItem('Missing documents', '${summary['missing']}'),
      ];
    case _DeclarationStream.clinicianProfileChanges:
      return <_MetadataItem>[
        _MetadataItem('Bio declaration', _presence(data['requestedBio'])),
        _MetadataItem('Photo declaration', _presence(data['requestedPhotoUrl'])),
      ];
    case _DeclarationStream.centerProfileChanges:
      final requestedDocs = _mapList(data['requestedDocumentItems']);
      final requestedImages = _mapList(data['requestedGalleryItems']);
      return <_MetadataItem>[
        _MetadataItem('Image declarations', '${requestedImages.length}'),
        _MetadataItem('Document declarations', '${requestedDocs.length}'),
        _MetadataItem('Accommodation cost declaration', _listPresence(data['requestedAccommodationCosts'])),
        _MetadataItem('Capability declaration', _mapPresence(data['requestedCenterCapabilities'])),
      ];
  }
}

List<_ComparisonItem> _comparisonItems(_DeclarationRecord record) {
  final data = record.data;
  switch (record.stream) {
    case _DeclarationStream.clinicians:
    case _DeclarationStream.centers:
      return const <_ComparisonItem>[];
    case _DeclarationStream.clinicianProfileChanges:
      return <_ComparisonItem>[
        _ComparisonItem(
          label: 'Bio',
          current: _text(data['currentBio'], fallback: '-'),
          requested: _text(data['requestedBio'], fallback: '-'),
        ),
        _ComparisonItem(
          label: 'Photo URL',
          current: _text(data['currentPhotoUrl'], fallback: '-'),
          requested: _text(data['requestedPhotoUrl'], fallback: '-'),
        ),
      ];
    case _DeclarationStream.centerProfileChanges:
      return <_ComparisonItem>[
        _ComparisonItem(
          label: 'Center name',
          current: _text(data['currentCenterName'], fallback: '-'),
          requested: _text(data['requestedCenterName'], fallback: '-'),
        ),
        _ComparisonItem(
          label: 'Manager name',
          current: _text(data['currentManagerName'], fallback: '-'),
          requested: _text(data['requestedManagerName'], fallback: '-'),
        ),
        _ComparisonItem(
          label: 'Description',
          current: _text(data['currentDescription'], fallback: '-'),
          requested: _text(data['requestedDescription'], fallback: '-'),
        ),
        _ComparisonItem(
          label: 'City',
          current: _text(data['currentCity'], fallback: '-'),
          requested: _text(data['requestedCity'], fallback: '-'),
        ),
        _ComparisonItem(
          label: 'Address',
          current: _text(data['currentAddress'], fallback: '-'),
          requested: _text(data['requestedAddress'], fallback: '-'),
        ),
        _ComparisonItem(
          label: 'Images',
          current: _assetSummary(_mapList(data['currentGalleryItems'])),
          requested: _assetSummary(_mapList(data['requestedGalleryItems'])),
        ),
        _ComparisonItem(
          label: 'Documents',
          current: _assetSummary(_mapList(data['currentDocumentItems'])),
          requested: _assetSummary(_mapList(data['requestedDocumentItems'])),
        ),
        _ComparisonItem(
          label: 'Accommodation costs',
          current: _pricingSummary(data['currentAccommodationCosts']),
          requested: _pricingSummary(data['requestedAccommodationCosts']),
        ),
        _ComparisonItem(
          label: 'Autism care costs',
          current: _autismPricingSummary(data['currentAutismCareCosts']),
          requested: _autismPricingSummary(data['requestedAutismCareCosts']),
        ),
        _ComparisonItem(
          label: 'Center capabilities',
          current: _capabilitiesSummary(data['currentCenterCapabilities']),
          requested: _capabilitiesSummary(data['requestedCenterCapabilities']),
        ),
      ];
  }
}

List<_DocumentItem> _documentItems(_DeclarationRecord record) {
  final data = record.data;
  final rawItems = <Map<String, dynamic>>[];
  if (record.stream == _DeclarationStream.centers) {
    rawItems.addAll(_mapList(data['documentItems']));
  }
  if (record.stream == _DeclarationStream.centerProfileChanges) {
    rawItems.addAll(_mapList(data['requestedDocumentItems']));
  }
  if (rawItems.isEmpty) return const <_DocumentItem>[];

  return rawItems
      .map((item) {
        final type = _firstText(
          item,
          const ['documentType', 'type', 'label', 'name', 'fileName'],
          fallback: 'Document',
        );
        final url = _firstText(
          item,
          const ['fileUrl', 'url'],
        );
        return _DocumentItem(
          label: type,
          status: _declarationStatus(
            _text(item['status'], fallback: 'submitted'),
          ),
          url: url,
          uploadedAt: _dateText(item['uploadedAt']),
        );
      })
      .toList(growable: false);
}

Map<String, int> _requiredDocumentSignalSummary(
  List<Map<String, dynamic>> docs,
) {
  final latest = <String, Map<String, dynamic>>{};
  for (final item in docs) {
    final type = (item['documentType'] ?? '').toString().trim();
    if (!isRequiredCenterDocumentType(type)) continue;
    latest[type] = item;
  }

  var completed = 0;
  var missing = 0;

  for (final requirement in kRequiredCenterDocumentTypes) {
    final key = (requirement['key'] ?? '').trim();
    final item = latest[key];
    if (item == null) {
      missing++;
      continue;
    }
    final fileName = (item['fileName'] ?? '').toString().trim();
    if (fileName.isEmpty) {
      missing++;
    } else {
      completed++;
    }
  }

  return {
    'required': kRequiredCenterDocumentTypes.length,
    'completed': completed,
    'missing': missing,
  };
}

List<Map<String, dynamic>> _mapList(dynamic raw) {
  if (raw is List) {
    return raw
        .whereType<Map>()
        .map((item) => item.map((key, value) => MapEntry('$key', value)))
        .toList(growable: false);
  }
  return const <Map<String, dynamic>>[];
}

String _firstText(
  Map<String, dynamic> data,
  List<String> keys, {
  String fallback = '',
}) {
  for (final key in keys) {
    final value = _text(data[key]);
    if (value.isNotEmpty) return value;
  }
  return fallback;
}

String _text(dynamic value, {String fallback = ''}) {
  final text = (value ?? '').toString().trim();
  return text.isEmpty ? fallback : text;
}

String _dateText(dynamic value) {
  if (value is Timestamp) {
    return value.toDate().toLocal().toString().split('.').first;
  }
  if (value is DateTime) {
    return value.toLocal().toString().split('.').first;
  }
  return _text(value);
}

String _stringListText(dynamic value) {
  if (value is! Iterable) return 'Not available';
  final items = value
      .map((item) => item.toString().trim())
      .where((item) => item.isNotEmpty)
      .toList(growable: false);
  return items.isEmpty ? 'None' : items.join(', ');
}

String _presence(dynamic value) {
  return _text(value).isEmpty ? 'Not declared' : 'Declared';
}

String _listPresence(dynamic value) {
  return _mapList(value).isEmpty ? 'Not declared' : 'Declared';
}

String _mapPresence(dynamic value) {
  return value is Map && value.isNotEmpty ? 'Declared' : 'Not declared';
}

String _boolText(dynamic value) {
  return value == true ? 'Yes' : 'No';
}

String _declarationStatus(String status) {
  switch (status.trim()) {
    case 'draft':
    case 'submitted':
    case 'processed':
    case 'stored':
      return status.trim();
    default:
      return 'submitted';
  }
}

String _readinessStatusText(String status) {
  switch (_declarationStatus(status)) {
    case 'ready':
    case 'processed':
    case 'uploaded':
      return 'Ready';
    case 'blocked':
    case 'stored':
    case 'needs_update':
      return 'Blocked';
    case 'incomplete':
      return 'Incomplete';
    case 'draft':
      return 'Draft';
    case 'submitted':
    default:
      return 'Submitted';
  }
}

String _assetSummary(List<Map<String, dynamic>> items) {
  if (items.isEmpty) return '-';
  final labels = items
      .map(
        (item) => _firstText(
          item,
          const ['label', 'documentType', 'name', 'fileName', 'slotKey'],
        ),
      )
      .where((value) => value.isNotEmpty)
      .take(3)
      .toList(growable: false);
  final preview = labels.isEmpty ? '' : ' - ${labels.join(' / ')}';
  return '${items.length}$preview';
}

String _pricingSummary(dynamic raw) {
  final items = mergeAccommodationCostItems(raw)
      .where((item) => item.enabled && item.price > 0)
      .toList(growable: false);
  if (items.isEmpty) return '-';
  return items
      .map((item) => '${item.labelEn}: ${_priceText(item.price)}')
      .join(' | ');
}

String _autismPricingSummary(dynamic raw) {
  final items = mergeAutismCareCostItems(raw)
      .where((item) => item.enabled && item.price > 0)
      .toList(growable: false);
  if (items.isEmpty) return '-';
  return items
      .map((item) => '${item.labelEn}: ${_priceText(item.price)}')
      .join(' | ');
}

String _capabilitiesSummary(dynamic raw) {
  final flags = CenterCapabilityFlags.fromMap(
    raw is Map ? Map<String, dynamic>.from(raw) : const <String, dynamic>{},
  );
  final items = <String>[];
  if (flags.supportsAddictionCasesWithHiv) {
    items.add('Supports addiction cases with HIV');
  }
  if (flags.acceptsAddictionCases) items.add('Accepts addiction cases');
  if (flags.acceptsPsychiatricCasesWithoutAddiction) {
    items.add('Accepts psychiatric cases without addiction');
  }
  if (flags.supportsChildren) items.add('Supports children');
  if (flags.supportsFamilies) items.add('Supports families');
  if (flags.supportsRecovery) items.add('Supports recovery');
  if (flags.supportsAccessibilitySupport) {
    items.add('Supports accessibility');
  }
  return items.isEmpty ? '-' : items.join(' | ');
}

String _profileChangeType(Map<String, dynamic> data, bool isCenter) {
  final type = _text(data['requestType']);
  if (type.isEmpty) {
    return isCenter
        ? 'Center profile update declaration'
        : 'Profile update declaration';
  }
  return type.replaceAll('_', ' ');
}

String _priceText(double price) {
  return price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2);
}

String _searchValue(dynamic value) {
  if (value is Map) {
    return value.values.map(_searchValue).join(' ');
  }
  if (value is List) {
    return value.map(_searchValue).join(' ');
  }
  return _text(value);
}

Future<void> _openUrl(String rawUrl) async {
  final url = rawUrl.trim();
  if (url.isEmpty) return;
  final uri = Uri.tryParse(url);
  if (uri == null || !uri.hasScheme) return;
  await launchUrl(uri, mode: LaunchMode.platformDefault);
}

BoxDecoration _cardDecoration(Color color) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: color.withValues(alpha: 0.38)),
  );
}
