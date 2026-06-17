import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// [S] Support Room runtime.
// Read-only observation only. No mutations or treatment decisions.
class SSupportRoomPage extends StatelessWidget {
  const SSupportRoomPage({super.key});

  static const String _supportRequestsCollection = 'support_requests';

  Stream<List<_SupportRequest>> _requestsStream() {
    return FirebaseFirestore.instance
        .collection(_supportRequestsCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(_SupportRequest.fromSnapshot)
              .toList(growable: false),
        );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7F8),
        appBar: AppBar(
          title: const Text('Support Room'),
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF17252A),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          bottom: const TabBar(
            isScrollable: true,
            labelColor: Color(0xFF17252A),
            unselectedLabelColor: Color(0xFF697B80),
            indicatorColor: Color(0xFF2B7A78),
            tabs: <Widget>[
              Tab(text: 'Support Signals'),
              Tab(text: 'Risk Signals'),
              Tab(text: 'Technical Requests'),
              Tab(text: 'Continuity Requests'),
            ],
          ),
        ),
        body: StreamBuilder<List<_SupportRequest>>(
          stream: _requestsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const _SupportRoomLoadingState();
            }

            if (snapshot.hasError) {
              return const _SupportRoomErrorState();
            }

            final requests = snapshot.data ?? const <_SupportRequest>[];
            return TabBarView(
              children: <Widget>[
                _SupportRequestList(
                  title: 'Support Signals',
                  subtitle: 'Read-only view of structured support signals.',
                  requests: _supportSignals(requests),
                  emptyMessage: 'No support signals detected yet.',
                ),
                _SupportRequestList(
                  title: 'Risk Signals',
                  subtitle: 'Signals marked by priority or risk report type.',
                  requests: _riskSignals(requests),
                  emptyMessage: 'No risk signals detected yet.',
                ),
                _SupportRequestList(
                  title: 'Technical Requests',
                  subtitle: 'Access and technical-use requests for observation.',
                  requests: _technicalRequests(requests),
                  emptyMessage: 'No technical requests detected yet.',
                ),
                _SupportRequestList(
                  title: 'Continuity Requests',
                  subtitle: 'Continuity-related support signals.',
                  requests: _continuityRequests(requests),
                  emptyMessage: 'No continuity requests detected yet.',
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  static List<_SupportRequest> _supportSignals(List<_SupportRequest> requests) {
    return requests.where((request) => request.supportType.isNotEmpty).toList();
  }

  static List<_SupportRequest> _riskSignals(List<_SupportRequest> requests) {
    return requests
        .where(
          (request) =>
              request.priority == 'high' || request.issueType == 'risk_report',
        )
        .toList();
  }

  static List<_SupportRequest> _technicalRequests(
    List<_SupportRequest> requests,
  ) {
    return requests
        .where(
          (request) =>
              request.supportType == 'client_support' ||
              request.supportType == 'center_support' ||
              request.supportType == 'clinician_support' ||
              request.issueType.contains('technical'),
        )
        .toList();
  }

  static List<_SupportRequest> _continuityRequests(
    List<_SupportRequest> requests,
  ) {
    return requests
        .where(
          (request) =>
              request.supportType == 'recovery_support' ||
              request.supportType == 'family_support',
        )
        .toList();
  }
}

class _SupportRequestList extends StatelessWidget {
  const _SupportRequestList({
    required this.title,
    required this.subtitle,
    required this.requests,
    required this.emptyMessage,
  });

  final String title;
  final String subtitle;
  final List<_SupportRequest> requests;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: <Widget>[
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1040),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _SupportRoomIntro(title: title, subtitle: subtitle),
                  const SizedBox(height: 18),
                  if (requests.isEmpty)
                    _SupportRoomEmptyState(message: emptyMessage)
                  else
                    for (final request in requests) ...<Widget>[
                      _SupportRequestCard(request: request),
                      const SizedBox(height: 12),
                    ],
                  const SizedBox(height: 12),
                  const _SupportRoomBoundaryNote(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SupportRoomIntro extends StatelessWidget {
  const _SupportRoomIntro({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF9DB8B2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: const Color(0xFF17252A),
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF4A5D63),
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 14),
          const _ObservationPill(),
        ],
      ),
    );
  }
}

