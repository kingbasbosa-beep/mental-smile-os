import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/web_registration/data/web_registration_draft_store.dart';
import 'package:flutterprojects/features/web_registration/presentation/web_registration_background.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';

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

  static const Color _fieldGold = Color(0xFFE8C878);
  static const Color _fieldSilver = Color(0xFFEDEDED);

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

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.login,
      (_) => false,
    );
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
    final l10n = AppLocalizations.of(context)!;

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
        _errorMessage = e.message ?? l10n.webCenterRegistrationFailed;
      });
    } catch (_) {
      setState(() {
        _errorMessage = l10n.webCenterRegistrationFailed;
      });
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
            Positioned(
              top: 16,
              right: 16,
              child: SafeArea(
                child: IconButton(
                  onPressed: _signOut,
                  icon: Image.asset(
                    'assets/branding/navigation/logout/logout_gold.png',
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.logout_rounded);
                    },
                  ),
                ),
              ),
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
                              Text(
                                l10n.webCenterRegistrationPortalTitle,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                l10n.webCenterRegistrationPortalSubtitle,
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
                                label: Text(l10n.webCenterGuidanceLibrary),
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
                                style: const TextStyle(
                                  color: _fieldGold,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration:
                                    _fieldDecoration(l10n.webCenterCenterName),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return l10n.webCenterCenterNameRequired;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                initialValue: _category,
                                dropdownColor: Colors.black,
                                iconEnabledColor: _fieldGold,
                                style: const TextStyle(
                                  color: _fieldGold,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration:
                                    _fieldDecoration(l10n.webCenterCategory),
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
                                        ? l10n.authRequiredField
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
                                dropdownColor: Colors.black,
                                iconEnabledColor: _fieldGold,
                                style: const TextStyle(
                                  color: _fieldGold,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration:
                                    _fieldDecoration(l10n.webCenterType),
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
                                        ? l10n.authRequiredField
                                        : null,
                                onChanged: _isSubmitting
                                    ? null
                                    : (value) =>
                                        setState(() => _centerType = value),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _emailController,
                                style: const TextStyle(
                                  color: _fieldGold,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration: _fieldDecoration(l10n.authEmail),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  final email = value?.trim() ?? '';
                                  if (email.isEmpty) {
                                    return l10n.authEmailRequired;
                                  }
                                  if (!email.contains('@')) {
                                    return l10n.authInvalidEmail;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _passwordController,
                                style: const TextStyle(
                                  color: _fieldGold,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration:
                                    _fieldDecoration(l10n.authPassword),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.length < 6) {
                                    return l10n.authWeakPassword;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _confirmPasswordController,
                                style: const TextStyle(
                                  color: _fieldGold,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration:
                                    _fieldDecoration(
                                  l10n.webCenterConfirmPassword,
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value != _passwordController.text) {
                                    return l10n.authPasswordsDoNotMatch;
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
                                      : Text(l10n.webCenterNextBasicInfo),
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

  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: _fieldGold,
        fontWeight: FontWeight.w700,
      ),
      hintStyle: TextStyle(
        color: _fieldGold.withValues(alpha: 0.72),
        fontWeight: FontWeight.w600,
      ),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.02),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: _fieldSilver.withValues(alpha: 0.75),
          width: 1.2,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: _fieldSilver,
          width: 1.8,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.redAccent.withValues(alpha: 0.85),
          width: 1.2,
        ),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.redAccent,
          width: 1.8,
        ),
      ),
    );
  }
}
