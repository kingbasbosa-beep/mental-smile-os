import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_smile_os/app/router/routes.dart';

class MkLanguagePage extends ConsumerWidget {
  const MkLanguagePage({super.key});

  static const _gold = Color(0xFFE0C174);
  static const _silver = Color(0xFFE8E8E8);

  Widget _backButton(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).maybePop(),
      icon: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF1B1007).withValues(alpha: 0.50),
          border: Border.all(
            color: _gold.withValues(alpha: 0.56),
          ),
          boxShadow: [
            BoxShadow(
              color: _gold.withValues(alpha: 0.16),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Image.asset(
          Directionality.of(context) == TextDirection.rtl
              ? 'assets/branding/navigation/back/back_right_gold.png'
              : 'assets/branding/navigation/back/back_left_gold.png',
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _registrationItem({
    required BuildContext context,
    required String label,
    required String route,
  }) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(route),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _silver.withValues(alpha: 0.72),
              width: 1.2,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: _silver.withValues(alpha: 0.12),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _gold,
            fontSize: 17,
            fontWeight: FontWeight.w800,
            shadows: [
              Shadow(
                color: _gold.withValues(alpha: 0.5),
                blurRadius: 10,
              ),
              Shadow(
                color: _silver.withValues(alpha: 0.22),
                blurRadius: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: _gold,
          elevation: 0,
          leading: _backButton(context),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      _gold,
                      BlendMode.modulate,
                    ),
                    child: Image.asset(
                      'assets/branding/logo_icon_light.png',
                      width: 190,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _registrationItem(
                    context: context,
                    label: isArabic ? 'تسجيل عميل' : 'Register as client',
                    route: Routes.clientRegister,
                  ),
                  const SizedBox(height: 14),
                  _registrationItem(
                    context: context,
                    label: isArabic ? 'تسجيل أخصائي' : 'Register as clinician',
                    route: Routes.webClinicianRegister,
                  ),
                  const SizedBox(height: 14),
                  _registrationItem(
                    context: context,
                    label: isArabic ? 'تسجيل مركز' : 'Register as center',
                    route: Routes.webCenterRegister,
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
