import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/contracts/role_names.dart';
import 'package:flutterprojects/shared/ui_kit/asset_fallback_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

class ClientDashboardPage extends StatelessWidget {
  const ClientDashboardPage({super.key});

  Stream<Map<String, dynamic>?> _clientStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.value(null);
    }

    final uid = user.uid;
    final email = (user.email ?? '').trim();

    return FirebaseFirestore.instance
        .collection('clients')
        .doc(uid)
        .snapshots()
        .asyncMap((doc) async {
      if (doc.exists && doc.data() != null) {
        return {
          'source': 'doc',
          ...doc.data()!,
        };
      }

      if (email.isNotEmpty) {
        final emailSnapshot = await FirebaseFirestore.instance
            .collection('clients')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();

        if (emailSnapshot.docs.isNotEmpty) {
          return {
            'source': 'email',
            ...emailSnapshot.docs.first.data(),
          };
        }
      }

      return null;
    });
  }

  Stream<int> _requestsCountStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Stream.value(0);

    final uid = user.uid;

    return FirebaseFirestore.instance
        .collection('booking_requests')
        .where('clientId', isEqualTo: uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.length)
        .handleError((_) => 0);
  }

  Stream<int> _messagesCountStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Stream.value(0);

    final uid = user.uid;

    return FirebaseFirestore.instance
        .collection('chat_threads')
        .where('ownerUid', isEqualTo: uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.where((doc) {
              final data = doc.data();
              return (data['needsHumanSupport'] ?? false) == true ||
                  (data['handoffState'] ?? '').toString() == 'admin_review' ||
                  (data['handoffState'] ?? '').toString() == 'admin_replying';
            }).length)
        .handleError((_) => 0);
  }

  Stream<Map<String, double>> _ratingsAboutClientStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.value({
        'count': 0,
        'avgStars': 0,
        'avgPercentage': 0,
      });
    }

    final uid = user.uid;

    return FirebaseFirestore.instance
        .collection('sessionRatings')
        .where('clientId', isEqualTo: uid)
        .where('reviewerType', isEqualTo: 'clinician')
        .snapshots()
        .map((snapshot) {
      final docs = snapshot.docs;
      final count = docs.length;

      double totalStars = 0;
      double totalPercentage = 0;

      for (final doc in docs) {
        final data = doc.data();
        totalStars += ((data['derivedStars'] ?? 0) as num).toDouble();
        totalPercentage += ((data['percentageScore'] ?? 0) as num).toDouble();
      }

      final avgStars = count == 0 ? 0.0 : totalStars / count;
      final avgPercentage = count == 0 ? 0.0 : totalPercentage / count;

      return {
        'count': count.toDouble(),
        'avgStars': avgStars,
        'avgPercentage': avgPercentage,
      };
    }).handleError((_) {
      return {
        'count': 0,
        'avgStars': 0,
        'avgPercentage': 0,
      };
    });
  }

  String _fallbackDisplayName() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return 'Client';

    final displayName = (user.displayName ?? '').trim();
    if (displayName.isNotEmpty) return displayName;

    final email = (user.email ?? '').trim();
    if (email.isNotEmpty) {
      return email.split('@').first;
    }

    return 'Client';
  }

  String _initials(String name) {
    final parts = name.trim().split(' ').where((e) => e.isNotEmpty).toList();
    if (parts.isEmpty) return 'C';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  String _readName(Map<String, dynamic>? data) {
    if (data == null) return _fallbackDisplayName();

    final candidates = [
      (data['displayName'] ?? '').toString().trim(),
      (data['name'] ?? '').toString().trim(),
      (data['fullName'] ?? '').toString().trim(),
    ];

    for (final value in candidates) {
      if (value.isNotEmpty) return value;
    }

    return _fallbackDisplayName();
  }

  String _readEmail(Map<String, dynamic>? data) {
    final userEmail = (FirebaseAuth.instance.currentUser?.email ?? '').trim();
    if (data == null) return userEmail;

    final fromDoc = (data['email'] ?? '').toString().trim();
    if (fromDoc.isNotEmpty) return fromDoc;

    return userEmail;
  }

  bool _readIsActive(Map<String, dynamic>? data) {
    if (data == null) return true;
    return (data['isActive'] ?? true) == true;
  }

  String _readStatusLabel(bool isArabic, Map<String, dynamic>? data) {
    final isActive = _readIsActive(data);
    if (isActive) {
      return isArabic ? 'الحساب نشط' : 'Account active';
    }
    return isArabic ? 'الحساب قيد المراجعة' : 'Account under review';
  }

  String _readAccountType(bool isArabic, Map<String, dynamic>? data) {
    final role =
        (data?['role'] ?? RoleNames.client).toString().trim().toLowerCase();
    if (role == RoleNames.client) {
      return isArabic ? 'عميل' : 'Client';
    }
    return role;
  }

  String _readPhone(Map<String, dynamic>? data) {
    if (data == null) return '';
    return (data['phone'] ?? data['phoneNumber'] ?? '').toString().trim();
  }

  String _readAvatarAsset(Map<String, dynamic>? data) {
    if (data == null) return '';
    final value = (data['avatarAsset'] ?? '').toString().trim();
    if (value.startsWith('assets/assets/')) {
      return value.replaceFirst('assets/assets/', 'assets/');
    }
    return value;
  }

  String _readCity(Map<String, dynamic>? data) {
    if (data == null) return '';
    return (data['city'] ?? '').toString().trim();
  }

  String _readNotes(Map<String, dynamic>? data, bool isArabic) {
    if (data == null) {
      return isArabic
          ? 'لا توجد تفاصيل إضافية محفوظة حاليًا.'
          : 'No additional saved details yet.';
    }

    final notes =
        (data['notes'] ?? data['bio'] ?? data['about'] ?? '').toString().trim();

    if (notes.isNotEmpty) return notes;

    return isArabic
        ? 'لا توجد تفاصيل إضافية محفوظة حاليًا.'
        : 'No additional saved details yet.';
  }

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(
          context,
          title: isArabic ? 'صفحتي الشخصية' : 'My Dashboard',
        ),
        body: AppPageBackground(
          child: StreamBuilder<Map<String, dynamic>?>(
            stream: _clientStream(),
            builder: (context, snapshot) {
              final data = snapshot.data;
              final name = _readName(data);
              final email = _readEmail(data);
              final phone = _readPhone(data);
              final avatarAsset = _readAvatarAsset(data);
              final city = _readCity(data);
              final statusLabel = _readStatusLabel(isArabic, data);
              final accountType = _readAccountType(isArabic, data);
              final notes = _readNotes(data, isArabic);
              final isActive = _readIsActive(data);
              debugPrint('CLIENT_DASHBOARD avatarAsset=$avatarAsset');
              debugPrint('CLIENT_DASHBOARD name=$name');
              debugPrint('CLIENT_DASHBOARD data=$data');

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
                          radius: 32,
                          backgroundColor:
                              AppColors.deepTeal.withValues(alpha: 0.12),
                          child: avatarAsset.isNotEmpty
                              ? ClipOval(
                                  child: Image.asset(
                                    normalizeAssetPath(avatarAsset),
                                    width: 64,
                                    height: 64,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const AppMissingAssetPlaceholder(
                                      width: 64,
                                      height: 64,
                                    ),
                                  ),
                                )
                              : Text(
                                  _initials(name),
                                  style: TextStyle(
                                    color: AppColors.deepTeal,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                        ),
                        const SizedBox(width: 14),
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
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w800),
                                textAlign:
                                    isArabic ? TextAlign.right : TextAlign.left,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                email.isEmpty
                                    ? (isArabic ? 'بدون بريد مسجل' : 'No email')
                                    : email,
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign:
                                    isArabic ? TextAlign.right : TextAlign.left,
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: AppSpacing.xs,
                                runSpacing: AppSpacing.xs,
                                children: [
                                  AppStatusBadge(
                                    label: accountType,
                                    color: AppColors.accentLavender,
                                  ),
                                  AppStatusBadge(
                                    label: statusLabel,
                                    color: isActive
                                        ? AppColors.success
                                        : const Color(0xFFE39A3B),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  StreamBuilder<int>(
                    stream: _requestsCountStream(),
                    builder: (context, snap) {
                      final count = snap.data ?? 0;
                      return _SectionCard(
                        title: isArabic ? 'طلباتي' : 'My Requests',
                        subtitle: isArabic
                            ? 'عدد طلبات الحجز الحالية: $count'
                            : 'Current booking requests count: $count',
                        icon: Icons.list_alt_outlined,
                        actionLabel: isArabic ? 'فتح الطلبات' : 'Open requests',
                        onTap: () =>
                            Navigator.of(context).pushNamed(Routes.myBookings),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  StreamBuilder<int>(
                    stream: _messagesCountStream(),
                    builder: (context, snap) {
                      final count = snap.data ?? 0;
                      return _SectionCard(
                        title: isArabic
                            ? 'الرسائل مع الإدارة'
                            : 'Messages with Admin',
                        subtitle: isArabic
                            ? 'عدد محادثات الإدارة المفتوحة: $count'
                            : 'Open admin conversations count: $count',
                        icon: Icons.chat_bubble_outline_rounded,
                        actionLabel: isArabic ? 'فتح الرسائل' : 'Open chat',
                        onTap: () => Navigator.of(context).pushNamed(
                          Routes.chat,
                          arguments: const {'mode': 'admin_support'},
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _SectionCard(
                    title: isArabic ? 'إثبات التحويل المالي' : 'Payment Proof',
                    subtitle: isArabic
                        ? 'رفع صورة أو ملف إثبات التحويل للإدارة'
                        : 'Upload payment transfer proof to admin',
                    icon: Icons.receipt_long_outlined,
                    actionLabel: isArabic ? 'رفع الإثبات' : 'Upload proof',
                    onTap: () => Navigator.of(context)
                        .pushNamed(Routes.clientPaymentProof),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _SectionCard(
                    title: isArabic ? 'جلساتي' : 'My Sessions',
                    subtitle: isArabic
                        ? 'عرض بيانات الجلسات والروابط والأكواد'
                        : 'View session details, links, and codes',
                    icon: Icons.video_camera_front_outlined,
                    actionLabel: isArabic ? 'فتح الجلسات' : 'Open sessions',
                    onTap: () =>
                        Navigator.of(context).pushNamed(Routes.clientSessions),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  StreamBuilder<Map<String, double>>(
                    stream: _ratingsAboutClientStream(),
                    builder: (context, snap) {
                      final data = snap.data ??
                          {
                            'count': 0,
                            'avgStars': 0,
                            'avgPercentage': 0,
                          };

                      final count = (data['count'] ?? 0).toInt();
                      final avgStars = (data['avgStars'] ?? 0).toDouble();
                      final avgPercentage =
                          (data['avgPercentage'] ?? 0).toDouble();

                      return AppSurfaceCard(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: isArabic
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              isArabic
                                  ? 'التقييمات عن العميل'
                                  : 'Ratings about client',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w800),
                              textAlign:
                                  isArabic ? TextAlign.right : TextAlign.left,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: _MiniMetricCard(
                                    title: isArabic
                                        ? 'عدد التقييمات'
                                        : 'Ratings count',
                                    value: '$count',
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Expanded(
                                  child: _MiniMetricCard(
                                    title: isArabic
                                        ? 'متوسط النجوم'
                                        : 'Average stars',
                                    value: avgStars.toStringAsFixed(1),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            _MiniMetricCard(
                              title: isArabic
                                  ? 'المتوسط العام'
                                  : 'Overall average',
                              value: '${avgPercentage.toStringAsFixed(1)}%',
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _InfoBlock(
                    title: isArabic ? 'بيانات الحساب' : 'Account Details',
                    body: [
                      if (email.isNotEmpty)
                        (isArabic ? 'البريد: ' : 'Email: ') + email,
                      if (phone.isNotEmpty)
                        (isArabic ? 'الهاتف: ' : 'Phone: ') + phone,
                      if (city.isNotEmpty)
                        (isArabic ? 'المدينة: ' : 'City: ') + city,
                      (isArabic ? 'الحالة: ' : 'Status: ') + statusLabel,
                    ].join('\n'),
                    icon: Icons.person_outline_rounded,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _InfoBlock(
                    title: isArabic ? 'ملاحظات الحساب' : 'Account Notes',
                    body: notes,
                    icon: Icons.notes_outlined,
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

class _SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String actionLabel;
  final VoidCallback onTap;

  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.actionLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.deepTeal.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.deepTeal),
          ),
          const SizedBox(width: AppSpacing.sm),
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
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          FilledButton(
            onPressed: onTap,
            child: Text(actionLabel),
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
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.deepTeal.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.deepTeal, size: 22),
          ),
          const SizedBox(width: AppSpacing.sm),
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

class _MiniMetricCard extends StatelessWidget {
  final String title;
  final String value;

  const _MiniMetricCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AppSectionPanel(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: const Color(0xFFF8F5FB),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurface.withValues(alpha: 0.68),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}
