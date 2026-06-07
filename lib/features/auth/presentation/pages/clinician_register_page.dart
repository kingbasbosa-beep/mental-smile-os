import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/features/specialists/data/clinician_specialty_catalog.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';

class ClinicianRegisterPage extends StatefulWidget {
  const ClinicianRegisterPage({super.key});

  @override
  State<ClinicianRegisterPage> createState() => _ClinicianRegisterPageState();
}

class _ClinicianRegisterPageState extends State<ClinicianRegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _photoUrlController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _sessionPriceController = TextEditingController();
  final TextEditingController _sessionDurationController =
      TextEditingController();

  final TextEditingController _identityFileNameController =
      TextEditingController();
  final TextEditingController _certificateFileNameController =
      TextEditingController();
  final TextEditingController _extraFileNameController =
      TextEditingController();

  bool _offersInPerson = true;
  bool _offersOnline = true;
  bool _offersGroupSessions = false;
  bool _loading = false;
  String? _error;

  String? _selectedProfessionalTitleKey;
  String? _selectedSpecialtyKey;

  static const List<Map<String, String>> _professionalTitles = [
    {
      'key': 'doctor',
      'labelAr': 'Ø¯.',
      'labelEn': 'Dr.',
    },
    {
      'key': 'specialist',
      'labelAr': 'Ø£.',
      'labelEn': 'Spec.',
    },
  ];

  static final List<Map<String, String>> _specialties =
      ClinicianSpecialtyCatalog.specialties
          .map((specialty) => {
                'key': specialty.key,
                'label': specialty.labelAr,
              })
          .toList(growable: false);

  String _selectedSpecialtyLabel() {
    final found = _specialties.where((e) => e['key'] == _selectedSpecialtyKey);
    if (found.isEmpty) return '';
    return found.first['label'] ?? '';
  }

  String _selectedTitleLabelAr() {
    final found = _professionalTitles.where(
      (e) => e['key'] == _selectedProfessionalTitleKey,
    );
    if (found.isEmpty) return '';
    return found.first['labelAr'] ?? '';
  }

  String _selectedTitleLabelEn() {
    final found = _professionalTitles.where(
      (e) => e['key'] == _selectedProfessionalTitleKey,
    );
    if (found.isEmpty) return '';
    return found.first['labelEn'] ?? '';
  }

  List<String> _selectedSessionModes(bool isArabic) {
    final items = <String>[];
    if (_offersInPerson) {
      items.add(isArabic ? 'Ø­Ø¶ÙˆØ±ÙŠ' : 'In person');
    }
    if (_offersOnline) {
      items.add(isArabic ? 'Ø£ÙˆÙ†Ù„Ø§ÙŠÙ†' : 'Online');
    }
    return items;
  }

  String _normalizeEmail(String value) {
    return value.trim().toLowerCase();
  }

  String _translateAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Ù‡Ø°Ø§ Ø§Ù„Ø¨Ø±ÙŠØ¯ Ù…Ø³ØªØ®Ø¯Ù… Ø¨Ø§Ù„ÙØ¹Ù„';
      case 'invalid-email':
        return 'Ø§Ù„Ø¨Ø±ÙŠØ¯ Ø§Ù„Ø¥Ù„ÙƒØªØ±ÙˆÙ†ÙŠ ØºÙŠØ± ØµØ§Ù„Ø­';
      case 'weak-password':
        return 'ÙƒÙ„Ù…Ø© Ø§Ù„Ù…Ø±ÙˆØ± Ø¶Ø¹ÙŠÙØ© Ø¬Ø¯Ù‹Ø§';
      case 'operation-not-allowed':
        return 'ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø¨Ø±ÙŠØ¯/ÙƒÙ„Ù…Ø© Ø§Ù„Ù…Ø±ÙˆØ± ØºÙŠØ± Ù…ÙØ¹Ù„ ÙÙŠ Firebase Auth';
      case 'network-request-failed':
        return 'ÙØ´Ù„ Ø§Ù„Ø§ØªØµØ§Ù„ Ø¨Ø§Ù„Ø´Ø¨ÙƒØ©ØŒ Ø­Ø§ÙˆÙ„ Ù…Ø±Ø© Ø£Ø®Ø±Ù‰';
      default:
        return e.message ?? 'ÙØ´Ù„ Ø¥Ù†Ø´Ø§Ø¡ Ø­Ø³Ø§Ø¨ Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ';
    }
  }

  Future<void> _register() async {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    final name = _nameController.text.trim();
    final email = _normalizeEmail(_emailController.text);
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final photoUrl = _photoUrlController.text.trim();
    final bio = _bioController.text.trim();
    final sessionPriceText = _sessionPriceController.text.trim();
    final sessionDurationText = _sessionDurationController.text.trim();

    final identityFileName = _identityFileNameController.text.trim();
    final certificateFileName = _certificateFileNameController.text.trim();
    final extraFileName = _extraFileNameController.text.trim();

    if (_selectedProfessionalTitleKey == null ||
        _selectedProfessionalTitleKey!.isEmpty) {
      setState(() => _error = 'Ø§Ø®ØªØ± Ø§Ù„Ù„Ù‚Ø¨ Ø§Ù„Ù…Ù‡Ù†ÙŠ');
      return;
    }

    if (name.isEmpty) {
      setState(() => _error = 'Ø§ÙƒØªØ¨ Ø§Ø³Ù… Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ');
      return;
    }

    if (_selectedSpecialtyKey == null || _selectedSpecialtyKey!.isEmpty) {
      setState(() => _error = 'Ø§Ø®ØªØ± Ø§Ù„ØªØ®ØµØµ');
      return;
    }

    if (email.isEmpty) {
      setState(() => _error = 'Ø§ÙƒØªØ¨ Ø§Ù„Ø¨Ø±ÙŠØ¯ Ø§Ù„Ø¥Ù„ÙƒØªØ±ÙˆÙ†ÙŠ');
      return;
    }

    if (password.length < 6) {
      setState(() => _error = 'ÙƒÙ„Ù…Ø© Ø§Ù„Ù…Ø±ÙˆØ± ÙŠØ¬Ø¨ Ø£Ù† ØªÙƒÙˆÙ† 6 Ø£Ø­Ø±Ù Ø¹Ù„Ù‰ Ø§Ù„Ø£Ù‚Ù„');
      return;
    }

    if (password != confirmPassword) {
      setState(() => _error = 'ØªØ£ÙƒÙŠØ¯ ÙƒÙ„Ù…Ø© Ø§Ù„Ù…Ø±ÙˆØ± ØºÙŠØ± Ù…Ø·Ø§Ø¨Ù‚');
      return;
    }

    if (identityFileName.isEmpty) {
      setState(() => _error = 'Ø£Ø¯Ø®Ù„ Ø§Ø³Ù… Ø£Ùˆ Ù…Ø±Ø¬Ø¹ Ù…Ù„Ù Ø§Ù„Ù‡ÙˆÙŠØ©');
      return;
    }

    if (certificateFileName.isEmpty) {
      setState(() => _error = 'Ø£Ø¯Ø®Ù„ Ø§Ø³Ù… Ø£Ùˆ Ù…Ø±Ø¬Ø¹ Ù…Ù„Ù Ø§Ù„Ø´Ù‡Ø§Ø¯Ø©');
      return;
    }

    if (!_offersInPerson && !_offersOnline) {
      setState(() => _error = 'Ø§Ø®ØªØ± ÙˆØ³ÙŠÙ„Ø© Ø¬Ù„Ø³Ø© ÙˆØ§Ø­Ø¯Ø© Ø¹Ù„Ù‰ Ø§Ù„Ø£Ù‚Ù„');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final auth = FirebaseAuth.instance;
      final firestore = FirebaseFirestore.instance;

      final cred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = cred.user;
      if (user == null) {
        throw Exception('ØªØ¹Ø°Ø± Ø¥Ù†Ø´Ø§Ø¡ Ø§Ù„Ù…Ø³ØªØ®Ø¯Ù…');
      }

      final uid = user.uid;
      final specialtyLabel = _selectedSpecialtyLabel();
      final titleLabelAr = _selectedTitleLabelAr();
      final titleLabelEn = _selectedTitleLabelEn();

      await user.updateDisplayName(name);
      await user.reload();

      await firestore.collection('clinicians').doc(uid).set({
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
        'offersGroupSessions': _offersGroupSessions,
        'bio': bio,
        'sessionPriceText': sessionPriceText,
        'sessionDurationText': sessionDurationText,
        'sessionModes': _selectedSessionModes(isArabic),
        'role': 'clinician',
        'isActive': false,
        'isAdmin': false,
        'photoUrl': photoUrl,
        'photoAsset': '',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'documentsSubmitted': true,
        'documentsUploadMode': 'manual_pending',
        'approvalStatus': 'pending_review',
        'identityFileName': identityFileName,
        'certificateFileName': certificateFileName,
        'extraFileName': extraFileName,
        'identityDocumentUrl': '',
        'certificateDocumentUrl': '',
        'extraDocumentUrl': '',
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ØªÙ… Ø¥Ù†Ø´Ø§Ø¡ Ø­Ø³Ø§Ø¨ Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ Ø¨Ù†Ø¬Ø§Ø­'),
        ),
      );

      Navigator.of(context).pushNamedAndRemoveUntil(
        '/menu',
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = _translateAuthError(e);
      });
    } catch (e) {
      setState(() {
        _error = 'ÙØ´Ù„ Ø¥Ù†Ø´Ø§Ø¡ Ø­Ø³Ø§Ø¨ Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ: $e';
      });
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Widget _manualFileTile({
    required String title,
    required String subtitle,
    required TextEditingController controller,
    bool requiredFile = false,
  }) {
    final hasValue = controller.text.trim().isNotEmpty;

    return AppSectionPanel(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: Colors.white.withValues(alpha: 0.90),
      borderColor: hasValue
          ? AppColors.mutedGold.withValues(alpha: 0.40)
          : AppColors.mutedGold.withValues(alpha: 0.16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            textDirection: Directionality.of(context),
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              if (requiredFile) ...[
                const SizedBox(width: AppSpacing.xs),
                const AppStatusBadge(label: 'Ø¥Ù„Ø²Ø§Ù…ÙŠ'),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(subtitle),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: controller,
            onChanged: (_) => setState(() {}),
            decoration: appInputDecoration(
              context: context,
              label: 'Ø§Ø³Ù… Ø§Ù„Ù…Ù„Ù / Ù…Ø±Ø¬Ø¹ Ø§Ù„Ù…Ù„Ù',
              icon: Icons.description_outlined,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoPreview() {
    final url = _photoUrlController.text.trim();

    if (url.isEmpty) {
      return AppSectionPanel(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xl,
        ),
        color: Colors.white.withValues(alpha: 0.86),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person_outline, size: 34, color: AppColors.deepTeal),
              SizedBox(height: AppSpacing.xs),
              Text('Ù…Ø¹Ø§ÙŠÙ†Ø© Ø§Ù„ØµÙˆØ±Ø© Ø³ØªØ¸Ù‡Ø± Ù‡Ù†Ø§'),
            ],
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 190,
      decoration: AppDecorations.softPanel(
        color: Colors.white.withValues(alpha: 0.92),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.broken_image_outlined,
                  size: 34,
                  color: AppColors.deepTeal,
                ),
                SizedBox(height: AppSpacing.xs),
                Text('ØªØ¹Ø°Ø± ØªØ­Ù…ÙŠÙ„ Ø§Ù„ØµÙˆØ±Ø© Ù…Ù† Ø§Ù„Ø±Ø§Ø¨Ø·'),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _photoUrlController.dispose();
    _bioController.dispose();
    _sessionPriceController.dispose();
    _sessionDurationController.dispose();
    _identityFileNameController.dispose();
    _certificateFileNameController.dispose();
    _extraFileNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: AppPageBackground(
          child: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                    vertical: AppSpacing.xxl,
                  ),
                  children: [
                    const SizedBox(height: AppSpacing.lg),
                    const AppHeroHeader(
                      title: 'ØªØ³Ø¬ÙŠÙ„ Ø£Ø®ØµØ§Ø¦ÙŠ Ø¬Ø¯ÙŠØ¯',
                      subtitle:
                          'Ù…Ù„Ù Ù…Ù‡Ù†ÙŠ Ø£ÙˆØ¶Ø­ ÙˆØ£Ù‡Ø¯Ø£ Ø¨Ù†ÙØ³ Ø§Ù„Ù‡ÙˆÙŠØ© Ø§Ù„Ø¯Ø§ÙØ¦Ø© Ù„Ù„Ù…Ø´Ø±ÙˆØ¹ØŒ Ù…Ø¹ ØªÙ‚Ø³ÙŠÙ… Ø¨ØµØ±ÙŠ Ø£Ù†Ø¸Ù Ù„Ù„Ø¨ÙŠØ§Ù†Ø§Øª ÙˆØ§Ù„Ù…Ø³ØªÙ†Ø¯Ø§Øª ÙˆØ§Ù„Ù…Ø¹Ø§ÙŠÙ†Ø©.',
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppSurfaceCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ø§Ù„Ø¨ÙŠØ§Ù†Ø§Øª Ø§Ù„Ø£Ø³Ø§Ø³ÙŠØ©',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Ø£Ø¯Ø®Ù„ Ù…Ø¹Ù„ÙˆÙ…Ø§Øª Ø§Ù„Ø­Ø³Ø§Ø¨ ÙˆØ§Ù„Ù…Ù„Ù Ø§Ù„Ù…Ù‡Ù†ÙŠ ÙƒÙ…Ø§ Ø³ØªØ¸Ù‡Ø± Ù„Ù„Ø¥Ø¯Ø§Ø±Ø© Ø£Ø«Ù†Ø§Ø¡ Ø§Ù„Ù…Ø±Ø§Ø¬Ø¹Ø©.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          DropdownButtonFormField<String>(
                            initialValue: _selectedProfessionalTitleKey,
                            decoration: appInputDecoration(
                              context: context,
                              label: 'Ø§Ù„Ù„Ù‚Ø¨ Ø§Ù„Ù…Ù‡Ù†ÙŠ',
                              icon: Icons.badge_outlined,
                            ),
                            items: _professionalTitles.map((item) {
                              final label = isArabic
                                  ? (item['labelAr'] ?? '')
                                  : (item['labelEn'] ?? '');
                              return DropdownMenuItem<String>(
                                value: item['key'],
                                child: Text(label),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedProfessionalTitleKey = value;
                              });
                            },
                          ),
                          const SizedBox(height: AppSpacing.md),
                          TextField(
                            controller: _nameController,
                            decoration: appInputDecoration(
                              context: context,
                              label: 'Ø§Ù„Ø§Ø³Ù… Ø¨Ø¯ÙˆÙ† Ù„Ù‚Ø¨',
                              icon: Icons.person_outline,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          DropdownButtonFormField<String>(
                            initialValue: _selectedSpecialtyKey,
                            decoration: appInputDecoration(
                              context: context,
                              label: 'Ø§Ù„ØªØ®ØµØµ',
                              icon: Icons.medical_services_outlined,
                            ),
                            items: _specialties.map((item) {
                              return DropdownMenuItem<String>(
                                value: item['key'],
                                child: Text(item['label'] ?? ''),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedSpecialtyKey = value;
                              });
                            },
                          ),
                          const SizedBox(height: AppSpacing.md),
                          AppSectionPanel(
                            child: SwitchListTile(
                              value: _offersGroupSessions,
                              onChanged: (value) {
                                setState(() {
                                  _offersGroupSessions = value;
                                });
                              },
                              activeThumbColor: AppColors.deepTeal,
                              contentPadding: EdgeInsets.zero,
                              title: const Text('ÙŠÙ‚Ø¯Ù… Ø¬Ø±ÙˆØ¨Ø§Øª Ø¬Ù…Ø§Ø¹ÙŠØ©'),
                              subtitle: const Text(
                                'ÙØ¹Ù‘Ù„ Ù‡Ø°Ø§ Ø§Ù„Ø®ÙŠØ§Ø± Ø¥Ø°Ø§ ÙƒÙ†Øª ØªÙ‚Ø¯Ù… Ø¬Ù„Ø³Ø§Øª Ø¬Ù…Ø§Ø¹ÙŠØ© ØªØ¹Ù„ÙŠÙ…ÙŠØ© Ø£Ùˆ Ø¹Ù„Ø§Ø¬ÙŠØ©',
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: appInputDecoration(
                              context: context,
                              label: 'Ø§Ù„Ø¨Ø±ÙŠØ¯ Ø§Ù„Ø¥Ù„ÙƒØªØ±ÙˆÙ†ÙŠ',
                              icon: Icons.alternate_email,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: appInputDecoration(
                              context: context,
                              label: 'ÙƒÙ„Ù…Ø© Ø§Ù„Ù…Ø±ÙˆØ±',
                              icon: Icons.lock_outline,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          TextField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: appInputDecoration(
                              context: context,
                              label: 'ØªØ£ÙƒÙŠØ¯ ÙƒÙ„Ù…Ø© Ø§Ù„Ù…Ø±ÙˆØ±',
                              icon: Icons.verified_user_outlined,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          TextField(
                            controller: _photoUrlController,
                            onChanged: (_) => setState(() {}),
                            decoration: appInputDecoration(
                              context: context,
                              label: 'Ø±Ø§Ø¨Ø· Ø§Ù„ØµÙˆØ±Ø© Ø§Ù„Ø´Ø®ØµÙŠØ© (Ø§Ø®ØªÙŠØ§Ø±ÙŠ)',
                              icon: Icons.image_outlined,
                              hintText: 'https://example.com/photo.jpg',
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          _buildPhotoPreview(),
                          const SizedBox(height: AppSpacing.md),
                          TextField(
                            controller: _bioController,
                            maxLines: 4,
                            decoration: appInputDecoration(
                              context: context,
                              label: 'Ù†Ø¨Ø°Ø© Ù…Ø®ØªØµØ±Ø©',
                              icon: Icons.notes_outlined,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          TextField(
                            controller: _sessionPriceController,
                            decoration: appInputDecoration(
                              context: context,
                              label: 'Ø³Ø¹Ø± Ø§Ù„Ø¬Ù„Ø³Ø©',
                              icon: Icons.sell_outlined,
                              hintText: 'Ù…Ø«Ø§Ù„: 300 Ø¬Ù†ÙŠÙ‡',
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          TextField(
                            controller: _sessionDurationController,
                            decoration: appInputDecoration(
                              context: context,
                              label: 'Ù…Ø¯Ø© Ø§Ù„Ø¬Ù„Ø³Ø©',
                              icon: Icons.schedule_outlined,
                              hintText: 'Ù…Ø«Ø§Ù„: 50 Ø¯Ù‚ÙŠÙ‚Ø©',
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          AppSectionPanel(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ÙˆØ³Ø§Ø¦Ù„ Ø§Ù„Ø¬Ù„Ø³Ø©',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                CheckboxListTile(
                                  value: _offersInPerson,
                                  onChanged: (value) {
                                    setState(
                                        () => _offersInPerson = value ?? false);
                                  },
                                  title: const Text('Ø­Ø¶ÙˆØ±ÙŠ'),
                                  activeColor: AppColors.deepTeal,
                                  contentPadding: EdgeInsets.zero,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                                CheckboxListTile(
                                  value: _offersOnline,
                                  onChanged: (value) {
                                    setState(
                                        () => _offersOnline = value ?? false);
                                  },
                                  title: const Text('Ø£ÙˆÙ†Ù„Ø§ÙŠÙ†'),
                                  activeColor: AppColors.deepTeal,
                                  contentPadding: EdgeInsets.zero,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Text(
                            'Ø§Ù„Ù…Ø³ØªÙ†Ø¯Ø§Øª',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          _manualFileTile(
                            title: 'ØµÙˆØ±Ø© Ø§Ù„Ù‡ÙˆÙŠØ©',
                            subtitle: 'Ø£Ø¯Ø®Ù„ Ø§Ø³Ù… Ø£Ùˆ Ù…Ø±Ø¬Ø¹ Ù…Ù„Ù Ø§Ù„Ù‡ÙˆÙŠØ©',
                            controller: _identityFileNameController,
                            requiredFile: true,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          _manualFileTile(
                            title: 'Ø´Ù‡Ø§Ø¯Ø© Ø£Ùˆ Ø¥Ø«Ø¨Ø§Øª Ø§Ù„ØªØ®ØµØµ',
                            subtitle: 'Ø£Ø¯Ø®Ù„ Ø§Ø³Ù… Ø£Ùˆ Ù…Ø±Ø¬Ø¹ Ù…Ù„Ù Ø§Ù„Ø´Ù‡Ø§Ø¯Ø©',
                            controller: _certificateFileNameController,
                            requiredFile: true,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          _manualFileTile(
                            title: 'Ù…Ø³ØªÙ†Ø¯ Ø¥Ø¶Ø§ÙÙŠ',
                            subtitle: 'Ø§Ø®ØªÙŠØ§Ø±ÙŠ: Ø£ÙŠ Ù…Ø±Ø¬Ø¹ Ù…Ù„Ù Ø¯Ø§Ø¹Ù… Ø¥Ø¶Ø§ÙÙŠ',
                            controller: _extraFileNameController,
                            requiredFile: false,
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
                                    ? 'Ø¬Ø§Ø±Ù Ø¥Ù†Ø´Ø§Ø¡ Ø§Ù„Ø­Ø³Ø§Ø¨...'
                                    : 'Ø¥Ù†Ø´Ø§Ø¡ Ø­Ø³Ø§Ø¨ Ø£Ø®ØµØ§Ø¦ÙŠ',
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child:
                                  const Text('Ù„Ø¯ÙŠÙƒ Ø­Ø³Ø§Ø¨ Ø¨Ø§Ù„ÙØ¹Ù„ØŸ ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø¯Ø®ÙˆÙ„'),
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

