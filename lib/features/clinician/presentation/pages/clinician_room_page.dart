import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_smile_os/app/locale_provider.dart';
import 'package:mental_smile_os/app/router/routes.dart';
import 'package:mental_smile_os/core/storage/locale_storage.dart';
import 'package:mental_smile_os/l10n/app_localizations.dart';
import 'package:mental_smile_os/shared/ui_kit/app_design_system.dart';
import 'package:mental_smile_os/shared/ui_kit/app_shell_actions.dart';

class ClinicianRoomPage extends StatefulWidget {
  const ClinicianRoomPage({super.key});

  @override
  State<ClinicianRoomPage> createState() => _ClinicianRoomPageState();
}

class _ClinicianRoomPageState extends State<ClinicianRoomPage> {
  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  void _goToMenu() {
    AppShellActions.returnToMenu(context);
  }

  Future<void> _toggleLocale() async {
    final locale = Localizations.localeOf(context);
    final nextCode = locale.languageCode.toLowerCase() == 'ar' ? 'en' : 'ar';
    await LocaleStorage().write(nextCode);
    if (!mounted) return;
    ProviderScope.containerOf(context, listen: false)
        .read(localeProvider.notifier)
        .state = Locale(nextCode);
  }

  String _dashboardBackgroundAsset(double width) {
    return 'assets/c7_branding/home/home_bg.png';
  }

  Alignment _dashboardBackgroundAlignment(double width) {
    if (width < 700) {
      return Alignment.topCenter;
    }
    return const Alignment(-0.08, 0);
  }

  bool _isLandscapeCompact(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return size.width > size.height && size.width < 900 && size.height < 540;
  }

  double _dashboardOverlayAlpha(double width) {
    if (width < 700) return 0.38;
    if (width <= 1100) return 0.32;
    return 0.28;
  }

