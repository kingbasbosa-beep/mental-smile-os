import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/core/ui/app_shell_actions.dart';

class ClientPaymentProofPage extends StatefulWidget {
  const ClientPaymentProofPage({super.key});

  @override
  State<ClientPaymentProofPage> createState() => _ClientPaymentProofPageState();
}

class _ClientPaymentProofPageState extends State<ClientPaymentProofPage> {
  final TextEditingController _receiptFileNameController =
      TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  bool _loading = false;
  String? _selectedRequestId;

  bool get _isArabic =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  DateTime _asDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
    }
    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _awaitingPaymentRequests(String uid) {
    final primary = FirebaseFirestore.instance
        .collection('booking_requests')
        .where('clientId', isEqualTo: uid)
        .snapshots();
    final legacy = FirebaseFirestore.instance
        .collection('bookingRequests')
        .where('clientId', isEqualTo: uid)
        .snapshots();

    return Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>.multi(
      (controller) {
        QuerySnapshot<Map<String, dynamic>>? primarySnapshot;
        QuerySnapshot<Map<String, dynamic>>? legacySnapshot;

        void emitMerged() {
          final merged =
              <String, QueryDocumentSnapshot<Map<String, dynamic>>>{};

          if (legacySnapshot != null) {
            for (final doc in legacySnapshot!.docs) {
              merged[doc.id] = doc;
            }
          }

          if (primarySnapshot != null) {
            for (final doc in primarySnapshot!.docs) {
              merged[doc.id] = doc;
            }
          }

          final docs = merged.values
              .where((doc) =>
                  (doc.data()['status'] ?? '').toString() == 'awaiting_payment')
              .toList()
            ..sort((a, b) => _asDateTime(b.data()['createdAt'])
                .compareTo(_asDateTime(a.data()['createdAt'])));
          controller.add(docs);
        }

        final primarySub = primary.listen(
          (snapshot) {
            primarySnapshot = snapshot;
            emitMerged();
          },
          onError: controller.addError,
        );

        final legacySub = legacy.listen(
          (snapshot) {
            legacySnapshot = snapshot;
            emitMerged();
          },
          onError: controller.addError,
        );

        controller.onCancel = () async {
          await primarySub.cancel();
          await legacySub.cancel();
        };
      },
    );
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> _existingRequestDocs(
    String requestId,
  ) async {
    final db = FirebaseFirestore.instance;
    final refs = [
      db.collection('booking_requests').doc(requestId),
      db.collection('bookingRequests').doc(requestId),
    ];

    final existing = <DocumentSnapshot<Map<String, dynamic>>>[];
    for (final ref in refs) {
      final snap = await ref.get();
      if (snap.exists) {
        existing.add(snap);
      }
    }
    return existing;
  }

  Future<void> _submit(String requestId) async {
    if (_loading) return;

    final receiptFileName = _receiptFileNameController.text.trim();

    if (receiptFileName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic
                ? 'أدخل اسم أو مرجع ملف إثبات التحويل أولًا'
                : 'Enter payment proof file name/reference first',
          ),
        ),
      );
      return;
    }

    setState(() => _loading = true);
    try {
      final requestDocs = await _existingRequestDocs(requestId);
      if (requestDocs.isEmpty) {
        throw Exception(
          _isArabic ? 'لم يتم العثور على الطلب' : 'Request not found',
        );
      }

      final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      final eligibleRefs = <DocumentReference<Map<String, dynamic>>>[];
      for (final doc in requestDocs) {
        final data = doc.data() ?? const <String, dynamic>{};
        final status = (data['status'] ?? '').toString();
        final clientId = (data['clientId'] ?? '').toString();
        if (status == 'awaiting_payment' && clientId == uid) {
          eligibleRefs.add(doc.reference);
        }
      }

      if (eligibleRefs.isEmpty) {
        throw Exception(
          _isArabic
              ? 'لا توجد نسخة مؤهلة من الطلب لرفع إثبات الدفع'
              : 'No eligible request copy is ready for payment proof',
        );
      }

      eligibleRefs.sort((a, b) {
        final aPrimary = a.parent.id == 'booking_requests' ? 0 : 1;
        final bPrimary = b.parent.id == 'booking_requests' ? 0 : 1;
        return aPrimary.compareTo(bPrimary);
      });
      final targetRef = eligibleRefs.first;
      final dataToUpdate = <String, dynamic>{
        'status': 'payment_review',
        'paymentStatus': 'submitted_by_client',
        'paymentReceiptFileName': receiptFileName,
        'paymentReceiptUrl': '',
        'paymentSubmittedAt': FieldValue.serverTimestamp(),
        'paymentClientNote': _noteController.text.trim(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
      await targetRef.update(dataToUpdate);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic
                ? 'تم إرسال إثبات التحويل إلى الإدارة'
                : 'Payment proof sent to admin',
          ),
        ),
      );
      Navigator.of(context).maybePop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic
                ? 'فشل إرسال إثبات التحويل: $e'
                : 'Failed to submit payment proof: $e',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void dispose() {
    _receiptFileNameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Directionality(
      textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(
          context,
          title: _isArabic ? 'رفع إثبات التحويل' : 'Upload payment proof',
        ),
        body: uid.isEmpty
            ? Center(
                child: Text(
                  _isArabic ? 'يجب تسجيل الدخول أولًا' : 'Please sign in first',
                ),
              )
            : StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                stream: _awaitingPaymentRequests(uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        _isArabic
                            ? 'تعذر تحميل الطلبات'
                            : 'Unable to load requests',
                      ),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data ?? const [];
                  if (docs.isEmpty) {
                    _selectedRequestId = null;
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          _isArabic
                              ? 'لا يوجد طلب بانتظار التحويل المالي حاليًا'
                              : 'No request currently awaiting payment',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  final hasSelection = docs.any(
                    (doc) => doc.id == _selectedRequestId,
                  );
                  final selectedDoc = hasSelection
                      ? docs.firstWhere((doc) => doc.id == _selectedRequestId)
                      : docs.first;
                  _selectedRequestId = selectedDoc.id;
                  final selectedData = selectedDoc.data();
                  final selectedClinicianName =
                      (selectedData['assignedClinicianName'] ??
                              selectedData['clinicianName'] ??
                              '')
                          .toString();
                  final selectedNote = (selectedData['note'] ?? '').toString();

                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withValues(alpha: 0.14),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _isArabic
                                  ? 'اختر الطلب المطلوب رفع إثباته'
                                  : 'Choose the request to upload proof for',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 12),
                            for (final doc in docs) ...[
                              Builder(
                                builder: (context) {
                                  final data = doc.data();
                                  final clinicianName =
                                      (data['assignedClinicianName'] ??
                                              data['clinicianName'] ??
                                              '')
                                          .toString();
                                  final note =
                                      (data['note'] ?? '').toString().trim();
                                  final isSelected =
                                      doc.id == _selectedRequestId;

                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                        color: isSelected
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .outline
                                                .withValues(alpha: 0.14),
                                        width: isSelected ? 1.6 : 1,
                                      ),
                                    ),
                                    child: ListTile(
                                      onTap: _loading
                                          ? null
                                          : () {
                                              setState(() {
                                                _selectedRequestId = doc.id;
                                              });
                                            },
                                      leading: Icon(
                                        isSelected
                                            ? Icons.radio_button_checked
                                            : Icons.radio_button_off,
                                      ),
                                      title: Text(
                                        clinicianName.trim().isNotEmpty
                                            ? clinicianName
                                            : (_isArabic
                                                ? 'طلب بدون اسم أخصائي'
                                                : 'Request without clinician name'),
                                      ),
                                      subtitle: note.isNotEmpty
                                          ? Text(
                                              _isArabic
                                                  ? 'ملاحظتك: $note'
                                                  : 'Your note: $note',
                                            )
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withValues(alpha: 0.14),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _isArabic ? 'تفاصيل الطلب' : 'Request details',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 10),
                            if (selectedClinicianName.trim().isNotEmpty)
                              Text(
                                _isArabic
                                    ? 'الأخصائي: $selectedClinicianName'
                                    : 'Clinician: $selectedClinicianName',
                              ),
                            if (selectedNote.trim().isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  _isArabic
                                      ? 'ملاحظتك: $selectedNote'
                                      : 'Your note: $selectedNote',
                                ),
                              ),
                            const SizedBox(height: 18),
                            TextField(
                              controller: _receiptFileNameController,
                              decoration: InputDecoration(
                                labelText: _isArabic
                                    ? 'اسم أو مرجع ملف إثبات التحويل'
                                    : 'Payment proof file name/reference',
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(
                                  Icons.description_outlined,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _noteController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                labelText: _isArabic
                                    ? 'ملاحظة إضافية للإدارة'
                                    : 'Additional note to admin',
                                border: const OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: FilledButton.icon(
                                onPressed: _loading
                                    ? null
                                    : () => _submit(selectedDoc.id),
                                icon: _loading
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Icon(Icons.send_outlined),
                                label: Text(
                                  _loading
                                      ? (_isArabic
                                          ? 'جارٍ الإرسال...'
                                          : 'Submitting...')
                                      : (_isArabic
                                          ? 'إرسال إثبات التحويل'
                                          : 'Submit payment proof'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
