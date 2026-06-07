import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/signals/signals.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';
import 'package:flutterprojects/shared/ui_kit/asset_fallback_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

class ClientRegisterPage extends StatefulWidget {
  const ClientRegisterPage({super.key});

  @override
  State<ClientRegisterPage> createState() => _ClientRegisterPageState();
}

class _ClientRegisterPageState extends State<ClientRegisterPage> {
  static const _clientGold = Color(0xFFE9B44C);
  static const _clientMutedText = Color(0xFFB8B8B8);
  static const _clientInputText = Color(0xFFFFE7B0);
  static const _clientDarkText = Color(0xFF101820);
  // [S] Signal Native Asset
  // Approved by Wave S-3 Classification Board.
  // Must remain free from booking/session/payment/accounting coupling.
  static const _signalSchemaVersion = 'client_signals_v1';

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _loading = false;
  String? _error;

  String _selectedAvatar = 'images/avatar_client_fmale.png';
  // [S] Client Signals
  // First signal capture only; not diagnosis, booking, session, or payment data.
  final Set<String> _selectedGoalSignals = {};
  final Set<String> _selectedInterestSignals = {};
  final Set<String> _selectedAccessibilitySignals = {};
  final Set<String> _selectedCommunicationSignals = {};
  // [S] Privacy Preferences
  // Controls preference visibility and recommendation consent only.
  bool _keepSupportPreferencesPrivate = true;
  bool _usePreferencesForRecommendations = false;

  static const List<String> _avatarOptions = [
    'images/avatar_client_fmale.png',
    'images/avatar_client_male.png',
    'images/avatar_clinician_fmale.png',
    'images/avatar_clinician_male.png',
  ];

  static const List<_ClientSignalOption> _goalSignalOptions = [
    _ClientSignalOption('need_specialist', 'أحتاج أخصائي', 'Find specialist'),
    _ClientSignalOption('need_center', 'أحتاج مركز', 'Find center'),
    _ClientSignalOption('recovery_support', 'دعم التعافي', 'Recovery support'),
    _ClientSignalOption('family_guidance', 'إرشاد أسري', 'Family guidance'),
    _ClientSignalOption('general_help', 'مساعدة عامة', 'General help'),
  ];

  static const List<_ClientSignalOption> _interestSignalOptions = [
    _ClientSignalOption('addiction', 'الإدمان', 'Addiction'),
    _ClientSignalOption('recovery', 'التعافي', 'Recovery'),
    _ClientSignalOption('family_support', 'دعم الأسرة', 'Family support'),
    _ClientSignalOption('special_needs', 'ذوي الاحتياجات', 'Special needs'),
    _ClientSignalOption(
      'prevention_awareness',
      'التوعية الوقائية',
      'Prevention awareness',
    ),
    _ClientSignalOption(
      'family_awareness',
      'التوعية الأسرية',
      'Family awareness',
    ),
    _ClientSignalOption('coaching', 'الكوتشينج', 'Coaching'),
    _ClientSignalOption('speech_support', 'دعم التخاطب', 'Speech support'),
    _ClientSignalOption('children_support', 'دعم الأطفال', 'Children support'),
    _ClientSignalOption('hearing_support', 'دعم السمع', 'Hearing support'),
  ];

  static const List<_ClientSignalOption> _accessibilitySignalOptions = [
    _ClientSignalOption('speech_support', 'مساعدة التخاطب', 'Speech support'),
    _ClientSignalOption('hearing_support', 'مساعدة السمع', 'Hearing support'),
    _ClientSignalOption('visual_assistance', 'مساعدة بصرية', 'Visual help'),
    _ClientSignalOption(
      'simplified_content',
      'محتوى مبسط',
      'Simplified content',
    ),
  ];

  static const List<_ClientSignalOption> _communicationSignalOptions = [
    _ClientSignalOption('text', 'نص', 'Text'),
    _ClientSignalOption('audio', 'صوت', 'Audio'),
    _ClientSignalOption('video', 'فيديو', 'Video'),
    _ClientSignalOption('visual', 'مرئي', 'Visual'),
  ];

  String _backgroundAsset() {
    return 'assets/branding/web_registration/clients/mobile/client_register.png';
  }

  String _normalizeEmail(String value) => value.trim().toLowerCase();

