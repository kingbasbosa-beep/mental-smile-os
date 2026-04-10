import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/core/auth/account_access_service.dart';
import 'package:flutterprojects/core/ui/app_design_system.dart';

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
  String _normalizeEmail(String value) => value.trim().toLowerCase();

  String _translateAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'البريد الإلكتروني غير صالح';
      case 'user-disabled':
        return 'هذا الحساب موقوف';
      case 'user-not-found':
        return 'هذا الحساب غير موجود في Firebase Auth';
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة';
      case 'invalid-credential':
        return 'بيانات الدخول غير صحيحة أو الحساب غير موجود في Firebase Auth';
      case 'network-request-failed':
        return 'فشل الاتصال بالشبكة، حاول مرة أخرى';
      case 'too-many-requests':
        return 'تمت محاولات كثيرة، انتظر قليلًا ثم حاول مرة أخرى';
      default:
        return e.message ?? 'فشل تسجيل الدخول';
    }
  }

  Future<String> _resolveLandingRoute(
    User user,
    SignedInAccessState access,
  ) async {
    if (access.isBlocked && !access.isAdmin) {
      return Routes.blockedAccount;
    }

    switch (access.role) {
      case 'admin':
        return Routes.adminHub;
      case 'clinician':
        return Routes.clinicianOperations;
      case 'center':
        return Routes.centerDashboard;
      case 'client':
        return Routes.clientDashboard;
    }

    if ((user.email ?? '').trim().isNotEmpty) {
      return Routes.clientDashboard;
    }
    return Routes.menu;
  }

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final auth = FirebaseAuth.instance;

      final cred = await auth.signInWithEmailAndPassword(
        email: _normalizeEmail(_emailController.text),
        password: _passwordController.text,
      );

      final user = cred.user;
      if (user == null) {
        throw Exception('User not found after login');
      }

      final access = await AccountAccessService().resolve(user);
      final landingRoute = await _resolveLandingRoute(user, access);
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        landingRoute,
        (route) => false,
        arguments:
            landingRoute == Routes.blockedAccount ? access.blockReason : null,
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _error = _translateAuthError(e));
    } catch (e) {
      setState(() => _error = 'فشل تسجيل الدخول: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Widget _registerNavButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: AppPageBackground(
          child: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 620),
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                    vertical: AppSpacing.xxl,
                  ),
                  children: [
                    const SizedBox(height: AppSpacing.lg),
                    const AppHeroHeader(
                      title: 'تسجيل الدخول',
                      subtitle:
                          'بوابة واحدة هادئة وواضحة للوصول إلى حسابات العميل والأخصائي والمركز بنفس الهوية البصرية للمشروع.',
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppSurfaceCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: appInputDecoration(
                              context: context,
                              label: 'البريد الإلكتروني',
                              icon: Icons.alternate_email,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: appInputDecoration(
                              context: context,
                              label: 'كلمة المرور',
                              icon: Icons.lock_outline,
                              suffixIcon: IconButton(
                                tooltip: _obscurePassword
                                    ? 'إظهار كلمة المرور'
                                    : 'إخفاء كلمة المرور',
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppColors.deepTeal,
                                ),
                              ),
                            ),
                          ),
                          if (_error != null) ...[
                            const SizedBox(height: AppSpacing.md),
                            AppMessageBanner(message: _error!),
                          ],
                          const SizedBox(height: AppSpacing.md),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: FilledButton.icon(
                              onPressed: _loading ? null : _login,
                              icon: _loading
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Icon(Icons.login),
                              label: Text(_loading ? 'جارٍ الدخول...' : 'دخول'),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Text(
                            isArabic
                                ? 'إنشاء حساب جديد'
                                : 'Create a new account',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          _registerNavButton(
                            label: 'تسجيل عميل جديد',
                            icon: Icons.person_add_alt_1_outlined,
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.clientRegister);
                            },
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          _registerNavButton(
                            label: 'تسجيل أخصائي جديد',
                            icon: Icons.medical_services_outlined,
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.clinicianRegister);
                            },
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          _registerNavButton(
                            label: 'تسجيل مركز جديد',
                            icon: Icons.business_outlined,
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.centerRegister);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
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
