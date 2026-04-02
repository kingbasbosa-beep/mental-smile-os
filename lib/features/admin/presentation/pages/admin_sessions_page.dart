import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/core/ui/app_design_system.dart';
import 'package:flutterprojects/core/ui/app_shell_actions.dart';

class AdminSessionsPage extends StatefulWidget {
  const AdminSessionsPage({super.key});

  @override
  State<AdminSessionsPage> createState() => _AdminSessionsPageState();
}

class _AdminSessionsPageState extends State<AdminSessionsPage> {
  String _tab = 'session_setup_pending';
  final Set<String> _busyIds = {};

  final Map<String, TextEditingController> _dateControllers = {};
  final Map<String, TextEditingController> _linkControllers = {};
  final Map<String, TextEditingController> _codeControllers = {};
  final Map<String, TextEditingController> _notesControllers = {};

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  TextEditingController _controllerFor(
    Map<String, TextEditingController> map,
    String requestId, {
    String initial = '',
  }) {
    return map.putIfAbsent(
      requestId,
      () => TextEditingController(text: initial),
    );
  }

  Future<void> _setBusy(String id, bool value) async {
    if (!mounted) return;
    setState(() {
      if (value) {
        _busyIds.add(id);
      } else {
        _busyIds.remove(id);
      }
    });
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

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _bookingDocsStream() {
    final primary = FirebaseFirestore.instance
        .collection('booking_requests')
        .orderBy('createdAt', descending: true)
        .snapshots();
    final legacy = FirebaseFirestore.instance
        .collection('bookingRequests')
        .orderBy('createdAt', descending: true)
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

          final docs = merged.values.toList()
            ..sort((a, b) {
              final aTs = a.data()['createdAt'];
              final bTs = b.data()['createdAt'];

              final aDate = aTs is Timestamp
                  ? aTs.toDate()
                  : DateTime.fromMillisecondsSinceEpoch(0);
              final bDate = bTs is Timestamp
                  ? bTs.toDate()
                  : DateTime.fromMillisecondsSinceEpoch(0);

              return bDate.compareTo(aDate);
            });

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

  Future<void> _scheduleSession(String requestId) async {
    final dateText = _dateControllers[requestId]?.text.trim() ?? '';
    final linkText = _linkControllers[requestId]?.text.trim() ?? '';
    final codeText = _codeControllers[requestId]?.text.trim() ?? '';
    final notesText = _notesControllers[requestId]?.text.trim() ?? '';

    if (dateText.isEmpty || linkText.isEmpty || codeText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'أدخل موعد الجلسة والرابط والكود أولًا'
                : 'Enter session date, link, and code first',
          ),
        ),
      );
      return;
    }

    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'session_scheduled',
        'sessionStatus': 'scheduled',
        'sessionDateText': dateText,
        'sessionLink': linkText,
        'sessionCode': codeText,
        'sessionAdminNotes': notesText,
        'sessionCreatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'تم إنشاء الجلسة بنجاح'
                : 'Session scheduled successfully',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _markInProgress(String requestId) async {
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'session_in_progress',
        'sessionStatus': 'in_progress',
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'تم تحويل الجلسة إلى جارية'
                : 'Session marked in progress',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _markCompleted(String requestId) async {
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'session_completed_pending_reviews',
        'sessionStatus': 'completed',
        'reviewStatus': 'pending_reviews',
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'تم تعليم الجلسة كمكتملة'
                : 'Session marked completed',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _moveToReschedule(String requestId) async {
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'reschedule_pending',
        'sessionStatus': 'reschedule_pending',
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'تم تحويل الطلب إلى انتظار إعادة الجدولة'
                : 'Moved to reschedule pending',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  bool _matchesTab(String status) {
    switch (_tab) {
      case 'session_scheduled':
        return status == 'session_scheduled' || status == 'session_in_progress';
      case 'session_completed_pending_reviews':
        return status == 'session_completed_pending_reviews';
      case 'reschedule_pending':
        return status == 'reschedule_pending';
      default:
        return status == 'session_setup_pending';
    }
  }

  String _statusLabel(String status, bool isArabic) {
    switch (status) {
      case 'session_scheduled':
        return isArabic ? 'جلسة مجدولة' : 'Session scheduled';
      case 'session_in_progress':
        return isArabic ? 'جلسة جارية' : 'Session in progress';
      case 'session_completed_pending_reviews':
        return isArabic ? 'بانتظار التقييمات' : 'Pending reviews';
      case 'reschedule_pending':
        return isArabic ? 'بانتظار إعادة الجدولة' : 'Reschedule pending';
      default:
        return isArabic ? 'بانتظار تجهيز الجلسة' : 'Session setup pending';
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'session_scheduled':
      case 'session_in_progress':
        return const Color(0xFF2E5AAC);
      case 'session_completed_pending_reviews':
        return const Color(0xFF1F9D63);
      case 'reschedule_pending':
        return const Color(0xFFE39B2E);
      default:
        return const Color(0xFF6C55B3);
    }
  }

  String _dateText(dynamic value) {
    if (value is Timestamp) {
      final d = value.toDate();
      final day = d.day.toString().padLeft(2, '0');
      final month = d.month.toString().padLeft(2, '0');
      final year = d.year.toString();
      final hour = d.hour.toString().padLeft(2, '0');
      final minute = d.minute.toString().padLeft(2, '0');
      return '$hour:$minute $day-$month-$year';
    }
    return '';
  }

  @override
  void dispose() {
    for (final c in _dateControllers.values) {
      c.dispose();
    }
    for (final c in _linkControllers.values) {
      c.dispose();
    }
    for (final c in _codeControllers.values) {
      c.dispose();
    }
    for (final c in _notesControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(
          context,
          title: isArabic ? 'الجلسات والروابط' : 'Sessions & Links',
        ),
        body: AppPageBackground(
          child:
              StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
            stream: _bookingDocsStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return AppEmptyState(
                  message: isArabic
                      ? 'تعذر تحميل الجلسات'
                      : 'Unable to load sessions',
                  icon: Icons.error_outline,
                );
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final docs = snapshot.data!.where((doc) {
                if ((doc.data()['archived'] ?? false) == true) {
                  return false;
                }
                final status = (doc.data()['status'] ?? 'session_setup_pending')
                    .toString();
                return _matchesTab(status);
              }).toList();

              return ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  AppSurfaceCard(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      alignment: WrapAlignment.end,
                      children: [
                        ChoiceChip(
                          selected: _tab == 'session_setup_pending',
                          label: Text(
                            isArabic ? 'بانتظار تجهيز الجلسة' : 'Setup pending',
                          ),
                          onSelected: (_) =>
                              setState(() => _tab = 'session_setup_pending'),
                        ),
                        ChoiceChip(
                          selected: _tab == 'session_scheduled',
                          label: Text(
                            isArabic ? 'جلسات مجدولة' : 'Scheduled',
                          ),
                          onSelected: (_) =>
                              setState(() => _tab = 'session_scheduled'),
                        ),
                        ChoiceChip(
                          selected: _tab == 'session_completed_pending_reviews',
                          label: Text(
                            isArabic ? 'بانتظار التقييمات' : 'Pending reviews',
                          ),
                          onSelected: (_) => setState(
                            () => _tab = 'session_completed_pending_reviews',
                          ),
                        ),
                        ChoiceChip(
                          selected: _tab == 'reschedule_pending',
                          label: Text(
                            isArabic ? 'إعادة جدولة' : 'Reschedule',
                          ),
                          onSelected: (_) =>
                              setState(() => _tab = 'reschedule_pending'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (docs.isEmpty)
                    AppEmptyState(
                      message: isArabic
                          ? 'لا توجد طلبات في هذا القسم'
                          : 'No requests in this section',
                    )
                  else
                    ...docs.map((doc) {
                      final data = doc.data();
                      final requestId = doc.id;
                      final busy = _busyIds.contains(requestId);

                      final clientName =
                          (data['clientName'] ?? 'Client').toString();
                      final clinicianName = (data['assignedClinicianName'] ??
                              data['clinicianName'] ??
                              '')
                          .toString();
                      final note = (data['note'] ?? '').toString();
                      final status = (data['status'] ?? '').toString();
                      final createdAt = _dateText(data['createdAt']);

                      final dateCtrl = _controllerFor(
                        _dateControllers,
                        requestId,
                        initial: (data['sessionDateText'] ?? '').toString(),
                      );
                      final linkCtrl = _controllerFor(
                        _linkControllers,
                        requestId,
                        initial: (data['sessionLink'] ?? '').toString(),
                      );
                      final codeCtrl = _controllerFor(
                        _codeControllers,
                        requestId,
                        initial: (data['sessionCode'] ?? '').toString(),
                      );
                      final notesCtrl = _controllerFor(
                        _notesControllers,
                        requestId,
                        initial: (data['sessionAdminNotes'] ?? '').toString(),
                      );

                      return AppSurfaceCard(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        color: Colors.white.withValues(alpha: 0.84),
                        child: Column(
                          crossAxisAlignment: isArabic
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Row(
                              textDirection: isArabic
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: isArabic
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        clientName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w800),
                                        textAlign: isArabic
                                            ? TextAlign.right
                                            : TextAlign.left,
                                      ),
                                      const SizedBox(height: AppSpacing.xs),
                                      if (clinicianName.trim().isNotEmpty)
                                        Text(
                                          isArabic
                                              ? 'الأخصائي: $clinicianName'
                                              : 'Clinician: $clinicianName',
                                        ),
                                    ],
                                  ),
                                ),
                                AppStatusBadge(
                                  label: _statusLabel(status, isArabic),
                                  color: _statusColor(status),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            if (createdAt.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: AppSpacing.xs),
                                child: Text(
                                  isArabic
                                      ? 'تاريخ الطلب: $createdAt'
                                      : 'Request date: $createdAt',
                                ),
                              ),
                            if (note.trim().isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: AppSpacing.xs),
                                child: Text(
                                  isArabic
                                      ? 'ملاحظة العميل: $note'
                                      : 'Client note: $note',
                                ),
                              ),
                            const SizedBox(height: AppSpacing.sm),
                            if (status == 'session_setup_pending' ||
                                status == 'reschedule_pending') ...[
                              TextField(
                                controller: dateCtrl,
                                decoration: appInputDecoration(
                                  context: context,
                                  label: isArabic
                                      ? 'موعد الجلسة'
                                      : 'Session date/time',
                                  icon: Icons.event_outlined,
                                  hintText: isArabic
                                      ? 'مثال: 25-03-2026 08:30 PM'
                                      : 'Example: 25-03-2026 08:30 PM',
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              TextField(
                                controller: linkCtrl,
                                decoration: appInputDecoration(
                                  context: context,
                                  label:
                                      isArabic ? 'رابط الجلسة' : 'Session link',
                                  icon: Icons.link_outlined,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              TextField(
                                controller: codeCtrl,
                                decoration: appInputDecoration(
                                  context: context,
                                  label:
                                      isArabic ? 'كود الجلسة' : 'Session code',
                                  icon: Icons.password_outlined,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              TextField(
                                controller: notesCtrl,
                                maxLines: 3,
                                decoration: appInputDecoration(
                                  context: context,
                                  label: isArabic
                                      ? 'ملاحظات الإدارة'
                                      : 'Admin notes',
                                  icon: Icons.notes_outlined,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.md),
                            ],
                            if (status == 'session_scheduled' ||
                                status == 'session_in_progress') ...[
                              if ((data['sessionDateText'] ?? '')
                                  .toString()
                                  .trim()
                                  .isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: AppSpacing.xs),
                                  child: Text(
                                    isArabic
                                        ? 'موعد الجلسة: ${(data['sessionDateText'] ?? '').toString()}'
                                        : 'Session date: ${(data['sessionDateText'] ?? '').toString()}',
                                  ),
                                ),
                              if ((data['sessionLink'] ?? '')
                                  .toString()
                                  .trim()
                                  .isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: AppSpacing.xs),
                                  child: Text(
                                    isArabic
                                        ? 'الرابط: ${(data['sessionLink'] ?? '').toString()}'
                                        : 'Link: ${(data['sessionLink'] ?? '').toString()}',
                                  ),
                                ),
                              if ((data['sessionCode'] ?? '')
                                  .toString()
                                  .trim()
                                  .isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: AppSpacing.xs),
                                  child: Text(
                                    isArabic
                                        ? 'الكود: ${(data['sessionCode'] ?? '').toString()}'
                                        : 'Code: ${(data['sessionCode'] ?? '').toString()}',
                                  ),
                                ),
                              const SizedBox(height: AppSpacing.sm),
                            ],
                            Wrap(
                              spacing: AppSpacing.sm,
                              runSpacing: AppSpacing.sm,
                              alignment: WrapAlignment.end,
                              children: [
                                if (status == 'session_setup_pending' ||
                                    status == 'reschedule_pending')
                                  FilledButton.icon(
                                    onPressed: busy
                                        ? null
                                        : () => _scheduleSession(requestId),
                                    icon: const Icon(Icons.video_call_outlined),
                                    label: Text(
                                      isArabic
                                          ? 'إنشاء/جدولة الجلسة'
                                          : 'Schedule session',
                                    ),
                                  ),
                                if (status == 'session_scheduled')
                                  FilledButton.tonalIcon(
                                    onPressed: busy
                                        ? null
                                        : () => _markInProgress(requestId),
                                    icon: const Icon(Icons.play_circle_outline),
                                    label: Text(
                                      isArabic
                                          ? 'تعليم كجلسة جارية'
                                          : 'Mark in progress',
                                    ),
                                  ),
                                if (status == 'session_scheduled' ||
                                    status == 'session_in_progress')
                                  FilledButton.tonalIcon(
                                    onPressed: busy
                                        ? null
                                        : () => _markCompleted(requestId),
                                    icon: const Icon(Icons.task_alt_outlined),
                                    label: Text(
                                      isArabic
                                          ? 'تعليم كمكتملة'
                                          : 'Mark completed',
                                    ),
                                  ),
                                if (status == 'session_scheduled' ||
                                    status == 'session_in_progress')
                                  OutlinedButton.icon(
                                    onPressed: busy
                                        ? null
                                        : () => _moveToReschedule(requestId),
                                    icon: const Icon(Icons.update_outlined),
                                    label: Text(
                                      isArabic ? 'إعادة جدولة' : 'Reschedule',
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