  List<String> _sortedSignals(Set<String> signals) {
    final values = signals.toList()..sort();
    return values;
  }

  Future<void> _emitRegistrationSignals() async {
    const runtime = CleanSignalRuntime();
    final goalSignals = _sortedSignals(_selectedGoalSignals);
    final interestSignals = _sortedSignals(_selectedInterestSignals);
    final accessibilitySignals = _sortedSignals(_selectedAccessibilitySignals);
    final communicationSignals = _sortedSignals(_selectedCommunicationSignals);

    if (goalSignals.isNotEmpty) {
      await runtime.emit(
        SignalPackageFactory.goalSelected(
          actorRole: 'client',
          targetId: goalSignals.first,
          signalSource: 'client_registration',
        ),
      );
    }
    if (interestSignals.isNotEmpty) {
      await runtime.emit(
        SignalPackageFactory.interestSelected(
          actorRole: 'client',
          targetId: interestSignals.first,
          signalSource: 'client_registration',
        ),
      );
    }
    if (accessibilitySignals.isNotEmpty) {
      await runtime.emit(
        SignalPackageFactory.accessibilityInterest(
          actorRole: 'client',
          targetId: accessibilitySignals.first,
          signalSource: 'client_registration',
        ),
      );
    }
    if (communicationSignals.isNotEmpty) {
      await runtime.emit(
        SignalPackageFactory.communicationPreferenceSelected(
          actorRole: 'client',
          targetId: communicationSignals.first,
          signalSource: 'client_registration',
        ),
      );
    }
  }

