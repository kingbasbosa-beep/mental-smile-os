import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/features/centers/data/models/center_pricing.dart';

class CenterBookingRequestArgs {
  final String centerId;
  final String centerName;
  final String? existingRequestId;

  const CenterBookingRequestArgs({
    required this.centerId,
    required this.centerName,
    this.existingRequestId,
  });
}

class CenterBookingRequestPage extends StatefulWidget {
  final CenterBookingRequestArgs args;

  const CenterBookingRequestPage({super.key, required this.args});

  @override
  State<CenterBookingRequestPage> createState() =>
      _CenterBookingRequestPageState();
}

class _CenterBookingRequestPageState extends State<CenterBookingRequestPage> {
  static const Set<String> _requiredAdminDocIds = {
    '4Seip1WPWJOymxzgr4QrVsQASmk2',
    'w4WyLNutDrhQaoXtkLFGMhys1EI3',
  };

  final TextEditingController _noteCtrl = TextEditingController();

  bool _submitting = false;
  bool _loadingDraft = false;
  String? _result;
  String _selectedAccommodationKey = '';
  String _lastCenterNote = '';
  String _lastSuggestedAlternativeKey = '';
  String _lastSuggestedAlternativeLabelAr = '';
  String _categoryKey = '';
  List<AccommodationCostItem> _accommodationCosts =
      defaultAccommodationCostItems();
  List<AutismCareCostItem> _autismCareCosts = defaultAutismCareCostItems();

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  bool get _usesAutismPricing => usesAutismCarePricing(_categoryKey);

  Future<void> _bootstrap() async {
    setState(() => _loadingDraft = true);
    try {
      final centerDoc = await FirebaseFirestore.instance
          .collection('centers')
          .doc(widget.args.centerId)
          .get();
      final centerData = centerDoc.data() ?? const <String, dynamic>{};
      _categoryKey = (centerData['category'] ?? '').toString().trim();
      _accommodationCosts =
          mergeAccommodationCostItems(centerData['accommodationCosts']);
      _autismCareCosts =
          mergeAutismCareCostItems(centerData['autismCareCosts']);

      final existingId = widget.args.existingRequestId;
      if (existingId != null && existingId.trim().isNotEmpty) {
        final docs = await _existingRequestDocs(existingId);
        if (docs.isNotEmpty) {
          final primary = docs.first.data() ?? const <String, dynamic>{};
          _noteCtrl.text = (primary['note'] ?? '').toString();
          _selectedAccommodationKey =
              (primary['selectedAccommodationKey'] ?? '').toString().trim();
          _lastCenterNote =
              (primary['lastCenterAvailabilityNote'] ?? '').toString().trim();
          _lastSuggestedAlternativeKey =
              (primary['lastCenterSuggestedAlternativeKey'] ?? '')
                  .toString()
                  .trim();
          _lastSuggestedAlternativeLabelAr =
              (primary['lastCenterSuggestedAlternativeLabelAr'] ?? '')
                  .toString()
                  .trim();
        }
      }
    } finally {
      if (mounted) {
        setState(() => _loadingDraft = false);
      }
    }
  }

