import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/booking/data/services/center_request_inbox_service.dart';

class CenterInboxPage extends StatefulWidget {
  const CenterInboxPage({super.key});

  @override
  State<CenterInboxPage> createState() => _CenterInboxPageState();
}

class _CenterInboxPageState extends State<CenterInboxPage> {
  String _filter = 'all';

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  String _availabilityLabel(String value, bool isArabic) {
    switch (value) {
      case 'available':
        return isArabic ? 'متاح' : 'Available';
      case 'unavailable':
        return isArabic ? 'غير متاح' : 'Unavailable';
      case 'pending':
      default:
        return isArabic ? 'بانتظار رد المركز' : 'Pending center response';
    }
  }

  String _dateText(dynamic value) {
    DateTime? dt;
    if (value is DateTime) dt = value;
    if (value is String) dt = DateTime.tryParse(value);
    if (value != null && value.runtimeType.toString() == 'Timestamp') {
      try {
        dt = (value as dynamic).toDate() as DateTime;
      } catch (_) {}
    }
    if (dt == null) return '';
    String two(int n) => n.toString().padLeft(2, '0');
    return '${dt.year}-${two(dt.month)}-${two(dt.day)} ${two(dt.hour)}:${two(dt.minute)}';
  }

  Future<void> _updateRequestEverywhere(
    String requestId,
    Map<String, dynamic> updates,
  ) async {
    final refs = [
      FirebaseFirestore.instance.collection('booking_requests').doc(requestId),
      FirebaseFirestore.instance.collection('bookingRequests').doc(requestId),
    ];

    for (final ref in refs) {
      final snap = await ref.get();
      if (snap.exists) {
        await ref.update({
          ...updates,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    }
  }

  Stream<List<CenterInboxRequest>> _requestsStream(String centerId) {
    return FirebaseFirestore.instance
        .collection('booking_requests')
        .where('centerId', isEqualTo: centerId)
        .where('requestKind', isEqualTo: 'center')
        .snapshots()
        .map((snap) {
      final docs = snap.docs.where((doc) {
        final status = (doc.data()['status'] ?? '').toString().trim();
        return status == 'center_follow_up' ||
            status == 'session_completed_pending_reviews' ||
            status == 'payout_pending';
      }).toList()
        ..sort((a, b) {
          final av = a.data()['updatedAt'] ?? a.data()['createdAt'];
          final bv = b.data()['updatedAt'] ?? b.data()['createdAt'];
          DateTime ad = DateTime.fromMillisecondsSinceEpoch(0);
          DateTime bd = DateTime.fromMillisecondsSinceEpoch(0);
          if (av is Timestamp) ad = av.toDate();
          if (bv is Timestamp) bd = bv.toDate();
          return bd.compareTo(ad);
        });
      return docs
          .map((doc) => CenterInboxRequest(id: doc.id, data: doc.data()))
          .toList();
    });
  }

  Future<void> _respond({
    required CenterInboxRequest request,
    required String availabilityStatus,
  }) async {
    final isArabic = _isArabic(context);
    final controller = TextEditingController(
      text: (request.data['centerAvailabilityNote'] ?? '').toString(),
    );
    final suggestedAlternativeController = TextEditingController(
      text:
          (request.data['centerSuggestedAlternativeLabelAr'] ?? '').toString(),
    );
    final shouldSubmit = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: AlertDialog(
            title: Text(
              availabilityStatus == 'available'
                  ? (isArabic ? 'تأكيد التوفر' : 'Confirm availability')
                  : (isArabic ? 'تأكيد عدم التوفر' : 'Confirm unavailability'),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: isArabic ? 'ملاحظة اختيارية' : 'Optional note',
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: suggestedAlternativeController,
                  decoration: InputDecoration(
                    labelText: isArabic
                        ? 'بديل مقترح اختياري'
                        : 'Optional suggested alternative',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(isArabic ? 'إلغاء' : 'Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(isArabic ? 'حفظ الرد' : 'Save response'),
              ),
            ],
          ),
        );
      },
    );

    if (shouldSubmit != true || !mounted) return;

    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (uid.isEmpty) return;

    try {
      await _updateRequestEverywhere(request.id, {
        'centerAvailabilityStatus': availabilityStatus,
        'centerAvailabilityNote': controller.text.trim(),
        'centerSuggestedAlternativeKey':
            suggestedAlternativeController.text.trim().isEmpty
                ? ''
                : suggestedAlternativeController.text.trim(),
        'centerSuggestedAlternativeLabelAr':
            suggestedAlternativeController.text.trim(),
        'centerAvailabilityRespondedAt': FieldValue.serverTimestamp(),
        'centerAvailabilityRespondedBy': uid,
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            availabilityStatus == 'available'
                ? (isArabic
                    ? 'تم إرسال رد التوفر للإدارة'
                    : 'Availability response sent to admin')
                : (isArabic
                    ? 'تم إرسال رد عدم التوفر للإدارة'
                    : 'Unavailability response sent to admin'),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic ? 'تعذر حفظ الرد: $e' : 'Unable to save response: $e',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isArabic ? 'وارد المركز' : 'Center inbox'),
        ),
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, authSnapshot) {
            final centerId = authSnapshot.data?.uid ?? '';
            if (!authSnapshot.hasData || centerId.isEmpty) {
              return Center(
                child: Text(
                  isArabic ? 'يجب تسجيل الدخول أولًا' : 'Please sign in first',
                ),
              );
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ChoiceChip(
                        label: Text(isArabic ? 'الكل' : 'All'),
                        selected: _filter == 'all',
                        onSelected: (_) => setState(() => _filter = 'all'),
                      ),
                      ChoiceChip(
                        label: Text(isArabic ? 'بانتظار الرد' : 'Pending'),
                        selected: _filter == 'pending',
                        onSelected: (_) => setState(() => _filter = 'pending'),
                      ),
                      ChoiceChip(
                        label: Text(isArabic ? 'متاح' : 'Available'),
                        selected: _filter == 'available',
                        onSelected: (_) =>
                            setState(() => _filter = 'available'),
                      ),
                      ChoiceChip(
                        label: Text(isArabic ? 'غير متاح' : 'Unavailable'),
                        selected: _filter == 'unavailable',
                        onSelected: (_) =>
                            setState(() => _filter = 'unavailable'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<CenterInboxRequest>>(
                    stream: _requestsStream(centerId),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            isArabic
                                ? 'تعذر تحميل طلبات المركز'
                                : 'Unable to load center requests',
                          ),
                        );
                      }
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final visible = snapshot.data!.where((request) {
                        final availability =
                            (request.data['centerAvailabilityStatus'] ??
                                    'pending')
                                .toString()
                                .trim();
                        if (_filter == 'all') return true;
                        return availability == _filter;
                      }).toList();

                      if (visible.isEmpty) {
                        return Center(
                          child: Text(
                            isArabic
                                ? 'لا توجد طلبات موجهة إلى هذا المركز حاليًا'
                                : 'No center-routed requests for this center right now',
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(12, 6, 12, 18),
                        itemCount: visible.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final request = visible[index];
                          final data = request.data;
                          final clientName =
                              (data['clientName'] ?? 'Client').toString();
                          final note = (data['note'] ?? '').toString().trim();
                          final adminNote = (data['adminFollowUpNote'] ?? '')
                              .toString()
                              .trim();
                          final createdAt = _dateText(data['createdAt']);
                          final availability =
                              (data['centerAvailabilityStatus'] ?? 'pending')
                                  .toString()
                                  .trim();
                          final status =
                              (data['status'] ?? '').toString().trim();
                          final centerReviewSubmitted =
                              (data['clinicianReviewSubmitted'] ?? false) ==
                                  true;
                          final availabilityNote =
                              (data['centerAvailabilityNote'] ?? '')
                                  .toString()
                                  .trim();

                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          clientName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                      Chip(
                                        label: Text(
                                          _availabilityLabel(
                                              availability, isArabic),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (createdAt.isNotEmpty) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      isArabic
                                          ? 'تاريخ الطلب: $createdAt'
                                          : 'Created at: $createdAt',
                                    ),
                                  ],
                                  if (note.isNotEmpty) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      isArabic
                                          ? 'ملاحظة العميل: $note'
                                          : 'Client note: $note',
                                    ),
                                  ],
                                  if (adminNote.isNotEmpty) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      isArabic
                                          ? 'ملاحظة الإدارة: $adminNote'
                                          : 'Admin note: $adminNote',
                                    ),
                                  ],
                                  if (availabilityNote.isNotEmpty) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      isArabic
                                          ? 'رد المركز: $availabilityNote'
                                          : 'Center note: $availabilityNote',
                                    ),
                                  ],
                                  const SizedBox(height: 12),
                                  if (status == 'center_follow_up')
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: [
                                        FilledButton.icon(
                                          onPressed: () => _respond(
                                            request: request,
                                            availabilityStatus: 'available',
                                          ),
                                          icon: const Icon(
                                            Icons.check_circle_outline,
                                          ),
                                          label: Text(
                                            isArabic ? 'متاح' : 'Available',
                                          ),
                                        ),
                                        OutlinedButton.icon(
                                          onPressed: () => _respond(
                                            request: request,
                                            availabilityStatus: 'unavailable',
                                          ),
                                          icon: const Icon(
                                              Icons.event_busy_outlined),
                                          label: Text(
                                            isArabic
                                                ? 'غير متاح'
                                                : 'Unavailable',
                                          ),
                                        ),
                                      ],
                                    ),
                                  if ((status ==
                                              'session_completed_pending_reviews' ||
                                          status == 'payout_pending') &&
                                      !centerReviewSubmitted)
                                    FilledButton.icon(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                          Routes.sessionReview,
                                          arguments: {
                                            'requestId': request.id,
                                            'reviewerType': 'clinician',
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                          Icons.rate_review_outlined),
                                      label: Text(
                                        isArabic
                                            ? 'إرسال تقييم المركز'
                                            : 'Submit center review',
                                      ),
                                    ),
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
            );
          },
        ),
      ),
    );
  }
}
