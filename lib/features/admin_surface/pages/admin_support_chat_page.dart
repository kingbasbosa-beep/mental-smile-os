import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/chat/data/models/chat_thread_model.dart';
import 'package:flutterprojects/features/chat/data/services/chat_firestore_service.dart';
import 'package:flutterprojects/features/chat/data/services/chat_health_service.dart';
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
      return isArabic ? 'شات إداري مباشر' : 'Direct admin support';
    }
    if (sourceType == 'client' || sourceType == 'guest') {
      return isArabic ? 'شات AI مصعّد' : 'Escalated AI chat';
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
      return isArabic ? 'حالة مصعّدة' : 'Escalated Case';
    }
    if (sourceType == 'admin_support') {
      return isArabic ? 'دعم بشري' : 'Human Support';
    }
    return isArabic ? 'محادثة AI' : 'AI Conversation';
  }

  Widget _buildIntroCard(BuildContext context, bool isArabic) {
    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isArabic ? 'إشراف بشري على الحالات' : 'Human-supervised cases',
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isArabic
                ? 'تم تصعيد هذه المحادثة من نظام الذكاء الاصطناعي وهي الآن تحت إشراف بشري.'
                : 'This conversation was escalated from the AI system and is now under human supervision.',
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
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
        appBar: AppShellActions.buildAppBar(
          context,
          title: isArabic ? 'رسائل الإدارة' : 'Admin Messages',
          canLogout: false,
        ),
        body: AppPageBackground(
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
                      ? 'لا توجد محادثات بانتظار الإدارة'
                      : 'No chats waiting for admin',
                  icon: Icons.support_agent_outlined,
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.lg),
                itemCount: threads.length + 1,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildIntroCard(context, isArabic);
                  }

                  final thread = threads[index - 1];
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
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        textDirection:
                            isArabic ? TextDirection.rtl : TextDirection.ltr,
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
                                      label: _chatTypeLabel(data, isArabic),
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
                                          lifecycleState, isArabic),
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
                          const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

