import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminCenterDetailsPage extends StatelessWidget {
  const AdminCenterDetailsPage({super.key, required this.centerId});

  final String centerId;

  String _text(dynamic value) {
    final text = (value ?? '').toString().trim();
    return text.isEmpty ? '-' : text;
  }

  String _dateText(dynamic value) {
    if (value is Timestamp) return value.toDate().toLocal().toString();
    return _text(value);
  }

  List<Map<String, dynamic>> _readMapList(dynamic raw) {
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map((item) => item.map((key, value) => MapEntry('$key', value)))
        .toList();
  }

  Map<String, dynamic> _readMap(dynamic raw) {
    if (raw is! Map) return const {};
    return raw.map((key, value) => MapEntry('$key', value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Center Details')),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('centers')
            .doc(centerId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Failed to load center details'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!.data();
          if (data == null) {
            return const Center(child: Text('Center not found'));
          }

          final galleryItems = _readMapList(data['galleryItems']);
          final galleryImages = (data['galleryImages'] is List)
              ? List<dynamic>.from(data['galleryImages'] as List)
              : const <dynamic>[];
          final documentItems = _readMapList(data['documentItems']);
          final accommodationCosts = _readMapList(data['accommodationCosts']);
          final autismCareCosts = _readMapList(data['autismCareCosts']);
          final capabilities = _readMap(data['centerCapabilities']);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _section(
                context,
                'Profile',
                [
                  _row('Doc ID', centerId),
                  _row(
                      'Name',
                      data['centerName'] ??
                          data['displayName'] ??
                          data['name']),
                  _row('Email', data['email']),
                  _row('Category', data['category']),
                  _row('Center type', data['centerType']),
                  _row('Manager', data['managerName']),
                  _row('Phone', data['phone'] ?? data['phoneNumber']),
                  _row('WhatsApp', data['whatsapp'] ?? data['whatsappNumber']),
                  _row('City', data['city']),
                  _row('Area', data['area']),
                  _row('Address', data['address']),
                  _row('Description', data['description']),
                  _row('Has detox unit', data['hasDetoxUnit']),
                  _row('Created at', _dateText(data['createdAt'])),
                  _row('Updated at', _dateText(data['updatedAt'])),
                ],
              ),
              _section(
                context,
                'Status',
                [
                  _row('Approval status', data['approvalStatus']),
                  _row('isActive', data['isActive']),
                  _row('active', data['active']),
                  _row('isBlocked', data['isBlocked']),
                  _row('Block reason', data['blockReason']),
                  _row('Blocked at', _dateText(data['blockedAt'])),
                ],
              ),
              _section(
                context,
                'Gallery',
                [
                  _row('Image URL', data['imageUrl']),
                  _row('Cover image URL', data['coverImageUrl']),
                  _row('Images ready', data['imagesReady']),
                  if (galleryImages.isEmpty)
                    _row('Gallery images', '-')
                  else
                    ...galleryImages.asMap().entries.map(
                          (entry) => _row(
                              'Gallery image ${entry.key + 1}', entry.value),
                        ),
                  if (galleryItems.isEmpty)
                    _row('Gallery items', '-')
                  else
                    ...galleryItems.asMap().entries.map(
                          (entry) => _mapRow(
                              'Gallery item ${entry.key + 1}', entry.value),
                        ),
                ],
              ),
              _section(
                context,
                'Documents',
                [
                  _row('Documents ready', data['documentsReady']),
                  if (documentItems.isEmpty)
                    _row('Document items', '-')
                  else
                    ...documentItems.asMap().entries.map(
                          (entry) =>
                              _mapRow('Document ${entry.key + 1}', entry.value),
                        ),
                ],
              ),
              _section(
                context,
                'Pricing',
                [
                  _row('Pricing ready', data['pricingReady']),
                  if (accommodationCosts.isEmpty)
                    _row('Accommodation costs', '-')
                  else
                    ...accommodationCosts.asMap().entries.map(
                          (entry) => _mapRow(
                              'Accommodation ${entry.key + 1}', entry.value),
                        ),
                  if (autismCareCosts.isEmpty)
                    _row('Autism care costs', '-')
                  else
                    ...autismCareCosts.asMap().entries.map(
                          (entry) => _mapRow(
                              'Autism care ${entry.key + 1}', entry.value),
                        ),
                ],
              ),
              _section(
                context,
                'Capabilities',
                capabilities.isEmpty
                    ? [_row('Capabilities', '-')]
                    : capabilities.entries
                        .map((entry) => _row(entry.key, entry.value))
                        .toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _section(BuildContext context, String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _row(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(child: Text(_text(value))),
        ],
      ),
    );
  }

  Widget _mapRow(String label, Map<String, dynamic> value) {
    final text = value.entries
        .map((entry) => '${entry.key}: ${_text(entry.value)}')
        .join('\n');
    return _row(label, text);
  }
}
