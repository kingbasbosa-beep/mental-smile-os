import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/core/auth/account_access_service.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

// ADMIN_SURFACE: SAFE_UI
class AdminClinicianRequestsPage extends StatefulWidget {
  const AdminClinicianRequestsPage({super.key});

  @override
  State<AdminClinicianRequestsPage> createState() =>
      _AdminClinicianRequestsPageState();
}

class _AdminClinicianRequestsPageState
    extends State<AdminClinicianRequestsPage> {
  String _tab = 'pending';
  final _blockingService = AccountBlockingService();

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  Future<void> _approve(String id) async {
    await FirebaseFirestore.instance.collection('clinicians').doc(id).update({
      'approvalStatus': 'approved',
      'isActive': true,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _reject(String id) async {
    await FirebaseFirestore.instance.collection('clinicians').doc(id).update({
      'approvalStatus': 'rejected',
      'isActive': false,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _returnToPending(String id) async {
    await FirebaseFirestore.instance.collection('clinicians').doc(id).update({
      'approvalStatus': 'pending_review',
      'isActive': false,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<String?> _askBlockReason(BuildContext context) async {
    final isArabic = _isArabic(context);
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(isArabic ? 'سبب الحظر' : 'Block reason'),
          content: TextField(
            controller: controller,
            maxLines: 3,
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            decoration: InputDecoration(
              hintText: isArabic
                  ? 'اكتب سبب الحظر ليظهر للمستخدم'
                  : 'Enter the block reason shown to the user',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(isArabic ? 'إلغاء' : 'Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final value = controller.text.trim();
                if (value.isEmpty) return;
                Navigator.of(dialogContext).pop(value);
              },
              child: Text(isArabic ? 'تأكيد الحظر' : 'Confirm block'),
            ),
          ],
        );
      },
    );
    controller.dispose();
    return result;
  }

  Future<void> _toggleBlock({
    required BuildContext context,
    required String clinicianId,
    required bool currentlyBlocked,
  }) async {
    final isArabic = _isArabic(context);
    try {
      if (currentlyBlocked) {
        await _blockingService.unblockAccount(
          collection: 'clinicians',
          docId: clinicianId,
        );
      } else {
        final reason = await _askBlockReason(context);
        if (reason == null || reason.trim().isEmpty) return;
        await _blockingService.blockAccount(
          collection: 'clinicians',
          docId: clinicianId,
          adminUid: FirebaseAuth.instance.currentUser?.uid ?? '',
          reason: reason,
        );
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            currentlyBlocked
                ? (isArabic
                    ? 'تم إلغاء حظر الأخصائي'
                    : 'Clinician unblocked successfully')
                : (isArabic
                    ? 'تم حظر الأخصائي'
                    : 'Clinician blocked successfully'),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تعذر تحديث حالة الحظر: $e'
                : 'Unable to update block state: $e',
          ),
        ),
      );
    }
  }

  String _statusLabel(String status, bool isArabic) {
    switch (status) {
      case 'approved':
        return isArabic ? 'مقبول' : 'Approved';
      case 'rejected':
        return isArabic ? 'مرفوض' : 'Rejected';
      default:
        return isArabic ? 'بانتظار الإدارة' : 'Pending review';
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'approved':
        return AppColors.success;
      case 'rejected':
        return AppColors.danger;
      default:
        return AppColors.accentLavender;
    }
  }

  String _dateText(dynamic value) {
    if (value is Timestamp) {
      return value.toDate().toLocal().toString().split('.').first;
    }
    return (value ?? '').toString().trim();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(
          context,
          title:
              isArabic ? 'طلبات تسجيل الأخصائيين' : 'Clinician registrations',
          canLogout: false,
        ),
        body: AppPageBackground(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('clinicians')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return AppEmptyState(
                  message: isArabic
                      ? 'تعذر تحميل طلبات الأخصائيين'
                      : 'Unable to load clinician requests',
                  icon: Icons.error_outline,
                );
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final allDocs = snapshot.data!.docs;
              final pendingCount = allDocs.where((doc) {
                final data = doc.data();
                final isBlocked = (data['isBlocked'] ?? false) == true;
                if (isBlocked) return false;
                final status =
                    (data['approvalStatus'] ?? 'pending_review').toString();
                return status == 'pending_review';
              }).length;
              final approvedCount = allDocs.where((doc) {
                final data = doc.data();
                final isBlocked = (data['isBlocked'] ?? false) == true;
                if (isBlocked) return false;
                final status =
                    (data['approvalStatus'] ?? 'pending_review').toString();
                return status == 'approved';
              }).length;
              final rejectedCount = allDocs.where((doc) {
                final data = doc.data();
                final isBlocked = (data['isBlocked'] ?? false) == true;
                if (isBlocked) return false;
                final status =
                    (data['approvalStatus'] ?? 'pending_review').toString();
                return status == 'rejected';
              }).length;
              final blockedCount = allDocs.where((doc) {
                final data = doc.data();
                return (data['isBlocked'] ?? false) == true;
              }).length;

              final docs = allDocs.where((doc) {
                final data = doc.data();
                final isBlocked = (data['isBlocked'] ?? false) == true;
                if (_tab == 'blocked') return isBlocked;
                if (isBlocked) return false;
                final status =
                    (data['approvalStatus'] ?? 'pending_review').toString();

                if (_tab == 'pending') return status == 'pending_review';
                if (_tab == 'approved') return status == 'approved';
                return status == 'rejected';
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
                          selected: _tab == 'pending',
                          label: Text(
                            isArabic
                                ? 'بانتظار الإدارة ($pendingCount)'
                                : 'Pending ($pendingCount)',
                          ),
                          onSelected: (_) => setState(() => _tab = 'pending'),
                        ),
                        ChoiceChip(
                          selected: _tab == 'approved',
                          label: Text(
                            isArabic
                                ? 'مقبولون ($approvedCount)'
                                : 'Approved ($approvedCount)',
                          ),
                          onSelected: (_) => setState(() => _tab = 'approved'),
                        ),
                        ChoiceChip(
                          selected: _tab == 'rejected',
                          label: Text(
                            isArabic
                                ? 'مرفوضون ($rejectedCount)'
                                : 'Rejected ($rejectedCount)',
                          ),
                          onSelected: (_) => setState(() => _tab = 'rejected'),
                        ),
                        ChoiceChip(
                          selected: _tab == 'blocked',
                          label: Text(
                            isArabic
                                ? 'محظورون ($blockedCount)'
                                : 'Blocked ($blockedCount)',
                          ),
                          onSelected: (_) => setState(() => _tab = 'blocked'),
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
                      final id = doc.id;
                      final name = (data['displayName'] ?? '').toString();
                      final email = (data['email'] ?? '').toString();
                      final specialty = (data['specialty'] ?? '').toString();
                      final status =
                          (data['approvalStatus'] ?? 'pending_review')
                              .toString();
                      final titleAr =
                          (data['professionalTitleLabelAr'] ?? '').toString();
                      final groupSessions =
                          (data['offersGroupSessions'] ?? false) == true;
                      final isBlocked = (data['isBlocked'] ?? false) == true;
                      final blockReason =
                          (data['blockReason'] ?? '').toString().trim();
                      final blockedAt = _dateText(data['blockedAt']);
                      final identityFile =
                          (data['identityFileName'] ?? '').toString();
                      final certificateFile =
                          (data['certificateFileName'] ?? '').toString();

                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: AppSurfaceCard(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          child: Column(
                            crossAxisAlignment: isArabic
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Row(
                                textDirection: isArabic
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: isArabic
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          [titleAr, name]
                                              .where((e) => e.trim().isNotEmpty)
                                              .join(' '),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                          textAlign: isArabic
                                              ? TextAlign.right
                                              : TextAlign.left,
                                        ),
                                        const SizedBox(height: AppSpacing.xs),
                                        Text(
                                          email.isEmpty
                                              ? (isArabic
                                                  ? 'بدون بريد'
                                                  : 'No email')
                                              : email,
                                          textAlign: isArabic
                                              ? TextAlign.right
                                              : TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  AppStatusBadge(
                                    label: _statusLabel(status, isArabic),
                                    color: _statusColor(status),
                                  ),
                                  if (isBlocked) ...[
                                    const SizedBox(width: AppSpacing.xs),
                                    AppStatusBadge(
                                      label: isArabic ? 'محظور' : 'Blocked',
                                      color: AppColors.danger,
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                isArabic
                                    ? 'التخصص: $specialty'
                                    : 'Specialty: $specialty',
                              ),
                              const SizedBox(height: AppSpacing.xxs),
                              Text(
                                isArabic
                                    ? 'جروبات جماعية: ${groupSessions ? "نعم" : "لا"}'
                                    : 'Group sessions: ${groupSessions ? "Yes" : "No"}',
                              ),
                              const SizedBox(height: AppSpacing.xxs),
                              Text(
                                isArabic
                                    ? 'ملف الهوية: ${identityFile.isEmpty ? "غير مرفوع" : identityFile}'
                                    : 'Identity file: ${identityFile.isEmpty ? "Not uploaded" : identityFile}',
                              ),
                              const SizedBox(height: AppSpacing.xxs),
                              Text(
                                isArabic
                                    ? 'ملف الشهادة: ${certificateFile.isEmpty ? "غير مرفوع" : certificateFile}'
                                    : 'Certificate file: ${certificateFile.isEmpty ? "Not uploaded" : certificateFile}',
                              ),
                              if (isBlocked) ...[
                                const SizedBox(height: AppSpacing.xxs),
                                Text(
                                  isArabic
                                      ? 'سبب الحظر: ${blockReason.isEmpty ? "غير محدد" : blockReason}'
                                      : 'Block reason: ${blockReason.isEmpty ? "Not provided" : blockReason}',
                                ),
                                if (blockedAt.isNotEmpty) ...[
                                  const SizedBox(height: AppSpacing.xxs),
                                  Text(
                                    isArabic
                                        ? 'تاريخ الحظر: $blockedAt'
                                        : 'Blocked at: $blockedAt',
                                  ),
                                ],
                              ],
                              const SizedBox(height: AppSpacing.md),
                              Wrap(
                                spacing: AppSpacing.sm,
                                runSpacing: AppSpacing.sm,
                                alignment: WrapAlignment.end,
                                children: [
                                  if (status != 'approved')
                                    FilledButton.icon(
                                      onPressed: () => _approve(id),
                                      icon: const Icon(
                                          Icons.check_circle_outline),
                                      label:
                                          Text(isArabic ? 'قبول' : 'Approve'),
                                    ),
                                  if (status != 'rejected')
                                    OutlinedButton.icon(
                                      onPressed: () => _reject(id),
                                      icon: const Icon(Icons.cancel_outlined),
                                      label: Text(isArabic ? 'رفض' : 'Reject'),
                                      style: appDestructiveButtonStyle(),
                                    ),
                                  if (status != 'pending_review')
                                    TextButton.icon(
                                      onPressed: () => _returnToPending(id),
                                      icon: const Icon(Icons.refresh),
                                      label: Text(
                                        isArabic
                                            ? 'إرجاع للبندنج'
                                            : 'Return to pending',
                                      ),
                                    ),
                                  OutlinedButton.icon(
                                    onPressed: () => _toggleBlock(
                                      context: context,
                                      clinicianId: id,
                                      currentlyBlocked: isBlocked,
                                    ),
                                    icon: Icon(
                                      isBlocked
                                          ? Icons.lock_open_outlined
                                          : Icons.block_outlined,
                                    ),
                                    label: Text(
                                      isBlocked
                                          ? (isArabic
                                              ? 'إلغاء الحظر'
                                              : 'Unblock')
                                          : (isArabic ? 'حظر' : 'Block'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
