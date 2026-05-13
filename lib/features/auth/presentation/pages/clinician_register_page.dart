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
      'labelAr': 'د.',
      'labelEn': 'Dr.',
    },
    {
      'key': 'specialist',
      'labelAr': 'أ.',
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
      items.add(isArabic ? 'حضوري' : 'In person');
    }
    if (_offersOnline) {
      items.add(isArabic ? 'أونلاين' : 'Online');
    }
    return items;
  }

  String _normalizeEmail(String value) {
    return value.trim().toLowerCase();
  }

  String _translateAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'هذا البريد مستخدم بالفعل';
      case 'invalid-email':
        return 'البريد الإلكتروني غير صالح';
      case 'weak-password':
        return 'كلمة المرور ضعيفة جدًا';
      case 'operation-not-allowed':
        return 'تسجيل البريد/كلمة المرور غير مفعل في Firebase Auth';
      case 'network-request-failed':
        return 'فشل الاتصال بالشبكة، حاول مرة أخرى';
      default:
        return e.message ?? 'فشل إنشاء حساب الأخصائي';
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
      setState(() => _error = 'اختر اللقب المهني');
      return;
    }

    if (name.isEmpty) {
      setState(() => _error = 'اكتب اسم الأخصائي');
      return;
    }

    if (_selectedSpecialtyKey == null || _selectedSpecialtyKey!.isEmpty) {
      setState(() => _error = 'اختر التخصص');
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

    if (identityFileName.isEmpty) {
      setState(() => _error = 'أدخل اسم أو مرجع ملف الهوية');
      return;
    }

    if (certificateFileName.isEmpty) {
      setState(() => _error = 'أدخل اسم أو مرجع ملف الشهادة');
      return;
    }

    if (!_offersInPerson && !_offersOnline) {
      setState(() => _error = 'اختر وسيلة جلسة واحدة على الأقل');
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
        throw Exception('تعذر إنشاء المستخدم');
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
          content: Text('تم إنشاء حساب الأخصائي بنجاح'),
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
        _error = 'فشل إنشاء حساب الأخصائي: $e';
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
                const AppStatusBadge(label: 'إلزامي'),
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
              label: 'اسم الملف / مرجع الملف',
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
              Text('معاينة الصورة ستظهر هنا'),
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
                Text('تعذر تحميل الصورة من الرابط'),
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
                      title: 'تسجيل أخصائي جديد',
                      subtitle:
                          'ملف مهني أوضح وأهدأ بنفس الهوية الدافئة للمشروع، مع تقسيم بصري أنظف للبيانات والمستندات والمعاينة.',
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppSurfaceCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'البيانات الأساسية',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'أدخل معلومات الحساب والملف المهني كما ستظهر للإدارة أثناء المراجعة.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          DropdownButtonFormField<String>(
                            initialValue: _selectedProfessionalTitleKey,
                            decoration: appInputDecoration(
                              context: context,
                              label: 'اللقب المهني',
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
                              label: 'الاسم بدون لقب',
                              icon: Icons.person_outline,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          DropdownButtonFormField<String>(
                            initialValue: _selectedSpecialtyKey,
                            decoration: appInputDecoration(
                              context: context,
                              label: 'التخصص',
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
                              title: const Text('يقدم جروبات جماعية'),
                              subtitle: const Text(
                                'فعّل هذا الخيار إذا كنت تقدم جلسات جماعية تعليمية أو علاجية',
                              ),
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
                          const SizedBox(height: AppSpacing.md),
                          TextField(
                            controller: _photoUrlController,
                            onChanged: (_) => setState(() {}),
                            decoration: appInputDecoration(
                              context: context,
                              label: 'رابط الصورة الشخصية (اختياري)',
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
                              label: 'نبذة مختصرة',
                              icon: Icons.notes_outlined,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          TextField(
                            controller: _sessionPriceController,
                            decoration: appInputDecoration(
                              context: context,
                              label: 'سعر الجلسة',
                              icon: Icons.payments_outlined,
                              hintText: 'مثال: 300 جنيه',
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          TextField(
                            controller: _sessionDurationController,
                            decoration: appInputDecoration(
                              context: context,
                              label: 'مدة الجلسة',
                              icon: Icons.schedule_outlined,
                              hintText: 'مثال: 50 دقيقة',
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          AppSectionPanel(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'وسائل الجلسة',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                CheckboxListTile(
                                  value: _offersInPerson,
                                  onChanged: (value) {
                                    setState(
                                        () => _offersInPerson = value ?? false);
                                  },
                                  title: const Text('حضوري'),
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
                                  title: const Text('أونلاين'),
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
                            'المستندات',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          _manualFileTile(
                            title: 'صورة الهوية',
                            subtitle: 'أدخل اسم أو مرجع ملف الهوية',
                            controller: _identityFileNameController,
                            requiredFile: true,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          _manualFileTile(
                            title: 'شهادة أو إثبات التخصص',
                            subtitle: 'أدخل اسم أو مرجع ملف الشهادة',
                            controller: _certificateFileNameController,
                            requiredFile: true,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          _manualFileTile(
                            title: 'مستند إضافي',
                            subtitle: 'اختياري: أي مرجع ملف داعم إضافي',
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
                                    ? 'جارٍ إنشاء الحساب...'
                                    : 'إنشاء حساب أخصائي',
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
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
