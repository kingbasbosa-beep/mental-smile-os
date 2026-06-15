import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mental_smile_os/app/router/routes.dart';
import 'package:mental_smile_os/features/web_registration/data/web_registration_draft_store.dart';
import 'package:mental_smile_os/features/web_registration/domain/declaration_readiness.dart';
import 'package:mental_smile_os/features/web_registration/presentation/web_registration_background.dart';
import 'package:mental_smile_os/l10n/app_localizations.dart';

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
  static const Color _inputCream = Color(0xFFFFF6DE);

  static const _categories = [
    {
      'key': 'recovery',
      'labelAr': 'مراكز التعافي',
      'labelEn': 'Recovery Centers'
    },
    {
      'key': 'detox',
      'labelAr': 'مراكز سحب السموم',
      'labelEn': 'Detox Centers',
    },
    {
      'key': 'special_needs',
      'labelAr': 'مراكز رعاية ذوي الاحتياجات الخاصة',
      'labelEn': 'Special Needs Centers',
    },
    {
      'key': 'hospital',
      'labelAr': 'المستشفيات',
      'labelEn': 'Hospitals',
    },
  ];
  static const _centerTypes = [
    {
      'key': 'halfway_house',
      'labelAr': 'هاف واي',
      'labelEn': 'Halfway House',
    },
    {
      'key': 'detox',
      'labelAr': 'ديتوكس / أعراض انسحاب',
      'labelEn': 'Detox',
    },
    {
      'key': 'hospital',
      'labelAr': 'مستشفى',
      'labelEn': 'Hospital',
    },
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

      final user = credential.user;
      if (user == null) {
        throw StateError('Center registration auth user is null.');
      }
      await user.updateDisplayName(_centerNameController.text.trim());
      await user.reload();
      final uid = user.uid;
      WebRegistrationDraftStore.setCenterUid(uid);
      final now = FieldValue.serverTimestamp();
      final categoryLabels = _labels(_categories, _category);
      final centerTypeLabels = _labels(_centerTypes, _centerType);

      final registrationData = <String, dynamic>{
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
        'isBlocked': false,
        'createdAt': now,
        'updatedAt': now,
      };
      await FirebaseFirestore.instance.collection('centers').doc(uid).set(
            DeclarationReadiness.centerPayload(
              currentData: const <String, dynamic>{},
              changes: registrationData,
            ),
          );

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(
        Routes.webCenterProfile,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? l10n.webCenterRegistrationFailed;
      });
    } on FirebaseException catch (e) {
      setState(() {
        _errorMessage = l10n.webCenterRegistrationFailed;
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

    final mediaQuery = MediaQuery.of(context);
    final isLandscapeCompact = mediaQuery.size.width > mediaQuery.size.height &&
        mediaQuery.size.height < 520;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final compactGap = isLandscapeCompact ? 8.0 : 10.0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                    'assets/branding/shared/navigation/logout/logout_gold.png',
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
                    isLandscapeCompact ? 8 : 20,
                    20,
                    webRegistrationFormBottomPadding(context) +
                        mediaQuery.viewInsets.bottom,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isLandscapeCompact ? 380 : 440,
                    ),
                    child: Card(
                      elevation: isLandscapeCompact ? 4 : 6,
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
                        padding: EdgeInsets.all(isLandscapeCompact ? 14 : 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: isLandscapeCompact ? 8 : 14),
                              const Text(
                                'Declaration step: submitting this data records readiness signals. Visibility depends on required signal completeness and safety status.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  height: 1.35,
                                ),
                              ),
                              SizedBox(height: compactGap),
                              TextButton(
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(Routes.portalHome),
                                child: Text(
                                  isArabic
                                      ? 'العودة إلى بوابة Mental Smile'
                                      : 'Back to Mental Smile Portal',
                                ),
                              ),
                              SizedBox(height: compactGap),
                              TextFormField(
                                controller: _centerNameController,
                                style: const TextStyle(
                                  color: _inputCream,
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
                              SizedBox(height: compactGap),
                              DropdownButtonFormField<String>(
                                initialValue: _category,
                                dropdownColor: Colors.black,
                                iconEnabledColor: _fieldGold,
                                style: const TextStyle(
                                  color: _inputCream,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration:
                                    _fieldDecoration(l10n.webCenterCategory),
                                items: _categories
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: item['key'],
                                        child: Text(
                                          isArabic
                                              ? (item['labelAr'] ?? '')
                                              : (item['labelEn'] ?? ''),
                                        ),
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
                              SizedBox(height: compactGap),
                              DropdownButtonFormField<String>(
                                initialValue: _centerType,
                                dropdownColor: Colors.black,
                                iconEnabledColor: _fieldGold,
                                style: const TextStyle(
                                  color: _inputCream,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration:
                                    _fieldDecoration(l10n.webCenterType),
                                items: _centerTypes
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: item['key'],
                                        child: Text(
                                          isArabic
                                              ? (item['labelAr'] ?? '')
                                              : (item['labelEn'] ?? ''),
                                        ),
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
                              SizedBox(height: compactGap),
                              TextFormField(
                                controller: _emailController,
                                style: const TextStyle(
                                  color: _inputCream,
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
                              SizedBox(height: compactGap),
                              TextFormField(
                                controller: _passwordController,
                                style: const TextStyle(
                                  color: _inputCream,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration: _fieldDecoration(l10n.authPassword),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.length < 6) {
                                    return l10n.authWeakPassword;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: compactGap),
                              TextFormField(
                                controller: _confirmPasswordController,
                                style: const TextStyle(
                                  color: _inputCream,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration: _fieldDecoration(
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
                              SizedBox(height: isLandscapeCompact ? 14 : 22),
                              SizedBox(
                                width: double.infinity,
                                height: isLandscapeCompact ? 40 : 44,
                                child: ElevatedButton(
                                  onPressed: _isSubmitting ? null : _submit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _fieldGold,
                                    foregroundColor: const Color(0xFF17100A),
                                    disabledBackgroundColor:
                                        _fieldGold.withValues(alpha: 0.45),
                                    disabledForegroundColor:
                                        Colors.black.withValues(alpha: 0.55),
                                    elevation: 6,
                                    shadowColor:
                                        _fieldGold.withValues(alpha: 0.28),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      side: BorderSide(
                                        color: _fieldSilver.withValues(
                                          alpha: 0.42,
                                        ),
                                      ),
                                    ),
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0,
                                    ),
                                  ),
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
