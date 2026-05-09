import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/contracts/role_names.dart';
import 'package:flutterprojects/shared/ui_kit/asset_fallback_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
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
        .collection('support_requests')
        .where('createdByUid', isEqualTo: uid)
        .where('supportType', isEqualTo: 'client_support')
        .snapshots()
        .map((snapshot) => snapshot.docs.where((doc) {
              final data = doc.data();
              final status = (data['status'] ?? '').toString().trim();
              return status != 'closed';
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

  String _dashboardBackgroundAsset(double width) {
    if (width < 700) {
      return 'assets/branding/client_dashboard/mobile/client_dashboard_mobile_bg.png';
    }
    if (width <= 1100) {
      return 'assets/branding/client_dashboard/tablet/client_dashboard_tablet_bg.png';
    }
    return 'assets/branding/client_dashboard/desktop/client_dashboard_desktop_bg.png';
  }

  Alignment _dashboardBackgroundAlignment(double width) {
    if (width < 700) {
      return Alignment.topCenter;
    }
    return const Alignment(-0.08, 0);
  }

  double _dashboardBackgroundScale(double width) {
    if (width <= 1100) return 1.0;
    return 1.0;
  }

  double _dashboardOverlayAlpha(double width) {
    if (width < 700) return 0.50;
    if (width <= 1100) return 0.42;
    return 0.38;
  }

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, backgroundConstraints) {
            final width = backgroundConstraints.maxWidth;

            return Stack(
              fit: StackFit.expand,
              children: [
                Transform.scale(
                  scale: _dashboardBackgroundScale(width),
                  child: Image.asset(
                    _dashboardBackgroundAsset(width),
                    fit: BoxFit.cover,
                    alignment: _dashboardBackgroundAlignment(width),
                  ),
                ),
                ColoredBox(
                  color: Colors.black
                      .withValues(alpha: _dashboardOverlayAlpha(width)),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  right: 10,
                  child: _DashboardTopActions(isArabic: isArabic),
                ),
                StreamBuilder<Map<String, dynamic>?>(
                  stream: _clientStream(),
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    final name = _readName(data);
                    final avatarAsset = _readAvatarAsset(data);
                    final isActive = _readIsActive(data);
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final isMobile = constraints.maxWidth < 720;
                        final padding =
                            isMobile ? AppSpacing.md : AppSpacing.lg;
                        final actionButtons = [
                          StreamBuilder<int>(
                            stream: _requestsCountStream(),
                            builder: (context, snap) {
                              final count = snap.data ?? 0;
                              return _ActionButton(
                                title: isArabic ? 'طلبات الحجز' : 'Bookings',
                                subtitle: isArabic
                                    ? 'طلبات الحجز: $count'
                                    : 'Booking requests: $count',
                                asset:
                                    'assets/images/client_dashboard/actions/client_bookings.png',
                                icon: Icons.list_alt_outlined,
                                onTap: () => Navigator.of(context)
                                    .pushNamed(Routes.myBookings),
                              );
                            },
                          ),
                          StreamBuilder<int>(
                            stream: _messagesCountStream(),
                            builder: (context, snap) {
                              final count = snap.data ?? 0;
                              return _ActionButton(
                                title: isArabic ? 'الدعم' : 'Support',
                                subtitle: isArabic
                                    ? 'طلبات الدعم: $count'
                                    : 'Support requests: $count',
                                asset:
                                    'assets/images/client_dashboard/actions/client_support.png',
                                icon: Icons.chat_bubble_outline_rounded,
                                onTap: () => Navigator.of(context).pushNamed(
                                  Routes.supportIssueSelector,
                                  arguments: const {
                                    'supportType': 'client_support'
                                  },
                                ),
                              );
                            },
                          ),
                          _ActionButton(
                            title: isArabic
                                ? 'إثبات التحويل النقدي'
                                : 'Payment Proof',
                            subtitle: isArabic
                                ? 'رفع إثبات التحويل'
                                : 'Upload transfer proof',
                            asset:
                                'assets/images/client_dashboard/actions/client_payment_proof.png',
                            icon: Icons.receipt_long_outlined,
                            onTap: () => Navigator.of(context)
                                .pushNamed(Routes.clientPaymentProof),
                          ),
                          _ActionButton(
                            title: isArabic ? 'جلساتي' : 'My Sessions',
                            subtitle: isArabic
                                ? 'الروابط والأكواد'
                                : 'Links and codes',
                            asset:
                                'assets/images/client_dashboard/actions/client_sessions.png',
                            icon: Icons.video_camera_front_outlined,
                            onTap: () => Navigator.of(context)
                                .pushNamed(Routes.clientSessions),
                          ),
                          _ActionButton(
                            title: isArabic ? 'المتابعة' : 'Follow-up',
                            subtitle: isArabic
                                ? 'تفضيلات الرسائل'
                                : 'Message preferences',
                            asset:
                                'assets/images/client_dashboard/actions/client_follow_up.png',
                            icon: Icons.mark_email_read_outlined,
                            onTap: () => Navigator.of(context)
                                .pushNamed(Routes.followUpRegistration),
                          ),
                        ];

                        final actionsWrap = Wrap(
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          spacing: isMobile ? 12 : AppSpacing.lg,
                          runSpacing: AppSpacing.md,
                          children: actionButtons,
                        );

                        final desktopActions = _DesktopActionCards(
                          actions: actionButtons,
                          width: constraints.maxWidth,
                        );

                        final ratingsPanel = StreamBuilder<Map<String, double>>(
                          stream: _ratingsAboutClientStream(),
                          builder: (context, snap) {
                            final ratingsData = snap.data ??
                                {
                                  'count': 0,
                                  'avgStars': 0,
                                  'avgPercentage': 0,
                                };

                            return _RatingsPanel(
                              isArabic: isArabic,
                              count: (ratingsData['count'] ?? 0).toInt(),
                              avgStars:
                                  (ratingsData['avgStars'] ?? 0).toDouble(),
                              avgPercentage: (ratingsData['avgPercentage'] ?? 0)
                                  .toDouble(),
                              horizontal: !isMobile,
                            );
                          },
                        );

                        final content = Padding(
                          padding: EdgeInsets.fromLTRB(
                            padding,
                            isMobile ? 50 : 48,
                            padding,
                            padding,
                          ),
                          child: isMobile
                              ? Column(
                                  children: [
                                    _ProfileBanner(
                                      isArabic: isArabic,
                                      name: name,
                                      avatarAsset: avatarAsset,
                                      isActive: isActive,
                                      initials: _initials(name),
                                      showGreeting: true,
                                      avatarSize: 72,
                                    ),
                                    const SizedBox(height: AppSpacing.sm),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: ratingsPanel,
                                    ),
                                    const SizedBox(height: AppSpacing.md),
                                    Center(child: actionsWrap),
                                  ],
                                )
                              : Stack(
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(height: 100),
                                        Expanded(
                                          child: Stack(
                                            children: [
                                              Center(child: desktopActions),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      left: 54,
                                      top: 16,
                                      child: const _DashboardLogoBadge(
                                        size: 104,
                                      ),
                                    ),
                                    Positioned(
                                      right: 40,
                                      top: 0,
                                      width: 230,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          _GreetingText(
                                            isArabic: isArabic,
                                            name: name,
                                            textTheme:
                                                Theme.of(context).textTheme,
                                          ),
                                          const SizedBox(height: 14),
                                          _ClientAvatarBadge(
                                            avatarAsset: avatarAsset,
                                            isActive: isActive,
                                            initials: _initials(name),
                                            size: 82,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: -22,
                                      top: 72,
                                      width: 520,
                                      child: ratingsPanel,
                                    ),
                                  ],
                                ),
                        );

                        if (isMobile) {
                          return SingleChildScrollView(child: content);
                        }

                        return content;
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DashboardTopActions extends StatelessWidget {
  final bool isArabic;

  const _DashboardTopActions({required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _TopIconButton(
          icon: Icons.arrow_back_rounded,
          tooltip: isArabic ? 'رجوع' : 'Back',
          onTap: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).maybePop();
            } else {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.menu,
                (route) => false,
              );
            }
          },
        ),
        const SizedBox(width: 12),
        _TopIconButton(
          icon: Icons.logout_rounded,
          tooltip: isArabic ? 'تسجيل الخروج' : 'Logout',
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            if (!context.mounted) return;
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.login,
              (route) => false,
            );
          },
        ),
      ],
    );
  }
}

