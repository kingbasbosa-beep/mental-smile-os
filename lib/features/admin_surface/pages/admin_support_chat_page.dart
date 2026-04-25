import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/core/system/domain_registry.dart';
import 'package:flutterprojects/core/system/domain_status.dart';
import 'package:flutterprojects/core/system/domain_status_service.dart';
import 'package:flutterprojects/features/chat/data/models/chat_thread_model.dart';
import 'package:flutterprojects/features/chat/data/services/chat_firestore_service.dart';
import 'package:flutterprojects/features/chat/data/services/chat_health_service.dart';
import 'package:flutterprojects/features/admin_surface/widgets/domain_advisory_banner.dart';
import 'package:flutterprojects/shared/ui_kit/asset_fallback_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

// ADMIN_SURFACE: SAFE_UI
class AdminSupportChatPage extends StatefulWidget {
  const AdminSupportChatPage({super.key});

  @override
  State<AdminSupportChatPage> createState() => _AdminSupportChatPageState();
}

class _AdminSupportChatPageState extends State<AdminSupportChatPage> {
  static final ChatFirestoreService _chatFirestoreService =
      ChatFirestoreService();
  static const ChatHealthService _chatHealthService = ChatHealthService();
  static const DomainStatusService _domainStatusService = DomainStatusService();

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
        sampleType: 'admin_support_page_open',
      );
    } catch (_) {
      // Health reporting must stay quiet and never block admin chat usage.
    }
  }

  bool _isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
  }

  bool _isEscalatedCase(Map<String, dynamic> data) {
    final sourceType = (data['sourceType'] ?? '').toString();
    return sourceType == 'client' || sourceType == 'guest';
  }

  String _statusLabel(String value, bool isArabic) {
    switch (value) {
      case 'assigned_admin':
        return isArabic ? 'بانتظار الإدارة' : 'Waiting for admin';
      case 'admin_replying':
        return isArabic ? 'الإدارة تتابع' : 'Admin replying';
      case 'resolved':
        return isArabic ? 'تم الحل' : 'Resolved';
      default:
        return value;
    }
  }

  String _avatarAsset(Map<String, dynamic> data) {
    final sourceType = (data['sourceType'] ?? '').toString();
    final ownerType = (data['ownerType'] ?? '').toString();

    if (ownerType.contains('clinician')) {
      return 'assets/c5/avatars/avatar_clinician_m.png';
    }
    if (ownerType.contains('center')) {
      return 'assets/c5/avatars/avatar_admin_support.png';
    }
    if (sourceType == 'admin_support') {
      return 'assets/c5/avatars/avatar_admin_support.png';
    }
    return 'assets/c5/avatars/avatar_client.png';
  }

  String _sourceLabel(Map<String, dynamic> data, bool isArabic) {
    final sourceType = (data['sourceType'] ?? '').toString();
    final ownerType = (data['ownerType'] ?? '').toString();

    if (sourceType == 'admin_support') {
      return isArabic ? 'دعم مباشر من الإدارة' : 'Direct Admin Support';
    }
    if (sourceType == 'client' || sourceType == 'guest') {
      return isArabic
          ? 'تصعيد تم اكتشافه بواسطة النظام'
          : 'AI-Detected Escalation';
    }
    if (ownerType.contains('clinician')) {
      return isArabic ? 'أخصائي' : 'Clinician';
    }
    if (ownerType.contains('center')) {
      return isArabic ? 'مركز' : 'Center';
    }
    return isArabic ? 'عميل' : 'Client';
  }

  String _chatTypeLabel(Map<String, dynamic> data, bool isArabic) {
    final sourceType = (data['sourceType'] ?? '').toString();

    if (_isEscalatedCase(data)) {
      return isArabic ? 'حالة دعم مصعّدة' : 'Escalated Support Case';
    }
    if (sourceType == 'admin_support') {
      return isArabic ? 'مراجعة بشرية مطلوبة' : 'Human Review Needed';
    }
    return isArabic ? 'محادثة AI' : 'AI Conversation';
  }

  String _advisoryTitle(bool isArabic, String status) {
    switch (status) {
      case 'disabled':
        return isArabic ? 'تنبيه: نطاق الشات معطل' : 'Advisory: Chat disabled';
      case 'maintenance':
        return isArabic
            ? 'تنبيه: نطاق الشات تحت صيانة مخططة'
            : 'Advisory: Chat maintenance';
      default:
        return isArabic
            ? 'تنبيه: نطاق الشات في حالة degraded'
            : 'Advisory: Chat degraded';
    }
  }

  String _advisoryBody(bool isArabic, DomainStatus status) {
    final reason = (status.statusReason ?? status.note ?? '').trim();
    final source = DomainAdvisoryBanner.statusSourceLabel(status.statusSource);

    final intro = switch (status.status) {
      'disabled' => isArabic
          ? 'هذا السطح يعرض نطاق الشات على أنه معطل حاليًا.'
          : 'This surface is showing the Chat domain as currently disabled.',
      'maintenance' => isArabic
          ? 'هذا السطح يعرض أن نطاق الشات تحت صيانة مخططة.'
          : 'This surface is showing the Chat domain as under planned maintenance.',
      _ => isArabic
          ? 'هذا السطح يعرض أن نطاق الشات في حالة degraded ويجب التعامل مع إشاراته بثقة أقل.'
          : 'This surface is showing the Chat domain as degraded and its signals should be treated with reduced trust.',
    };

    if (reason.isEmpty) {
      return '$intro ${isArabic ? 'المصدر' : 'Source'}: $source.';
    }

    return '$intro ${isArabic ? 'المصدر' : 'Source'}: $source. ${isArabic ? 'الملاحظة' : 'Note'}: $reason';
  }

  Widget _buildDomainAdvisoryBanner(BuildContext context, bool isArabic) {
    return StreamBuilder<DomainStatus>(
      stream: _domainStatusService.watchDomainStatus(DomainKey.chat),
      builder: (context, snapshot) {
        final status = snapshot.data;
        if (status == null || status.status == 'active' || status.isUnknown) {
          return const SizedBox.shrink();
        }

        return DomainAdvisoryBanner(
          status: status,
          domainDisplayName: 'Chat',
          title: _advisoryTitle(isArabic, status.status),
          body: _advisoryBody(isArabic, status),
          nonBlockingMessage: isArabic
              ? 'هذا تنبيه معلوماتي فقط. عمليات الشات لا يتم حظرها بواسطة هذا الإشعار.'
              : 'This is informational only. Chat operations are not blocked by this notice.',
          isArabic: isArabic,
          margin: const EdgeInsets.only(bottom: AppSpacing.md),
        );
      },
    );
  }

  Widget _buildIntroCard(BuildContext context, bool isArabic) {
    return AppSurfaceCard(
      color: const Color(0xFF10161A).withValues(alpha: 0.94),
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isArabic ? 'مراجعة بشرية مطلوبة' : 'Human Review Needed',
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isArabic
                ? 'يعرض هذا السطح محادثات تحتاج مراجعة بشرية، مع تمييز الدعم المباشر من الإدارة عن التصعيد المكتشف بواسطة النظام.'
                : 'This surface shows conversations needing human review, separating direct admin support from AI-detected escalation.',
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isArabic
                ? 'يرجى الرد للإرشاد فقط، وتحويل أي طلب تغييري إلى الإجراءات داخل النظام.'
                : 'Respond for guidance only. Redirect operational requests to system actions.',
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.obsidian.withValues(alpha: 0.72),
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFF0F1316),
        appBar: AppShellActions.buildAppBar(
          context,
          title: isArabic ? 'رسائل الإدارة' : 'Admin Messages',
          canLogout: false,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF13191D),
                Color(0xFF0F1316),
                Color(0xFF151B1F),
              ],
            ),
          ),
          child: StreamBuilder<List<ChatThreadModel>>(
            stream: _chatFirestoreService.streamAdminSupportInboxThreads(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return AppEmptyState(
                  message: isArabic
                      ? 'تعذر تحميل رسائل الإدارة'
                      : 'Unable to load admin chats',
                  icon: Icons.error_outline,
                );
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final threads = snapshot.data!;

              if (threads.isEmpty) {
                return AppEmptyState(
                  message: isArabic
                      ? 'لا توجد محادثات تتطلب مراجعة بشرية'
                      : 'No chats needing human review',
                  icon: Icons.support_agent_outlined,
                );
              }

              return ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  _buildDomainAdvisoryBanner(context, isArabic),
                  _buildIntroCard(context, isArabic),
                  for (final thread in threads) ...[
                    const SizedBox(height: AppSpacing.md),
                    Builder(
                      builder: (context) {
                        final data = <String, dynamic>{
                          'sourceType': thread.sourceType,
                          'ownerType': thread.ownerType,
                        };

                        final threadId = thread.id;
                        final displayName = thread.displayName.trim().isEmpty
                            ? (thread.ownerUid.trim().isEmpty
                                ? 'Client'
                                : thread.ownerUid)
                            : thread.displayName;
                        final preview = thread.lastMessagePreview.trim();
                        final handoffState = thread.handoffState;
                        final lifecycleState = thread.lifecycleState;
                        final bookingRequestId = thread.bookingRequestId ?? '';

                        return InkWell(
                          borderRadius: BorderRadius.circular(AppRadii.lg),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              Routes.chat,
                              arguments: {'threadId': threadId},
                            );
                          },
                          child: AppSurfaceCard(
                            color: const Color(0xFF10161A)
                                .withValues(alpha: 0.94),
                            borderColor: const Color(0xFFD8B26A)
                                .withValues(alpha: 0.18),
                            padding: const EdgeInsets.all(AppSpacing.md),
                            child: Row(
                              textDirection: isArabic
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              children: [
                                CircleAvatar(
                                  radius: 26,
                                  backgroundImage: safeAssetImageProvider(
                                    _avatarAsset(data),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Expanded(
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
                                            child: Text(
                                              displayName,
                                              textAlign: isArabic
                                                  ? TextAlign.right
                                                  : TextAlign.left,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          ),
                                          const SizedBox(width: AppSpacing.xs),
                                          AppStatusBadge(
                                            label:
                                                _chatTypeLabel(data, isArabic),
                                            color: AppColors.deepTeal,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        preview.isEmpty
                                            ? (isArabic
                                                ? 'لا توجد رسالة أخيرة'
                                                : 'No last message')
                                            : preview,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: isArabic
                                            ? TextAlign.right
                                            : TextAlign.left,
                                      ),
                                      if (_isEscalatedCase(data)) ...[
                                        const SizedBox(height: AppSpacing.xs),
                                        Text(
                                          isArabic
                                              ? 'تم تمييز هذه الحالة من قبل الذكاء الاصطناعي بسبب إشارات خطر مكتشفة.'
                                              : 'This case was flagged by the AI due to detected risk signals.',
                                          textAlign: isArabic
                                              ? TextAlign.right
                                              : TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: AppColors.obsidian
                                                    .withValues(alpha: 0.72),
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ],
                                      const SizedBox(height: AppSpacing.sm),
                                      Wrap(
                                        spacing: AppSpacing.xs,
                                        runSpacing: AppSpacing.xs,
                                        alignment: WrapAlignment.end,
                                        children: [
                                          AppStatusBadge(
                                            label: _sourceLabel(data, isArabic),
                                            color: const Color(0xFF8A5A1F),
                                          ),
                                          AppStatusBadge(
                                            label: _statusLabel(
                                              lifecycleState,
                                              isArabic,
                                            ),
                                            color: AppColors.accentLavender,
                                          ),
                                          AppStatusBadge(
                                            label: handoffState,
                                            color: AppColors.info,
                                          ),
                                          if (bookingRequestId.isNotEmpty)
                                            AppStatusBadge(
                                              label: isArabic
                                                  ? 'طلب: $bookingRequestId'
                                                  : 'Request: $bookingRequestId',
                                              color: AppColors.mist,
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
