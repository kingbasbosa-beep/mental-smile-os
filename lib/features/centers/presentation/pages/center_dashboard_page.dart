import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class CenterDashboardPage extends StatelessWidget {
  const CenterDashboardPage({super.key});

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  Stream<Map<String, dynamic>?> _centerStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Stream.value(null);

    final uid = user.uid;
    final email = (user.email ?? '').trim();

    return FirebaseFirestore.instance
        .collection('centers')
        .doc(uid)
        .snapshots()
        .asyncMap((doc) async {
      if (doc.exists && doc.data() != null) {
        return {'_id': doc.id, ...doc.data()!};
      }

      if (email.isNotEmpty) {
        final emailSnapshot = await FirebaseFirestore.instance
            .collection('centers')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();

        if (emailSnapshot.docs.isNotEmpty) {
          return {
            '_id': emailSnapshot.docs.first.id,
            ...emailSnapshot.docs.first.data(),
          };
        }
      }

      return null;
    });
  }

  String _initials(String name) {
    final parts = name.trim().split(' ').where((e) => e.isNotEmpty).toList();
    if (parts.isEmpty) return 'C';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.login,
      (route) => false,
    );
  }

  List<Map<String, dynamic>> _readDocuments(Map<String, dynamic> data) {
    final raw = data['documentItems'];
    if (raw is List) {
      return raw
          .whereType<Map>()
          .map((e) => e.map((k, v) => MapEntry('$k', v)))
          .toList();
    }
    return const [];
  }

  List<Map<String, dynamic>> _readGallery(Map<String, dynamic> data) {
    final raw = data['galleryItems'];
    if (raw is List) {
      return raw
          .whereType<Map>()
          .map((e) => e.map((k, v) => MapEntry('$k', v)))
          .toList();
    }

    final fallback = (data['galleryImages'] as List?) ?? const [];
    return fallback
        .whereType<String>()
        .map(
          (e) => {
            'label': 'Image',
            'url': e,
            'status': 'uploaded',
          },
        )
        .toList();
  }

  String _docStatusLabel(String status, bool isArabic) {
    switch (status) {
      case 'approved':
        return isArabic ? 'مقبول' : 'Approved';
      case 'rejected':
        return isArabic ? 'مرفوض' : 'Rejected';
      case 'needs_update':
        return isArabic ? 'يحتاج تحديث' : 'Needs update';
      case 'uploaded':
      case 'pending':
      default:
        return isArabic ? 'بانتظار المراجعة' : 'Pending review';
    }
  }

  Color _docStatusColor(String status) {
    switch (status) {
      case 'approved':
        return const Color(0xFF1F9D63);
      case 'rejected':
        return const Color(0xFFD04B4B);
      case 'needs_update':
        return const Color(0xFFE39B2E);
      case 'uploaded':
      case 'pending':
      default:
        return const Color(0xFF6C55B3);
    }
  }

  String _approvalStatusLabel(String status, bool isArabic) {
    switch (status) {
      case 'approved':
        return isArabic ? 'معتمد' : 'Approved';
      case 'center_follow_up':
        return isArabic ? 'قيد المتابعة' : 'Follow-up';
      case 'rejected_admin':
      case 'rejected':
        return isArabic ? 'مرفوض' : 'Rejected';
      case 'pending_review':
      case 'pending_admin':
      default:
        return isArabic ? 'بانتظار المراجعة' : 'Pending review';
    }
  }

  Color _approvalStatusColor(String status) {
    switch (status) {
      case 'approved':
        return const Color(0xFF1F9D63);
      case 'center_follow_up':
        return const Color(0xFFE39B2E);
      case 'rejected_admin':
      case 'rejected':
        return const Color(0xFFD04B4B);
      case 'pending_review':
      case 'pending_admin':
      default:
        return const Color(0xFF6C55B3);
    }
  }

  String _centerTypeLabel(String type, bool isArabic) {
    switch (type.trim()) {
      case 'detox':
        return isArabic ? 'ديتوكس / أعراض انسحاب' : 'Detox / Withdrawal';
      case 'hospital':
        return isArabic ? 'مستشفى' : 'Hospital';
      case 'special_needs_care':
        return isArabic ? 'رعاية ذوي الاحتياجات الخاصة' : 'Special Needs Care';
      case 'halfway_house':
      default:
        return isArabic ? 'هاف واي' : 'Halfway House';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(
          context,
          title: isArabic ? 'الصفحة الشخصية للمركز' : 'Center Dashboard',
        ),
        body: AppPageBackground(
          child: StreamBuilder<Map<String, dynamic>?>(
            stream: _centerStream(),
            builder: (context, snapshot) {
              final scheme = Theme.of(context).colorScheme;
              final data = snapshot.data ?? <String, dynamic>{};

              final centerName =
                  (data['centerName'] ?? data['displayName'] ?? '')
                      .toString()
                      .trim();
              final email = (data['email'] ?? '').toString().trim();
              final phone = (data['phone'] ?? '').toString().trim();
              final city = (data['city'] ?? '').toString().trim();
              final address = (data['address'] ?? '').toString().trim();
              final description = (data['description'] ?? '').toString().trim();
              final managerName = (data['managerName'] ?? '').toString().trim();
              final centerType = (data['centerType'] ?? '').toString().trim();
              final hasDetoxUnit = ((data['hasDetoxUnit'] ?? false) == true) ||
                  centerType == 'detox';
              final approvalStatus =
                  (data['approvalStatus'] ?? 'pending_admin').toString().trim();
              final imagesReady = (data['imagesReady'] ?? false) == true;
              final documentsReady = (data['documentsReady'] ?? false) == true;

              final gallery = _readGallery(data);
              final documents = _readDocuments(data);

              final statusLabel =
                  _approvalStatusLabel(approvalStatus, isArabic);

              return ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  AppSurfaceCard(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Row(
                      textDirection:
                          isArabic ? TextDirection.rtl : TextDirection.ltr,
                      children: [
                        CircleAvatar(
                          radius: 34,
                          backgroundColor:
                              scheme.primary.withValues(alpha: 0.12),
                          child: Text(
                            _initials(
                                centerName.isEmpty ? 'Center' : centerName),
                            style: TextStyle(
                              color: scheme.primary,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: isArabic
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                centerName.isEmpty
                                    ? (isArabic ? 'مركز' : 'Center')
                                    : centerName,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w800),
                                textAlign:
                                    isArabic ? TextAlign.right : TextAlign.left,
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                email.isEmpty
                                    ? (isArabic ? 'بدون بريد' : 'No email')
                                    : email,
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Wrap(
                                spacing: AppSpacing.xs,
                                runSpacing: AppSpacing.xs,
                                children: [
                                  _MiniBadge(
                                    label: isArabic ? 'مركز' : 'Center',
                                    color: const Color(0xFF6C55B3),
                                  ),
                                  _MiniBadge(
                                    label:
                                        _centerTypeLabel(centerType, isArabic),
                                    color: const Color(0xFF2F6B5F),
                                  ),
                                  _MiniBadge(
                                    label: statusLabel,
                                    color: _approvalStatusColor(
                                      approvalStatus,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  _CenterActionCards(
                    children: [
                      _SectionCard(
                        title: isArabic ? 'طلبات جديدة' : 'New requests',
                        subtitle: isArabic
                            ? 'وارد الطلبات بانتظار رد المركز'
                            : 'Inbox requests awaiting center response',
                        icon: Icons.inbox_outlined,
                        accent: const Color(0xFFE7C766),
                        imagePath:
                            'assets/images/center_dashboard/actions/center_new_requests.png',
                        onTap: () =>
                            Navigator.of(context).pushNamed(Routes.centerInbox),
                      ),
                      _SectionCard(
                        title: isArabic ? 'طلبات نشطة' : 'Active requests',
                        subtitle: isArabic
                            ? 'متابعة الطلبات الجارية'
                            : 'Follow active center requests',
                        icon: Icons.timelapse_outlined,
                        accent: const Color(0xFF8EDBFF),
                        imagePath:
                            'assets/images/center_dashboard/actions/center_active_requests.png',
                        onTap: () =>
                            Navigator.of(context).pushNamed(Routes.centerInbox),
                      ),
                      _SectionCard(
                        title: isArabic ? 'طلبات مكتملة' : 'Completed requests',
                        subtitle: isArabic
                            ? 'مراجعة الإقامات المكتملة'
                            : 'Review completed residencies',
                        icon: Icons.verified_outlined,
                        accent: const Color(0xFF9FE6D7),
                        imagePath:
                            'assets/images/center_dashboard/actions/center_completed_requests.png',
                        onTap: () => Navigator.of(context)
                            .pushNamed(Routes.centerResidencies),
                      ),
                      _SectionCard(
                        title: isArabic
                            ? 'طلبات مرفوضة/ملغاة'
                            : 'Rejected requests',
                        subtitle: isArabic
                            ? 'متابعة الطلبات غير المكتملة'
                            : 'Review unavailable or cancelled requests',
                        icon: Icons.cancel_outlined,
                        accent: const Color(0xFFFF9A8A),
                        imagePath:
                            'assets/images/center_dashboard/actions/center_rejected_requests.png',
                        onTap: () =>
                            Navigator.of(context).pushNamed(Routes.centerInbox),
                      ),
                      _SectionCard(
                        title: isArabic ? 'جلساتي' : 'My sessions',
                        subtitle: isArabic
                            ? 'الإقامات المجدولة والجارية'
                            : 'Scheduled and active residencies',
                        icon: Icons.hotel_outlined,
                        accent: const Color(0xFF9FE6D7),
                        imagePath:
                            'assets/images/center_dashboard/actions/center_sessions.png',
                        onTap: () => Navigator.of(context)
                            .pushNamed(Routes.centerResidencies),
                      ),
                      _SectionCard(
                        title: isArabic ? 'تحديث بياناتي' : 'Update profile',
                        subtitle: isArabic
                            ? 'الصور والوثائق وبيانات المركز'
                            : 'Images, documents, and center data',
                        icon: Icons.dashboard_customize_outlined,
                        accent: const Color(0xFFFFB56B),
                        imagePath:
                            'assets/images/center_dashboard/actions/center_update_profile.png',
                        onTap: () => Navigator.of(context)
                            .pushNamed(Routes.centerOperations),
                      ),
                      _SectionCard(
                        title: isArabic
                            ? 'حالات الشات المحالة'
                            : 'Transferred chats',
                        subtitle: isArabic
                            ? 'قناة الدعم والمتابعة مع الإدارة'
                            : 'Support and admin follow-up channel',
                        icon: Icons.chat_bubble_outline_rounded,
                        accent: const Color(0xFF8EDBFF),
                        imagePath:
                            'assets/images/center_dashboard/actions/center_transferred_chats.png',
                        onTap: () => Navigator.pushNamed(
                          context,
                          Routes.supportIssueSelector,
                          arguments: const {'supportType': 'center_support'},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _CenterGalleryCard(
                    title: isArabic ? 'صور المركز' : 'Center Gallery',
                    subtitle: isArabic
                        ? 'عرض الصور الأساسية داخل إطار واحد'
                        : 'Main images in a single frame',
                    items: gallery,
                  ),
                  const SizedBox(height: 12),
                  _InfoBlock(
                    title: isArabic ? 'الوثائق' : 'Documents',
                    body: documents.isEmpty
                        ? (isArabic
                            ? 'لا توجد وثائق مرفوعة بعد.'
                            : 'No uploaded documents yet.')
                        : documents.map((doc) {
                            final type = (doc['documentType'] ?? '').toString();
                            final fileName = (doc['fileName'] ?? '').toString();
                            final status =
                                (doc['status'] ?? 'pending').toString();
                            final reviewNote =
                                (doc['reviewNote'] ?? '').toString().trim();

                            final line = [
                              if (type.isNotEmpty) type,
                              if (fileName.isNotEmpty) fileName,
                              _docStatusLabel(status, isArabic),
                              if (reviewNote.isNotEmpty)
                                (isArabic
                                    ? 'ملاحظة: $reviewNote'
                                    : 'Note: $reviewNote'),
                            ].join(' - ');

                            return line;
                          }).join('\n'),
                    icon: Icons.folder_open_outlined,
                  ),
                  const SizedBox(height: 12),
                  _InfoBlock(
                    title: isArabic ? 'بيانات المركز' : 'Center Details',
                    body: [
                      if (managerName.isNotEmpty)
                        (isArabic ? 'المسؤول: ' : 'Manager: ') + managerName,
                      if (centerType.isNotEmpty)
                        (isArabic ? 'النوع التشغيلي: ' : 'Operational type: ') +
                            _centerTypeLabel(centerType, isArabic),
                      (isArabic
                              ? 'قسم أعراض انسحاب داخلي: '
                              : 'Internal withdrawal unit: ') +
                          (hasDetoxUnit
                              ? (isArabic ? 'نعم' : 'Yes')
                              : (isArabic ? 'لا' : 'No')),
                      if (phone.isNotEmpty)
                        (isArabic ? 'الهاتف: ' : 'Phone: ') + phone,
                      if (city.isNotEmpty)
                        (isArabic ? 'المدينة: ' : 'City: ') + city,
                      if (address.isNotEmpty)
                        (isArabic ? 'العنوان: ' : 'Address: ') + address,
                    ].isEmpty
                        ? (isArabic
                            ? 'لا توجد بيانات إضافية بعد.'
                            : 'No extra details yet.')
                        : [
                            if (managerName.isNotEmpty)
                              (isArabic ? 'المسؤول: ' : 'Manager: ') +
                                  managerName,
                            if (phone.isNotEmpty)
                              (isArabic ? 'الهاتف: ' : 'Phone: ') + phone,
                            if (city.isNotEmpty)
                              (isArabic ? 'المدينة: ' : 'City: ') + city,
                            if (address.isNotEmpty)
                              (isArabic ? 'العنوان: ' : 'Address: ') + address,
                          ].join('\n'),
                    icon: Icons.business_outlined,
                  ),
                  const SizedBox(height: 12),
                  _InfoBlock(
                    title: isArabic ? 'وصف المركز' : 'Center Description',
                    body: description.isEmpty
                        ? (isArabic
                            ? 'لم يتم إضافة وصف بعد.'
                            : 'No description added yet.')
                        : description,
                    icon: Icons.notes_outlined,
                  ),
                  const SizedBox(height: 12),
                  _CenterReadinessBlock(
                    isArabic: isArabic,
                    imagesReady: imagesReady,
                    documentsReady: documentsReady,
                  ),
                  const SizedBox(height: 12),
                  if (documents.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: scheme.outline.withValues(alpha: 0.12),
                        ),
                      ),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: documents.map((doc) {
                          final status =
                              (doc['status'] ?? 'pending').toString();
                          return _MiniBadge(
                            label: _docStatusLabel(status, isArabic),
                            color: _docStatusColor(status),
                          );
                        }).toList(),
                      ),
                    ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed: () => _logout(context),
                      icon: const Icon(Icons.logout),
                      label: Text(isArabic ? 'تسجيل الخروج' : 'Logout'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CenterGalleryCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<Map<String, dynamic>> items;

  const _CenterGalleryCard({
    required this.title,
    required this.subtitle,
    required this.items,
  });

  @override
  State<_CenterGalleryCard> createState() => _CenterGalleryCardState();
}

class _CenterGalleryCardState extends State<_CenterGalleryCard> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    final hasItems = widget.items.isNotEmpty;
    final safeIndex = hasItems ? (_index.clamp(0, widget.items.length - 1)) : 0;

    final current = hasItems ? widget.items[safeIndex] : <String, dynamic>{};
    final label = (current['label'] ?? '').toString();
    final url = (current['url'] ?? '').toString();
    final status = (current['status'] ?? 'uploaded').toString();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: scheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 6),
          Text(widget.subtitle),
          const SizedBox(height: 14),
          Container(
            height: 240,
            width: double.infinity,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: scheme.outline.withValues(alpha: 0.10),
              ),
            ),
            child: hasItems
                ? Stack(
                    children: [
                      Positioned.fill(
                        child: url.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  url,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) {
                                    return _FallbackGalleryView(
                                      label: label,
                                      status: status,
                                    );
                                  },
                                ),
                              )
                            : _FallbackGalleryView(
                                label: label,
                                status: status,
                              ),
                      ),
                      Positioned(
                        right: 12,
                        top: 12,
                        child: _MiniBadge(
                          label: label.isEmpty
                              ? (isArabic ? 'صورة' : 'Image')
                              : label,
                          color: const Color(0xFF6C55B3),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        top: 12,
                        child: _MiniBadge(
                          label: status,
                          color: const Color(0xFF6F9DC7),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      isArabic
                          ? 'لا توجد صور مرفوعة بعد'
                          : 'No uploaded images yet',
                    ),
                  ),
          ),
          const SizedBox(height: 12),
          if (hasItems)
            Row(
              children: [
                IconButton(
                  onPressed: widget.items.length <= 1
                      ? null
                      : () {
                          setState(() {
                            _index = (_index - 1 + widget.items.length) %
                                widget.items.length;
                          });
                        },
                  icon: const Icon(Icons.chevron_left),
                ),
                Expanded(
                  child: Text(
                    isArabic
                        ? 'صورة ${safeIndex + 1} من ${widget.items.length}'
                        : 'Image ${safeIndex + 1} of ${widget.items.length}',
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  onPressed: widget.items.length <= 1
                      ? null
                      : () {
                          setState(() {
                            _index = (_index + 1) % widget.items.length;
                          });
                        },
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _FallbackGalleryView extends StatelessWidget {
  final String label;
  final String status;

  const _FallbackGalleryView({
    required this.label,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.photo_library_outlined, size: 46),
          const SizedBox(height: 10),
          Text(
            label.isEmpty ? (isArabic ? 'صورة مركز' : 'Center image') : label,
          ),
          const SizedBox(height: 4),
          Text(
            isArabic ? 'الحالة: $status' : 'Status: $status',
          ),
        ],
      ),
    );
  }
}

class _CenterReadinessBlock extends StatelessWidget {
  final bool isArabic;
  final bool imagesReady;
  final bool documentsReady;

  const _CenterReadinessBlock({
    required this.isArabic,
    required this.imagesReady,
    required this.documentsReady,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: scheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.verified_outlined, color: scheme.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic
                      ? 'جاهزية الصور والوثائق'
                      : 'Images & Documents Readiness',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  [
                    (isArabic ? 'الصور: ' : 'Images: ') +
                        (imagesReady
                            ? (isArabic ? 'مرفوعة' : 'Uploaded')
                            : (isArabic ? 'بانتظار الرفع' : 'Pending upload')),
                    (isArabic ? 'الوثائق: ' : 'Documents: ') +
                        (documentsReady
                            ? (isArabic ? 'مرفوعة' : 'Uploaded')
                            : (isArabic ? 'بانتظار الرفع' : 'Pending upload')),
                  ].join('\n'),
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CenterActionCards extends StatelessWidget {
  final List<Widget> children;

  const _CenterActionCards({required this.children});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        spacing: 16,
        runSpacing: 16,
        children: children,
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final String imagePath;
  final VoidCallback onTap;

  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return _CenterActionHover(
      accent: accent,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          hoverColor: accent.withValues(alpha: 0.10),
          splashColor: accent.withValues(alpha: 0.10),
          highlightColor: accent.withValues(alpha: 0.08),
          child: SizedBox(
            width: 172,
            height: 206,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.black.withValues(alpha: 0.42),
                      alignment: Alignment.center,
                      child: Icon(icon, color: accent, size: 38),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.08),
                          Colors.black.withValues(alpha: 0.16),
                          Colors.black.withValues(alpha: 0.70),
                        ],
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: accent.withValues(alpha: 0.62),
                        width: 1.1,
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    start: 12,
                    end: 12,
                    bottom: 12,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: const Color(0xFFFFE7B2),
                            fontWeight: FontWeight.w900,
                            height: 1.05,
                            shadows: const [
                              Shadow(
                                color: Colors.black,
                                blurRadius: 10,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                            color:
                                const Color(0xFFFFE7B2).withValues(alpha: 0.84),
                            fontWeight: FontWeight.w700,
                            height: 1.12,
                            shadows: const [
                              Shadow(
                                color: Colors.black,
                                blurRadius: 8,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Icon(
                          isArabic
                              ? Icons.keyboard_arrow_left_rounded
                              : Icons.keyboard_arrow_right_rounded,
                          color: accent,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CenterActionHover extends StatefulWidget {
  final Widget child;
  final Color accent;

  const _CenterActionHover({
    required this.child,
    required this.accent,
  });

  @override
  State<_CenterActionHover> createState() => _CenterActionHoverState();
}

class _CenterActionHoverState extends State<_CenterActionHover> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.035 : 1.0,
        duration: const Duration(milliseconds: 170),
        curve: Curves.easeOutCubic,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: widget.accent.withValues(
                  alpha: _hovered ? 0.30 : 0.18,
                ),
                blurRadius: _hovered ? 24 : 16,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  final String title;
  final String body;
  final IconData icon;

  const _InfoBlock({
    required this.title,
    required this.body,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: scheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: scheme.primary, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w800),
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                ),
                const SizedBox(height: 8),
                Text(
                  body,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _MiniBadge({
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}