  Widget _buildDashboardBackground({required Widget child}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        return Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              _dashboardBackgroundAsset(width),
              fit: BoxFit.cover,
              alignment: _dashboardBackgroundAlignment(width),
              errorBuilder: (context, error, stackTrace) =>
                  const ColoredBox(color: Color(0xFF061D24)),
            ),
            ColoredBox(
              color: Colors.black.withValues(
                alpha: _dashboardOverlayAlpha(width),
              ),
            ),
            child,
          ],
        );
      },
    );
  }

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  Stream<Map<String, dynamic>?> _clinicianStream() {
    if (_uid.isEmpty) return Stream.value(null);

    return FirebaseFirestore.instance
        .collection('clinicians')
        .doc(_uid)
        .snapshots()
        .map((doc) => doc.data());
  }

  Future<void> _signOut() async {
    await AppShellActions.signOutToLogin(context);
  }

  Widget _buildHomeSummary({
    required BuildContext context,
    required bool isArabic,
    required String clinicianName,
    required String clinicianPhotoUrl,
  }) {
    final compact = _isLandscapeCompact(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildClinicianTopBar(
          context: context,
          isArabic: isArabic,
          clinicianName: clinicianName,
          clinicianPhotoUrl: clinicianPhotoUrl,
        ),
        SizedBox(height: compact ? 4.0 : 8.0),
        _buildRoomActions(
          context: context,
          isArabic: isArabic,
        ),
      ],
    );
  }

  Widget _buildClinicianTopBar({
    required BuildContext context,
    required bool isArabic,
    required String clinicianName,
    required String clinicianPhotoUrl,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = _isLandscapeCompact(context);
        final gap = compact
            ? 6.0
            : constraints.maxWidth < 420
                ? 8.0
                : 16.0;

        return Row(
          textDirection: TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ClinicianGoldLogo(isArabic: isArabic),
            SizedBox(width: gap),
            Expanded(
              child: Align(
                alignment: Alignment.topRight,
                child: _ClinicianCompactProfile(
                  isArabic: isArabic,
                  clinicianName: clinicianName,
                  clinicianPhotoUrl: clinicianPhotoUrl,
                  onBackToMenu: _goToMenu,
                  onToggleLanguage: _toggleLocale,
                  onSignOut: _signOut,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRoomActions({
    required BuildContext context,
    required bool isArabic,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return _RoomActionsCarousel(
      children: [
        _RoomActionButton(
          label: l10n.clinicianOpenCases,
          icon: Icons.forum_outlined,
          imageAsset:
              'assets/images/clinicians_dashboard/actions/clinician_open_cases.png',
          primary: true,
          onTap: () {
            Navigator.of(context).pushNamed(
              Routes.clinicianChatInbox,
            );
          },
        ),
        _RoomActionButton(
          label: l10n.clinicianSendSupportRequest,
          icon: Icons.chat_bubble_outline_rounded,
          imageAsset:
              'assets/images/clinicians_dashboard/actions/clinician_support_request.png',
          onTap: () {
            Navigator.of(context).pushNamed(
              Routes.supportIssueSelector,
              arguments: const {'supportType': 'clinician_support'},
            );
          },
        ),
        _RoomActionButton(
          label: l10n.clinicianEditProfile,
          icon: Icons.edit_outlined,
          imageAsset:
              'assets/images/clinicians_dashboard/actions/clinician_edit_profile.png',
          onTap: () => Navigator.of(context).pushNamed(
            Routes.clinicianProfileEditRequest,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);
    final l10n = AppLocalizations.of(context)!;

    if (_uid.isEmpty) {
      return Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          body: _buildDashboardBackground(
            child: Center(
              child: Text(
                l10n.clinicianPleaseSignIn,
              ),
            ),
          ),
        ),
      );
    }

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: _buildDashboardBackground(
          child: StreamBuilder<Map<String, dynamic>?>(
            stream: _clinicianStream(),
            builder: (context, clinicianSnapshot) {
              final clinicianData =
                  clinicianSnapshot.data ?? <String, dynamic>{};
              final clinicianName =
                  (clinicianData['displayName'] ?? '').toString().trim();
              final clinicianPhotoUrl =
                  (clinicianData['photoUrl'] ?? '').toString().trim();
              return LayoutBuilder(
                builder: (context, constraints) {
                  final compact = _isLandscapeCompact(context);
                  final horizontal = constraints.maxWidth >= 700 ? 24.0 : 16.0;
                  final vertical = compact
                      ? 24.0
                      : constraints.maxWidth >= 700
                          ? 56.0
                          : 44.0;

                  return ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontal,
                      vertical: vertical,
                    ),
                    children: [
                      _buildHomeSummary(
                        context: context,
                        isArabic: isArabic,
                        clinicianName: clinicianName,
                        clinicianPhotoUrl: clinicianPhotoUrl,
                      ),
                    ],
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

class _ClinicianLogoutButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool compact;

  const _ClinicianLogoutButton({
    required this.onPressed,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Tooltip(
      message: l10n.commonLogout,
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: compact ? 36 : 38,
            height: compact ? 36 : 38,
            child: Image.asset(
              'assets/branding/navigation/logout/logout_gold.png',
              width: compact ? 24 : 26,
              height: compact ? 24 : 26,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.logout_rounded,
                  color: AppColors.mutedGold,
                  size: 22,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 7,
                      offset: Offset(0, 1),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ClinicianHeaderIconButton extends StatelessWidget {
  final IconData icon;
  final String? asset;
  final String tooltip;
  final VoidCallback onPressed;
  final bool compact;

  const _ClinicianHeaderIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.asset,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: compact ? 36 : 38,
            height: compact ? 36 : 38,
            child: asset == null
                ? Icon(
                    icon,
                    color: AppColors.mutedGold,
                    size: compact ? 21 : 22,
                    shadows: const [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 7,
                        offset: Offset(0, 1),
                      ),
                    ],
                  )
                : Image.asset(
                    asset!,
                    width: compact ? 24 : 26,
                    height: compact ? 24 : 26,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        icon,
                        color: AppColors.mutedGold,
                        size: 22,
                        shadows: const [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 7,
                            offset: Offset(0, 1),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}

class _ClinicianLanguageButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool compact;

  const _ClinicianLanguageButton({
    required this.label,
    required this.onPressed,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Container(
            width: compact ? 36 : 38,
            height: compact ? 36 : 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.22),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.mutedGold.withValues(alpha: 0.42),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.mutedGold.withValues(alpha: 0.14),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFFFFE7B2),
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ClinicianGoldLogo extends StatelessWidget {
  final bool isArabic;

  const _ClinicianGoldLogo({required this.isArabic});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final compact = size.width > size.height && size.width < 900;
    final isTablet = size.width >= 700 && size.width <= 1100;
    final logoSize = compact
        ? 76.0
        : isTablet
            ? 104.0
            : 90.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Image.asset(
        'assets/branding/logo_icon.png',
        width: logoSize,
        height: logoSize,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.auto_awesome_rounded,
            color: const Color(0xFFE7C766),
            size: compact
                ? 72.0
                : isTablet
                    ? 96.0
                    : 84.0,
          );
        },
      ),
    );
  }
}

class _ClinicianCompactProfile extends StatelessWidget {
  final bool isArabic;
  final String clinicianName;
  final String clinicianPhotoUrl;
  final VoidCallback onBackToMenu;
  final VoidCallback onToggleLanguage;
  final VoidCallback onSignOut;

  const _ClinicianCompactProfile({
    required this.isArabic,
    required this.clinicianName,
    required this.clinicianPhotoUrl,
    required this.onBackToMenu,
    required this.onToggleLanguage,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final compact = size.width > size.height && size.width < 900;
    final isTablet = size.width >= 700 && size.width <= 1100;
    final avatarRadius = compact ? 36.0 : 46.0;
    final actionSpacing = compact ? 6.0 : 8.0;
    final photoUri = Uri.tryParse(clinicianPhotoUrl.trim());
    final hasValidPhotoUrl = photoUri != null &&
        (photoUri.scheme == 'http' || photoUri.scheme == 'https');
    final displayName = clinicianName.isEmpty
        ? (isArabic ? 'أخصائي' : 'Clinician')
        : clinicianName;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: compact ? 260.0 : 300.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: isTablet ? 8.0 : 0,
              ),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Wrap(
                  spacing: actionSpacing,
                  runSpacing: 4,
                  alignment: isArabic ? WrapAlignment.end : WrapAlignment.start,
                  children: [
                    _ClinicianHeaderIconButton(
                      compact: compact,
                      icon: Icons.arrow_back_rounded,
                      asset: isArabic
                          ? 'assets/branding/navigation/back/back_right_gold.png'
                          : 'assets/branding/navigation/back/back_left_gold.png',
                      tooltip: isArabic ? 'القائمة' : 'Menu',
                      onPressed: onBackToMenu,
                    ),
                    _ClinicianLanguageButton(
                      compact: compact,
                      label: isArabic ? 'EN' : 'AR',
                      onPressed: onToggleLanguage,
                    ),
                    _ClinicianLogoutButton(
                      compact: compact,
                      onPressed: onSignOut,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: compact ? 2.0 : 4.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: TextDirection.rtl,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DecoratedBox(
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
                  child: CircleAvatar(
                    radius: avatarRadius,
                    backgroundColor:
                        const Color(0xFFE7C766).withValues(alpha: 0.18),
                    backgroundImage: hasValidPhotoUrl
                        ? NetworkImage(clinicianPhotoUrl.trim())
                        : null,
                    child: hasValidPhotoUrl
                        ? null
                        : Icon(
                            Icons.person_rounded,
                            color: const Color(0xFFE7C766),
                            size: compact ? 40.0 : 50.0,
                          ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    displayName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFFFFE7B2),
                      fontWeight: FontWeight.w900,
                      height: 1.15,
                      letterSpacing: 0,
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
            ),
          ],
        ),
      ),
    );
  }
}

class _RoomActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String imageAsset;
  final bool primary;
  final VoidCallback? onTap;

  const _RoomActionButton({
    required this.label,
    required this.icon,
    required this.imageAsset,
    required this.onTap,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final accent = primary ? const Color(0xFFE7C766) : const Color(0xFF8EDBFF);
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Opacity(
      opacity: enabled ? 1 : 0.55,
      child: _RoomActionHover(
        accent: accent,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(24),
            hoverColor: accent.withValues(alpha: 0.06),
            splashColor: accent.withValues(alpha: 0.08),
            highlightColor: accent.withValues(alpha: 0.04),
            child: SizedBox(
              width: double.infinity,
              height: 226,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF061D24),
                                const Color(0xFF0B3A3A),
                                accent.withValues(alpha: 0.32),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              icon,
                              color: accent,
                              size: 46,
                            ),
                          ),
                        );
                      },
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.02),
                            Colors.black.withValues(alpha: 0.12),
                            Colors.black.withValues(alpha: 0.62),
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
                            accent.withValues(alpha: 0.12),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: accent.withValues(alpha: 0.46),
                          width: 1,
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      start: 14,
                      end: 14,
                      bottom: 14,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            label,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
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
                          Icon(
                            isArabic
                                ? Icons.keyboard_arrow_left_rounded
                                : Icons.keyboard_arrow_right_rounded,
                            color: accent,
                            size: 19,
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
      ),
    );
  }
}

class _RoomActionsCarousel extends StatefulWidget {
  final List<Widget> children;

  const _RoomActionsCarousel({required this.children});

  @override
  State<_RoomActionsCarousel> createState() => _RoomActionsCarouselState();
}

class _RoomActionsCarouselState extends State<_RoomActionsCarousel> {
  PageController? _controller;
  double _viewportFraction = 0.82;
  double _page = 0;
  bool _pageUpdateScheduled = false;

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
  void didUpdateWidget(covariant _RoomActionsCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.children.length != oldWidget.children.length) {
      final maxIndex = widget.children.isEmpty ? 0 : widget.children.length - 1;
      _page = _page.clamp(0, maxIndex).toDouble();
    }
  }

  void _handlePageChange() {
    if (!mounted) return;
    if (_pageUpdateScheduled) return;

    _pageUpdateScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _pageUpdateScheduled = false;
      final nextPage = _controller?.hasClients == true
          ? (_controller?.page ?? _page)
          : _page;
      if (nextPage == _page) return;

      setState(() => _page = nextPage);
    });
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
        final mediaSize = MediaQuery.sizeOf(context);
        final isMobile = width < 700;
        final isTablet = width >= 700 && width <= 1100;
        final compact =
            mediaSize.width > mediaSize.height && mediaSize.height < 540;
        final compactHeight = (mediaSize.height * 0.30).clamp(132.0, 166.0);
        final viewportFraction = isMobile
            ? compact
                ? 0.54
                : 0.76
            : isTablet
                ? 0.50
                : 0.30;
        _syncController(viewportFraction);
        final controller = _controller!;
        final currentIndex = _page.round().clamp(0, widget.children.length - 1);
        final canGoBack = currentIndex > 0;
        final canGoForward = currentIndex < widget.children.length - 1;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1040),
            child: SizedBox(
              height: compact
                  ? compactHeight
                  : isMobile
                      ? 232
                      : isTablet
                          ? 238
                          : 260,
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
                          scale: compact ? scale * 0.84 : scale,
                          duration: const Duration(milliseconds: 260),
                          curve: Curves.easeOutQuart,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: compact
                                  ? 2.0
                                  : isMobile
                                      ? 6.0
                                      : 10.0,
                            ),
                            child: Center(child: widget.children[index]),
                          ),
                        ),
                      );
                    },
                  ),
                  PositionedDirectional(
                    start: compact
                        ? 2
                        : isMobile
                            ? 6
                            : 18,
                    child: _RoomCarouselArrow(
                      icon: Icons.chevron_left_rounded,
                      enabled: canGoBack,
                      onPressed: () => _goToPage(currentIndex - 1),
                    ),
                  ),
                  PositionedDirectional(
                    end: compact
                        ? 2
                        : isMobile
                            ? 6
                            : 18,
                    child: _RoomCarouselArrow(
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

class _RoomCarouselArrow extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onPressed;

  const _RoomCarouselArrow({
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
              alpha: enabled ? 0.12 : 0.04,
            ),
            blurRadius: enabled ? 12 : 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SizedBox(
        width: 38,
        height: 38,
        child: IconButton.filledTonal(
          onPressed: enabled ? onPressed : null,
          icon: Icon(icon),
          style: IconButton.styleFrom(
            backgroundColor: Colors.black.withValues(alpha: 0.30),
            disabledBackgroundColor: Colors.black.withValues(alpha: 0.14),
            foregroundColor: const Color(0xFFFFE7B2),
            disabledForegroundColor: Colors.white.withValues(alpha: 0.30),
            side: BorderSide(
              color: const Color(0xFFE7C766).withValues(
                alpha: enabled ? 0.30 : 0.10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoomActionHover extends StatefulWidget {
  final Widget child;
  final Color accent;

  const _RoomActionHover({
    required this.child,
    required this.accent,
  });

  @override
  State<_RoomActionHover> createState() => _RoomActionHoverState();
}

class _RoomActionHoverState extends State<_RoomActionHover> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.012 : 1.0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutQuart,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: widget.accent.withValues(
                  alpha: _hovered ? 0.20 : 0.10,
                ),
                blurRadius: _hovered ? 20 : 12,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: const Color(0xFFE7C766).withValues(
                  alpha: _hovered ? 0.08 : 0.04,
                ),
                blurRadius: _hovered ? 22 : 14,
                spreadRadius: 0,
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class ClinicianProfileEditRequestPage extends StatefulWidget {
  const ClinicianProfileEditRequestPage({super.key});

  @override
  State<ClinicianProfileEditRequestPage> createState() =>
      _ClinicianProfileEditRequestPageState();
}

class _ClinicianProfileEditRequestPageState
    extends State<ClinicianProfileEditRequestPage> {
  String _profileEditBackgroundAsset(double width) {
    if (width < 700) {
      return 'assets/images/backgrounds/specialists_bg_mobile.png';
    }
    if (width < 1100) {
      return 'assets/images/backgrounds/specialists_bg_tablet.png';
    }
    return 'assets/images/backgrounds/specialists_bg_desktop.png';
  }

  BoxDecoration _profileEditGlassDecoration({
    double alpha = 0.34,
    double radius = 22,
  }) {
    return BoxDecoration(
      color: Colors.black.withValues(alpha: alpha),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: const Color(0xFFE7C766).withValues(alpha: 0.34),
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFE7C766).withValues(alpha: 0.08),
          blurRadius: 24,
          offset: const Offset(0, 12),
        ),
      ],
    );
  }

  Widget _buildProfileEditBackground({required Widget child}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              _profileEditBackgroundAsset(constraints.maxWidth),
              fit: BoxFit.cover,
              alignment: constraints.maxWidth < 700
                  ? Alignment.topCenter
                  : Alignment.center,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.62),
                    Colors.black.withValues(alpha: 0.38),
                    Colors.black.withValues(alpha: 0.74),
                  ],
                ),
              ),
            ),
            child,
          ],
        );
      },
    );
  }

  InputDecoration _profileEditInputDecoration(String label) {
    const gold = Color(0xFFE7C766);
    const lightText = Color(0xFFFFF4D4);

    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: lightText.withValues(alpha: 0.72),
        fontWeight: FontWeight.w700,
      ),
      filled: true,
      fillColor: Colors.black.withValues(alpha: 0.22),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: gold.withValues(alpha: 0.30),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: gold,
          width: 1.25,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }

  ButtonStyle _profileEditSubmitButtonStyle() {
    return FilledButton.styleFrom(
      backgroundColor: const Color(0xFF1B1007).withValues(alpha: 0.92),
      foregroundColor: const Color(0xFFFFE7B2),
      disabledBackgroundColor: Colors.black.withValues(alpha: 0.28),
      disabledForegroundColor: const Color(0xFFFFE7B2).withValues(alpha: 0.50),
      side: BorderSide(
        color: const Color(0xFFE7C766).withValues(alpha: 0.52),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      elevation: 0,
    );
  }

  final _requestedPhotoUrlController = TextEditingController();
  final _requestedBioController = TextEditingController();

  bool _submittingChangeRequest = false;

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  Stream<Map<String, dynamic>?> _clinicianStream() {
    if (_uid.isEmpty) return Stream.value(null);
    return FirebaseFirestore.instance
        .collection('clinicians')
        .doc(_uid)
        .snapshots()
        .map((doc) => doc.exists ? doc.data() : null);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _requestsStream() {
    return FirebaseFirestore.instance
        .collection('clinician_profile_change_requests')
        .where('clinicianId', isEqualTo: _uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  String _requestStatusLabel(String status, bool isArabic) {
    switch (status) {
      case 'draft':
        return isArabic ? 'مسودة' : 'Draft';
      case 'processed':
        return isArabic ? 'تمت المعالجة' : 'Processed';
      case 'stored':
        return isArabic ? 'مؤرشف' : 'Stored';
      case 'submitted':
      default:
        return isArabic ? 'تم التقديم' : 'Submitted';
    }
  }

  Map<String, dynamic> _profileDeclarationSignals({
    required String requestedPhotoUrl,
    required String requestedBio,
  }) {
    return {
      'profile.photo': requestedPhotoUrl.isNotEmpty,
      'profile.bio': requestedBio.isNotEmpty,
    };
  }

  Future<void> _submitProfileChangeRequest(
    Map<String, dynamic> clinicianData,
  ) async {
    final requestedPhotoUrl = _requestedPhotoUrlController.text.trim();
    final requestedBio = _requestedBioController.text.trim();

    if (requestedPhotoUrl.isEmpty && requestedBio.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'أدخل رابط صورة أو نبذة جديدة أولًا'
                : 'Enter a new photo URL or bio first',
          ),
        ),
      );
      return;
    }

    setState(() => _submittingChangeRequest = true);
    try {
      final currentBio = (clinicianData['bio'] ?? '').toString().trim();
      final currentPhotoUrl =
          (clinicianData['photoUrl'] ?? '').toString().trim();
      var requestType = 'profile_update';
      if (requestedBio.isNotEmpty && requestedPhotoUrl.isNotEmpty) {
        requestType = 'photo_and_bio_update';
      } else if (requestedBio.isNotEmpty) {
        requestType = 'bio_update';
      } else if (requestedPhotoUrl.isNotEmpty && currentPhotoUrl.isEmpty) {
        requestType = 'photo_upload';
      } else if (requestedPhotoUrl.isNotEmpty) {
        requestType = 'photo_update';
      }

      await FirebaseFirestore.instance
          .collection('clinician_profile_change_requests')
          .add({
        'clinicianId': _uid,
        'clinicianName': (clinicianData['displayName'] ?? '').toString(),
        'clinicianEmail': (clinicianData['email'] ?? '').toString(),
        'requestType': requestType,
        'currentBio': currentBio,
        'requestedBio': requestedBio,
        'currentPhotoUrl': currentPhotoUrl,
        'requestedPhotoUrl': requestedPhotoUrl,
        'status': 'submitted',
        'declarationSignals': _profileDeclarationSignals(
          requestedPhotoUrl: requestedPhotoUrl,
          requestedBio: requestedBio,
        ),
        'profileSignals': {
          if (requestedPhotoUrl.isNotEmpty) 'photoUrl': requestedPhotoUrl,
          if (requestedBio.isNotEmpty) 'bio': requestedBio,
        },
        'changeSummary': requestType,
        'submittedAt': FieldValue.serverTimestamp(),
        'submittedBy': _uid,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      _requestedPhotoUrlController.clear();
      _requestedBioController.clear();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'تم تقديم إعلان تحديث الملف الشخصي'
                : 'Profile update declaration submitted',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _submittingChangeRequest = false);
      }
    }
  }

  Widget _buildRequestForm({
    required BuildContext context,
    required bool isArabic,
    required Map<String, dynamic> clinicianData,
  }) {
    final size = MediaQuery.sizeOf(context);
    final compact = size.width > size.height && size.width < 900;

    return Container(
      padding: EdgeInsets.all(compact ? 14.0 : 18.0),
      decoration: _profileEditGlassDecoration(alpha: 0.34, radius: 22),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: Color(0xFFFFF4D4)),
        child: Column(
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              isArabic
                  ? 'إعلان تحديث الصورة أو النبذة'
                  : 'Declare photo or bio update',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFFE7C766),
                    fontWeight: FontWeight.w800,
                  ),
            ),
            SizedBox(height: compact ? 6.0 : 8.0),
            Text(
              isArabic
                  ? 'يتم تقديم تحديثات الصورة والنبذة كإعلانات وتمثيلها بإشارات الملف الشخصي.'
                  : 'Profile photo and bio updates are submitted as declarations and represented by profile signals.',
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFFFFF4D4),
                    height: 1.35,
                  ),
            ),
            SizedBox(height: compact ? 10.0 : 14.0),
            TextField(
              controller: _requestedPhotoUrlController,
              style: const TextStyle(
                color: Color(0xFFFFF4D4),
                fontWeight: FontWeight.w600,
              ),
              cursorColor: const Color(0xFFE7C766),
              decoration: _profileEditInputDecoration(
                isArabic ? 'رابط الصورة الجديدة' : 'New photo URL',
              ),
            ),
            SizedBox(height: compact ? 8.0 : 12.0),
            TextField(
              controller: _requestedBioController,
              maxLines: compact ? 3 : 4,
              style: const TextStyle(
                color: Color(0xFFFFF4D4),
                fontWeight: FontWeight.w600,
              ),
              cursorColor: const Color(0xFFE7C766),
              decoration: _profileEditInputDecoration(
                isArabic ? 'النبذة الجديدة' : 'New bio',
              ),
            ),
            SizedBox(height: compact ? 10.0 : 14.0),
            SizedBox(
              width: double.infinity,
              height: compact ? 48.0 : 52.0,
              child: FilledButton.icon(
                style: _profileEditSubmitButtonStyle(),
                onPressed: _submittingChangeRequest
                    ? null
                    : () => _submitProfileChangeRequest(clinicianData),
                icon: _submittingChangeRequest
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.fact_check_outlined),
                label: Text(
                  _submittingChangeRequest
                      ? (isArabic
                          ? 'جارٍ تقديم الإعلان...'
                          : 'Submitting declaration...')
                      : (isArabic ? 'تقديم الإعلان' : 'Submit declaration'),
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestsList({
    required BuildContext context,
    required bool isArabic,
    required List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _profileEditGlassDecoration(alpha: 0.34, radius: 22),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: Color(0xFFFFF4D4)),
        child: Column(
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              isArabic
                  ? 'إعلانات تحديث الملف الشخصي'
                  : 'Profile update declarations',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFFE7C766),
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 12),
            if (docs.isEmpty)
              Text(isArabic
                  ? 'لا توجد إعلانات تحديث للملف الشخصي حتى الآن'
                  : 'No profile update declarations yet')
            else
              ...docs.map((doc) {
                final data = doc.data();
                final status = (data['status'] ?? 'submitted').toString();
                final requestedBio = (data['requestedBio'] ?? '').toString();
                final requestedPhotoUrl =
                    (data['requestedPhotoUrl'] ?? '').toString();

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7C766).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE7C766).withValues(alpha: 0.22),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: isArabic
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        _requestStatusLabel(status, isArabic),
                        style: const TextStyle(
                          color: Color(0xFFE7C766),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (requestedPhotoUrl.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(isArabic
                            ? 'الصورة المعلنة: $requestedPhotoUrl'
                            : 'Declared photo: $requestedPhotoUrl'),
                      ],
                      if (requestedBio.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(isArabic
                            ? 'النبذة المعلنة: $requestedBio'
                            : 'Declared bio: $requestedBio'),
                      ],
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _requestedPhotoUrlController.dispose();
    _requestedBioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);
    final l10n = AppLocalizations.of(context)!;
    final size = MediaQuery.sizeOf(context);
    final compact = size.width > size.height && size.width < 900;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => AppShellActions.goBackOrMenu(context),
            icon: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1B1007).withValues(alpha: 0.50),
                border: Border.all(
                  color: const Color(0xFFFFD98A).withValues(alpha: 0.56),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFD98A).withValues(alpha: 0.34),
                    blurRadius: 16,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                  BoxShadow(
                    color: const Color(0xFFE7A94C).withValues(alpha: 0.24),
                    blurRadius: 26,
                    spreadRadius: 2,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Image.asset(
                isArabic
                    ? 'assets/branding/navigation/back/back_right_gold.png'
                    : 'assets/branding/navigation/back/back_left_gold.png',
                width: 22,
                height: 22,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.arrow_back_rounded,
                    color: Color(0xFFFFE7B2),
                    size: 22,
                  );
                },
              ),
            ),
            tooltip: isArabic ? 'رجوع' : 'Back',
          ),
          title: Text(
            l10n.clinicianEditProfile,
            style: const TextStyle(
              color: Color(0xFFC9A75B),
              fontWeight: FontWeight.w800,
            ),
          ),
          backgroundColor: const Color(0xFF0F1316).withValues(alpha: 0.96),
          foregroundColor: const Color(0xFFC9A75B),
          elevation: 0,
        ),
        body: _buildProfileEditBackground(
          child: StreamBuilder<Map<String, dynamic>?>(
            stream: _clinicianStream(),
            builder: (context, clinicianSnapshot) {
              final clinicianData =
                  clinicianSnapshot.data ?? <String, dynamic>{};

              return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _requestsStream(),
                builder: (context, requestSnapshot) {
                  final docs = requestSnapshot.data?.docs ?? const [];
                  final hasPending = docs.any(
                    (doc) =>
                        (doc.data()['status'] ?? 'submitted') == 'submitted',
                  );

                  return ListView(
                    padding: EdgeInsets.all(compact ? 14.0 : AppSpacing.lg),
                    children: [
                      if (hasPending)
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: _profileEditGlassDecoration(
                            alpha: 0.34,
                            radius: 22,
                          ),
                          child: Text(
                            isArabic
                                ? 'تم تقديم إعلان تحديث للملف الشخصي. يمكنك متابعة حالته هنا.'
                                : 'A profile update declaration is submitted. You can track it here.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: const Color(0xFFFFF4D4),
                                ),
                            textAlign:
                                isArabic ? TextAlign.right : TextAlign.left,
                          ),
                        )
                      else
                        _buildRequestForm(
                          context: context,
                          isArabic: isArabic,
                          clinicianData: clinicianData,
                        ),
                      const SizedBox(height: 12),
                      _buildRequestsList(
                        context: context,
                        isArabic: isArabic,
                        docs: docs,
                      ),
                    ],
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