class _ObservationPill extends StatelessWidget {
  const _ObservationPill();

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
        'Read-only observation only',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF23443E),
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

class _SupportRequestCard extends StatelessWidget {
  const _SupportRequestCard({required this.request});

  final _SupportRequest request;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD1DDE0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _MetaChip(label: 'Signal', value: _supportTypeLabel(request.supportType)),
              _MetaChip(label: 'Type', value: _issueTypeLabel(request.issueType)),
              _MetaChip(label: 'Priority', value: _priorityLabel(request.priority)),
              _MetaChip(label: 'State', value: _statusLabel(request.status)),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Source role: ${request.userRole.isEmpty ? '-' : request.userRole}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF35484E),
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            'Submitted by: ${request.createdByUid.isEmpty ? '-' : request.createdByUid}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF52656A),
                ),
          ),
          const SizedBox(height: 6),
          Text(
            'Created: ${request.createdAtLabel}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF697B80),
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
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
        '$label: ${value.isEmpty ? '-' : value}',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF17252A),
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

class _SupportRoomLoadingState extends StatelessWidget {
  const _SupportRoomLoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _SupportRoomErrorState extends StatelessWidget {
  const _SupportRoomErrorState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Unable to load support signals.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF17252A),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _SupportRoomEmptyState extends StatelessWidget {
  const _SupportRoomEmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD1DDE0)),
      ),
      child: Text(
        message,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF52656A),
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _SupportRoomBoundaryNote extends StatelessWidget {
  const _SupportRoomBoundaryNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F1EF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF7AA69D)),
      ),
      child: Text(
        'This room observes support signals and routes guidance. It does not '
        'own people, journeys, or treatment decisions.',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF23443E),
              height: 1.45,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _SupportRequest {
  const _SupportRequest({
    required this.id,
    required this.supportType,
    required this.issueType,
    required this.priority,
    required this.status,
    required this.createdByUid,
    required this.userRole,
    required this.createdAt,
  });

  factory _SupportRequest.fromSnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return _SupportRequest(
      id: _stringValue(data['id'], fallback: snapshot.id),
      supportType: _stringValue(data['supportType']),
      issueType: _stringValue(data['issueType']),
      priority: _stringValue(data['priority']),
      status: _stringValue(data['status']),
      createdByUid: _stringValue(data['createdByUid']),
      userRole: _stringValue(data['userRole']),
      createdAt: data['createdAt'],
    );
  }

  final String id;
  final String supportType;
  final String issueType;
  final String priority;
  final String status;
  final String createdByUid;
  final String userRole;
  final Object? createdAt;

  String get createdAtLabel {
    final value = createdAt;
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

  static String _stringValue(Object? value, {String fallback = ''}) {
    final text = (value ?? '').toString().trim();
    return text.isEmpty ? fallback : text;
  }
}

String _supportTypeLabel(String value) {
  switch (value) {
    case 'recovery_support':
      return 'Recovery Support';
    case 'family_support':
      return 'Family Support';
    case 'client_support':
      return 'Client Support';
    case 'center_support':
      return 'Center Support';
    case 'clinician_support':
      return 'Clinician Support';
    default:
      return value;
  }
}

String _issueTypeLabel(String value) {
  switch (value) {
    case 'risk_report':
      return 'Risk Report';
    case 'general_help':
      return 'General Help';
    case 'recovery_support':
      return 'Recovery Support';
    default:
      return value;
  }
}

String _priorityLabel(String value) {
  switch (value) {
    case 'normal':
      return 'Normal';
    case 'high':
      return 'High';
    default:
      return value;
  }
}

String _statusLabel(String value) {
  switch (value) {
    case 'new':
      return 'New';
    default:
      return value;
  }
}
