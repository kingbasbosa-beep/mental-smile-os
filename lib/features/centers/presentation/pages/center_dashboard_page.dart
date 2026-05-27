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
    await AppShellActions.signOutToLogin(context);
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
        return isArabic ? 'قيد المراجعة' : 'Follow-up';
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
    final isArabic = _isArabic(context);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, backgroundConstraints) {
            final width = backgroundConstraints.maxWidth;
            final height = backgroundConstraints.maxHeight;
            final isCompactLandscape = width < 900 && height < 520;

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
                StreamBuilder<Map<String, dynamic>?>(
                  stream: _centerStream(),
                  builder: (context, snapshot) {
                    final scheme = Theme.of(context).colorScheme;
                    final data = snapshot.data ?? <String, dynamic>{};

                    final centerName =
                        (data['centerName'] ?? data['displayName'] ?? '')
                            .toString()
                            .trim();
                    final email = (data['email'] ?? '').toString().trim();
                    final imageUrl =
                        (data['imageUrl'] ?? data['coverImageUrl'] ?? '')
                            .toString()
                            .trim();
                    final phone = (data['phone'] ?? '').toString().trim();
                    final city = (data['city'] ?? '').toString().trim();
                    final address = (data['address'] ?? '').toString().trim();
                    final description =
                        (data['description'] ?? '').toString().trim();
                    final managerName =
                        (data['managerName'] ?? '').toString().trim();
                    final centerType =
                        (data['centerType'] ?? '').toString().trim();
                    final hasDetoxUnit =
                        ((data['hasDetoxUnit'] ?? false) == true) ||
                            centerType == 'detox';
                    final approvalStatus =
                        (data['approvalStatus'] ?? 'pending_admin')
                            .toString()
                            .trim();
                    final imagesReady = (data['imagesReady'] ?? false) == true;
                    final documentsReady =
                        (data['documentsReady'] ?? false) == true;

                    final gallery = _readGallery(data);
                    final documents = _readDocuments(data);
                    final galleryThumbs = gallery
                        .map(
                          (item) => (item['url'] ??
                                  item['imageUrl'] ??
                                  item['asset'] ??
                                  item['path'] ??
                                  '')
                              .toString()
                              .trim(),
                        )
                        .where((value) => value.isNotEmpty)
                        .take(4)
                        .toList();
                    final statusLabel =
                        _approvalStatusLabel(approvalStatus, isArabic);
                    return ListView(
                      padding: EdgeInsets.fromLTRB(
                        width < 700 ? 14 : 72,
                        isCompactLandscape ? 12 : (width < 700 ? 18 : 86),
                        width < 700 ? 14 : 72,
                        isCompactLandscape ? 16 : 24,
                      ),
                      children: [
                        Row(
                          textDirection: TextDirection.ltr,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _CenterBrandMark(),
                            const Spacer(),
                            _CenterFloatingProfile(
                              isArabic: isArabic,
                              centerName: centerName,
                              imageUrl: imageUrl,
                              compact: isCompactLandscape,
                              onLogout: () => _logout(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _CenterInfoChips(
                          values: [
                            centerName.isEmpty
                                ? (isArabic ? 'مركز' : 'Center')
                                : centerName,
                            email.isEmpty
                                ? (isArabic ? 'بدون بريد' : 'No email')
                                : email,
                            statusLabel,
                            _centerTypeLabel(centerType, isArabic),
                          ],
                        ),
                        SizedBox(height: isCompactLandscape ? 12 : 22),
                        if (galleryThumbs.isNotEmpty) ...[
                          _CenterTopGallery(imageUrls: galleryThumbs),
                          const SizedBox(height: 16),
                        ],
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
                              onTap: () => Navigator.of(context)
                                  .pushNamed(Routes.centerInbox),
                            ),
                            _SectionCard(
                              title:
                                  isArabic ? 'طلبات نشطة' : 'Active requests',
                              subtitle: isArabic
                                  ? 'متابعة الطلبات الجارية'
                                  : 'Follow active center requests',
                              icon: Icons.timelapse_outlined,
                              accent: const Color(0xFF8EDBFF),
                              imagePath:
                                  'assets/images/center_dashboard/actions/center_active_requests.png',
                              onTap: () => Navigator.of(context)
                                  .pushNamed(Routes.centerInbox),
                            ),
                            _SectionCard(
                              title: isArabic
                                  ? 'طلبات مكتملة'
                                  : 'Completed requests',
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
                                  ? 'طلبات مرفوضة'
                                  : 'Rejected requests',
                              subtitle: isArabic
                                  ? 'متابعة الطلبات المرفوضة أو غير المتاحة'
                                  : 'Review unavailable or cancelled requests',
                              icon: Icons.cancel_outlined,
                              accent: const Color(0xFFFF9A8A),
                              imagePath:
                                  'assets/images/center_dashboard/actions/center_rejected_requests.png',
                              onTap: () => Navigator.of(context)
                                  .pushNamed(Routes.centerInbox),
                            ),
                            _SectionCard(
                              title: isArabic ? 'الإقامات' : 'My sessions',
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
                              title:
                                  isArabic ? 'تحديث بياناتي' : 'Update profile',
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
                                arguments: const {
                                  'supportType': 'center_support'
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
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

class _CenterBrandMark extends StatelessWidget {
  const _CenterBrandMark();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE7C766).withValues(alpha: 0.24),
            blurRadius: 28,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.28),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Image.asset(
        'assets/branding/logo_icon.png',
        width: 86,
        height: 86,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.auto_awesome_rounded,
            color: Color(0xFFE7C766),
            size: 82,
          );
        },
      ),
    );
  }
}

class _CenterFloatingProfile extends StatelessWidget {
  final bool isArabic;
  final String centerName;
  final String imageUrl;
  final bool compact;
  final VoidCallback onLogout;

  const _CenterFloatingProfile({
    required this.isArabic,
    required this.centerName,
    required this.imageUrl,
    this.compact = false,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final displayName =
        centerName.isEmpty ? (isArabic ? 'مركز' : 'Center') : centerName;

    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: compact ? 88 : 112,
          height: compact ? 112 : 148,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _CenterProfileImage(
                imageUrl: imageUrl,
                fallbackText: displayName,
                compact: compact,
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: _CenterLogoutButton(
                    isArabic: isArabic,
                    onPressed: onLogout,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: compact ? 160 : 220),
          child: Text(
            displayName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: const Color(0xFFFFE7B2),
              fontWeight: FontWeight.w900,
              letterSpacing: 0,
              height: 1.05,
              shadows: const [
                Shadow(
                  color: Colors.black,
                  blurRadius: 12,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CenterProfileImage extends StatelessWidget {
  final String imageUrl;
  final String fallbackText;
  final bool compact;

  const _CenterProfileImage({
    required this.imageUrl,
    required this.fallbackText,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final trimmed = imageUrl.trim();
    final uri = Uri.tryParse(trimmed);
    final isNetwork =
        uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
    final isAsset = trimmed.startsWith('assets/');

    Widget fallback() {
      return Center(
        child: Text(
          fallbackText.trim().isEmpty ? 'C' : fallbackText.trim()[0],
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: const Color(0xFFE7C766),
                fontWeight: FontWeight.w900,
              ),
        ),
      );
    }

    Widget imageChild;
    if (isNetwork) {
      imageChild = Image.network(
        trimmed,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => fallback(),
      );
    } else if (isAsset) {
      imageChild = Image.asset(
        trimmed,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => fallback(),
      );
    } else {
      imageChild = fallback();
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE7C766).withValues(alpha: 0.22),
            blurRadius: 24,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.30),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipOval(
        child: Container(
          width: compact ? 88 : 112,
          height: compact ? 88 : 112,
          color: const Color(0xFFE7C766).withValues(alpha: 0.18),
          child: imageChild,
        ),
      ),
    );
  }
}

class _CenterLogoutButton extends StatelessWidget {
  final bool isArabic;
  final VoidCallback onPressed;

  const _CenterLogoutButton({
    required this.isArabic,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: isArabic ? 'تسجيل الخروج' : 'Sign out',
      child: SizedBox(
        height: 30,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.logout_rounded, size: 15),
          label: Text(isArabic ? 'خروج' : 'Logout'),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFFFE7B2),
            side: BorderSide(
              color: const Color(0xFFE7C766).withValues(alpha: 0.62),
            ),
            backgroundColor: Colors.black.withValues(alpha: 0.24),
            minimumSize: const Size(0, 30),
            padding: const EdgeInsets.symmetric(horizontal: 9),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0,
                ),
          ),
        ),
      ),
    );
  }
}

class _CenterInfoChips extends StatelessWidget {
  final List<String> values;

  const _CenterInfoChips({required this.values});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 10,
        runSpacing: 8,
        children: values.map((value) => _CenterInfoChip(label: value)).toList(),
      ),
    );
  }
}