class _TopIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _TopIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 34,
            height: 34,
            child: Icon(
              icon,
              color: AppColors.mutedGold,
              size: 20,
              shadows: const [
                Shadow(
                  color: Colors.black,
                  blurRadius: 7,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopActionCards extends StatelessWidget {
  final List<Widget> actions;
  final double width;

  const _DesktopActionCards({
    required this.actions,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final maxWidth = width >= 1200 ? 900.0 : 760.0;

    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: width >= 1200 ? 18 : 14,
          runSpacing: 16,
          children: actions,
        ),
      ),
    );
  }
}

class _ProfileBanner extends StatelessWidget {
  final bool isArabic;
  final String name;
  final String avatarAsset;
  final bool isActive;
  final String initials;
  final bool showGreeting;
  final double avatarSize;

  const _ProfileBanner({
    required this.isArabic,
    required this.name,
    required this.avatarAsset,
    required this.isActive,
    required this.initials,
    required this.showGreeting,
    required this.avatarSize,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: avatarSize + 26,
      child: Row(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 19),
            child: _ClientAvatarBadge(
              avatarAsset: avatarAsset,
              isActive: isActive,
              initials: initials,
              size: avatarSize,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          if (showGreeting)
            Expanded(
              child: _GreetingText(
                isArabic: isArabic,
                name: name,
                textTheme: textTheme,
              ),
            )
          else
            const Spacer(),
        ],
      ),
    );
  }
}

