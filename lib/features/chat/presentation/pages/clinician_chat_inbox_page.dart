import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/chat/data/models/chat_escalation_model.dart';
import 'package:flutterprojects/features/chat/data/services/chat_firestore_service.dart';

/// Clinician-facing inbox for escalated chat cases assigned to the logged-in clinician.
/// Arabic-first RTL, consistent with ChatEscalationsPage card layout.
class ClinicianChatInboxPage extends StatefulWidget {
  const ClinicianChatInboxPage({
    super.key,
    required this.clinicianUid,
  });

  final String clinicianUid;

  @override
  State<ClinicianChatInboxPage> createState() => _ClinicianChatInboxPageState();
}

class _ClinicianChatInboxPageState extends State<ClinicianChatInboxPage> {
  final ChatFirestoreService _service = ChatFirestoreService();

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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('حالات الشات للأخصائي'),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || uid.isEmpty || uid != widget.clinicianUid) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'يجب تسجيل الدخول كأخصائي لرؤية هذه الصفحة.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return StreamBuilder<List<ChatEscalationModel>>(
      stream: _service.streamClinicianEscalations(widget.clinicianUid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'فشل تحميل الحالات: ${snapshot.error}',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = snapshot.data ?? [];
        if (items.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد حالات تصعيد مخصصة لك حالياً',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final e = items[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.ownerDisplayName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text('مستوى الخطر: ${e.riskLevel}'),
                    Text('النقاط: ${e.riskScore}'),
                    Text('الحالة: ${_statusLabel(e.status)}'),
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
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                    const SizedBox(height: 12),
                    Text(
                      'المعيّن له: أنت',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              Routes.chat,
                              arguments: {'threadId': e.threadId},
                            );
                          },
                          child: const Text('فتح الشات'),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              Routes.chatEscalationReport,
                              arguments: {'escalationId': e.id},
                            );
                          },
                          child: const Text('عرض التقرير'),
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
  }
}