class _CenterInfoChip extends StatelessWidget {
  final String label;

  const _CenterInfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      constraints: const BoxConstraints(maxWidth: 240),
      padding: const EdgeInsets.symmetric(horizontal: 13),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE7C766).withValues(alpha: 0.38),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: const Color(0xFFFFE7B2),
              fontWeight: FontWeight.w800,
              letterSpacing: 0,
            ),
      ),
    );
  }
}

class _CenterTopGallery extends StatelessWidget {
  final List<String> imageUrls;

  const _CenterTopGallery({required this.imageUrls});

  static Widget _image(String source, {BoxFit fit = BoxFit.cover}) {
    final trimmed = source.trim();
    final uri = Uri.tryParse(trimmed);
    final isNetwork =
        uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
    final isAsset = trimmed.startsWith('assets/');

    Widget fallback(BuildContext context) {
      return ColoredBox(
        color: Colors.black.withValues(alpha: 0.22),
        child: Icon(
          Icons.broken_image_outlined,
          color: const Color(0xFFFFE7B2).withValues(alpha: 0.62),
          size: 22,
        ),
      );
    }

    if (isNetwork) {
      return Image.network(
        trimmed,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => fallback(context),
      );
    }

    if (isAsset) {
      return Image.asset(
        trimmed,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => fallback(context),
      );
    }

    return Builder(builder: fallback);
  }

