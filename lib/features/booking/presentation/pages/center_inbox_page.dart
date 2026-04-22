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
  String _activeCenterId = '';
  Stream<List<CenterInboxRequest>>? _activeRequestsStream;

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

  bool _isResidencyStage(String status) {
    return status == 'session_setup_pending' ||
        status == 'session_scheduled' ||
        status == 'reschedule_pending';
  }

  String _statusLabel(String status, bool isArabic) {
    switch (status) {
      case 'pending_admin':
        return isArabic ? 'مرئي للمركز' : 'Visible to center';
      case 'center_follow_up':
        return isArabic ? 'بانتظار رد المركز' : 'Pending center response';
      case 'session_setup_pending':
        return isArabic ? 'بانتظار تجهيز الإقامة' : 'Residency setup pending';
      case 'session_scheduled':
        return isArabic ? 'إقامة مجدولة' : 'Residency scheduled';
      case 'reschedule_pending':
        return isArabic ? 'بانتظار إعادة الجدولة' : 'Reschedule pending';
      default:
        return status;
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

  Stream<List<CenterInboxRequest>> _requestsStream(String centerId) {
    return const CenterRequestInboxService().watchRequestsForCenter(centerId);
  }

  void _ensureRequestsStream(String centerId) {
    if (centerId.isEmpty) return;
    if (_activeRequestsStream == null || _activeCenterId != centerId) {
      _activeCenterId = centerId;
      _activeRequestsStream = _requestsStream(centerId);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _ensureRequestsStream(FirebaseAuth.instance.currentUser?.uid ?? '');
  }

  Future<void> _respond({
    required CenterInboxRequest request,
    required String availabilityStatus,
  }) async {
    final isArabic = _isArabic(context);
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
            content: Text(
              isArabic
                  ? 'سيتم إرسال رد توفر منظم فقط دون تغيير حالة الطلب.'
                  : 'Only a structured availability signal will be sent; request status will not change.',
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
      await const CenterRequestInboxService().respondToAvailability(
        requestId: request.id,
        centerId: uid,
        availabilityStatus: availabilityStatus,
      );
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
        body: Builder(
          builder: (context) {
            final centerId = FirebaseAuth.instance.currentUser?.uid ?? '';
            if (centerId.isEmpty) {
              return Center(
                child: Text(
                  isArabic ? 'يجب تسجيل الدخول أولًا' : 'Please sign in first',
                ),
              );
            }
            _ensureRequestsStream(centerId);

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
                    stream: _activeRequestsStream,
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
                        final status =
                            (request.data['status'] ?? '').toString().trim();
                        if (_isResidencyStage(status)) {
                          return _filter == 'all' || _filter == 'pending';
                        }
                        if (_filter == 'all') return true;
                        return availability == _filter;
                      }).toList();

                      if (visible.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  isArabic
                                      ? 'لا توجد طلبات موجهة إلى هذا المركز حاليًا'
                                      : 'No center-routed requests for this center right now',
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  isArabic
                                      ? 'وارد المركز يعرض طلبات رد التوفر وبدايات الإقامة التي تحتاج متابعة من المركز.'
                                      : 'Center inbox shows availability requests and residency-start actions that still need center follow-up.',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                      ),
                                ),
                                const SizedBox(height: 16),
                                OutlinedButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      Routes.centerResidencies,
                                    );
                                  },
                                  icon: const Icon(Icons.home_work_outlined),
                                  label: Text(
                                    isArabic
                                        ? 'فتح الإقامات والمتابعة'
                                        : 'Open residencies',
                                  ),
                                ),
                              ],
                            ),
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
                                          status == 'pending_admin' ||
                                                  status == 'center_follow_up'
                                              ? _availabilityLabel(
                                                  availability,
                                                  isArabic,
                                                )
                                              : _statusLabel(
                                                  status,
                                                  isArabic,
                                                ),
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
                                  if (_isResidencyStage(status)) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      isArabic
                                          ? 'هذا الطلب في مرحلة الإقامة وما زال يحتاج متابعة من المركز.'
                                          : 'This request is now in the residency stage and still needs center follow-up.',
                                    ),
                                    const SizedBox(height: 12),
                                    OutlinedButton.icon(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                          Routes.centerResidencies,
                                        );
                                      },
                                      icon:
                                          const Icon(Icons.home_work_outlined),
                                      label: Text(
                                        isArabic
                                            ? 'فتح ملف الإقامة'
                                            : 'Open residency file',
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 12),
                                  if (status == 'pending_admin' ||
                                      status == 'center_follow_up')
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
