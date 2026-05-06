import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
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
  String _sectionTab = 'clinicians';
  String _tab = 'pending';
  String _search = '';
  String _approvalFilter = 'all';
  String _activityFilter = 'all';
  String _sort = 'newest';
  final _searchController = TextEditingController();
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

  DateTime _moment(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value) ?? DateTime(1970);
    return DateTime(1970);
  }

  bool _matchesSearch(Map<String, dynamic> data) {
    final q = _search.trim().toLowerCase();
    if (q.isEmpty) return true;
    final values = [
      data['displayName'],
      data['fullDisplayNameAr'],
      data['fullDisplayNameEn'],
      data['email'],
      data['phone'],
      data['phoneNumber'],
      data['specialty'],
    ].map((value) => (value ?? '').toString().toLowerCase());
    return values.any((value) => value.contains(q));
  }

  bool _matchesApprovalFilter(Map<String, dynamic> data) {
    if (_approvalFilter == 'all') return true;
    final status = (data['approvalStatus'] ?? 'pending_review').toString();
    return status == _approvalFilter;
  }

  bool _matchesActivityFilter(Map<String, dynamic> data) {
    final isActive = (data['isActive'] ?? false) == true;
    final isBlocked = (data['isBlocked'] ?? false) == true;
    switch (_activityFilter) {
      case 'active':
        return isActive && !isBlocked;
      case 'inactive':
        return !isActive && !isBlocked;
      case 'blocked':
        return isBlocked;
      case 'unblocked':
        return !isBlocked;
      default:
        return true;
    }
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
          title: isArabic
              ? 'دليل الأخصائيين وبوابات الاعتماد'
              : 'Directory & Approval Gates',
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

              final allDocs = snapshot.data!.docs.toList()
                ..sort((a, b) {
                  final aCreated = _moment(a.data()['createdAt']);
                  final bCreated = _moment(b.data()['createdAt']);
                  return _sort == 'oldest'
                      ? aCreated.compareTo(bCreated)
                      : bCreated.compareTo(aCreated);
                });
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
                if (!_matchesSearch(data)) return false;
                if (!_matchesApprovalFilter(data)) return false;
                if (!_matchesActivityFilter(data)) return false;
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
                          selected: _sectionTab == 'clinicians',
                          label: const Text('الأخصائيين'),
                          onSelected: (_) =>
                              setState(() => _sectionTab = 'clinicians'),
                        ),
                        ChoiceChip(
                          selected: _sectionTab == 'centers',
                          label: const Text('المراكز'),
                          onSelected: (_) =>
                              setState(() => _sectionTab = 'centers'),
                        ),
                        ChoiceChip(
                          selected: _sectionTab == 'clients',
                          label: const Text('العملاء'),
                          onSelected: (_) =>
                              setState(() => _sectionTab = 'clients'),
                        ),
                        ChoiceChip(
                          selected: _sectionTab == 'rules',
                          label: const Text('القواعد الحاكمة'),
                          onSelected: (_) =>
                              setState(() => _sectionTab = 'rules'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (_sectionTab == 'rules') ...[
                    AppSurfaceCard(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isArabic
                              ? 'دليل الأخصائيين وبوابات الاعتماد'
                              : 'Directory & Approval Gates',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          isArabic
                              ? 'التركيز: الأخصائيون بانتظار الاعتماد. الحالات الأخرى للرجوع فقط.'
                              : 'Focus: clinicians awaiting approval. Other states are reference views.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.obsidian.withValues(alpha: 0.72),
                              ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'What it is: clinician coordination layer, session-based care layer (future), and specialist involvement boundary.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'What it does not do currently: no active booking system, no live session orchestration, no automated matching, and no active clinician assignment.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Current state: frozen, not active, not exposed to users, and not connected to other layers.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Boundaries: isolated from Content & Care, isolated from Gateway, and will require strict activation rules later.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: AppColors.info.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(AppRadii.lg),
                            border: Border.all(
                              color: AppColors.info.withValues(alpha: 0.18),
                            ),
                          ),
                          child: Text(
                            'Supervision note: medical-adjacent but not a medical system, must follow strict compliance later, and remains a safety-critical layer.',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  height: 1.35,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppSurfaceCard(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Clinician Freeze Rules',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'This compact section makes the current freeze status explicit without changing any workflow.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.obsidian.withValues(alpha: 0.72),
                              ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Currently not allowed: no active assignment, no live scheduling, no workflow expansion, and no new integration into other layers.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'What must not be assumed: this layer is not production-ready, not user-facing active care, and not an approved orchestration layer.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Before any future unfreeze: explicit readiness review, policy and compliance review, activation boundaries, and ownership clarification must exist first.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: AppColors.danger.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(AppRadii.lg),
                            border: Border.all(
                              color: AppColors.danger.withValues(alpha: 0.18),
                            ),
                          ),
                          child: Text(
                            'Supervision note: frozen by design, safety-sensitive, and any change requires deliberate approval.',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  height: 1.35,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppSurfaceCard(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Clinician Unfreeze Preconditions',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'This compact section clarifies what must be true before any future clinician-layer unfreeze is even considered.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.obsidian.withValues(alpha: 0.72),
                              ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Preconditions before any future unfreeze: readiness review completed, policy and compliance review completed, subsystem boundaries confirmed, ownership clearly assigned, and activation sequence explicitly approved.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'What unfreeze does not mean: not immediate launch, not full workflow activation, and not automatic integration into other layers.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: AppColors.success.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(AppRadii.lg),
                            border: Border.all(
                              color: AppColors.success.withValues(alpha: 0.18),
                            ),
                          ),
                          child: Text(
                            'Supervision note: unfreeze must be deliberate, staged activation only, and this safety-sensitive layer requires explicit approval.',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  height: 1.35,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppSurfaceCard(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Preview Clean Workspace',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                'Open the new parallel clinician workspace shell for controlled preview only. This does not replace or activate the frozen layer.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppColors.obsidian
                                          .withValues(alpha: 0.72),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        OutlinedButton(
                          onPressed: () => Navigator.of(context).pushNamed(
                            Routes.adminClinicianWorkspace,
                          ),
                          child: const Text('Open New Clinician Workspace'),
                        ),
                      ],
                    ),
                  ),
                  ],
                  if (_sectionTab == 'centers') ...[
                    AppSurfaceCard(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Center(
                        child: FilledButton.icon(
                          onPressed: () => Navigator.of(context).pushNamed(
                            Routes.adminCenters,
                          ),
                          icon: const Icon(Icons.apartment_outlined),
                          label: const Text('فتح اعتماد المراكز'),
                        ),
                      ),
                    ),
                  ],
                  if (_sectionTab == 'clients') ...[
                    AppSurfaceCard(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Center(
                        child: FilledButton.icon(
                          onPressed: () => Navigator.of(context).pushNamed(
                            Routes.adminClients,
                          ),
                          icon: const Icon(Icons.people_alt_outlined),
                          label: const Text('فتح متابعة العملاء'),
                        ),
                      ),
                    ),
                  ],
                  if (_sectionTab == 'clinicians') ...[
                    AppSurfaceCard(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Column(
                        children: [
                          TextField(
                            controller: _searchController,
                            onChanged: (value) =>
                                setState(() => _search = value),
                            textDirection:
                                isArabic ? TextDirection.rtl : TextDirection.ltr,
                            decoration: appInputDecoration(
                              context: context,
                              label: isArabic
                                  ? 'بحث بالاسم / البريد / الهاتف'
                                  : 'Search by name, email, or phone',
                              icon: Icons.search,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Wrap(
                            spacing: AppSpacing.sm,
                            runSpacing: AppSpacing.sm,
                            children: [
                              DropdownButton<String>(
                                value: _approvalFilter,
                                items: [
                                  DropdownMenuItem(
                                    value: 'all',
                                    child: Text(isArabic
                                        ? 'كل حالات الاعتماد'
                                        : 'All approval statuses'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'pending_review',
                                    child: Text(isArabic ? 'قيد المراجعة' : 'Pending'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'approved',
                                    child: Text(isArabic ? 'مقبول' : 'Approved'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'rejected',
                                    child: Text(isArabic ? 'مرفوض' : 'Rejected'),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value == null) return;
                                  setState(() => _approvalFilter = value);
                                },
                              ),
                              DropdownButton<String>(
                                value: _activityFilter,
                                items: [
                                  DropdownMenuItem(
                                    value: 'all',
                                    child: Text(isArabic
                                        ? 'كل حالات الحساب'
                                        : 'All account states'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'active',
                                    child: Text(isArabic ? 'نشط' : 'Active'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'inactive',
                                    child: Text(isArabic ? 'غير نشط' : 'Inactive'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'blocked',
                                    child: Text(isArabic ? 'محظور' : 'Blocked'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'unblocked',
                                    child: Text(isArabic ? 'غير محظور' : 'Unblocked'),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value == null) return;
                                  setState(() => _activityFilter = value);
                                },
                              ),
                              DropdownButton<String>(
                                value: _sort,
                                items: [
                                  DropdownMenuItem(
                                    value: 'newest',
                                    child: Text(isArabic ? 'الأحدث' : 'Newest'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'oldest',
                                    child: Text(isArabic ? 'الأقدم' : 'Oldest'),
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
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          onSelected: (_) => setState(() => _tab = 'pending'),
                        ),
                        ChoiceChip(
                          selected: _tab == 'approved',
                          label: Text(
                            isArabic
                                ? 'مقبولون ($approvedCount)'
                                : 'Approved ($approvedCount)',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.obsidian.withValues(alpha: 0.72),
                            ),
                          ),
                          onSelected: (_) => setState(() => _tab = 'approved'),
                        ),
                        ChoiceChip(
                          selected: _tab == 'rejected',
                          label: Text(
                            isArabic
                                ? 'مرفوضون ($rejectedCount)'
                                : 'Rejected ($rejectedCount)',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.obsidian.withValues(alpha: 0.72),
                            ),
                          ),
                          onSelected: (_) => setState(() => _tab = 'rejected'),
                        ),
                        ChoiceChip(
                          selected: _tab == 'blocked',
                          label: Text(
                            isArabic
                                ? 'محظورون ($blockedCount)'
                                : 'Blocked ($blockedCount)',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.obsidian.withValues(alpha: 0.72),
                            ),
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