  InputDecoration _clientInputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: _clientMutedText,
        fontWeight: FontWeight.w700,
      ),
      prefixIcon: Icon(icon, color: _clientGold),
      prefixIconConstraints: const BoxConstraints(
        minWidth: 36,
        minHeight: 36,
      ),
      filled: true,
      fillColor: Colors.transparent,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 6),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: _clientGold, width: 1.2),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: _clientGold, width: 2),
      ),
    );
  }

  Widget _avatarButton(String avatar) {
    final isSelected = _selectedAvatar == avatar;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAvatar = avatar;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 82,
        height: 82,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withValues(alpha: 0.08),
          border: Border.all(
            color:
                isSelected ? _clientGold : _clientGold.withValues(alpha: 0.38),
            width: isSelected ? 3 : 1.3,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    blurRadius: 16,
                    color: _clientGold.withValues(alpha: 0.34),
                  ),
                ]
              : null,
        ),
        child: ClipOval(
          child: Image.asset(
            normalizeAssetPath(avatar),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const AppMissingAssetPlaceholder(),
          ),
        ),
      ),
    );
  }

  Future<void> _register() async {
    final l10n = AppLocalizations.of(context)!;
    final name = _nameController.text.trim();
    final email = _normalizeEmail(_emailController.text);
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty) {
      setState(() => _error = l10n.authNameRequired);
      return;
    }

    if (email.isEmpty) {
      setState(() => _error = l10n.authEmailRequired);
      return;
    }

    if (!email.contains('@')) {
      setState(() => _error = l10n.authInvalidEmail);
      return;
    }

    if (password.length < 6) {
      setState(() => _error = l10n.authWeakPassword);
      return;
    }

    if (password != confirmPassword) {
      setState(() => _error = l10n.authPasswordsDoNotMatch);
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

      final user = cred.user;
      if (user == null) {
        throw Exception('User not found after registration');
      }

      await user.updateDisplayName(name);

      await FirebaseFirestore.instance.collection('clients').doc(user.uid).set({
        'role': 'client',
        'displayName': name,
        'email': email,
        'avatarAsset': _selectedAvatar,
        // [S] Client Signals
        // Approved signal-native map. Do not couple to booking/session/payment.
        'clientSignals': {
          'goalSignals': _sortedSignals(_selectedGoalSignals),
          'interestSignals': _sortedSignals(_selectedInterestSignals),
          'accessibilitySignals': _sortedSignals(
            _selectedAccessibilitySignals,
          ),
          'communicationSignals': _sortedSignals(_selectedCommunicationSignals),
        },
        // [S] Privacy Preferences
        // Preference governance only; not a legacy workflow control.
        'privacyPreferences': {
          'keepSupportPreferencesPrivate': _keepSupportPreferencesPrivate,
          'usePreferencesForRecommendations': _usePreferencesForRecommendations,
        },
        'signalSchemaVersion': _signalSchemaVersion,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      await _emitRegistrationSignals();

      await user.reload();

      if (!mounted) return;

      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.clientDashboard,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = e.message ?? l10n.authRegistrationFailed;
      });
    } catch (e) {
      setState(() {
        _error = l10n.authRegistrationFailed;
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

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.login,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode.toLowerCase() == 'ar';
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Transform.scale(
              scale: 0.93,
              child: Image.asset(
                _backgroundAsset(),
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
            Container(color: Colors.black.withValues(alpha: 0.12)),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final sideSpacing = constraints.maxWidth < 520 ? 40.0 : 78.0;
                  final avatarTop = constraints.maxHeight < 720 ? 60.0 : 84.0;

                  return Stack(
                    children: [
                      Positioned(
                        top: AppSpacing.md,
                        right: AppSpacing.md,
                        child: SafeArea(
                          child: _RegisterLogoutButton(onPressed: _signOut),
                        ),
                      ),
                      Positioned(
                        top: avatarTop,
                        left: sideSpacing,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _avatarButton(_avatarOptions[0]),
                            const SizedBox(height: 14),
                            _avatarButton(_avatarOptions[1]),
                          ],
                        ),
                      ),
                      Positioned(
                        top: avatarTop,
                        right: sideSpacing,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _avatarButton(_avatarOptions[2]),
                            const SizedBox(height: 14),
                            _avatarButton(_avatarOptions[3]),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xl,
                            vertical: AppSpacing.md,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 410),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: _nameController,
                                  style: const TextStyle(
                                    color: _clientInputText,
                                    fontSize: 14,
                                  ),
                                  decoration: _clientInputDecoration(
                                    label: l10n.authName,
                                    icon: Icons.person_outline,
                                  ),
                                ),
                                const SizedBox(height: 9),
                                TextField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(
                                    color: _clientInputText,
                                    fontSize: 14,
                                  ),
                                  decoration: _clientInputDecoration(
                                    label: l10n.authEmail,
                                    icon: Icons.alternate_email,
                                  ),
                                ),
                                const SizedBox(height: 9),
                                TextField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  style: const TextStyle(
                                    color: _clientInputText,
                                    fontSize: 14,
                                  ),
                                  decoration: _clientInputDecoration(
                                    label: l10n.authPassword,
                                    icon: Icons.lock_outline,
                                  ),
                                ),
                                const SizedBox(height: 9),
                                TextField(
                                  controller: _confirmPasswordController,
                                  obscureText: true,
                                  style: const TextStyle(
                                    color: _clientInputText,
                                    fontSize: 14,
                                  ),
                                  decoration: _clientInputDecoration(
                                    label: l10n.authConfirmPassword,
                                    icon: Icons.verified_user_outlined,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.md),
                                _ClientSignalSection(
                                  title: isArabic ? 'أهدافي' : 'My goals',
                                  options: _goalSignalOptions,
                                  selectedKeys: _selectedGoalSignals,
                                  isArabic: isArabic,
                                  onChanged: _toggleSignal,
                                ),
                                _ClientSignalSection(
                                  title: isArabic ? 'اهتماماتي' : 'Interests',
                                  options: _interestSignalOptions,
                                  selectedKeys: _selectedInterestSignals,
                                  isArabic: isArabic,
                                  onChanged: _toggleSignal,
                                ),
                                _ClientSignalSection(
                                  title: isArabic
                                      ? 'تفضيلات الوصول'
                                      : 'Accessibility',
                                  options: _accessibilitySignalOptions,
                                  selectedKeys: _selectedAccessibilitySignals,
                                  isArabic: isArabic,
                                  onChanged: _toggleSignal,
                                ),
                                _ClientSignalSection(
                                  title: isArabic
                                      ? 'طريقة التواصل'
                                      : 'Communication',
                                  options: _communicationSignalOptions,
                                  selectedKeys: _selectedCommunicationSignals,
                                  isArabic: isArabic,
                                  onChanged: _toggleSignal,
                                ),
                                _ClientPrivacyPreferences(
                                  isArabic: isArabic,
                                  keepSupportPreferencesPrivate:
                                      _keepSupportPreferencesPrivate,
                                  usePreferencesForRecommendations:
                                      _usePreferencesForRecommendations,
                                  onPrivateChanged: (value) {
                                    setState(() {
                                      _keepSupportPreferencesPrivate = value;
                                    });
                                  },
                                  onRecommendationsChanged: (value) {
                                    setState(() {
                                      _usePreferencesForRecommendations = value;
                                    });
                                  },
                                ),
                                if (_error != null) ...[
                                  const SizedBox(height: AppSpacing.sm),
                                  AppMessageBanner(message: _error!),
                                ],
                                const SizedBox(height: AppSpacing.md),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFF7D889),
                                        _clientGold,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            _clientGold.withValues(alpha: 0.28),
                                        blurRadius: 16,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: FilledButton.icon(
                                      style: FilledButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: _clientDarkText,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      onPressed: _loading ? null : _register,
                                      icon: _loading
                                          ? const SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: _clientDarkText,
                                              ),
                                            )
                                          : const Icon(Icons.person_add_alt_1),
                                      label: Text(
                                        _loading
                                            ? l10n.authCreatingAccount
                                            : l10n.authClientRegister,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.md),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
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

class _RegisterLogoutButton extends StatelessWidget {
  const _RegisterLogoutButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Image.asset(
        'assets/branding/navigation/logout/logout_gold.png',
        width: 30,
        height: 30,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.logout_rounded,
            color: _ClientRegisterPageState._clientGold,
          );
        },
      ),
    );
  }
}

