import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/core/auth/account_access_service.dart';
import 'package:flutterprojects/shared/contracts/role_names.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const _cyberNavy = Color(0xFF061A26);
  static const _cyberTurquoise = Color(0xFF00E5FF);
  static const _cyberText = Color(0xFF7DF9FF);
  static const _cyberGold = Color(0xFFE0C174);

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

  String _err(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'البريد الإلكتروني غير صالح';
      case 'user-disabled':
        return 'هذا الحساب موقوف';
      case 'user-not-found':
        return 'الحساب غير موجود';
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة';
      case 'network-request-failed':
        return 'مشكلة في الاتصال';
      default:
        return 'فشل تسجيل الدخول';
    }
  }

  Future<String> _resolve(User u, SignedInAccessState a) async {
    // Blocked users
    if (a.isBlocked && !a.isAdmin) {
      return Routes.blockedAccount;
    }

    // Approval gate for center & clinician
    final needsApproval =
        a.role == RoleNames.clinician || a.role == RoleNames.center;

    if (needsApproval) {
      final status = a.approvalStatus.trim().toLowerCase();

      if (status == 'rejected' || status == 'rejected_admin') {
        return Routes.blockedAccount;
      }

      if (status != 'approved' || !a.isActive) {
        return Routes.blockedAccount;
      }
    }

    // Normal routing
    switch (a.role) {
      case RoleNames.admin:
        return Routes.adminHub;
      case RoleNames.clinician:
        return Routes.clinicianOperations;
      case RoleNames.center:
        return Routes.centerDashboard;
      case RoleNames.client:
        return Routes.clientDashboard;
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
      setState(() => _error = _err(e));
    } catch (_) {
      setState(() => _error = 'خطأ غير متوقع');
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
  }) {
    return TextField(
      controller: c,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
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

  Widget _loginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _cyberNavy,
          foregroundColor: _cyberText,
          disabledBackgroundColor: _cyberNavy.withValues(alpha: 0.55),
          disabledForegroundColor: _cyberText.withValues(alpha: 0.55),
          side:
              BorderSide(color: _cyberGold.withValues(alpha: 0.9), width: 1.2),
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
                  color: _cyberText,
                ),
              )
            : const Text('دخول | Login'),
      ),
    );
  }

  Widget _registrationEntry({
    required IconData icon,
    required String label,
    required String subtitle,
    required String route,
  }) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: _cyberNavy.withValues(alpha: 0.72),
          foregroundColor: _cyberText,
          side: BorderSide(color: _cyberTurquoise.withValues(alpha: 0.75)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
        onPressed: () => Navigator.pushNamed(context, route),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: 0.22),
                border: Border.all(color: _cyberGold.withValues(alpha: 0.76)),
              ),
              child: Icon(icon, color: _cyberGold, size: 19),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _cyberText,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: _cyberGold.withValues(alpha: 0.88),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: _cyberTurquoise,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(_bg(context), fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: Container(color: Colors.black.withValues(alpha: 0.5)),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 450),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            color: Color(0xFFFFE8A3),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _field(
                          c: _emailController,
                          label: 'البريد الإلكتروني',
                          icon: Icons.email,
                        ),
                        const SizedBox(height: 12),
                        _field(
                          c: _passwordController,
                          label: 'كلمة المرور',
                          icon: Icons.lock,
                          obscure: _obscurePassword,
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
                        _loginButton(),
                        const SizedBox(height: 20),
                        _registrationEntry(
                          icon: Icons.person_add_alt_1_outlined,
                          label: 'تسجيل عميل',
                          subtitle: 'Client registration',
                          route: Routes.clientRegister,
                        ),
                        const SizedBox(height: 10),
                        _registrationEntry(
                          icon: Icons.medical_services_outlined,
                          label: 'تسجيل أخصائي عبر الويب',
                          subtitle: 'Clinician web registration',
                          route: Routes.webClinicianRegister,
                        ),
                        const SizedBox(height: 10),
                        _registrationEntry(
                          icon: Icons.apartment_outlined,
                          label: 'تسجيل مركز عبر الويب',
                          subtitle: 'Center web registration',
                          route: Routes.webCenterRegister,
                        ),
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
