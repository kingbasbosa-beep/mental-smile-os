import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const String kDevClinicianId =
    String.fromEnvironment('MK_DEV_CLINICIAN_ID', defaultValue: '');

class ClinicianInboxPage extends StatefulWidget {
  final String clinicianId;
  final String clinicianName;

  const ClinicianInboxPage({
    super.key,
    required this.clinicianId,
    required this.clinicianName,
  });

  @override
  State<ClinicianInboxPage> createState() => _ClinicianInboxPageState();
}

class _ClinicianInboxPageState extends State<ClinicianInboxPage> {
  String _statusFilter = 'assigned_clinician';

  final _slotCtrl = TextEditingController(text: 'Next available');
  final _rejectCtrl = TextEditingController();

  @override
  void dispose() {
    _slotCtrl.dispose();
    _rejectCtrl.dispose();
    super.dispose();
  }

  String _effectiveClinicianUid() {
    final currentUid = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (currentUid.isNotEmpty) return currentUid;
    return kDevClinicianId.isNotEmpty ? kDevClinicianId : widget.clinicianId;
  }

  Query<Map<String, dynamic>> _query(String status) {
    final uid = _effectiveClinicianUid();

    return FirebaseFirestore.instance
        .collection('booking_requests')
        .where('clinicianUid', isEqualTo: uid)
        .where('status', isEqualTo: status)
        .orderBy('createdAt', descending: true)
        .limit(100);
  }

  Future<void> _updateRequestEverywhere(
    String requestId,
    Map<String, dynamic> updates,
  ) async {
    final payload = {
      ...updates,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    final db = FirebaseFirestore.instance;
    final refs = [
      db.collection('booking_requests').doc(requestId),
      db.collection('bookingRequests').doc(requestId),
    ];

    for (final ref in refs) {
      final snap = await ref.get();
      if (snap.exists) {
        await ref.update(payload);
      }
    }
  }

  String _fmtCreatedAt(dynamic v) {
    if (v == null) return '';
    DateTime? dt;

    if (v is Timestamp) {
      dt = v.toDate();
    } else if (v is DateTime) {
      dt = v;
    } else if (v is String) {
      dt = DateTime.tryParse(v);
    }

    if (dt == null) return v.toString();

    String two(int n) => n.toString().padLeft(2, '0');
    final y = dt.year.toString().padLeft(4, '0');
    final m = two(dt.month);
    final d = two(dt.day);
    final hh = two(dt.hour);
    final mm = two(dt.minute);
    return '$y-$m-$d $hh:$mm';
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'assigned_clinician':
        return 'طلبات جديدة';
      case 'awaiting_payment':
        return 'بانتظار التحويل';
      case 'clinician_rejected':
        return 'مرفوضة';
      default:
        return status;
    }
  }

  Widget _statusTabs(BuildContext context) {
    const items = <Map<String, String>>[
      {'key': 'assigned_clinician', 'label': 'طلبات جديدة'},
      {'key': 'awaiting_payment', 'label': 'بانتظار التحويل'},
      {'key': 'clinician_rejected', 'label': 'مرفوضة'},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
      child: Wrap(
        spacing: 10,
        children: [
          for (final it in items)
            ChoiceChip(
              label: Text(it['label']!),
              selected: _statusFilter == it['key'],
              onSelected: (value) => setState(() => _statusFilter = it['key']!),
            ),
        ],
      ),
    );
  }

