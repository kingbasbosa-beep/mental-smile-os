import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/web_registration/data/web_registration_draft_store.dart';
import 'package:flutterprojects/features/web_registration/presentation/web_registration_background.dart';

class WebCenterRegisterPortalPage extends StatefulWidget {
  const WebCenterRegisterPortalPage({super.key});

  @override
  State<WebCenterRegisterPortalPage> createState() =>
      _WebCenterRegisterPortalPageState();
}

class _WebCenterRegisterPortalPageState
    extends State<WebCenterRegisterPortalPage> {
  final _formKey = GlobalKey<FormState>();
  final _centerNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _category;
  String? _centerType;
  bool _isSubmitting = false;
  String? _errorMessage;

  static const _categories = [
    {
      'key': 'recovery',
      'labelAr': 'مراكز التعافي',
      'labelEn': 'Recovery Centers'
    },
    {'key': 'detox', 'labelAr': 'مراكز سحب السموم', 'labelEn': 'Detox Centers'},
    {
      'key': 'special_needs',
      'labelAr': 'مراكز رعاية ذوي الاحتياجات الخاصة',
      'labelEn': 'Special Needs Centers',
    },
    {'key': 'hospital', 'labelAr': 'المستشفيات', 'labelEn': 'Hospitals'},
  ];

  static const _centerTypes = [
    {'key': 'halfway_house', 'labelAr': 'هاف واي', 'labelEn': 'Halfway House'},
    {'key': 'detox', 'labelAr': 'ديتوكس / أعراض انسحاب', 'labelEn': 'Detox'},
    {'key': 'hospital', 'labelAr': 'مستشفى', 'labelEn': 'Hospital'},
    {
      'key': 'special_needs_care',
      'labelAr': 'رعاية ذوي الاحتياجات الخاصة',
      'labelEn': 'Special Needs Care',
    },
  ];

  @override
  void dispose() {
    _centerNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Map<String, String> _labels(
    List<Map<String, String>> items,
    String? key,
  ) {
    return items.firstWhere(
      (item) => item['key'] == key,
      orElse: () => const {'labelAr': '', 'labelEn': ''},
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      final uid = credential.user!.uid;
      WebRegistrationDraftStore.setCenterUid(uid);
      final now = FieldValue.serverTimestamp();
      final categoryLabels = _labels(_categories, _category);
      final centerTypeLabels = _labels(_centerTypes, _centerType);

      await FirebaseFirestore.instance.collection('centers').doc(uid).set({
        'role': 'center',
        'name': _centerNameController.text.trim(),
        'centerName': _centerNameController.text.trim(),
        'displayName': _centerNameController.text.trim(),
        'email': _emailController.text.trim(),
        'category': _category,
        'categoryLabelAr': categoryLabels['labelAr'],
        'categoryLabelEn': categoryLabels['labelEn'],
        'centerType': _centerType,
        'centerTypeLabelAr': centerTypeLabels['labelAr'],
        'centerTypeLabelEn': centerTypeLabels['labelEn'],
        'sortOrder': 0,
        'approvalStatus': 'pending_admin',
        'active': false,
        'isActive': false,
        'imagesReady': false,
        'documentsReady': false,
        'createdAt': now,
        'updatedAt': now,
      });

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(
        Routes.webCenterProfile,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'Registration failed. Please try again.';
      });
    } catch (_) {
      setState(() {
        _errorMessage = 'Registration failed. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: webRegistrationCompactFormTheme(
        context,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              webRegistrationBackgroundAsset(
                context,
                roleFolder: 'centers',
                fileName: 'centers_step_1_account.png',
              ),
              fit: BoxFit.contain,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    20,
                    20,
                    webRegistrationFormBottomPadding(context),
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 440),
                    child: Card(
                      elevation: 6,
                      color: webRegistrationPanelNavy.withValues(alpha: 0.18),
                      shadowColor: Colors.black.withValues(alpha: 0.32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(
                          color: webRegistrationBorderTurquoise.withValues(
                              alpha: 0.28),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Center Registration Portal',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Create your center account for admin review.',
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 6),
                              OutlinedButton.icon(
                                onPressed: () =>
                                    Navigator.of(context).pushNamed(
                                  Routes.webLibrary,
                                ),
                                icon: const Icon(Icons.menu_book_outlined,
                                    size: 16),
                                label: const Text('مكتبة الإرشاد'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: webRegistrationTextTurquoise,
                                  side: BorderSide(
                                    color: webRegistrationBorderTurquoise
                                        .withValues(
                                      alpha: 0.55,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  textStyle: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    shadows: webRegistrationTextShadows,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                controller: _centerNameController,
                                decoration: const InputDecoration(
                                  labelText: 'Center name',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Center name is required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                initialValue: _category,
                                decoration: const InputDecoration(
                                  labelText: 'Category',
                                  border: OutlineInputBorder(),
                                ),
                                items: _categories
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: item['key'],
                                        child: Text(item['labelEn'] ?? ''),
                                      ),
                                    )
                                    .toList(),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Required'
                                        : null,
                                onChanged: _isSubmitting
                                    ? null
                                    : (value) {
                                        setState(() {
                                          _category = value;
                                          if (value == 'detox') {
                                            _centerType = 'detox';
                                          } else if (value == 'hospital') {
                                            _centerType = 'hospital';
                                          } else if (value == 'special_needs') {
                                            _centerType = 'special_needs_care';
                                          } else {
                                            _centerType = 'halfway_house';
                                          }
                                        });
                                      },
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                initialValue: _centerType,
                                decoration: const InputDecoration(
                                  labelText: 'Center type',
                                  border: OutlineInputBorder(),
                                ),
                                items: _centerTypes
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: item['key'],
                                        child: Text(item['labelEn'] ?? ''),
                                      ),
                                    )
                                    .toList(),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Required'
                                        : null,
                                onChanged: _isSubmitting
                                    ? null
                                    : (value) =>
                                        setState(() => _centerType = value),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  final email = value?.trim() ?? '';
                                  if (email.isEmpty) return 'Email is required';
                                  if (!email.contains('@')) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(),
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _confirmPasswordController,
                                decoration: const InputDecoration(
                                  labelText: 'Confirm password',
                                  border: OutlineInputBorder(),
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                              if (_errorMessage != null) ...[
                                const SizedBox(height: 10),
                                Text(
                                  _errorMessage!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 22),
                              SizedBox(
                                width: double.infinity,
                                height: 44,
                                child: ElevatedButton(
                                  onPressed: _isSubmitting ? null : _submit,
                                  child: _isSubmitting
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text('Next: Basic Info'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
