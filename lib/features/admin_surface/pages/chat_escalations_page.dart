import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/core/auth/account_access_service.dart';
import 'package:flutterprojects/features/chat/data/models/chat_escalation_model.dart';
import 'package:flutterprojects/features/chat/data/models/clinician_option_model.dart';
import 'package:flutterprojects/features/chat/data/services/chat_firestore_service.dart';
import 'package:flutterprojects/features/chat/data/services/chat_health_service.dart';

class ChatEscalationsPage extends StatefulWidget {
  const ChatEscalationsPage({super.key});

  @override
  State<ChatEscalationsPage> createState() => _ChatEscalationsPageState();
}

class _ChatEscalationsPageState extends State<ChatEscalationsPage> {
  final ChatFirestoreService _service = ChatFirestoreService();
  static const ChatHealthService _chatHealthService = ChatHealthService();
  String _filter = 'all';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _emitChatHealth();
    });
  }

  Future<void> _emitChatHealth() async {
    try {
      await _chatHealthService.emitHealthSnapshot(
        sampleType: 'chat_escalations_page_open',
      );
    } catch (_) {
      // Health reporting must stay quiet and never block escalation workflows.
    }
  }

  Color _riskColor(String riskLevel) {
    switch (riskLevel) {
      case 'critical':
        return const Color(0xFFD84B4B);
      case 'high':
        return const Color(0xFFE39B2E);
      case 'medium':
        return const Color(0xFF2E5AAC);
      default:
        return const Color(0xFF6C55B3);
    }
  }

  String _riskLabel(String riskLevel) {
    if (riskLevel == 'critical') {
      return 'تنبيه أمان / حالة عاجلة';
    }
    return 'الخطر: $riskLevel';
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'resolved':
        return const Color(0xFF1F9D63);
      case 'forwarded_to_clinician':
        return const Color(0xFF2E5AAC);
      case 'assigned':
        return const Color(0xFF8A5A1F);
      default:
        return const Color(0xFF6C55B3);
    }
  }

  String _reasonLabel(String code) {
    switch (code) {
      case 'collapse':
        return 'انهيار عاطفي';
      case 'hopelessness':
        return 'فقدان الأمل';
      case 'fear':
        return 'خوف';
      case 'guilt':
        return 'ذنب';
      case 'denial':
        return 'إنكار';
      case 'craving':
        return 'رغبة في التعاطي';
      case 'justification':
        return 'تبرير';
      case 'manipulation':
        return 'تلاعب';
      default:
        return code;
    }
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'open':
        return 'مفتوحة';
      case 'assigned':
        return 'معيّنة للأدمن';
      case 'forwarded_to_clinician':
        return 'محوّلة لأخصائي';
      case 'resolved':
        return 'مغلقة';
      default:
        return status;
    }
  }

  List<ChatEscalationModel> _applyFilter(List<ChatEscalationModel> items) {
    if (_filter == 'all') return items;
    return items.where((e) => e.status == _filter).toList();
  }

  Future<bool> _isCurrentAdminUser() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || uid.isEmpty) return false;

    if (uid == kKnownPrimaryAdminUid) return true;

    final adminDoc =
        await FirebaseFirestore.instance.collection('admins').doc(uid).get();
    final data = adminDoc.data();
    return adminDoc.exists && data != null && (data['active'] ?? false) == true;
  }

  Future<void> _pickClinicianAndForward(
    BuildContext context,
    ChatEscalationModel escalation,
  ) async {
    try {
      final clinicians = await _service.streamClinicians().first;

      if (!context.mounted) return;

      if (clinicians.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لا يوجد أخصائيون متاحون حاليًا')),
        );
        return;
      }

      final selected = await showDialog<ClinicianOptionModel>(
        context: context,
        builder: (dialogContext) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: const Text('اختر الأخصائي'),
              content: SizedBox(
                width: 520,
                height: 420,
                child: ListView.separated(
                  itemCount: clinicians.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final c = clinicians[index];
                    return ListTile(
                      title: Text(c.displayName),
                      subtitle: Text(
                        c.specialty.isEmpty ? 'بدون تخصص محدد' : c.specialty,
                      ),
                      trailing:
                          c.isAdmin ? const Chip(label: Text('أدمن')) : null,
                      onTap: () {
                        Navigator.of(dialogContext).pop(c);
                      },
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('إلغاء'),
                ),
              ],
            ),
          );
        },
      );

      if (selected == null) return;

      await _service.forwardEscalationToClinician(
        escalationId: escalation.id,
        threadId: escalation.threadId,
        clinicianUid: selected.id,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('تم تحويل الحالة إلى ${selected.displayName}')),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل تحميل قائمة الأخصائيين: $e')),
      );
    }
  }

  Future<void> _assignToMe(
    BuildContext context,
    ChatEscalationModel escalation,
  ) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || uid.isEmpty) return;

    await _service.assignEscalationToAdmin(
      escalationId: escalation.id,
      threadId: escalation.threadId,
      adminUid: uid,
    );

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم تعيين الحالة لك')),
    );
  }

  Future<void> _resolveEscalation(
    BuildContext context,
    ChatEscalationModel escalation,
  ) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || uid.isEmpty) return;

    await _service.resolveEscalation(
      escalationId: escalation.id,
      threadId: escalation.threadId,
      resolverUid: uid,
    );

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إغلاق الحالة')),
    );
  }

  String _assignedLabel(
    ChatEscalationModel e,
    Map<String, ClinicianOptionModel> cliniciansMap,
  ) {
    final uid = e.assignedToUid;
    if (uid == null || uid.isEmpty) return 'غير معيّن';

    final item = cliniciansMap[uid];
    if (item != null) {
      return item.displayName;
    }
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('حالات مصعّدة (سجل قديم)'),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Text(
                'هذا القسم يعرض محادثات قديمة فقط. طلبات الدعم الجديدة تتم عبر نظام الطلبات المنظمة.',
                textAlign: TextAlign.right,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('الكل'),
                    selected: _filter == 'all',
                    onSelected: (_) => setState(() => _filter = 'all'),
                  ),
                  ChoiceChip(
                    label: const Text('مفتوحة'),
                    selected: _filter == 'open',
                    onSelected: (_) => setState(() => _filter = 'open'),
                  ),
                  ChoiceChip(
                    label: const Text('معيّنة'),
                    selected: _filter == 'assigned',
                    onSelected: (_) => setState(() => _filter = 'assigned'),
                  ),
                  ChoiceChip(
                    label: const Text('محوّلة'),
                    selected: _filter == 'forwarded_to_clinician',
                    onSelected: (_) =>
                        setState(() => _filter = 'forwarded_to_clinician'),
                  ),
                  ChoiceChip(
                    label: const Text('مغلقة'),
                    selected: _filter == 'resolved',
                    onSelected: (_) => setState(() => _filter = 'resolved'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<bool>(
                future: _isCurrentAdminUser(),
                builder: (context, adminSnapshot) {
                  final isAdminUser = adminSnapshot.data == true;
                  return StreamBuilder<Map<String, ClinicianOptionModel>>(
                    stream: _service.streamCliniciansMap(),
                    builder: (context, cliniciansSnapshot) {
                      final cliniciansMap = cliniciansSnapshot.data ?? {};

                      return StreamBuilder<List<ChatEscalationModel>>(
                        stream: _service.streamEscalations(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                  'فشل تحميل الحالات المصعّدة التاريخية: ${snapshot.error}'),
                            );
                          }

                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          final items = _applyFilter(snapshot.data ?? []);
                          if (items.isEmpty) {
                            return const Center(
                              child: Text('لا توجد حالات تاريخية مطابقة لهذا الفلتر'),
                            );
                          }

                          return ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount: items.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final e = items[index];
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.ownerDisplayName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _riskColor(e.riskLevel)
                                                  .withValues(alpha: 0.12),
                                              borderRadius:
                                                  BorderRadius.circular(999),
                                            ),
                                            child: Text(
                                              _riskLabel(e.riskLevel),
                                              style: TextStyle(
                                                color: _riskColor(e.riskLevel),
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _statusColor(e.status)
                                                  .withValues(alpha: 0.12),
                                              borderRadius:
                                                  BorderRadius.circular(999),
                                            ),
                                            child: Text(
                                              _statusLabel(e.status),
                                              style: TextStyle(
                                                color: _statusColor(e.status),
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF3ECFF),
                                              borderRadius:
                                                  BorderRadius.circular(999),
                                            ),
                                            child: Text(
                                              'النقاط: ${e.riskScore}',
                                              style: const TextStyle(
                                                color: Color(0xFF6C55B3),
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (e.assignedToType != null)
                                        Text(
                                            'نوع التعيين: ${e.assignedToType == 'admin' ? 'أدمن' : 'أخصائي'}'),
                                      if (e.assignedToUid != null)
                                        Text(
                                            'المعيّن له: ${_assignedLabel(e, cliniciansMap)}'),
                                      const SizedBox(height: 8),
                                      if (e.reasonCodes.isNotEmpty)
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: e.reasonCodes
                                              .map(
                                                (r) => Chip(
                                                  label: Text(_reasonLabel(r)),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      if (e.summaryText.isNotEmpty) ...[
                                        const SizedBox(height: 12),
                                        Text(
                                          e.summaryText,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                      const SizedBox(height: 12),
                                      Text(
                                        'Thread ID: ${e.threadId}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      const SizedBox(height: 12),
                                      Wrap(
                                        spacing: 12,
                                        runSpacing: 12,
                                        children: [
                                          if (isAdminUser)
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                  Routes.chatEscalationReport,
                                                  arguments: {
                                                    'escalationId': e.id
                                                  },
                                                );
                                              },
                                              child: const Text('عرض التقرير'),
                                            ),
                                          OutlinedButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                Routes.chat,
                                                arguments: {
                                                  'threadId': e.threadId
                                                },
                                              );
                                            },
                                            child: const Text('فتح المحادثة القديمة'),
                                          ),
                                          if (isAdminUser &&
                                              (e.status == 'open' ||
                                                  e.status == 'assigned'))
                                            FilledButton(
                                              onPressed: () =>
                                                  _assignToMe(context, e),
                                              child: const Text('تعيين لي'),
                                            ),
                                          if (isAdminUser &&
                                              e.status != 'resolved')
                                            FilledButton.tonal(
                                              onPressed: () =>
                                                  _pickClinicianAndForward(
                                                      context, e),
                                              child:
                                                  const Text('تحويل لأخصائي'),
                                            ),
                                          if (isAdminUser &&
                                              e.status != 'resolved')
                                            FilledButton.tonal(
                                              onPressed: () =>
                                                  _resolveEscalation(
                                                      context, e),
                                              child: const Text('إغلاق الحالة'),
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
