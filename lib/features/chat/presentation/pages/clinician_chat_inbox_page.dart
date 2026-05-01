import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/chat/data/models/chat_escalation_model.dart';
import 'package:flutterprojects/features/chat/data/models/chat_thread_model.dart';
import 'package:flutterprojects/features/chat/data/services/chat_firestore_service.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';

/// Clinician-facing surface for escalated or referred chat cases.
/// This remains separate from assignments and sessions.
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
  bool _resolvingCase = false;

  String _statusLabel(String status) {
    switch (status) {
      case 'open':
        return 'مفتوحة';
      case 'assigned':
        return 'معيّنة للإدارة';
      case 'forwarded_to_clinician':
        return 'محوّلة للأخصائي';
      case 'resolved':
        return 'تم التعامل معها';
      default:
        return status;
    }
  }

  String _riskLabel(String code) {
    switch (code) {
      case 'critical':
        return 'حرج';
      case 'high':
        return 'مرتفع';
      case 'medium':
        return 'متوسط';
      case 'low':
        return 'منخفض';
      default:
        return code;
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

  String _originLabel(ChatThreadModel? thread) {
    final sourceType = thread?.sourceType ?? '';
    if (sourceType == 'client' || sourceType == 'guest') {
      return 'AI escalated';
    }
    if (sourceType == 'admin_support') {
      return 'Admin referred';
    }
    return 'Referred case';
  }

  Color _originColor(ChatThreadModel? thread) {
    final sourceType = thread?.sourceType ?? '';
    if (sourceType == 'client' || sourceType == 'guest') {
      return AppColors.info;
    }
    if (sourceType == 'admin_support') {
      return AppColors.accentLavender;
    }
    return AppColors.mist;
  }

  String _identityLabel(
      ChatEscalationModel escalation, ChatThreadModel? thread) {
    final displayName = escalation.ownerDisplayName.trim();
    if (displayName.isNotEmpty && displayName != 'مستخدم') {
      return displayName;
    }

    final threadName = thread?.displayName.trim() ?? '';
    if (threadName.isNotEmpty && threadName != 'مستخدم') {
      return threadName;
    }

    return escalation.ownerUid.isEmpty ? 'Case user' : escalation.ownerUid;
  }

  String _previewText(ChatEscalationModel escalation, ChatThreadModel? thread) {
    final preview = thread?.lastMessagePreview.trim() ?? '';
    if (preview.isNotEmpty) return preview;
    final summary = escalation.summaryText.trim();
    if (summary.isNotEmpty) return summary;
    return 'لا توجد معاينة للرسائل بعد';
  }

  String _currentStateLabel(
      ChatEscalationModel escalation, ChatThreadModel? thread) {
    if (escalation.status == 'resolved') {
      return 'تم التعامل معها';
    }
    final handoff = thread?.handoffState ?? '';
    final lifecycle = thread?.lifecycleState ?? '';
    if (handoff == 'clinician_review' || lifecycle == 'assigned_clinician') {
      return 'بانتظار متابعة الأخصائي';
    }
    return _statusLabel(escalation.status);
  }

  Future<void> _markAsHandled(ChatEscalationModel escalation) async {
    final resolverUid = FirebaseAuth.instance.currentUser?.uid;
    if (resolverUid == null || resolverUid.isEmpty) return;

    setState(() {
      _resolvingCase = true;
    });

    try {
      await _service.resolveEscalation(
        escalationId: escalation.id,
        threadId: escalation.threadId,
        resolverUid: resolverUid,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم تحديث الحالة إلى تم التعامل معها'),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('فشل تحديث الحالة: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _resolvingCase = false;
        });
      }
    }
  }

  Widget _buildIntroCard() {
    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'حالات الشات للأخصائي',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'هذه المساحة مخصصة للحالات المصعّدة أو المُحالة من الشات، وهي منفصلة عن الجلسات والطلبات التشغيلية.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildUnauthenticatedState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: AppSurfaceCard(
          child: Text(
            'يجب تسجيل الدخول كأخصائي لرؤية هذه الصفحة.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return AppEmptyState(
      message: 'لا توجد حالات شات مصعّدة أو مُحالة لك حالياً',
      icon: Icons.inbox_outlined,
    );
  }

  Widget _buildCaseCard(
      ChatEscalationModel escalation, ChatThreadModel? thread) {
    final currentState = _currentStateLabel(escalation, thread);
    final preview = _previewText(escalation, thread);
    final identity = _identityLabel(escalation, thread);
    final risk = _riskLabel(escalation.riskLevel);
    final origin = _originLabel(thread);
    final canMarkHandled = escalation.status != 'resolved';

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  identity,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              AppStatusBadge(
                label: origin,
                color: _originColor(thread),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              AppStatusBadge(
                label: 'State: $currentState',
                color: AppColors.deepTeal,
              ),
              AppStatusBadge(
                label: 'Risk: $risk',
                color: AppColors.info,
              ),
              AppStatusBadge(
                label: 'Score: ${escalation.riskScore}',
                color: AppColors.mist,
              ),
              if ((escalation.bookingRequestId ?? '').isNotEmpty)
                AppStatusBadge(
                  label: 'Request: ${escalation.bookingRequestId}',
                  color: AppColors.accentLavender,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            preview,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          if (escalation.reasonCodes.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: escalation.reasonCodes
                  .map(
                    (reason) => Chip(
                      label: Text(_reasonLabel(reason)),
                    ),
                  )
                  .toList(),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    Routes.chat,
                    arguments: {'threadId': escalation.threadId},
                  );
                },
                child: const Text('فتح الشات'),
              ),
              if (canMarkHandled)
                FilledButton.tonal(
                  onPressed:
                      _resolvingCase ? null : () => _markAsHandled(escalation),
                  child: const Text('تم التعامل معها'),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('حالات الشات للأخصائي'),
        ),
        body: AppPageBackground(
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || uid.isEmpty || uid != widget.clinicianUid) {
      return _buildUnauthenticatedState();
    }

    return StreamBuilder<List<ChatEscalationModel>>(
      stream: _service.streamClinicianEscalations(widget.clinicianUid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: AppSurfaceCard(
                child: Text(
                  'فشل تحميل الحالات: ${snapshot.error}',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = snapshot.data ?? [];
        if (items.isEmpty) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildIntroCard(),
              const SizedBox(height: 16),
              _buildEmptyState(),
            ],
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: items.length + 1,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildIntroCard();
            }

            final escalation = items[index - 1];
            return FutureBuilder<ChatThreadModel?>(
              future: _service.getThread(escalation.threadId),
              builder: (context, threadSnapshot) {
                final thread = threadSnapshot.data;
                return _buildCaseCard(escalation, thread);
              },
            );
          },
        );
      },
    );
  }
}