  void _openImage(BuildContext context, String source) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.72),
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(18),
          child: Stack(
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 980),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.42),
                        border: Border.all(
                          color:
                              const Color(0xFFE7C766).withValues(alpha: 0.46),
                        ),
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 10,
                        child: _image(source, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                top: 10,
                end: 10,
                child: IconButton.filledTonal(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  icon: const Icon(Icons.close_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black.withValues(alpha: 0.48),
                    foregroundColor: const Color(0xFFFFE7B2),
                    side: BorderSide(
                      color: const Color(0xFFE7C766).withValues(alpha: 0.44),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleImages = imageUrls.take(4).toList();
    if (visibleImages.isEmpty) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final source in visibleImages) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  onTap: () => _openImage(context, source),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: 104,
                    height: 66,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFE7C766).withValues(alpha: 0.36),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              const Color(0xFFE7C766).withValues(alpha: 0.07),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: _image(source),
                  ),
                ),
              ),
            ],
          ],
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
    final viewport = MediaQuery.sizeOf(context);
    final isCompactLandscape = viewport.width < 900 && viewport.height < 520;

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

class _CenterActionCards extends StatefulWidget {
  final List<Widget> children;

  const _CenterActionCards({required this.children});

  @override
  State<_CenterActionCards> createState() => _CenterActionCardsState();
}

class _CenterActionCardsState extends State<_CenterActionCards> {
  PageController? _controller;
  double _viewportFraction = 0.78;
  double _page = 0;

  @override
  void initState() {
    super.initState();
    _syncController(_viewportFraction);
  }

