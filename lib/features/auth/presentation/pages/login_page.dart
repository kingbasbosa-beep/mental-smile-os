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
      case 'invalid-email': return 'البريد الإلكتروني غير صالح';
      case 'user-disabled': return 'هذا الحساب موقوف';
      case 'user-not-found': return 'الحساب غير موجود';
      case 'wrong-password': return 'كلمة المرور غير صحيحة';
      case 'network-request-failed': return 'مشكلة في الاتصال';
      default: return 'فشل تسجيل الدخول';
    }
  }

  Future<String> _resolve(User u, SignedInAccessState a) async {
    if (a.isBlocked && !a.isAdmin) return Routes.blockedAccount;
    switch (a.role) {
      case RoleNames.admin: return Routes.adminHub;
      case RoleNames.clinician: return Routes.clinicianOperations;
      case RoleNames.center: return Routes.centerDashboard;
      case RoleNames.client: return Routes.clientDashboard;
    }
    return Routes.menu;
  }

  Future<void> _login() async {
    setState(() { _loading = true; _error = null; });
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
        fillColor: Colors.black.withOpacity(0.4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
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
              child: Container(color: Colors.black.withOpacity(0.5)),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 450),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
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
                              setState(() => _obscurePassword = !_obscurePassword);
                            },
                            icon: Icon(
                              _obscurePassword ? Icons.visibility : Icons.visibility_off,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        if (_error != null) ...[
                          const SizedBox(height: 12),
                          Text(_error!, style: const TextStyle(color: Colors.red)),
                        ],

                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _loading ? null : _login,
                            child: _loading
                                ? const CircularProgressIndicator()
                                : const Text('دخول'),
                          ),
                        ),

                        const SizedBox(height: 20),

                        TextButton(
                          onPressed: () => Navigator.pushNamed(context, Routes.clientRegister),
                          child: const Text('تسجيل عميل'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(context, Routes.clinicianRegister),
                          child: const Text('تسجيل أخصائي'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(context, Routes.centerRegister),
                          child: const Text('تسجيل مركز'),
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
