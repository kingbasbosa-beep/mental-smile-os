import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/shared/ui_kit/asset_fallback_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

class ClientRegisterPage extends StatefulWidget {
  const ClientRegisterPage({super.key});

  @override
  State<ClientRegisterPage> createState() => _ClientRegisterPageState();
}

class _ClientRegisterPageState extends State<ClientRegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _loading = false;
  String? _error;

  String _selectedAvatar = 'images/avatar_client_fmale.png';

  static const List<String> _avatarOptions = [
    'images/avatar_client_fmale.png',
    'images/avatar_client_male.png',
    'images/avatar_clinician_fmale.png',
    'images/avatar_clinician_male.png',
  ];

  Future<void> _register() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty) {
      setState(() => _error = 'اكتب الاسم');
      return;
    }

    if (email.isEmpty) {
      setState(() => _error = 'اكتب البريد الإلكتروني');
      return;
    }

    if (password.length < 6) {
      setState(() => _error = 'كلمة المرور يجب أن تكون 6 أحرف على الأقل');
      return;
    }

    if (password != confirmPassword) {
      setState(() => _error = 'تأكيد كلمة المرور غير مطابق');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final auth = FirebaseAuth.instance;

      final cred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await cred.user?.updateDisplayName(name);
      await FirebaseFirestore.instance
          .collection('clients')
          .doc(cred.user!.uid)
          .set({
        'role': 'client',
        'displayName': name,
        'email': email,
        'avatarAsset': _selectedAvatar,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      await cred.user?.reload();

      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/menu',
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = e.message ?? 'فشل إنشاء حساب العميل';
      });
    } catch (e) {
      setState(() {
        _error = 'فشل إنشاء حساب العميل: $e';
      });
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      title: 'حساب عميل جديد',
                      subtitle:
                          'ابدأ حسابًا بسيطًا وواضحًا بنفس الطابع البصري الهادئ، مع صورة شخصية وإعدادات أساسية جاهزة للمتابعة لاحقًا.',
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppSurfaceCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'اختر صورة الحساب',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Wrap(
                            spacing: AppSpacing.sm,
                            runSpacing: AppSpacing.sm,
                            children: _avatarOptions.map((avatar) {
                              final isSelected = _selectedAvatar == avatar;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedAvatar = avatar;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 180),
                                  width: 74,
                                  height: 74,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.deepTeal
                                          : AppColors.mutedGold
                                              .withValues(alpha: 0.20),
                                      width: isSelected ? 3 : 1.2,
                                    ),
                                    boxShadow: isSelected
                                        ? const [
                                            BoxShadow(
                                              blurRadius: 14,
                                              color: Color(0x221A4B4F),
                                              offset: Offset(0, 4),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      normalizeAssetPath(avatar),
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          const AppMissingAssetPlaceholder(),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          TextField(
                            controller: _nameController,
                            decoration: appInputDecoration(
                              context: context,
                              label: 'الاسم',
                              icon: Icons.person_outline,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
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
                            obscureText: true,
                            decoration: appInputDecoration(
                              context: context,
                              label: 'كلمة المرور',
                              icon: Icons.lock_outline,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          TextField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: appInputDecoration(
                              context: context,
                              label: 'تأكيد كلمة المرور',
                              icon: Icons.verified_user_outlined,
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
                              onPressed: _loading ? null : _register,
                              icon: _loading
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Icon(Icons.person_add_alt_1),
                              label: Text(
                                _loading
                                    ? 'جارٍ إنشاء الحساب...'
                                    : 'إنشاء حساب عميل',
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child:
                                  const Text('لديك حساب بالفعل؟ تسجيل الدخول'),
                            ),
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