  @override
  void dispose() {
    _controller?.removeListener(_handlePageChange);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _CenterActionCards oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.children.length != oldWidget.children.length) {
      final maxIndex = widget.children.isEmpty ? 0 : widget.children.length - 1;
      _page = _page.clamp(0, maxIndex).toDouble();
    }
  }

  void _handlePageChange() {
    if (!mounted) return;
    setState(() => _page = _controller?.page ?? _page);
  }

  void _syncController(double viewportFraction) {
    if (_controller != null && _viewportFraction == viewportFraction) return;

    final oldPage =
        _controller?.hasClients == true ? (_controller?.page ?? _page) : _page;
    final maxIndex = widget.children.isEmpty ? 0 : widget.children.length - 1;

    _controller?.removeListener(_handlePageChange);
    _controller?.dispose();
    _viewportFraction = viewportFraction;
    _page = oldPage.clamp(0, maxIndex).toDouble();
    _controller = PageController(
      initialPage: _page.round().clamp(0, maxIndex).toInt(),
      viewportFraction: viewportFraction,
    )..addListener(_handlePageChange);
  }

  void _goToPage(int targetIndex) {
    if (widget.children.isEmpty) return;
    final maxIndex = widget.children.length - 1;
    final clamped = targetIndex.clamp(0, maxIndex).toInt();
    _controller?.animateToPage(
      clamped,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutQuart,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.children.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < 700;
        final isTablet = width >= 700 && width <= 1100;
        final isCompactLandscape =
            width < 900 && MediaQuery.sizeOf(context).height < 520;
        final viewportFraction = isMobile
            ? (isCompactLandscape ? 0.64 : 0.82)
            : isTablet
                ? 0.56
                : 0.34;
        _syncController(viewportFraction);
        final controller = _controller!;
        final currentIndex = _page.round().clamp(0, widget.children.length - 1);
        final canGoBack = currentIndex > 0;
        final canGoForward = currentIndex < widget.children.length - 1;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1280),
            child: SizedBox(
              height: isCompactLandscape ? 214 : (isMobile ? 270 : 306),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView.builder(
                    controller: controller,
                    itemCount: widget.children.length,
                    padEnds: true,
                    itemBuilder: (context, index) {
                      final distance = (_page - index).abs().clamp(0.0, 1.0);
                      final scale = 1.0 - (distance * 0.06);
                      final opacity = 1.0 - (distance * 0.18);

                      return AnimatedOpacity(
                        opacity: opacity,
                        duration: const Duration(milliseconds: 260),
                        curve: Curves.easeOutQuart,
                        child: AnimatedScale(
                          scale: scale,
                          duration: const Duration(milliseconds: 260),
                          curve: Curves.easeOutQuart,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 8 : 12,
                            ),
                            child: Center(child: widget.children[index]),
                          ),
                        ),
                      );
                    },
                  ),
                  PositionedDirectional(
                    start: isMobile ? 2 : 10,
                    child: _ActionCarouselArrow(
                      icon: Icons.chevron_left_rounded,
                      enabled: canGoBack,
                      onPressed: () => _goToPage(currentIndex - 1),
                    ),
                  ),
                  PositionedDirectional(
                    end: isMobile ? 2 : 10,
                    child: _ActionCarouselArrow(
                      icon: Icons.chevron_right_rounded,
                      enabled: canGoForward,
                      onPressed: () => _goToPage(currentIndex + 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ActionCarouselArrow extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onPressed;

  const _ActionCarouselArrow({
    required this.icon,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE7C766).withValues(
              alpha: enabled ? 0.22 : 0.08,
            ),
            blurRadius: enabled ? 18 : 8,
            spreadRadius: enabled ? 1 : 0,
          ),
        ],
      ),
      child: SizedBox(
        width: 46,
        height: 46,
        child: IconButton.filledTonal(
          onPressed: enabled ? onPressed : null,
          icon: Icon(icon),
          style: IconButton.styleFrom(
            backgroundColor: Colors.black.withValues(alpha: 0.48),
            disabledBackgroundColor: Colors.black.withValues(alpha: 0.20),
            foregroundColor: const Color(0xFFFFE7B2),
            disabledForegroundColor: Colors.white.withValues(alpha: 0.30),
            side: BorderSide(
              color: const Color(0xFFE7C766).withValues(
                alpha: enabled ? 0.44 : 0.14,
              ),
            ),
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
    final viewport = MediaQuery.sizeOf(context);
    final isCompactLandscape = viewport.width < 900 && viewport.height < 520;

    return _CenterActionHover(
      accent: accent,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(28),
          hoverColor: accent.withValues(alpha: 0.08),
          splashColor: accent.withValues(alpha: 0.10),
          highlightColor: accent.withValues(alpha: 0.06),
          child: SizedBox(
            width: double.infinity,
            height: isCompactLandscape ? 208 : 264,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
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
                          Colors.black.withValues(alpha: 0.05),
                          Colors.black.withValues(alpha: 0.18),
                          Colors.black.withValues(alpha: 0.76),
                        ],
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.topCenter,
                        radius: 1.1,
                        colors: [
                          accent.withValues(alpha: 0.20),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: accent.withValues(alpha: 0.68),
                        width: 1.2,
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    start: 16,
                    end: 16,
                    bottom: 16,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: const Color(0xFFFFE7B2),
                            fontWeight: FontWeight.w900,
                            height: 1.08,
                            shadows: const [
                              Shadow(
                                color: Colors.black,
                                blurRadius: 12,
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
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                            color:
                                const Color(0xFFFFE7B2).withValues(alpha: 0.86),
                            fontWeight: FontWeight.w700,
                            height: 1.14,
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
                          size: 20,
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
        scale: _hovered ? 1.018 : 1.0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutQuart,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: widget.accent.withValues(
                  alpha: _hovered ? 0.34 : 0.18,
                ),
                blurRadius: _hovered ? 28 : 16,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: const Color(0xFFE7C766).withValues(
                  alpha: _hovered ? 0.16 : 0.08,
                ),
                blurRadius: _hovered ? 34 : 20,
                spreadRadius: _hovered ? 1 : 0,
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