  Future<void> _onApprovePressed(BuildContext context, String docId) async {
    final messenger = ScaffoldMessenger.of(context);
    final slot = _slotCtrl.text.trim();
    final clinicianUid =
        FirebaseAuth.instance.currentUser?.uid ?? _effectiveClinicianUid();

    try {
      await _updateRequestEverywhere(docId, {
        'status': 'awaiting_payment',
        'approvedSlot': slot.isEmpty ? 'Next available' : slot,
        'handledByClinicianId': clinicianUid,
        'clinicianDecisionType': 'approved',
        'clinicianDecisionBy': clinicianUid,
        'clinicianDecisionAt': FieldValue.serverTimestamp(),
        'clinicianDecisionNote': slot.isEmpty ? 'Next available' : slot,
        'paymentStatus': 'not_started',
        'sessionStatus': 'not_created',
        'reviewStatus': 'not_started',
        'payoutStatus': 'blocked',
      });
      messenger.showSnackBar(
        const SnackBar(
            content: Text('تمت موافقة الأخصائي وتحويل الطلب لانتظار الدفع ✅')),
      );
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('فشل القبول: $e')));
    }
  }

  Future<void> _onRejectPressed(BuildContext context, String docId) async {
    _rejectCtrl.text = '';
    final messenger = ScaffoldMessenger.of(context);
    final clinicianUid =
        FirebaseAuth.instance.currentUser?.uid ?? _effectiveClinicianUid();

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('رفض الطلب'),
          content: TextField(
            controller: _rejectCtrl,
            decoration: const InputDecoration(
              labelText: 'سبب الرفض',
              hintText: 'اكتب سبب الرفض هنا...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('تأكيد الرفض'),
            ),
          ],
        ),
      ),
    );

    if (ok != true) return;

    final reason = _rejectCtrl.text.trim();
    try {
      await _updateRequestEverywhere(docId, {
        'status': 'clinician_rejected',
        'rejectReason': reason.isEmpty ? 'تم الرفض' : reason,
        'handledByClinicianId': clinicianUid,
        'clinicianDecisionType': 'rejected',
        'clinicianDecisionBy': clinicianUid,
        'clinicianDecisionAt': FieldValue.serverTimestamp(),
        'clinicianDecisionNote': reason.isEmpty ? 'تم الرفض' : reason,
        'paymentStatus': 'blocked',
        'sessionStatus': 'cancelled',
      });
      messenger.showSnackBar(const SnackBar(content: Text('تم رفض الطلب ⛔')));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('فشل الرفض: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = _query(_statusFilter);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('وارد الأخصائي'),
        ),
        body: Column(
          children: [
            _statusTabs(context),
            if (_statusFilter == 'assigned_clinician')
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: TextField(
                  controller: _slotCtrl,
                  decoration: const InputDecoration(
                    labelText: 'موعد أو ملاحظة القبول',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: q.snapshots(),
                builder: (context, snap) {
                  if (snap.hasError) {
                    return Center(child: Text('خطأ: ${snap.error}'));
                  }
                  if (!snap.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final rawDocs = snap.data?.docs ?? const [];
                  final docs = rawDocs.where((d) {
                    final data = d.data();
                    final requestKind =
                        (data['requestKind'] ?? 'clinician').toString();
                    return requestKind != 'center';
                  }).toList();

                  if (docs.isEmpty) {
                    return Center(
                      child: Text(
                        _statusFilter == 'assigned_clinician'
                            ? 'لا توجد طلبات جديدة بانتظار الأخصائي'
                            : 'لا توجد نتائج',
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 18),
                    itemCount: docs.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, i) {
                      final d = docs[i];
                      final data = d.data();

                      final clientName =
                          (data['clientName'] ?? data['clientId'] ?? 'عميل')
                              .toString();
                      final createdAt = _fmtCreatedAt(data['createdAt']);
                      final status = (data['status'] ?? '').toString();
                      final note = (data['note'] ?? '').toString();
                      final rejectReason =
                          (data['rejectReason'] ?? '').toString();
                      final approvedSlot =
                          (data['approvedSlot'] ?? '').toString();
                      final adminDecisionNote =
                          (data['adminDecisionNote'] ?? '').toString();
                      final paymentStatus =
                          (data['paymentStatus'] ?? '').toString();
                      final sessionStatus =
                          (data['sessionStatus'] ?? '').toString();

                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      clientName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      createdAt.isEmpty
                                          ? _statusLabel(status)
                                          : '${_statusLabel(status)} • $createdAt',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    if (note.isNotEmpty) ...[
                                      const SizedBox(height: 8),
                                      Text('ملاحظة العميل: $note'),
                                    ],
                                    if (adminDecisionNote.isNotEmpty) ...[
                                      const SizedBox(height: 8),
                                      Text(
                                          'ملاحظة الإدارة: $adminDecisionNote'),
                                    ],
                                    if (approvedSlot.isNotEmpty) ...[
                                      const SizedBox(height: 8),
                                      Text('موعد/ملاحظة القبول: $approvedSlot'),
                                    ],
                                    if (rejectReason.isNotEmpty) ...[
                                      const SizedBox(height: 8),
                                      Text('سبب الرفض: $rejectReason'),
                                    ],
                                    if (paymentStatus.isNotEmpty) ...[
                                      const SizedBox(height: 8),
                                      Text('حالة الدفع: $paymentStatus'),
                                    ],
                                    if (sessionStatus.isNotEmpty) ...[
                                      const SizedBox(height: 8),
                                      Text('حالة الجلسة: $sessionStatus'),
                                    ],
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              if (_statusFilter == 'assigned_clinician') ...[
                                OutlinedButton(
                                  onPressed: () =>
                                      _onRejectPressed(context, d.id),
                                  child: const Text('رفض'),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () =>
                                      _onApprovePressed(context, d.id),
                                  child: const Text('قبول'),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
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
