import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminSupportChatPage extends StatelessWidget {
  const AdminSupportChatPage({super.key});

  bool _isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
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

    if (sourceType == 'admin_support') {
      return 'assets/c5/avatars/avatar_admin_support.png';
    }
    if (ownerType.contains('clinician')) {
      return 'assets/c5/avatars/avatar_clinician_m.png';
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
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('chat_threads')
                .orderBy('updatedAt', descending: true)
                .snapshots(),
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

              final docs = snapshot.data!.docs.where((doc) {
                final data = doc.data();
                return (data['needsHumanSupport'] ?? false) == true;
              }).toList();

              if (docs.isEmpty) {
                return AppEmptyState(
                  message: isArabic
                      ? 'لا توجد محادثات بانتظار الإدارة'
                      : 'No chats waiting for admin',
                  icon: Icons.support_agent_outlined,
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.lg),
                itemCount: docs.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  final doc = docs[index];
                  final data = doc.data();

                  final threadId = doc.id;
                  final displayName =
                      (data['displayName'] ?? data['ownerUid'] ?? 'Client')
                          .toString();
                  final preview =
                      (data['lastMessagePreview'] ?? '').toString().trim();
                  final handoffState =
                      (data['handoffState'] ?? 'admin_review').toString();
                  final lifecycleState =
                      (data['lifecycleState'] ?? 'assigned_admin').toString();
                  final bookingRequestId =
                      (data['bookingRequestId'] ?? '').toString();

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
                            backgroundImage: AssetImage(_avatarAsset(data)),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: isArabic
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  displayName,
                                  textAlign: isArabic
                                      ? TextAlign.right
                                      : TextAlign.left,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
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

