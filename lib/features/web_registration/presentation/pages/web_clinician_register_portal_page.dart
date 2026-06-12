import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/specialists/data/clinician_specialty_catalog.dart';
import 'package:flutterprojects/features/web_registration/data/web_registration_draft_store.dart';
import 'package:flutterprojects/features/web_registration/domain/declaration_readiness.dart';
import 'package:flutterprojects/features/web_registration/presentation/web_registration_background.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';

class WebClinicianRegisterPortalPage extends StatefulWidget {
  const WebClinicianRegisterPortalPage({super.key});

  @override
  State<WebClinicianRegisterPortalPage> createState() =>
      _WebClinicianRegisterPortalPageState();
}

class _WebClinicianRegisterPortalPageState
    extends State<WebClinicianRegisterPortalPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isSubmitting = false;
  String? _error;
  String? _selectedProfessionalTitleKey;
  String? _selectedSpecialtyKey;
  final Set<String> _selectedCapabilitySignals = {};
  final Set<String> _selectedAccessibilitySignals = {};
  final Set<String> _selectedCommunicationSignals = {};
  final Set<String> _selectedLearningSignals = {};

  static const Color _fieldGold = Color(0xFFE8C878);
  static const Color _fieldSilver = Color(0xFFEDEDED);
  static const Color _inputCream = Color(0xFFFFF6DE);
  // [S] Provider Signals
  // Additive declaration signals only.
  static const String _signalSchemaVersion = 'provider_signals_v1';

  static const List<Map<String, String>> _professionalTitles = [
    {'key': 'doctor', 'labelAr': 'د.', 'labelEn': 'Dr.'},
    {'key': 'specialist', 'labelAr': 'أ.', 'labelEn': 'Spec.'},
  ];

  static final List<Map<String, String>> _specialties =
      ClinicianSpecialtyCatalog.specialties
          .map((specialty) => {
                'key': specialty.key,
                'label': specialty.labelAr,
              })
          .toList(growable: false);

  // [S] Provider Signals
  // Capability/accessibility/communication/learning signals only.
  static const List<_ProviderSignalOption> _capabilitySignalOptions = [
    _ProviderSignalOption('psychologist', 'أخصائي نفسي', 'Psychologist'),
    _ProviderSignalOption(
      'clinical_psychologist',
      'أخصائي نفسي إكلينيكي',
      'Clinical psychologist',
    ),
    _ProviderSignalOption(
      'addiction_counselor',
      'إرشاد مرتبط بالإدمان',
      'Addiction counseling',
    ),
    _ProviderSignalOption(
      'speech_specialist',
      'يدعم صعوبات النطق',
      'Speech support',
    ),
    _ProviderSignalOption(
      'family_counselor',
      'مناسب للأسر',
      'Family counselor',
    ),
    _ProviderSignalOption('coach', 'كوتشينج', 'Coaching'),
    _ProviderSignalOption(
      'recovery_support',
      'دعم مرتبط بالتعافي',
      'Recovery support',
    ),
    _ProviderSignalOption(
      'family_support',
      'دعم أسري',
      'Family support',
    ),
    _ProviderSignalOption(
      'children_support',
      'مناسب للأطفال',
      'Children support',
    ),
    _ProviderSignalOption(
      'mental_health_support',
      'دعم الصحة النفسية',
      'Mental health support',
    ),
    _ProviderSignalOption(
      'psychiatric_without_addiction_awareness',
      'توعية نفسية غير مرتبطة بالإدمان',
      'Non-addiction mental health awareness',
    ),
    _ProviderSignalOption(
      'hiv_sensitive_support',
      'دعم حساس لفيروس نقص المناعة',
      'HIV-sensitive support',
    ),
  ];

  static const List<_ProviderSignalOption> _accessibilitySignalOptions = [
    _ProviderSignalOption(
      'speech_support',
      'يدعم صعوبات النطق',
      'Speech support',
    ),
    _ProviderSignalOption(
      'hearing_support',
      'يدعم صعوبات السمع',
      'Hearing support',
    ),
    _ProviderSignalOption(
      'visual_assistance',
      'يدعم مساعدة بصرية',
      'Visual assistance',
    ),
    _ProviderSignalOption(
      'simplified_communication',
      'يدعم تواصل مبسط',
      'Simplified communication',
    ),
    _ProviderSignalOption(
      'text_based_support',
      'يدعم تواصل نصي',
      'Text-based support',
    ),
  ];

  static const List<_ProviderSignalOption> _communicationSignalOptions = [
    _ProviderSignalOption('in_person', 'حضوري', 'In person'),
    _ProviderSignalOption('online', 'أونلاين', 'Online'),
    _ProviderSignalOption('text', 'نصي', 'Text'),
    _ProviderSignalOption('audio', 'صوتي', 'Audio'),
    _ProviderSignalOption('video', 'فيديو', 'Video'),
    _ProviderSignalOption(
      'group_support',
      'جلسات جماعية',
      'Group support',
    ),
  ];

  static const List<_ProviderSignalOption> _learningSignalOptions = [
    _ProviderSignalOption(
      'provider_learning',
      'تطوير مهني',
      'Provider learning',
    ),
    _ProviderSignalOption(
      'family_support_learning',
      'تعلم دعم الأسرة',
      'Family support learning',
    ),
    _ProviderSignalOption(
      'recovery_learning',
      'تعلم دعم التعافي',
      'Recovery learning',
    ),
    _ProviderSignalOption(
      'accessibility_learning',
      'تعلم الوصول والإتاحة',
      'Accessibility learning',
    ),
    _ProviderSignalOption(
      'content_contribution',
      'مساهمة معرفية',
      'Content contribution',
    ),
  ];

  @override
  void dispose() {
    _nameController.dispose();
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

  Map<String, String>? _selectedTitle() {
    for (final title in _professionalTitles) {
      if (title['key'] == _selectedProfessionalTitleKey) return title;
    }
    return null;
  }

  Map<String, String>? _selectedSpecialty() {
    for (final specialty in _specialties) {
      if (specialty['key'] == _selectedSpecialtyKey) return specialty;
    }
    return null;
  }

  List<String> _sortedSignals(Set<String> signals) {
    final values = signals.toList()..sort();
    return values;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context)!;

    setState(() {
      _isSubmitting = true;
      _error = null;
    });

    try {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim().toLowerCase();
      final title = _selectedTitle();
      final specialty = _selectedSpecialty();
      final titleLabelAr = title?['labelAr'] ?? '';
      final titleLabelEn = title?['labelEn'] ?? '';
      final specialtyLabel = specialty?['label'] ?? '';

      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: _passwordController.text,
      );
      final user = credential.user;
      if (user == null) {
        throw Exception('Clinician auth user is null');
      }
      await user.updateDisplayName(name);
      await user.reload();
      final uid = user.uid;

      WebRegistrationDraftStore.setClinicianUid(uid);

      final now = FieldValue.serverTimestamp();
      final registrationData = <String, dynamic>{
        'displayName': name,
        'fullDisplayNameAr':
            titleLabelAr.isEmpty ? name : '$titleLabelAr $name',
        'fullDisplayNameEn':
            titleLabelEn.isEmpty ? name : '$titleLabelEn $name',
        'professionalTitleKey': _selectedProfessionalTitleKey,
        'professionalTitleLabelAr': titleLabelAr,
        'professionalTitleLabelEn': titleLabelEn,
        'email': email,
        'specialty': specialtyLabel,
        'specialtyKey': _selectedSpecialtyKey,
        'specialtyLabel': specialtyLabel,
        'bio': '',
        // [S] Provider Signals
        'providerSignals': {
          'capabilitySignals': _sortedSignals(_selectedCapabilitySignals),
          'accessibilitySignals': _sortedSignals(_selectedAccessibilitySignals),
          'communicationSignals': _sortedSignals(_selectedCommunicationSignals),
          'learningSignals': _sortedSignals(_selectedLearningSignals),
        },
        'signalSchemaVersion': _signalSchemaVersion,
        'role': 'clinician',
        'isBlocked': false,
        'photoUrl': '',
        'photoAsset': '',
        'createdAt': now,
        'updatedAt': now,
        'documentsSubmitted': false,
        'documentsUploadMode': 'web_registration',
        'identityFileName': '',
        'certificateFileName': '',
        'extraFileName': '',
        'identityDocumentUrl': '',
        'certificateDocumentUrl': '',
        'extraDocumentUrl': '',
      };
      await FirebaseFirestore.instance.collection('clinicians').doc(uid).set(
            DeclarationReadiness.clinicianPayload(
              currentData: const <String, dynamic>{},
              changes: registrationData,
            ),
          );

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(Routes.webClinicianProfile);
    } on FirebaseAuthException catch (e) {
      setState(() => _error = e.message ?? l10n.webClinicianRegistrationFailed);
    } catch (_) {
      setState(() => _error = l10n.webClinicianRegistrationFailed);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.authRequiredField;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

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
                roleFolder: 'clinicians',
                fileName: 'clinicians_step_1_account.png',
              ),
              fit: BoxFit.contain,
            ),
            Container(color: Colors.black.withValues(alpha: 0.10)),
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
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 16),
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
                              const SizedBox(height: 12),
                              TextButton(
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(Routes.portalHome),
                                child: Text(
                                  Localizations.localeOf(context)
                                              .languageCode
                                              .toLowerCase() ==
                                          'ar'
                                      ? 'العودة إلى بوابة Mental Smile'
                                      : 'Back to Mental Smile Portal',
                                ),
                              ),
                              const SizedBox(height: 8),
                              _textField(_nameController, l10n.webClinicianName,
                                  validator: _required),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                initialValue: _selectedProfessionalTitleKey,
                                dropdownColor: Colors.black,
                                iconEnabledColor: _fieldGold,
                                style: const TextStyle(
                                  color: _inputCream,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration: _fieldDecoration(
                                  l10n.webClinicianProfessionalTitle,
                                ),
                                items: _professionalTitles
                                    .map((title) => DropdownMenuItem(
                                          value: title['key'],
                                          child: Text(title['labelAr'] ?? ''),
                                        ))
                                    .toList(),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? l10n.authRequiredField
                                        : null,
                                onChanged: (value) {
                                  setState(() =>
                                      _selectedProfessionalTitleKey = value);
                                },
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                initialValue: _selectedSpecialtyKey,
                                dropdownColor: Colors.black,
                                iconEnabledColor: _fieldGold,
                                style: const TextStyle(
                                  color: _inputCream,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration: _fieldDecoration(
                                    l10n.webClinicianSpecialty),
                                items: _specialties
                                    .map((specialty) => DropdownMenuItem(
                                          value: specialty['key'],
                                          child: Text(specialty['label'] ?? ''),
                                        ))
                                    .toList(),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? l10n.authRequiredField
                                        : null,
                                onChanged: (value) {
                                  setState(() => _selectedSpecialtyKey = value);
                                },
                              ),
                              const SizedBox(height: 10),
                              _textField(
                                _emailController,
                                l10n.authEmail,
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
                              _textField(
                                _passwordController,
                                l10n.authPassword,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.length < 6) {
                                    return l10n.authWeakPassword;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              _textField(
                                _confirmPasswordController,
                                l10n.authConfirmPassword,
                                obscureText: true,
                                validator: (value) {
                                  if (value != _passwordController.text) {
                                    return l10n.authPasswordsDoNotMatch;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 12),
                              _ProviderSignalSection(
                                title: isArabic
                                    ? 'إشارات الخدمة'
                                    : 'Service signals',
                                options: _capabilitySignalOptions,
                                selectedKeys: _selectedCapabilitySignals,
                                isArabic: isArabic,
                                onChanged: _toggleSignal,
                              ),
                              _ProviderSignalSection(
                                title: isArabic
                                    ? 'إشارات الوصول'
                                    : 'Accessibility signals',
                                options: _accessibilitySignalOptions,
                                selectedKeys: _selectedAccessibilitySignals,
                                isArabic: isArabic,
                                onChanged: _toggleSignal,
                              ),
                              _ProviderSignalSection(
                                title: isArabic
                                    ? 'إشارات التواصل'
                                    : 'Communication signals',
                                options: _communicationSignalOptions,
                                selectedKeys: _selectedCommunicationSignals,
                                isArabic: isArabic,
                                onChanged: _toggleSignal,
                              ),
                              _ProviderSignalSection(
                                title: isArabic
                                    ? 'إشارات التعلم والمساهمة'
                                    : 'Learning signals',
                                options: _learningSignalOptions,
                                selectedKeys: _selectedLearningSignals,
                                isArabic: isArabic,
                                onChanged: _toggleSignal,
                              ),
                              if (_error != null) ...[
                                const SizedBox(height: 10),
                                Text(
                                  _error!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                height: 44,
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
                                              strokeWidth: 2),
                                        )
                                      : Text(l10n.webClinicianNextProfile),
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

  Widget _textField(
    TextEditingController controller,
    String label, {
    bool obscureText = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        color: _inputCream,
        fontWeight: FontWeight.w700,
      ),
      decoration: _fieldDecoration(label),
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

  void _toggleSignal(Set<String> selectedKeys, String key, bool selected) {
    setState(() {
      if (selected) {
        selectedKeys.add(key);
      } else {
        selectedKeys.remove(key);
      }
    });
  }
}

class _ProviderSignalOption {
  const _ProviderSignalOption(this.key, this.labelAr, this.labelEn);

  final String key;
  final String labelAr;
  final String labelEn;

  String label(bool isArabic) => isArabic ? labelAr : labelEn;
}

class _ProviderSignalSection extends StatelessWidget {
  const _ProviderSignalSection({
    required this.title,
    required this.options,
    required this.selectedKeys,
    required this.isArabic,
    required this.onChanged,
  });

  final String title;
  final List<_ProviderSignalOption> options;
  final Set<String> selectedKeys;
  final bool isArabic;
  final void Function(Set<String> selectedKeys, String key, bool selected)
      onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: _WebClinicianRegisterPortalPageState._inputCream,
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final option in options)
                FilterChip(
                  label: Text(option.label(isArabic)),
                  selected: selectedKeys.contains(option.key),
                  onSelected: (selected) {
                    onChanged(selectedKeys, option.key, selected);
                  },
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  selectedColor: _WebClinicianRegisterPortalPageState._fieldGold
                      .withValues(alpha: 0.9),
                  backgroundColor: Colors.black.withValues(alpha: 0.22),
                  checkmarkColor: const Color(0xFF17100A),
                  side: BorderSide(
                    color: _WebClinicianRegisterPortalPageState._fieldGold
                        .withValues(alpha: 0.42),
                  ),
                  labelStyle: TextStyle(
                    color: selectedKeys.contains(option.key)
                        ? const Color(0xFF17100A)
                        : _WebClinicianRegisterPortalPageState._inputCream,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
