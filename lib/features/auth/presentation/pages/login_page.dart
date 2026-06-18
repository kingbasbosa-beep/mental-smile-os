import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_smile_os/app/router/routes.dart';
import 'package:mental_smile_os/core/auth/account_access_service.dart';
import 'package:mental_smile_os/core/visibility/visibility_readiness.dart';
import 'package:mental_smile_os/l10n/app_localizations.dart';
import 'package:mental_smile_os/shared/contracts/role_names.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const _cyberGold = Color(0xFFE0C174);
  static const _clientMutedText = Color(0xFFB8B8B8);
  static const _clientInputText = Color(0xFFFFE7B0);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;
  bool _obscurePassword = true;
  String? _error;

  String _normalizeEmail(String v) => v.trim().toLowerCase();

  String _bg(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < 600) return 'assets/branding/login/login_mobile_v1.png';
    if (w < 1100) return 'assets/branding/login/login_tablet_v1.png';
    return 'assets/branding/login/login_web_v1.png';
  }

  String _err(FirebaseAuthException e, AppLocalizations l10n) {
    switch (e.code) {
      case 'invalid-email':
        return l10n.authInvalidEmail;
      case 'user-disabled':
        return l10n.authLoginFailed;
      case 'user-not-found':
        return l10n.authInvalidCredentialsMessage;
      case 'wrong-password':
        return l10n.authInvalidCredentialsMessage;
      case 'network-request-failed':
        return l10n.authTryAgain;
      default:
        return l10n.authLoginFailed;
    }
  }

  Future<String> _resolve(User u, SignedInAccessState a) async {
    // Blocked users
    if (a.isBlocked) {
      return Routes.blockedAccount;
    }

    // Visibility readiness gate for centers and clinicians.
    final needsReadiness =
        a.role == RoleNames.clinician || a.role == RoleNames.center;

    if (needsReadiness &&
        a.visibilityReadiness != VisibilityReadiness.ready) {
      return Routes.blockedAccount;
    }

    // Normal routing
    switch (a.role) {
      case RoleNames.owner:
        return Routes.sOwnerHome;
      case RoleNames.monitoringOperator:
        return Routes.sSignalMonitoringRoom;
      case RoleNames.registrySteward:
        return Routes.sRegistryRoom;
      case RoleNames.declarationReviewer:
        return Routes.sDeclarationReviewRoom;
      case RoleNames.supportObserver:
        return Routes.sSupportRoom;
      case RoleNames.clinician:
        return Routes.clinicianRoom;
      case RoleNames.center:
        return Routes.centerDashboard;
      case RoleNames.client:
        return Routes.clientSessionRoom;
      default:
        return Routes.menu;
    }
  }

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _normalizeEmail(_emailController.text),
        password: _passwordController.text,
      );

      final u = cred.user!;
      final a = await AccountAccessService().resolve(u);
      final r = await _resolve(u, a);

      if (!mounted) return;

      Navigator.of(context).pushNamedAndRemoveUntil(r, (route) => false);
    } on FirebaseAuthException catch (e) {
      final l10n = AppLocalizations.of(context)!;
      setState(() => _error = _err(e, l10n));
    } catch (_) {
      final l10n = AppLocalizations.of(context)!;
      setState(() => _error = l10n.authUnexpectedError);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Widget _field({
    required TextEditingController c,
    required String label,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
    bool clientStyle = false,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: c,
      keyboardType: keyboardType,
      obscureText: obscure,
      style: clientStyle
          ? const TextStyle(
              color: _clientInputText,
              fontSize: 14,
            )
          : const TextStyle(color: Colors.white),
      decoration: clientStyle
          ? InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(
                color: _clientMutedText,
                fontWeight: FontWeight.w700,
              ),
              prefixIcon: Icon(icon, color: _cyberGold),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 36,
                minHeight: 36,
              ),
              suffixIcon: suffix,
              filled: true,
              fillColor: Colors.transparent,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 6),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: _cyberGold, width: 1.2),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: _cyberGold, width: 2),
              ),
            )
          : InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(color: Color(0xFFFFE8A3)),
              prefixIcon: Icon(icon, color: const Color(0xFFFFE8A3)),
              suffixIcon: suffix,
              filled: true,
              fillColor: Colors.black.withValues(alpha: 0.4),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
    );
  }

  Widget _loginButton(AppLocalizations l10n) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: _loading
              ? [
                  const Color(0xFFD8D8D8).withValues(alpha: 0.45),
                  const Color(0xFFF8F8F8).withValues(alpha: 0.5),
                  const Color(0xFFBEBEBE).withValues(alpha: 0.45),
                ]
              : const [
                  Color(0xFFE8E8E8),
                  Color(0xFFFFFFFF),
                  Color(0xFFBDBDBD),
                ],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.78)),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: _loading ? 0.18 : 0.42),
            blurRadius: 18,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: _cyberGold.withValues(alpha: _loading ? 0.12 : 0.24),
            blurRadius: 22,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: const Color(0xFF111111),
            disabledBackgroundColor: Colors.transparent,
            disabledForegroundColor:
                const Color(0xFF111111).withValues(alpha: 0.55),
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
            elevation: 0,
          ),
          onPressed: _loading ? null : _login,
          child: _loading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    color: Color(0xFF111111),
                  ),
                )
              : Text(l10n.authLoginButton),
        ),
      ),
    );
  }

  Widget _registerLink(AppLocalizations l10n) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: _cyberGold,
        overlayColor: Colors.transparent,
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 28),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(Routes.language);
      },
      child: Text(
        l10n.authCreateAccount,
        style: TextStyle(
          color: _cyberGold,
          fontSize: 13,
          fontWeight: FontWeight.w800,
          shadows: [
            Shadow(
              color: _cyberGold.withValues(alpha: 0.72),
              blurRadius: 10,
            ),
            Shadow(
              color: Colors.white.withValues(alpha: 0.34),
              blurRadius: 14,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final textDirection = locale.languageCode.toLowerCase() == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(_bg(context), fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: Container(color: Colors.black.withValues(alpha: 0.5)),
            ),
            Align(
              alignment: const Alignment(0, 0.78),
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 390),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.03),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        Text(
                          l10n.authLoginTitle,
                          style: const TextStyle(
                            color: Color(0xFFFFE8A3),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _field(
                          c: _emailController,
                          label: l10n.authEmail,
                          icon: Icons.alternate_email,
                          clientStyle: true,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 12),
                        _field(
                          c: _passwordController,
                          label: l10n.authPassword,
                          icon: Icons.lock_outline,
                          obscure: _obscurePassword,
                          clientStyle: true,
                          suffix: IconButton(
                            onPressed: () {
                              setState(
                                  () => _obscurePassword = !_obscurePassword);
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if (_error != null) ...[
                          const SizedBox(height: 12),
                          Text(_error!,
                              style: const TextStyle(color: Colors.red)),
                        ],
                        const SizedBox(height: 20),
                        _loginButton(l10n),
                        const SizedBox(height: 10),
                        _registerLink(l10n),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