class _ClientSignalOption {
  const _ClientSignalOption(this.key, this.labelAr, this.labelEn);

  final String key;
  final String labelAr;
  final String labelEn;

  String label(bool isArabic) => isArabic ? labelAr : labelEn;
}

class _ClientSignalSection extends StatelessWidget {
  const _ClientSignalSection({
    required this.title,
    required this.options,
    required this.selectedKeys,
    required this.isArabic,
    required this.onChanged,
  });

  final String title;
  final List<_ClientSignalOption> options;
  final Set<String> selectedKeys;
  final bool isArabic;
  final void Function(Set<String> selectedKeys, String key, bool selected)
      onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: _ClientRegisterPageState._clientInputText,
              fontSize: 12,
              fontWeight: FontWeight.w800,
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
                  selectedColor:
                      _ClientRegisterPageState._clientGold.withValues(
                    alpha: 0.9,
                  ),
                  backgroundColor: Colors.black.withValues(alpha: 0.2),
                  checkmarkColor: _ClientRegisterPageState._clientDarkText,
                  side: BorderSide(
                    color: _ClientRegisterPageState._clientGold.withValues(
                      alpha: 0.45,
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: selectedKeys.contains(option.key)
                        ? _ClientRegisterPageState._clientDarkText
                        : _ClientRegisterPageState._clientInputText,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ClientPrivacyPreferences extends StatelessWidget {
  const _ClientPrivacyPreferences({
    required this.isArabic,
    required this.keepSupportPreferencesPrivate,
    required this.usePreferencesForRecommendations,
    required this.onPrivateChanged,
    required this.onRecommendationsChanged,
  });

  final bool isArabic;
  final bool keepSupportPreferencesPrivate;
  final bool usePreferencesForRecommendations;
  final ValueChanged<bool> onPrivateChanged;
  final ValueChanged<bool> onRecommendationsChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        children: [
          _ClientPrivacySwitch(
            value: keepSupportPreferencesPrivate,
            label: isArabic
                ? 'إبقاء تفضيلات الدعم خاصة'
                : 'Keep support preferences private',
            onChanged: onPrivateChanged,
          ),
          _ClientPrivacySwitch(
            value: usePreferencesForRecommendations,
            label: isArabic
                ? 'استخدام التفضيلات للتوصيات'
                : 'Use preferences for recommendations',
            onChanged: onRecommendationsChanged,
          ),
        ],
      ),
    );
  }
}

class _ClientPrivacySwitch extends StatelessWidget {
  const _ClientPrivacySwitch({
    required this.value,
    required this.label,
    required this.onChanged,
  });

  final bool value;
  final String label;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      dense: true,
      contentPadding: EdgeInsets.zero,
      activeThumbColor: _ClientRegisterPageState._clientGold,
      title: Text(
        label,
        style: const TextStyle(
          color: _ClientRegisterPageState._clientInputText,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