  List<Map<String, dynamic>> _availableAccommodationOptions() {
    if (_usesAutismPricing) {
      return _autismCareCosts
          .where((item) => item.enabled && item.price > 0)
          .map(
            (item) => {
              'key': item.key,
              'labelAr': item.labelAr,
              'price': item.price,
              'pricingUnit': item.pricingUnit,
              'snapshot': item.toMap(),
            },
          )
          .toList();
    }

    return _accommodationCosts
        .where((item) => item.enabled && item.price > 0)
        .map(
          (item) => {
            'key': item.key,
            'labelAr': item.labelAr,
            'price': item.price,
            'pricingUnit': item.pricingUnit,
            'snapshot': item.toMap(),
          },
        )
        .toList();
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> _existingRequestDocs(
    String requestId,
  ) async {
    final refs = [
      FirebaseFirestore.instance.collection('booking_requests').doc(requestId),
      FirebaseFirestore.instance.collection('bookingRequests').doc(requestId),
    ];
    final existing = <DocumentSnapshot<Map<String, dynamic>>>[];
    for (final ref in refs) {
      final snap = await ref.get();
      if (snap.exists) existing.add(snap);
    }
    return existing;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _resolveCenterAdmins() async {
    final adminsSnap = await FirebaseFirestore.instance
        .collection('clinicians')
        .where('isActive', isEqualTo: true)
        .where('isAdmin', isEqualTo: true)
        .where('role', isEqualTo: 'clinician')
        .get();

    final allAdmins = adminsSnap.docs;
    if (allAdmins.isEmpty) {
      throw Exception('لم يتم العثور على حسابات إدارة مفعلة');
    }

    final matched = allAdmins
        .where((doc) => _requiredAdminDocIds.contains(doc.id))
        .toList();

    final foundIds = matched.map((e) => e.id).toSet();
    if (foundIds.length != _requiredAdminDocIds.length) {
      final missing = _requiredAdminDocIds.difference(foundIds).toList()
        ..sort();
      throw Exception(
        'حسابات إدارة المراكز المطلوبة غير موجودة أو غير مفعلة: ${missing.join(' / ')}',
      );
    }

    matched.sort((a, b) => a.id.compareTo(b.id));
    return matched;
  }

  Future<void> _submit() async {
    if (_submitting) return;

    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    if (uid == null) {
      setState(() => _result = 'يجب تسجيل الدخول أولًا');
      return;
    }

    setState(() {
      _submitting = true;
      _result = null;
    });

    final messenger = ScaffoldMessenger.of(context);

    try {
      final admins = await _resolveCenterAdmins();

      final note = _noteCtrl.text.trim();
      final options = _availableAccommodationOptions();
      final selection = options.cast<Map<String, dynamic>?>().firstWhere(
            (item) =>
                (item?['key'] ?? '').toString() == _selectedAccommodationKey,
            orElse: () => null,
          );
      if (options.isNotEmpty && selection == null) {
        throw Exception('اختر نوع الإقامة أولًا');
      }
      final firestore = FirebaseFirestore.instance;
      final createdAt = Timestamp.now();
      final requestGroupId = firestore.collection('booking_requests').doc().id;

      final sentToNames = admins
          .map((adminDoc) =>
              (adminDoc.data()['displayName'] ?? 'Admin').toString())
          .toList();
      final sentToIds = admins.map((adminDoc) => adminDoc.id).toList();

      final selectedLabelAr = (selection?['labelAr'] ?? '').toString();
      final selectedPricingUnit =
          (selection?['pricingUnit'] ?? '').toString().trim();
      final selectedPrice = (selection?['price'] is num)
          ? (selection!['price'] as num).toDouble()
          : 0.0;
      final payload = <String, dynamic>{
        'requestKind': 'center',
        'requestGroupId': requestGroupId,
        'clientId': uid,
        'clientName': (user?.displayName ?? user?.email ?? 'Client').trim(),
        'centerId': widget.args.centerId,
        'centerName': widget.args.centerName,
        'status': 'pending_admin',
        'workflowStage': 'pending_admin',
        'createdAt': createdAt,
        'updatedAt': createdAt,
        'note': note,
        'adminForwarded': false,
        'adminAssignedBy': '',
        'adminAssignedAt': null,
        'centerAvailabilityStatus': 'pending',
        'centerAvailabilityNote': '',
        'centerAvailabilityRespondedAt': null,
        'centerAvailabilityRespondedBy': '',
        'centerSuggestedAlternativeKey': '',
        'centerSuggestedAlternativeLabelAr': '',
        'selectedAccommodationKey': _selectedAccommodationKey,
        'selectedAccommodationLabelAr': selectedLabelAr,
        'selectedAccommodationPricingSnapshot':
            selection?['snapshot'] ?? const <String, dynamic>{},
        'selectedAccommodationPrice': selectedPrice,
        'selectedAccommodationPricingUnit': selectedPricingUnit,
        'lastCenterAvailabilityStatus': '',
        'lastCenterAvailabilityNote': _lastCenterNote,
        'lastCenterSuggestedAlternativeKey': _lastSuggestedAlternativeKey,
        'lastCenterSuggestedAlternativeLabelAr':
            _lastSuggestedAlternativeLabelAr,
        'clientRevisionNumber': 0,
        'lastCenterFeedbackRevisionNumber': 0,
        'clientUpdatedAfterCenterFeedback': false,
        'adminCanApproveWithoutCenterRecheck': false,
        'targetAdminIds': sentToIds,
        'targetAdminNames': sentToNames,
      };

      final existingId = widget.args.existingRequestId;
      if (existingId != null && existingId.trim().isNotEmpty) {
        final requestDocs = await _existingRequestDocs(existingId);
        var clientRevisionNumber = 0;
        if (requestDocs.isNotEmpty) {
          final current = requestDocs.first.data() ?? const <String, dynamic>{};
          final previousRevision = (current['clientRevisionNumber'] ?? 0);
          if (previousRevision is num) {
            clientRevisionNumber = previousRevision.toInt();
          }
        }
        final updatePayload = <String, dynamic>{
          'status': 'pending_admin',
          'workflowStage': 'pending_admin',
          'updatedAt': FieldValue.serverTimestamp(),
          'note': note,
          'centerAvailabilityStatus': 'pending',
          'centerAvailabilityNote': '',
          'centerAvailabilityRespondedAt': null,
          'centerAvailabilityRespondedBy': '',
          'centerSuggestedAlternativeKey': '',
          'centerSuggestedAlternativeLabelAr': '',
          'selectedAccommodationKey': _selectedAccommodationKey,
          'selectedAccommodationLabelAr': selectedLabelAr,
          'selectedAccommodationPricingSnapshot':
              selection?['snapshot'] ?? const <String, dynamic>{},
          'selectedAccommodationPrice': selectedPrice,
          'selectedAccommodationPricingUnit': selectedPricingUnit,
          'clientRevisionNumber': clientRevisionNumber + 1,
          'clientUpdatedAfterCenterFeedback': true,
          'adminCanApproveWithoutCenterRecheck':
              _lastSuggestedAlternativeKey.isNotEmpty &&
                  _lastSuggestedAlternativeKey == _selectedAccommodationKey,
        };
        for (final doc in requestDocs) {
          await doc.reference.update(updatePayload);
        }
      } else {
        final requestRef = firestore.collection('booking_requests').doc();
        await requestRef.set(payload);
      }

      if (!mounted) return;

      final routedNames = sentToNames.toSet().join(' / ');
      setState(() => _result = 'تم إرسال طلب المركز إلى الإدارة بنجاح');

      messenger.showSnackBar(
        SnackBar(
          content: Text(
            routedNames.isEmpty
                ? 'تم إرسال طلب المركز إلى الإدارة'
                : 'تم إرسال طلب المركز إلى: $routedNames',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _result = 'تعذر إرسال الطلب');
      messenger.showSnackBar(
        SnackBar(content: Text('فشل الإرسال: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('طلب حجز مركز'),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: scheme.outline.withValues(alpha: 0.14),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        child: Text(
                          widget.args.centerName.trim().isEmpty
                              ? 'م'
                              : widget.args.centerName.trim().characters.first,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.args.centerName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'سيتم إرسال طلبك أولًا إلى الإدارة، وتظل المتابعة كلها عبر الإدارة فقط بدون تواصل مباشر مع المركز من جهة العميل.',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: scheme.outline.withValues(alpha: 0.14),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ملاحظات إضافية',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'اكتب أي تفاصيل تريد أن تصل إلى الإدارة بخصوص طلب المركز.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      if (_availableAccommodationOptions().isNotEmpty) ...[
                        Text(
                          'اختيار نوع الإقامة',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          initialValue: _selectedAccommodationKey.isEmpty
                              ? null
                              : _selectedAccommodationKey,
                          isExpanded: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'اختر نوع الإقامة',
                          ),
                          items: _availableAccommodationOptions().map((item) {
                            final unit = (item['pricingUnit'] ?? '').toString();
                            final unitLabel = unit == 'month'
                                ? 'شهري'
                                : unit == 'day'
                                    ? 'يومي'
                                    : '';
                            return DropdownMenuItem<String>(
                              value: (item['key'] ?? '').toString(),
                              child: Text(
                                '${item['labelAr']} - ${item['price']}${unitLabel.isEmpty ? '' : ' / $unitLabel'}',
                              ),
                            );
                          }).toList(),
                          onChanged: _submitting
                              ? null
                              : (value) {
                                  setState(() {
                                    _selectedAccommodationKey = value ?? '';
                                  });
                                },
                        ),
                        const SizedBox(height: 12),
                      ],
                      if (_lastCenterNote.isNotEmpty ||
                          _lastSuggestedAlternativeLabelAr.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: scheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'آخر ملاحظة من المركز',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 6),
                              if (_lastCenterNote.isNotEmpty)
                                Text(_lastCenterNote),
                              if (_lastSuggestedAlternativeLabelAr.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    'البديل المقترح: $_lastSuggestedAlternativeLabelAr',
                                  ),
                                ),
                            ],
                          ),
                        ),
                      if (_lastCenterNote.isNotEmpty ||
                          _lastSuggestedAlternativeLabelAr.isNotEmpty)
                        const SizedBox(height: 12),
                      TextField(
                        controller: _noteCtrl,
                        decoration: const InputDecoration(
                          hintText: 'اكتب ملاحظتك هنا...',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 54,
                  child: FilledButton.icon(
                    onPressed: (_submitting || _loadingDraft) ? null : _submit,
                    icon: _submitting
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send_outlined),
                    label: Text(
                      _submitting
                          ? 'جارٍ الإرسال...'
                          : 'إرسال الطلب إلى الإدارة',
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (_result != null)
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      _result!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
