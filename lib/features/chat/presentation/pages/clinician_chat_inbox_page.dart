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

  bool get _isArabic =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  String _backgroundAsset(double width) {
    if (width < 700) {
      return 'assets/images/backgrounds/specialists_bg_mobile.png';
    }
    if (width < 1100) {
      return 'assets/images/backgrounds/specialists_bg_tablet.png';
    }
    return 'assets/images/backgrounds/specialists_bg_desktop.png';
  }

  BoxDecoration _glassDecoration({double alpha = 0.34, double radius = 22}) {
    return BoxDecoration(
      color: Colors.black.withValues(alpha: alpha),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: const Color(0xFFE7C766).withValues(alpha: 0.34),
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFE7C766).withValues(alpha: 0.08),
          blurRadius: 24,
          offset: const Offset(0, 12),
        ),
      ],
    );
  }

  Widget _buildDarkShell({required Widget child}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              _backgroundAsset(constraints.maxWidth),
              fit: BoxFit.cover,
              alignment: constraints.maxWidth < 700
                  ? Alignment.topCenter
                  : Alignment.center,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.62),
                    Colors.black.withValues(alpha: 0.38),
                    Colors.black.withValues(alpha: 0.74),
                  ],
                ),
              ),
            ),
            child,
          ],
        );
      },
    );
  }

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
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: _glassDecoration(alpha: 0.34, radius: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'حالات الشات للأخصائي',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFFE7C766),
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'هذه المساحة مخصصة للحالات المصعّدة أو المُحالة من الشات، وهي منفصلة عن الجلسات والطلبات التشغيلية.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFFFF4D4),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnauthenticatedState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: _glassDecoration(alpha: 0.36, radius: 22),
          child: Text(
            'يجب تسجيل الدخول كأخصائي لرؤية هذه الصفحة.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFFFF4D4),
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: _glassDecoration(alpha: 0.34, radius: 22),
      child: Column(
        children: [
          const Icon(
            Icons.inbox_outlined,
            color: Color(0xFFE7C766),
            size: 34,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'لا توجد حالات شات مصعّدة أو مُحالة لك حالياً',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFFFFF4D4),
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
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

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: _glassDecoration(alpha: 0.34, radius: 22),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: Color(0xFFFFF4D4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  identity,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFFFFF4D4),
                        fontWeight: FontWeight.w800,
                      ),
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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFFFF4D4),
                ),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = _isArabic ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1B1007).withValues(alpha: 0.50),
                border: Border.all(
                  color: const Color(0xFFFFD98A).withValues(alpha: 0.56),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFD98A).withValues(alpha: 0.34),
                    blurRadius: 16,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                  BoxShadow(
                    color: const Color(0xFFE7A94C).withValues(alpha: 0.24),
                    blurRadius: 26,
                    spreadRadius: 2,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Image.asset(
                textDirection == TextDirection.rtl
                    ? 'assets/branding/navigation/back/back_right_gold.png'
                    : 'assets/branding/navigation/back/back_left_gold.png',
                width: 22,
                height: 22,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.arrow_back_rounded,
                    color: Color(0xFFFFE7B2),
                    size: 22,
                  );
                },
              ),
            ),
          ),
          title: Text(
            _isArabic ? 'حالات الشات للأخصائي' : 'Clinician Chat Cases',
          ),
          backgroundColor: const Color(0xFF0F1316).withValues(alpha: 0.96),
          foregroundColor: const Color(0xFFC9A75B),
          elevation: 0,
          titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFFC9A75B),
                fontWeight: FontWeight.w800,
              ),
        ),
        body: _buildDarkShell(
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
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: _glassDecoration(alpha: 0.36, radius: 22),
                child: Text(
                  'فشل تحميل الحالات: ${snapshot.error}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFFFFF4D4),
                      ),
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
