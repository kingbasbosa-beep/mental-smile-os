import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';

const String kDevClinicianId =
    String.fromEnvironment('MK_DEV_CLINICIAN_ID', defaultValue: '');

// Clinician-domain structural decoupling: keep legacy mirror writes disabled.
// Rollback remains trivial if bookingRequests compatibility must be restored.
const bool _legacyBookingRequestsWriteEnabled = false;

// clinicianUid is legacy compatibility only; assignedClinicianId is canonical.
// Rollback remains possible by enabling this local guard.
const bool _legacyClinicianUidReadEnabled = false;

// Legacy clinician inbox is demoted during structural decoupling.
// Rollback remains trivial by re-enabling this local guard.
const bool _legacyClinicianInboxEnabled = false;

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

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  Query<Map<String, dynamic>> _query(String status) {
    final uid = _effectiveClinicianUid();

    return FirebaseFirestore.instance
        .collection('booking_requests')
        .where(
          _legacyClinicianUidReadEnabled
              ? 'clinicianUid'
              : 'assignedClinicianId',
          isEqualTo: uid,
        )
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
      if (_legacyBookingRequestsWriteEnabled)
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

  String _statusLabel(String status, AppLocalizations l10n) {
    switch (status) {
      case 'assigned_clinician':
        return l10n.clinicianNewRequests;
      case 'awaiting_payment':
        return l10n.clinicianAwaitingPayment;
      case 'clinician_rejected':
        return l10n.clinicianClosed;
      default:
        return status;
    }
  }
  Widget _statusTabs(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = <Map<String, String>>[
      {'key': 'assigned_clinician', 'label': l10n.clinicianNewRequests},
      {'key': 'awaiting_payment', 'label': l10n.clinicianAwaitingPayment},
      {'key': 'clinician_rejected', 'label': l10n.clinicianClosed},
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
  Widget _buildLegacyInboxIntro(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
    final scheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 10, 12, 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: scheme.outline.withValues(alpha: 0.14),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isArabic ? 'صندوق وارد توافق/legacy' : 'Legacy compatibility inbox',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 6),
          Text(
            isArabic
                ? 'هذه الصفحة ما زالت متاحة للتوافق والمتابعة، لكن المساحة الأساسية لطلبات الأخصائي داخل Specialist Workspace أصبحت غرفة عمليات الأخصائي.'
                : 'This page remains available for compatibility and follow-up, but the primary specialist workspace for assignments is now Clinician Operations.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Future<void> _onApprovePressed(BuildContext context, String docId) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context)!;
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
        SnackBar(content: Text(l10n.clinicianApprovalSent)),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('${l10n.clinicianAcceptFailed}: $e')),
      );
    }
  }
  Future<void> _onRejectPressed(BuildContext context, String docId) async {
    _rejectCtrl.text = '';
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isArabic = _isArabic(context);
    final clinicianUid =
        FirebaseAuth.instance.currentUser?.uid ?? _effectiveClinicianUid();

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: AlertDialog(
          title: Text(l10n.clinicianRejectRequestTitle),
          content: TextField(
            controller: _rejectCtrl,
            decoration: InputDecoration(
              labelText: l10n.clinicianRejectReason,
              hintText: l10n.clinicianRejectReasonHint,
              border: const OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l10n.authCancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l10n.clinicianConfirmReject),
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
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.clinicianRequestRejected)),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('${l10n.clinicianRejectFailed}: $e')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);
    final l10n = AppLocalizations.of(context)!;

    if (!_legacyClinicianInboxEnabled) {
      return Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            title: Text(l10n.clinicianInboxTitle),
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'تم إيقاف صندوق الوارد القديم مؤقتًا. استخدم غرفة عمليات الأخصائي.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    }

    final q = _query(_statusFilter);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.clinicianInboxTitle),
        ),
        body: Column(
          children: [
            _buildLegacyInboxIntro(context),
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
                                          ? _statusLabel(status, l10n)
                                          : '${_statusLabel(status, l10n)} • $createdAt',
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
                                  child: Text(l10n.clinicianReject),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () =>
                                      _onApprovePressed(context, d.id),
                                  child: Text(l10n.clinicianAccept),
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
