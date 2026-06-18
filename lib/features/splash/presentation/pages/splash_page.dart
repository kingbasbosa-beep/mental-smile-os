import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_smile_os/app/locale_provider.dart';
import 'package:mental_smile_os/app/router/routes.dart';
import 'package:mental_smile_os/core/storage/locale_storage.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  bool _languagePressed = false;

  String _backgroundAsset(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 600) {
      return 'assets/branding/splash/splash_mobile_v1.jpg';
    }

    if (width < 1100) {
      return 'assets/branding/splash/splash_tablet_v1.jpg';
    }

    return 'assets/branding/splash/splash_web_v1.jpg';
  }

  Future<void> _toggleLocale(Locale locale) async {
    final nextCode = locale.languageCode.toLowerCase() == 'ar' ? 'en' : 'ar';
    await LocaleStorage().write(nextCode);
    ref.read(localeProvider.notifier).state = Locale(nextCode);
  }

  void _showProviderCenterAccessSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: const Color(0xFFF7F4EF),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Provider / Center Access',
                  style: TextStyle(
                    color: Color(0xFF17201B),
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 12),
                _SplashSheetAction(
                  icon: Icons.psychology_alt_outlined,
                  label: 'Providers',
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    Navigator.of(context).pushNamed(Routes.sCityProviders);
                  },
                ),
                const SizedBox(height: 10),
                _SplashSheetAction(
                  icon: Icons.apartment_outlined,
                  label: 'Centers',
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    Navigator.of(context).pushNamed(Routes.sCityCenters);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bg = _backgroundAsset(context);
    final languageIconSize =
        MediaQuery.sizeOf(context).width < 700 ? 46.0 : 60.0;
    final locale = ref.watch(localeProvider);
    final activeLocale = locale ?? Localizations.localeOf(context);
    final isArabic = activeLocale.languageCode.toLowerCase() == 'ar';
    final isMobile = MediaQuery.sizeOf(context).width < 700;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                bg,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.25),
              ),
            ),
            Positioned(
              top: 20,
              right: isMobile ? 24 : 96,
              child: Tooltip(
                message: isArabic ? 'English' : 'Arabic',
                child: GestureDetector(
                  onTapDown: (_) => setState(() => _languagePressed = true),
                  onTapCancel: () => setState(() => _languagePressed = false),
                  onTapUp: (_) => setState(() => _languagePressed = false),
                  onTap: () => _toggleLocale(activeLocale),
                  child: AnimatedScale(
                    scale: _languagePressed ? 0.96 : 1,
                    duration: const Duration(milliseconds: 120),
                    curve: Curves.easeOutCubic,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 140),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(
                          alpha: _languagePressed ? 0.24 : 0.14,
                        ),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: const Color(0xFFFFE8A3).withValues(
                            alpha: _languagePressed ? 0.56 : 0.34,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFD4AF37).withValues(
                              alpha: _languagePressed ? 0.34 : 0.18,
                            ),
                            blurRadius: _languagePressed ? 20 : 12,
                          ),
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.22),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/branding/language/en_gold.png',
                        width: languageIconSize,
                        height: languageIconSize,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Text(
                            isArabic ? 'EN' : 'AR',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFE8A3),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(
                  right: isMobile ? 24 : 92,
                  left: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _SplashPrimaryAction(
                      label: 'Quick Access',
                      icon: Icons.flash_on_rounded,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          Routes.clientSessionRoom,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    _SplashSecondaryAction(
                      label: 'Accessibility Access',
                      icon: Icons.accessibility_new_rounded,
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.accessibility);
                      },
                    ),
                    const SizedBox(height: 10),
                    _SplashSecondaryAction(
                      label: 'Provider / Center Access',
                      icon: Icons.business_center_outlined,
                      onPressed: () => _showProviderCenterAccessSheet(context),
                    ),
                    const SizedBox(height: 10),
                    _SplashSecondaryAction(
                      label: 'Legacy Login',
                      icon: Icons.login_rounded,
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                          Routes.login,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    _SplashSecondaryAction(
                      label: 'Web Portal',
                      icon: Icons.public_rounded,
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                          Routes.portalHome,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SplashPrimaryAction extends StatelessWidget {
  const _SplashPrimaryAction({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minWidth: 220),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF4C2),
              Color(0xFFD4AF37),
              Color(0xFF7A4E12),
            ],
          ),
          border: Border.all(
            color: const Color(0xFFFFE8A3),
            width: 1.3,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD4AF37).withValues(alpha: 0.65),
              blurRadius: 24,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFFF4F1E8), size: 20),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFFF4F1E8),
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      blurRadius: 6,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SplashSecondaryAction extends StatelessWidget {
  const _SplashSecondaryAction({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFFFFE8A3),
        backgroundColor: Colors.black.withValues(alpha: 0.18),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
          side: BorderSide(
            color: const Color(0xFFFFE8A3).withValues(alpha: 0.34),
          ),
        ),
      ),
      label: Text(
        label,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          shadows: [
            Shadow(
              color: Colors.black54,
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }
}

class _SplashSheetAction extends StatelessWidget {
  const _SplashSheetAction({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFF116A5B),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
