import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/core/auth/account_access_service.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

// ADMIN_SURFACE: SAFE_UI
class AdminClientsPage extends StatefulWidget {
  const AdminClientsPage({super.key});

  @override
  State<AdminClientsPage> createState() => _AdminClientsPageState();
}

class _AdminClientsPageState extends State<AdminClientsPage> {
  final _blockingService = AccountBlockingService();
  final _searchController = TextEditingController();

  String _tab = 'all';
  String _search = '';
  String _approvalFilter = 'all';
  String _sort = 'newest';

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  String _dateText(dynamic value) {
    if (value is Timestamp) {
      return value.toDate().toLocal().toString().split('.').first;
    }
    return (value ?? '').toString().trim();
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
                  ? 'اكتب سبب حظر العميل'
                  : 'Enter the reason for blocking this client',
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
    required String clientId,
    required bool currentlyBlocked,
  }) async {
    final isArabic = _isArabic(context);
    try {
      if (currentlyBlocked) {
        await _blockingService.unblockAccount(
          collection: 'clients',
          docId: clientId,
        );
      } else {
        final reason = await _askBlockReason(context);
        if (reason == null || reason.trim().isEmpty) return;
        await _blockingService.blockAccount(
          collection: 'clients',
          docId: clientId,
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
                    ? 'تم إلغاء حظر العميل'
                    : 'Client unblocked successfully')
                : (isArabic ? 'تم حظر العميل' : 'Client blocked successfully'),
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

  bool _matchesSearch(Map<String, dynamic> data) {
    final q = _search.trim().toLowerCase();
    if (q.isEmpty) return true;
    final values = [
      (data['displayName'] ?? '').toString().trim().toLowerCase(),
      (data['name'] ?? '').toString().trim().toLowerCase(),
      (data['fullName'] ?? '').toString().trim().toLowerCase(),
      (data['email'] ?? '').toString().trim().toLowerCase(),
      (data['phone'] ?? '').toString().trim().toLowerCase(),
      (data['phoneNumber'] ?? '').toString().trim().toLowerCase(),
    ];
    return values.any((value) => value.contains(q));
  }

  bool _matchesApprovalFilter(Map<String, dynamic> data) {
    if (_approvalFilter == 'all') return true;
    return (data['approvalStatus'] ?? '').toString() == _approvalFilter;
  }

  DateTime _moment(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value) ?? DateTime(1970);
    return DateTime(1970);
  }

  @override
  void dispose() {
    _searchController.dispose();
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
          title: isArabic ? 'إدارة العملاء' : 'Clients Management',
          canLogout: false,
        ),
        body: AppPageBackground(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('clients')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return AppEmptyState(
                  message: isArabic
                      ? 'تعذر تحميل بيانات العملاء'
                      : 'Unable to load clients',
                  icon: Icons.error_outline,
                );
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final allDocs = snapshot.data!.docs.toList()
                ..sort((a, b) {
                  final aCreated = _moment(a.data()['createdAt']);
                  final bCreated = _moment(b.data()['createdAt']);
                  return _sort == 'oldest'
                      ? aCreated.compareTo(bCreated)
                      : bCreated.compareTo(aCreated);
                });
              final blockedCount = allDocs.where((doc) {
                final data = doc.data();
                return (data['isBlocked'] ?? false) == true;
              }).length;
              final activeCount = allDocs.length - blockedCount;

              final docs = allDocs.where((doc) {
                final data = doc.data();
                final isBlocked = (data['isBlocked'] ?? false) == true;
                if (!_matchesSearch(data)) return false;
                if (!_matchesApprovalFilter(data)) return false;
                if (_tab == 'blocked') return isBlocked;
                if (_tab == 'active') return !isBlocked;
                return true;
              }).toList();

              return ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  AppSurfaceCard(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: isArabic
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _searchController,
                          onChanged: (value) => setState(() => _search = value),
                          textDirection:
                              isArabic ? TextDirection.rtl : TextDirection.ltr,
                          decoration: appInputDecoration(
                            context: context,
                            label: isArabic
                                ? 'بحث بالاسم أو البريد'
                                : 'Search by name, email, or phone',
                            icon: Icons.search,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.sm,
                          alignment: WrapAlignment.end,
                          children: [
                            ChoiceChip(
                              selected: _tab == 'all',
                              label: Text(
                                isArabic
                                    ? 'الكل (${allDocs.length})'
                                    : 'All (${allDocs.length})',
                              ),
                              onSelected: (_) => setState(() => _tab = 'all'),
                            ),
                            ChoiceChip(
                              selected: _tab == 'active',
                              label: Text(
                                isArabic
                                    ? 'نشطون ($activeCount)'
                                    : 'Active ($activeCount)',
                              ),
                              onSelected: (_) =>
                                  setState(() => _tab = 'active'),
                            ),
                            ChoiceChip(
                              selected: _tab == 'blocked',
                              label: Text(
                                isArabic
                                    ? 'محظورون ($blockedCount)'
                                    : 'Blocked ($blockedCount)',
                              ),
                              onSelected: (_) =>
                                  setState(() => _tab = 'blocked'),
                            ),
                            DropdownButton<String>(
                              value: _approvalFilter,
                              items: [
                                DropdownMenuItem(
                                  value: 'all',
                                  child: Text(
                                    isArabic
                                        ? 'كل حالات الاعتماد'
                                        : 'All approval statuses',
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'pending_review',
                                  child: Text(
                                    isArabic ? 'قيد المراجعة' : 'Pending',
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'approved',
                                  child: Text(
                                    isArabic ? 'مقبول' : 'Approved',
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'rejected',
                                  child: Text(
                                    isArabic ? 'مرفوض' : 'Rejected',
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                if (value == null) return;
                                setState(() => _approvalFilter = value);
                              },
                            ),
                            DropdownButton<String>(
                              value: _sort,
                              items: [
                                DropdownMenuItem(
                                  value: 'newest',
                                  child: Text(
                                    isArabic ? 'الأحدث' : 'Newest',
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'oldest',
                                  child: Text(
                                    isArabic ? 'الأقدم' : 'Oldest',
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                if (value == null) return;
                                setState(() => _sort = value);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (docs.isEmpty)
                    AppEmptyState(
                      message: isArabic
                          ? 'لا يوجد عملاء مطابقون لهذا الفلتر'
                          : 'No clients match this filter',
                    )
                  else
                    ...docs.map((doc) {
                      final data = doc.data();
                      final name = (data['displayName'] ??
                              data['name'] ??
                              data['fullName'] ??
                              'Client')
                          .toString();
                      final email = (data['email'] ?? '').toString();
                      final isBlocked = (data['isBlocked'] ?? false) == true;
                      final blockReason =
                          (data['blockReason'] ?? '').toString().trim();
                      final blockedAt = _dateText(data['blockedAt']);

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
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: isArabic
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
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
                                  AppStatusBadge(
                                    label: isBlocked
                                        ? (isArabic ? 'محظور' : 'Blocked')
                                        : (isArabic ? 'نشط' : 'Active'),
                                    color: isBlocked
                                        ? AppColors.danger
                                        : AppColors.success,
                                  ),
                                ],
                              ),
                              if (isBlocked) ...[
                                const SizedBox(height: AppSpacing.sm),
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
                              Align(
                                alignment: isArabic
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: OutlinedButton.icon(
                                  onPressed: () => _toggleBlock(
                                    context: context,
                                    clientId: doc.id,
                                    currentlyBlocked: isBlocked,
                                  ),
                                  icon: Icon(
                                    isBlocked
                                        ? Icons.lock_open_outlined
                                        : Icons.block_outlined,
                                  ),
                                  label: Text(
                                    isBlocked
                                        ? (isArabic ? 'إلغاء الحظر' : 'Unblock')
                                        : (isArabic ? 'حظر' : 'Block'),
                                  ),
                                ),
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
