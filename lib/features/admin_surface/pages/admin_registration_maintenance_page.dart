import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminRegistrationMaintenancePage extends StatelessWidget {
  const AdminRegistrationMaintenancePage({super.key});

  static const _stuckPendingDays = 7;

  Future<_RegistrationHealthReport> _loadReport() async {
    final results = await Future.wait([
      FirebaseFirestore.instance.collection('clinicians').get(),
      FirebaseFirestore.instance.collection('centers').get(),
      FirebaseFirestore.instance.collection('clients').get(),
    ]);

    return _RegistrationHealthReport(
      clinicians: _buildClinicianReport(results[0].docs),
      centers: _buildCenterReport(results[1].docs),
      clients: _buildClientReport(results[2].docs),
    );
  }

  _CollectionHealthReport _buildClinicianReport(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    final missingDocs = <String>[];
    final incomplete = <String>[];
    final stuck = <String>[];

    for (final doc in docs) {
      final data = doc.data();
      final identity = (data['identityFileName'] ?? '').toString().trim();
      final certificate = (data['certificateFileName'] ?? '').toString().trim();
      if (identity.isEmpty || certificate.isEmpty) missingDocs.add(doc.id);

      final hasProfile = (data['bio'] ?? '').toString().trim().isNotEmpty ||
          (data['photoUrl'] ?? '').toString().trim().isNotEmpty;
      final hasSessions = (data['sessionPriceText'] ?? '')
              .toString()
              .trim()
              .isNotEmpty &&
          (data['sessionDurationText'] ?? '').toString().trim().isNotEmpty &&
          data['sessionModes'] is List &&
          (data['sessionModes'] as List).isNotEmpty;
      final docsSubmitted = (data['documentsSubmitted'] ?? false) == true;
      if (!hasProfile || !hasSessions || !docsSubmitted) incomplete.add(doc.id);

      if (_isStuckPending(data)) stuck.add(doc.id);
    }

    return _baseReport(
      collection: 'clinicians',
      docs: docs,
      missingRequiredDocs: missingDocs,
      stuckPending: stuck,
      incompleteRegistration: incomplete,
    );
  }

  _CollectionHealthReport _buildCenterReport(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    final missingDocs = <String>[];
    final incomplete = <String>[];
    final stuck = <String>[];
    var documentsReadyFalse = 0;
    var imagesReadyFalse = 0;
    var pricingReadyFalse = 0;

    for (final doc in docs) {
      final data = doc.data();
      final documentItems = data['documentItems'];
      final requiredTypes = {
        'identity_proof',
        'center_license',
        'location_proof'
      };
      final uploadedTypes = <String>{};
      if (documentItems is List) {
        for (final item in documentItems.whereType<Map>()) {
          final type = (item['documentType'] ?? '').toString();
          final fileName = (item['fileName'] ?? '').toString().trim();
          if (fileName.isNotEmpty) uploadedTypes.add(type);
        }
      }
      if (!uploadedTypes.containsAll(requiredTypes)) missingDocs.add(doc.id);

      final documentsReady = (data['documentsReady'] ?? false) == true;
      final imagesReady = (data['imagesReady'] ?? false) == true;
      final pricingReady = (data['pricingReady'] ?? false) == true;
      if (!documentsReady) documentsReadyFalse++;
      if (!imagesReady) imagesReadyFalse++;
      if (!pricingReady) pricingReadyFalse++;

      final hasProfile =
          (data['managerName'] ?? '').toString().trim().isNotEmpty &&
              (data['phone'] ?? data['phoneNumber'] ?? '')
                  .toString()
                  .trim()
                  .isNotEmpty &&
              (data['city'] ?? '').toString().trim().isNotEmpty &&
              (data['address'] ?? '').toString().trim().isNotEmpty;
      if (!hasProfile || !documentsReady || !imagesReady || !pricingReady) {
        incomplete.add(doc.id);
      }

      if (_isStuckPending(data)) stuck.add(doc.id);
    }

    return _baseReport(
      collection: 'centers',
      docs: docs,
      missingRequiredDocs: missingDocs,
      stuckPending: stuck,
      incompleteRegistration: incomplete,
      documentsReadyFalse: documentsReadyFalse,
      imagesReadyFalse: imagesReadyFalse,
      pricingReadyFalse: pricingReadyFalse,
    );
  }

  _CollectionHealthReport _buildClientReport(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    final incomplete = <String>[];
    final stuck = <String>[];
    for (final doc in docs) {
      final data = doc.data();
      final hasName =
          (data['displayName'] ?? data['name'] ?? data['fullName'] ?? '')
              .toString()
              .trim()
              .isNotEmpty;
      final hasEmail = (data['email'] ?? '').toString().trim().isNotEmpty;
      if (!hasName || !hasEmail) incomplete.add(doc.id);
      if (_isStuckPending(data)) stuck.add(doc.id);
    }

    return _baseReport(
      collection: 'clients',
      docs: docs,
      missingRequiredDocs: const [],
      stuckPending: stuck,
      incompleteRegistration: incomplete,
    );
  }

  _CollectionHealthReport _baseReport({
    required String collection,
    required List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
    required List<String> missingRequiredDocs,
    required List<String> stuckPending,
    required List<String> incompleteRegistration,
    int documentsReadyFalse = 0,
    int imagesReadyFalse = 0,
    int pricingReadyFalse = 0,
  }) {
    var pending = 0;
    var approved = 0;
    var rejected = 0;
    var blocked = 0;

    for (final doc in docs) {
      final data = doc.data();
      final status = (data['approvalStatus'] ?? '').toString();
      final isActive = (data['isActive'] ?? data['active'] ?? false) == true;
      final isBlocked = (data['isBlocked'] ?? false) == true;

      if (isBlocked) blocked++;
      if (status == 'approved' || isActive) {
        approved++;
      } else if (status == 'rejected' || status == 'rejected_admin') {
        rejected++;
      } else if (status.startsWith('pending') || status.isEmpty) {
        pending++;
      }
    }

    return _CollectionHealthReport(
      collection: collection,
      total: docs.length,
      pending: pending,
      approved: approved,
      rejected: rejected,
      blocked: blocked,
      missingRequiredDocs: missingRequiredDocs,
      stuckPending: stuckPending,
      incompleteRegistration: incompleteRegistration,
      documentsReadyFalse: documentsReadyFalse,
      imagesReadyFalse: imagesReadyFalse,
      pricingReadyFalse: pricingReadyFalse,
    );
  }

  bool _isStuckPending(Map<String, dynamic> data) {
    final status = (data['approvalStatus'] ?? '').toString();
    if (!status.startsWith('pending')) return false;
    final createdAt = data['createdAt'];
    DateTime? created;
    if (createdAt is Timestamp) created = createdAt.toDate();
    if (createdAt is String) created = DateTime.tryParse(createdAt);
    if (created == null) return false;
    return DateTime.now().difference(created).inDays >= _stuckPendingDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration Maintenance')),
      body: FutureBuilder<_RegistrationHealthReport>(
        future: _loadReport(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text('Failed to load report: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final report = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _summaryBanner(report),
              _reportCard(context, report.clinicians),
              _reportCard(context, report.centers),
              _reportCard(context, report.clients),
            ],
          );
        },
      ),
    );
  }

  Widget _summaryBanner(_RegistrationHealthReport report) {
    final totalPending = report.clinicians.pending +
        report.centers.pending +
        report.clients.pending;
    final totalBlocked = report.clinicians.blocked +
        report.centers.blocked +
        report.clients.blocked;
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _metric('Total pending', totalPending),
            _metric('Total blocked', totalBlocked),
            _metric(
              'Stuck pending',
              report.clinicians.stuckPending.length +
                  report.centers.stuckPending.length +
                  report.clients.stuckPending.length,
            ),
          ],
        ),
      ),
    );
  }

  Widget _reportCard(BuildContext context, _CollectionHealthReport report) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              report.collection,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _metric('Total', report.total),
                _metric('Pending', report.pending),
                _metric('Approved', report.approved),
                _metric('Rejected', report.rejected),
                _metric('Blocked', report.blocked),
                _metric('Missing docs', report.missingRequiredDocs.length),
                _metric('Stuck pending', report.stuckPending.length),
                _metric(
                    'Incomplete steps', report.incompleteRegistration.length),
                _metric('documentsReady false', report.documentsReadyFalse),
                _metric('imagesReady false', report.imagesReadyFalse),
                _metric('pricingReady false', report.pricingReadyFalse),
              ],
            ),
            const SizedBox(height: 12),
            _idList('Missing required docs', report.missingRequiredDocs),
            _idList('Accounts stuck pending', report.stuckPending),
            _idList(
                'Incomplete registration steps', report.incompleteRegistration),
          ],
        ),
      ),
    );
  }

  Widget _metric(String label, int value) {
    return Chip(
      label: Text('$label: $value'),
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _idList(String title, List<String> ids) {
    final preview = ids.take(12).join(', ');
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        ids.isEmpty
            ? '$title: none'
            : '$title (${ids.length}): $preview${ids.length > 12 ? ', ...' : ''}',
      ),
    );
  }
}

class _RegistrationHealthReport {
  const _RegistrationHealthReport({
    required this.clinicians,
    required this.centers,
    required this.clients,
  });

  final _CollectionHealthReport clinicians;
  final _CollectionHealthReport centers;
  final _CollectionHealthReport clients;
}

class _CollectionHealthReport {
  const _CollectionHealthReport({
    required this.collection,
    required this.total,
    required this.pending,
    required this.approved,
    required this.rejected,
    required this.blocked,
    required this.missingRequiredDocs,
    required this.stuckPending,
    required this.incompleteRegistration,
    required this.documentsReadyFalse,
    required this.imagesReadyFalse,
    required this.pricingReadyFalse,
  });

  final String collection;
  final int total;
  final int pending;
  final int approved;
  final int rejected;
  final int blocked;
  final List<String> missingRequiredDocs;
  final List<String> stuckPending;
  final List<String> incompleteRegistration;
  final int documentsReadyFalse;
  final int imagesReadyFalse;
  final int pricingReadyFalse;
}