class _GreetingText extends StatelessWidget {
  final bool isArabic;
  final String name;
  final TextTheme textTheme;

  const _GreetingText({
    required this.isArabic,
    required this.name,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          isArabic ? 'مرحباً $name' : 'Welcome, $name',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.titleLarge?.copyWith(
            color: const Color(0xFFE7C766),
            fontWeight: FontWeight.w900,
            shadows: const [
              Shadow(
                color: Colors.black,
                blurRadius: 8,
                offset: Offset(0, 1),
              ),
            ],
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 4),
        Text(
          isArabic
              ? 'كل خطواتك موجودة هنا بهدوء.'
              : 'Your next steps are all here.',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.mutedGold.withValues(alpha: 0.84),
            fontWeight: FontWeight.w700,
            shadows: const [
              Shadow(
                color: Colors.black,
                blurRadius: 6,
                offset: Offset(0, 1),
              ),
            ],
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}

class _ClientAvatarBadge extends StatelessWidget {
  final String avatarAsset;
  final bool isActive;
  final String initials;
  final double size;

  const _ClientAvatarBadge({
    required this.avatarAsset,
    required this.isActive,
    required this.initials,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final imageSize = size - 6;
    final badgeSize = size >= 80 ? 22.0 : 18.0;
    final initialsSize = size >= 80 ? 26.0 : 22.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.mutedGold, width: 1.6),
            color: Colors.white.withValues(alpha: 0.28),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white.withValues(alpha: 0.90),
            child: avatarAsset.isNotEmpty
                ? ClipOval(
                    child: Image.asset(
                      normalizeAssetPath(avatarAsset),
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          AppMissingAssetPlaceholder(
                        width: imageSize,
                        height: imageSize,
                      ),
                    ),
                  )
                : Text(
                    initials,
                    style: TextStyle(
                      color: AppColors.deepTeal,
                      fontWeight: FontWeight.w900,
                      fontSize: initialsSize,
                    ),
                  ),
          ),
        ),
        PositionedDirectional(
          start: -2,
          bottom: 4,
          child: Container(
            width: badgeSize,
            height: badgeSize,
            decoration: BoxDecoration(
              color:
                  isActive ? const Color(0xFF00E5C3) : const Color(0xFFD16A6A),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: (isActive
                          ? const Color(0xFF00E5C3)
                          : const Color(0xFFD16A6A))
                      .withValues(alpha: 0.55),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DashboardLogoBadge extends StatelessWidget {
  final double size;

  const _DashboardLogoBadge({required this.size});

  @override
  Widget build(BuildContext context) {
    final imageSize = size;

    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.mutedGold.withValues(alpha: 0.14),
              blurRadius: 18,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Image.asset(
          'assets/branding/logo_primary_dark.png',
          width: imageSize,
          height: imageSize,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              AppMissingAssetPlaceholder(
            width: imageSize,
            height: imageSize,
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final String asset;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({
    required this.title,
    required this.subtitle,
    required this.asset,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 720;
    final cardWidth = isMobile ? 150.0 : 158.0;
    final cardHeight = isMobile ? 176.0 : 190.0;

    return Material(
      color: Colors.transparent,
      child: _HoverScale(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          hoverColor: AppColors.mutedGold.withValues(alpha: 0.10),
          splashColor: AppColors.deepTeal.withValues(alpha: 0.10),
          highlightColor: AppColors.mutedGold.withValues(alpha: 0.08),
          child: SizedBox(
            width: cardWidth,
            height: cardHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    asset,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.black.withValues(alpha: 0.42),
                      alignment: Alignment.center,
                      child: Icon(
                        icon,
                        color: AppColors.mutedGold,
                        size: 34,
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.10),
                          Colors.black.withValues(alpha: 0.16),
                          Colors.black.withValues(alpha: 0.66),
                        ],
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppColors.mutedGold.withValues(alpha: 0.62),
                        width: 1.1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mutedGold.withValues(alpha: 0.18),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
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
                                const Color(0xFFFFE7B2).withValues(alpha: 0.82),
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
                          color: AppColors.mutedGold,
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

class _HoverScale extends StatefulWidget {
  final Widget child;

  const _HoverScale({required this.child});

  @override
  State<_HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<_HoverScale> {
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
                color: AppColors.mutedGold.withValues(
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

class _RatingsPanel extends StatelessWidget {
  final bool isArabic;
  final int count;
  final double avgStars;
  final double avgPercentage;
  final bool horizontal;

  const _RatingsPanel({
    required this.isArabic,
    required this.count,
    required this.avgStars,
    required this.avgPercentage,
    this.horizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    final metrics = [
      _PlainMetric(
        value: '$count',
        label: isArabic ? 'عدد التقييمات' : 'Ratings count',
      ),
      _PlainMetric(
        value: avgStars.toStringAsFixed(1),
        label: isArabic ? 'متوسط النجوم' : 'Average stars',
      ),
      _PlainMetric(
        value: '${avgPercentage.toStringAsFixed(1)}%',
        label: isArabic ? 'المتوسط العام' : 'Overall average',
      ),
    ];

    if (horizontal) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < metrics.length; i++) ...[
            if (i > 0) const SizedBox(width: AppSpacing.lg),
            metrics[i],
          ],
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < metrics.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.md),
          metrics[i],
        ],
      ],
    );
  }
}

class _PlainMetric extends StatelessWidget {
  final String value;
  final String label;

  const _PlainMetric({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: const Color(0xFFE7C766),
            fontWeight: FontWeight.w900,
            shadows: const [
              Shadow(
                color: Colors.black,
                blurRadius: 7,
                offset: Offset(0, 1),
              ),
            ],
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppColors.mutedGold.withValues(alpha: 0.82),
            fontWeight: FontWeight.w700,
            shadows: const [
              Shadow(
                color: Colors.black,
                blurRadius: 5,
                offset: Offset(0, 1),
              ),
            ],
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
