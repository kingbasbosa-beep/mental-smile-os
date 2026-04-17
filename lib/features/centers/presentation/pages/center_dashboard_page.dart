import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/asset_fallback_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

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
        return isArabic
            ? 'رعاية ذوي الاحتياجات الخاصة'
            : 'Special Needs Care';
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
                                    label: _centerTypeLabel(centerType, isArabic),
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
                  _SectionCard(
                    title: isArabic ? 'وارد الطلبات' : 'Center Inbox',
                    subtitle: isArabic
                        ? 'الطلبات التي أحالتها الإدارة إلى المركز للرد على التوفر'
                        : 'Requests routed by admin for availability response',
                    icon: Icons.inbox_outlined,
                    accent: const Color(0xFFB8860B),
                    badgeLabel: isArabic ? 'بوابة الرد' : 'Response Gate',
                    assetPath: 'c7_branding/logo/logo_mark.png',
                    actionLabel: isArabic ? 'فتح الوارد' : 'Open inbox',
                    onTap: () =>
                        Navigator.of(context).pushNamed(Routes.centerInbox),
                  ),
                  const SizedBox(height: 12),
                  _SectionCard(
                    title: isArabic ? 'الإقامات والمتابعة' : 'Residencies',
                    subtitle: isArabic
                        ? 'متابعة الإقامات المجدولة والجارية وتقارير الخروج'
                        : 'Track scheduled stays, active residencies, and discharge reports',
                    icon: Icons.hotel_outlined,
                    accent: const Color(0xFF2F6B5F),
                    badgeLabel: isArabic ? 'إقامة' : 'Residency',
                    assetPath: 'c7_branding/home/hero_art.png',
                    actionLabel:
                        isArabic ? 'فتح الإقامات' : 'Open residencies',
                    onTap: () => Navigator.of(context)
                        .pushNamed(Routes.centerResidencies),
                  ),
                  const SizedBox(height: 12),
                  _SectionCard(
                    title: isArabic ? 'غرفة العمليات' : 'Operations Room',
                    subtitle: isArabic
                        ? 'متابعة الطلبات والرسائل ورفع الصور والوثائق'
                        : 'Track requests, messages, images, and documents',
                    icon: Icons.dashboard_customize_outlined,
                    accent: const Color(0xFF7A4E2D),
                    badgeLabel: isArabic ? 'تشغيل' : 'Operations',
                    assetPath: 'c7_branding/home/home_bg.png',
                    actionLabel: isArabic ? 'فتح الغرفة' : 'Open room',
                    onTap: () => Navigator.of(context)
                        .pushNamed(Routes.centerOperations),
                  ),
                  const SizedBox(height: 12),
                  _SectionCard(
                    title: isArabic ? 'الشات مع الإدارة' : 'Chat with Admin',
                    subtitle: isArabic
                        ? 'قناة مباشرة وآمنة للتواصل مع الإدارة والمتابعة'
                        : 'A direct and safe channel to communicate with admin',
                    icon: Icons.chat_bubble_outline_rounded,
                    accent: const Color(0xFF496D7C),
                    badgeLabel: isArabic ? 'دعم إداري' : 'Admin Support',
                    assetPath: 'c7_branding/logo/logo_mark.png',
                    actionLabel: isArabic ? 'فتح الشات' : 'Open chat',
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.chat,
                      arguments: const {'mode': 'admin_support'},
                    ),
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

class _SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final String badgeLabel;
  final String assetPath;
  final String actionLabel;
  final VoidCallback onTap;

  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.badgeLabel,
    required this.assetPath,
    required this.actionLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            accent.withValues(alpha: 0.18),
            accent.withValues(alpha: 0.06),
            scheme.surface,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: accent.withValues(alpha: 0.25),
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -8,
            right: isArabic ? null : -10,
            left: isArabic ? -10 : null,
            child: Opacity(
              opacity: 0.10,
              child: Image.asset(
                normalizeAssetPath(assetPath),
                width: 128,
                height: 128,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const AppMissingAssetPlaceholder(width: 128, height: 128),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: isArabic ? null : 0,
            right: isArabic ? 0 : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: accent.withValues(alpha: 0.24)),
              ),
              child: Text(
                badgeLabel,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: accent,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                  border: Border.all(color: accent.withValues(alpha: 0.24)),
                ),
                child: Icon(icon, color: accent, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    crossAxisAlignment: isArabic
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFF3F2B17),
                                ),
                        textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF5B5348),
                              height: 1.45,
                            ),
                        textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      ),
                      const SizedBox(height: 14),
                      Align(
                        alignment: isArabic
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: FilledButton.icon(
                          onPressed: onTap,
                          style: FilledButton.styleFrom(
                            backgroundColor: accent,
                            foregroundColor: Colors.white,
                          ),
                          icon: const Icon(Icons.arrow_forward_outlined),
                          label: Text(actionLabel),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
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

