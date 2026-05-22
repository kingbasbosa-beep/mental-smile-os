import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/external_follow_up/data/models/follow_up_registry_entry.dart';
import 'package:flutterprojects/features/external_follow_up/data/services/follow_up_registry_service.dart';
import 'package:flutterprojects/features/external_follow_up/domain/follow_up_registry_constants.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';

class FollowUpRegistrationPage extends StatefulWidget {
  const FollowUpRegistrationPage({super.key});

  @override
  State<FollowUpRegistrationPage> createState() =>
      _FollowUpRegistrationPageState();
}

class _FollowUpRegistrationPageState extends State<FollowUpRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _service = FollowUpRegistryService();

  final _displayNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _scrollController = ScrollController();
  final Set<String> _selectedFollowUpTypes = <String>{};
  final Set<String> _selectedEducationalTopics = <String>{};

  bool _consentAccepted = false;
  bool _policyAcknowledged = false;
  bool _submitting = false;

  int? _birthDay;
  int? _birthMonth;
  String? _supportFrequency;
  String? _recoveryFrequency;
  int? _recoveryStartMonth;
  int? _recoveryStartYear;

  bool get _isBirthdaySelected =>
      _selectedFollowUpTypes.contains(FollowUpRegistryType.birthday);

  bool get _isRecoverySelected =>
      _selectedFollowUpTypes.contains(FollowUpRegistryType.recoverySupport);

  bool get _isGeneralSupportSelected =>
      _selectedFollowUpTypes.contains(FollowUpRegistryType.generalSupport);

  bool get _isEducationSelected => _selectedFollowUpTypes
      .contains(FollowUpRegistryType.educationalAwareness);

  bool get _isArabic =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  TextDirection get _pageDirection =>
      _isArabic ? TextDirection.rtl : TextDirection.ltr;

  TextAlign get _contentTextAlign =>
      _isArabic ? TextAlign.right : TextAlign.left;

  CrossAxisAlignment get _contentAlignment =>
      _isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start;

  Alignment get _sectionTitleAlignment =>
      _isArabic ? Alignment.center : Alignment.centerLeft;

  String _copy({required String ar, required String en}) =>
      _isArabic ? ar : en;

  String _backgroundAsset(double width) {
    if (width < 700) {
      return 'assets/images/backgrounds/specialists_bg_mobile.png';
    }
    if (width < 1100) {
      return 'assets/images/backgrounds/specialists_bg_tablet.png';
    }
    return 'assets/images/backgrounds/specialists_bg_desktop.png';
  }

  BoxDecoration _glassDecoration({double alpha = 0.34, double radius = 22}) {
    return BoxDecoration(
      color: Colors.black.withValues(alpha: alpha),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: const Color(0xFFE7C766).withValues(alpha: 0.34),
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFE7C766).withValues(alpha: 0.08),
          blurRadius: 24,
          offset: const Offset(0, 12),
        ),
      ],
    );
  }

  List<int> get _yearOptions {
    final currentYear = DateTime.now().year;
    return List<int>.generate(21, (index) => currentYear - index);
  }

  String? get _preferredContactChannel {
    final hasPhone = _phoneNumberController.text.trim().isNotEmpty;
    final hasEmail = _emailController.text.trim().isNotEmpty;

    if (hasPhone && hasEmail) return FollowUpRegistryContactChannel.both;
    if (hasPhone) return FollowUpRegistryContactChannel.whatsapp;
    if (hasEmail) return FollowUpRegistryContactChannel.email;
    return null;
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_submitting) return;
    final messenger = ScaffoldMessenger.of(context);

    if (_formKey.currentState?.validate() != true) return;

    final validationError = _validateSelections();
    if (validationError != null) {
      messenger.showSnackBar(SnackBar(content: Text(validationError)));
      return;
    }

    setState(() => _submitting = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      final entry = FollowUpRegistryEntry(
        id: '',
        displayName: _resolvedDisplayName(user),
        phoneNumber: _nullableText(_phoneNumberController),
        email: _nullableText(_emailController),
        preferredContactChannel: _preferredContactChannel,
        createdAt: null,
        updatedAt: null,
        registeredByUid: user?.uid,
        source: FollowUpRegistrySource.clientRequest,
        status: FollowUpRegistryStatus.active,
        followUpTypes: _selectedFollowUpTypes.toList(),
        birthDate: null,
        birthDay: _birthDay,
        birthMonth: _birthMonth,
        supportFrequency: _supportFrequency,
        recoveryStartDate: null,
        recoveryFrequency: _recoveryFrequency,
        recoveryStartMonth: _recoveryStartMonth,
        recoveryStartYear: _recoveryStartYear,
        recoveryStatus: null,
        educationalTopics: _selectedEducationalTopics.toList(),
        consentAccepted: _consentAccepted,
        consentAcceptedAt: _consentAccepted ? DateTime.now() : null,
        notes: null,
      );

      await _service.createEntry(entry);

      if (!mounted) return;
      _resetForm();
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Follow-up registration submitted successfully.'),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text('Failed to submit follow-up registration: $error'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  String? _validateSelections() {
    if (_selectedFollowUpTypes.isEmpty) {
      return _copy(
        ar: 'اختر نوع متابعة واحدًا على الأقل.',
        en: 'Select at least one follow-up type.',
      );
    }

    if (_preferredContactChannel == null) {
      return _copy(
        ar: 'أدخل رقم واتساب أو بريدًا إلكترونيًا.',
        en: 'Enter a WhatsApp number or an email address.',
      );
    }

    if (!_consentAccepted) {
      return _copy(
        ar: 'الموافقة مطلوبة للمتابعة.',
        en: 'Consent is required to continue.',
      );
    }

    if (!_policyAcknowledged) {
      return _copy(
        ar: 'يلزم الإقرار بتوضيح سياسة المتابعة قبل إتمام التسجيل.',
        en: 'Acknowledge the follow-up policy clarification before submitting.',
      );
    }

    if (_isBirthdaySelected && (_birthDay == null || _birthMonth == null)) {
      return _copy(
        ar: 'يلزم تحديد يوم وشهر الميلاد.',
        en: 'Birthday day and month are required.',
      );
    }

    if (_isRecoverySelected &&
        (_recoveryFrequency == null ||
            _recoveryStartMonth == null ||
            _recoveryStartYear == null)) {
      return _copy(
        ar: 'يلزم تحديد وتيرة المتابعة وشهر وسنة بداية التعافي.',
        en: 'Recovery frequency, start month, and start year are required.',
      );
    }

    if (_isGeneralSupportSelected && _supportFrequency == null) {
      return _copy(
        ar: 'يلزم تحديد وتيرة رسائل الدعم.',
        en: 'Support frequency is required.',
      );
    }

    if (_isEducationSelected && _selectedEducationalTopics.isEmpty) {
      return _copy(
        ar: 'اختر موضوعًا توعويًا واحدًا على الأقل.',
        en: 'Select at least one educational topic.',
      );
    }

    return null;
  }

  String _resolvedDisplayName(User? user) {
    final typedName = _displayNameController.text.trim();
    if (typedName.isNotEmpty) return typedName;

    final userDisplayName = user?.displayName?.trim() ?? '';
    if (userDisplayName.isNotEmpty) return userDisplayName;

    final email = _emailController.text.trim();
    if (email.isNotEmpty) return email;

    final phone = _phoneNumberController.text.trim();
    if (phone.isNotEmpty) return phone;

    return 'Follow-up registration';
  }

  String? _nullableText(TextEditingController controller) {
    final text = controller.text.trim();
    return text.isEmpty ? null : text;
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _displayNameController.clear();
    _phoneNumberController.clear();
    _emailController.clear();
    setState(() {
      _selectedFollowUpTypes.clear();
      _selectedEducationalTopics.clear();
      _consentAccepted = false;
      _policyAcknowledged = false;
      _birthDay = null;
      _birthMonth = null;
      _supportFrequency = null;
      _recoveryFrequency = null;
      _recoveryStartMonth = null;
      _recoveryStartYear = null;
    });
  }

  String _recoveryFrequencyLabel(String value) {
    switch (value) {
      case 'weekly':
        return _copy(ar: 'أسبوعيًا', en: 'Weekly');
      case 'biweekly':
        return _copy(ar: 'كل أسبوعين', en: 'Every two weeks');
      case 'monthly':
        return _copy(ar: 'شهريًا', en: 'Monthly');
      default:
        return value;
    }
  }

  String _supportFrequencyLabel(String value) {
    switch (value) {
      case 'weekly':
        return _copy(ar: 'أسبوعيًا', en: 'Weekly');
      case 'biweekly':
        return _copy(ar: 'كل أسبوعين', en: 'Every two weeks');
      case 'monthly':
        return _copy(ar: 'شهريًا', en: 'Monthly');
      case 'occasional':
        return _copy(ar: 'عند الحاجة', en: 'Occasional');
      default:
        return value;
    }
  }

  String _educationTopicLabel(String value) {
    switch (value) {
      case 'relapse_prevention':
        return _copy(ar: 'الوقاية من الانتكاس', en: 'Relapse prevention');
      case 'family_support':
        return _copy(ar: 'دعم الأسرة', en: 'Family support');
      case 'coping_skills':
        return _copy(ar: 'مهارات التعامل', en: 'Coping skills');
      case 'healthy_routines':
        return _copy(ar: 'العادات الصحية', en: 'Healthy routines');
      default:
        return value;
    }
  }

  String _preferredContactChannelLabel() {
    switch (_preferredContactChannel) {
      case FollowUpRegistryContactChannel.whatsapp:
        return _copy(ar: 'واتساب', en: 'WhatsApp');
      case FollowUpRegistryContactChannel.email:
        return _copy(ar: 'البريد الإلكتروني', en: 'Email');
      case FollowUpRegistryContactChannel.both:
        return _copy(ar: 'واتساب والبريد الإلكتروني', en: 'WhatsApp and email');
      default:
        return _copy(
          ar: 'وسيلة التواصل المفضلة غير متاحة حاليًا',
          en: 'Preferred contact channel is not available yet',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _pageDirection,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  _backgroundAsset(constraints.maxWidth),
                  fit: BoxFit.cover,
                  alignment: constraints.maxWidth < 700
                      ? Alignment.topCenter
                      : Alignment.center,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.62),
                        Colors.black.withValues(alpha: 0.38),
                        Colors.black.withValues(alpha: 0.74),
                      ],
                    ),
                  ),
                ),
                AppShellActions.buildOverlayActions(
                  onBack: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.clientDashboard,
                      (route) => false,
                    );
                  },
                  showLogout: false,
                ),
                SafeArea(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 760),
                      child: Form(
                        key: _formKey,
                        child: RawScrollbar(
                          controller: _scrollController,
                          thumbVisibility: true,
                          thickness: 4,
                          radius: const Radius.circular(999),
                          thumbColor:
                              const Color(0xFFE7C766).withValues(alpha: 0.42),
                          child: ListView(
                            controller: _scrollController,
                            padding: const EdgeInsets.fromLTRB(
                              AppSpacing.xl,
                              88,
                              AppSpacing.xl,
                              AppSpacing.xxl,
                            ),
                            children: [
                              Container(
                                padding: const EdgeInsets.all(AppSpacing.lg),
                                decoration:
                                    _glassDecoration(alpha: 0.34, radius: 24),
                                child: Column(
                                  crossAxisAlignment: _contentAlignment,
                                  children: [
                                    if (_isArabic)
                                      const Center(
                                        child: GoldPageTitle(
                                          title: 'تسجيل المتابعة',
                                          padding: EdgeInsets.zero,
                                        ),
                                      )
                                    else
                                      Text(
                                        'Follow-up Registration',
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                              color: const Color(0xFFE7C766),
                                              fontWeight: FontWeight.w900,
                                              shadows: [
                                                Shadow(
                                                  color: const Color(0xFFE7C766)
                                                      .withValues(alpha: 0.24),
                                                  blurRadius: 12,
                                                ),
                                              ],
                                            ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: AppSpacing.lg),
                            Container(
                              padding: const EdgeInsets.all(AppSpacing.lg),
                              decoration: _glassDecoration(alpha: 0.34),
                              child: Column(
                                crossAxisAlignment: _contentAlignment,
                                children: [
                                  Align(
                                    alignment: _sectionTitleAlignment,
                                    child: Text(
                                      _copy(
                                        ar: 'أنواع المتابعة',
                                        en: 'Follow-up Types',
                                      ),
                                      textAlign: _isArabic
                                          ? TextAlign.center
                                          : TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: const Color(0xFFE7C766),
                                          fontWeight: FontWeight.w900,
                                        ),
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.sm),
                                  Text(
                                    _copy(
                                      ar: 'اختر نوعًا واحدًا أو أكثر من خدمات الدعم المناسبة لك.',
                                      en: 'Choose one or more support categories.',
                                    ),
                                    textAlign: _contentTextAlign,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: const Color(0xFFFFF4D4)),
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  _buildTypeSelector(
                                    title: _copy(
                                      ar: 'تهنئة أعياد الميلاد',
                                      en: 'Birthday greetings',
                                    ),
                                    value: FollowUpRegistryType.birthday,
                                  ),
                                  _buildTypeSelector(
                                    title: _copy(
                                      ar: 'متابعة التعافي',
                                      en: 'Recovery follow-up',
                                    ),
                                    value: FollowUpRegistryType.recoverySupport,
                                  ),
                                  _buildTypeSelector(
                                    title: _copy(
                                      ar: 'رسائل الدعم العامة',
                                      en: 'General support messages',
                                    ),
                                    value: FollowUpRegistryType.generalSupport,
                                  ),
                                  _buildTypeSelector(
                                    title: _copy(
                                      ar: 'محتوى توعوي وتثقيفي',
                                      en: 'Educational / awareness content',
                                    ),
                                    value: FollowUpRegistryType
                                        .educationalAwareness,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            Container(
                              padding: const EdgeInsets.all(AppSpacing.lg),
                              decoration: _glassDecoration(alpha: 0.34),
                              child: Column(
                                crossAxisAlignment: _contentAlignment,
                                children: [
                                  Align(
                                    alignment: _sectionTitleAlignment,
                                    child: Text(
                                      _copy(
                                        ar: 'توضيح سياسة المتابعة',
                                        en: 'Follow-up Policy Clarification',
                                      ),
                                      textAlign: _isArabic
                                          ? TextAlign.center
                                          : TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: const Color(0xFFE7C766),
                                          fontWeight: FontWeight.w900,
                                        ),
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.sm),
                                  Text(
                                    _copy(
                                      ar: 'المتابعة مقدمة من الإدارة كخدمة دعم مجانية وليست خدمة علاجية.\n'
                                          'المتابعة بعد الجلسات أو الإقامة فقط، وليست أثناء تقديم الخدمة.\n'
                                          'المتابعة أثناء الجلسات أو الإقامة حق من حقوقك ويقدمها لك مقدم الخدمة مباشرة.',
                                      en: 'Administrative follow-up is a free support service, not a therapeutic service.\n'
                                          'Follow-up applies after sessions or residency, not during active service delivery.\n'
                                          'During sessions or residency, therapeutic follow-up is your right and is provided directly by the service provider.',
                                    ),
                                    textAlign: _contentTextAlign,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: const Color(0xFFFFF4D4),
                                          fontWeight: FontWeight.w600,
                                          height: 1.7,
                                        ),
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  CheckboxListTile(
                                    value: _policyAcknowledged,
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(
                                      _copy(
                                        ar: 'أقر بأن المتابعة المقدمة من الإدارة خدمة دعم مجانية وليست خدمة علاجية، وأن المتابعة العلاجية أثناء الجلسات أو الإقامة مسؤولية مقدم الخدمة ضمن الخدمة المدفوعة.',
                                        en: "I acknowledge that administrative follow-up is a free support service, not a therapeutic service, and that therapeutic follow-up during sessions or residency is the provider's responsibility as part of the paid service.",
                                      ),
                                      textAlign: _contentTextAlign,
                                      style: const TextStyle(
                                        color: Color(0xFFFFF4D4),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _policyAcknowledged = value == true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            Container(
                              padding: const EdgeInsets.all(AppSpacing.lg),
                              decoration: _glassDecoration(alpha: 0.34),
                              child: Column(
                                crossAxisAlignment: _contentAlignment,
                                children: [
                                  Align(
                                    alignment: _sectionTitleAlignment,
                                    child: Text(
                                      _copy(
                                        ar: 'بيانات التواصل',
                                        en: 'Contact Details',
                                      ),
                                      textAlign: _isArabic
                                          ? TextAlign.center
                                          : TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: const Color(0xFFE7C766),
                                          fontWeight: FontWeight.w900,
                                        ),
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  TextFormField(
                                    controller: _displayNameController,
                                    textAlign: _contentTextAlign,
                                    decoration: appInputDecoration(
                                      context: context,
                                      label: _copy(
                                        ar: 'الاسم أو اللقب',
                                        en: 'Name or nickname',
                                      ),
                                      icon: Icons.person_outline,
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  TextFormField(
                                    controller: _phoneNumberController,
                                    keyboardType: TextInputType.phone,
                                    textAlign: _contentTextAlign,
                                    onChanged: (_) => setState(() {}),
                                    decoration: appInputDecoration(
                                      context: context,
                                      label: _copy(
                                        ar: 'رقم واتساب',
                                        en: 'WhatsApp number',
                                      ),
                                      icon: Icons.phone_outlined,
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    textAlign: _contentTextAlign,
                                    onChanged: (_) => setState(() {}),
                                    decoration: appInputDecoration(
                                      context: context,
                                      label: _copy(
                                        ar: 'البريد الإلكتروني',
                                        en: 'Email',
                                      ),
                                      icon: Icons.email_outlined,
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  Container(
                                    padding:
                                        const EdgeInsets.all(AppSpacing.md),
                                    decoration: _glassDecoration(
                                      alpha: 0.28,
                                      radius: 18,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.link_outlined),
                                        const SizedBox(width: AppSpacing.sm),
                                        Expanded(
                                          child: Text(
                                            '${_copy(ar: 'وسيلة التواصل المفضلة', en: 'Preferred contact channel')}: ${_preferredContactChannelLabel()}',
                                            textAlign: _contentTextAlign,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color:
                                                      const Color(0xFFFFF4D4),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (_isBirthdaySelected) ...[
                              const SizedBox(height: AppSpacing.lg),
                              _buildBirthdaySection(),
                            ],
                            if (_isRecoverySelected) ...[
                              const SizedBox(height: AppSpacing.lg),
                              _buildRecoverySection(),
                            ],
                            if (_isGeneralSupportSelected) ...[
                              const SizedBox(height: AppSpacing.lg),
                              _buildGeneralSupportSection(),
                            ],
                            if (_isEducationSelected) ...[
                              const SizedBox(height: AppSpacing.lg),
                              _buildEducationSection(),
                            ],
                            const SizedBox(height: AppSpacing.lg),
                            Container(
                              padding: const EdgeInsets.all(AppSpacing.lg),
                              decoration: _glassDecoration(alpha: 0.34),
                              child: Column(
                                crossAxisAlignment: _contentAlignment,
                                children: [
                                  Align(
                                    alignment: _sectionTitleAlignment,
                                    child: Text(
                                      _copy(
                                        ar: 'الموافقة',
                                        en: 'Consent',
                                      ),
                                      textAlign: _isArabic
                                          ? TextAlign.center
                                          : TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: const Color(0xFFE7C766),
                                          fontWeight: FontWeight.w900,
                                        ),
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  CheckboxListTile(
                                    value: _consentAccepted,
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(
                                      _copy(
                                        ar: 'أوافق على استقبال رسائل المتابعة والدعم والتوعية من فريق الدعم.',
                                        en: 'I agree to receive follow-up, support, and awareness messages from the support team.',
                                      ),
                                      textAlign: _contentTextAlign,
                                      style: const TextStyle(
                                        color: Color(0xFFFFF4D4),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _consentAccepted = value == true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: FilledButton.icon(
                                onPressed: _submitting ? null : _submit,
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFFE7C766),
                                  foregroundColor: const Color(0xFF1B1007),
                                  disabledBackgroundColor: const Color(
                                    0xFFE7C766,
                                  ).withValues(alpha: 0.44),
                                  disabledForegroundColor: const Color(
                                    0xFF1B1007,
                                  ).withValues(alpha: 0.70),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w900,
                                      ),
                                ),
                                icon: _submitting
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Color(0xFF1B1007),
                                        ),
                                      )
                                    : const Icon(Icons.how_to_reg_outlined),
                                label: Text(
                                  _submitting
                                      ? _copy(
                                          ar: 'جارٍ الإرسال...',
                                          en: 'Submitting...',
                                        )
                                      : _copy(
                                          ar: 'إتمام التسجيل',
                                          en: 'Submit registration',
                                        ),
                                ),
                              ),
                            ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTypeSelector({
    required String title,
    required String value,
  }) {
    final selected = _selectedFollowUpTypes.contains(value);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: CheckboxListTile(
        value: selected,
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          title,
          textAlign: _contentTextAlign,
          style: const TextStyle(color: Color(0xFFFFF4D4)),
        ),
        onChanged: (checked) {
          setState(() {
            if (checked == true) {
              _selectedFollowUpTypes.add(value);
            } else {
              _selectedFollowUpTypes.remove(value);
              if (value == FollowUpRegistryType.birthday) {
                _birthDay = null;
                _birthMonth = null;
              } else if (value == FollowUpRegistryType.recoverySupport) {
                _recoveryFrequency = null;
                _recoveryStartMonth = null;
                _recoveryStartYear = null;
              } else if (value == FollowUpRegistryType.generalSupport) {
                _supportFrequency = null;
              } else if (value == FollowUpRegistryType.educationalAwareness) {
                _selectedEducationalTopics.clear();
              }
            }
          });
        },
      ),
    );
  }

  Widget _buildBirthdaySection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: _glassDecoration(alpha: 0.34),
      child: Column(
        crossAxisAlignment: _contentAlignment,
        children: [
          Align(
            alignment: _sectionTitleAlignment,
            child: Text(
              _copy(ar: 'تاريخ الميلاد', en: 'Birthday Details'),
              textAlign: _isArabic ? TextAlign.center : TextAlign.left,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFFE7C766),
                  fontWeight: FontWeight.w900,
                ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: _birthDay,
                  items: List<int>.generate(31, (index) => index + 1)
                      .map(
                        (day) => DropdownMenuItem<int>(
                          value: day,
                          child: Text(day.toString()),
                        ),
                      )
                      .toList(),
                  decoration: appInputDecoration(
                    context: context,
                    label: _copy(ar: 'اليوم', en: 'Birth day'),
                    icon: Icons.cake_outlined,
                  ),
                  onChanged: (value) => setState(() => _birthDay = value),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: _birthMonth,
                  items: List<int>.generate(12, (index) => index + 1)
                      .map(
                        (month) => DropdownMenuItem<int>(
                          value: month,
                          child: Text(month.toString()),
                        ),
                      )
                      .toList(),
                  decoration: appInputDecoration(
                    context: context,
                    label: _copy(ar: 'الشهر', en: 'Birth month'),
                    icon: Icons.calendar_month_outlined,
                  ),
                  onChanged: (value) => setState(() => _birthMonth = value),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecoverySection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: _glassDecoration(alpha: 0.34),
      child: Column(
        crossAxisAlignment: _contentAlignment,
        children: [
          Align(
            alignment: _sectionTitleAlignment,
            child: Text(
              _copy(ar: 'متابعة التعافي', en: 'Recovery Follow-up'),
              textAlign: _isArabic ? TextAlign.center : TextAlign.left,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFFE7C766),
                  fontWeight: FontWeight.w900,
                ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          DropdownButtonFormField<String>(
            value: _recoveryFrequency,
            items: FollowUpRegistryRecoveryFrequency.values
                .map(
                  (value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(_recoveryFrequencyLabel(value)),
                  ),
                )
                .toList(),
            decoration: appInputDecoration(
              context: context,
              label: _copy(ar: 'وتيرة المتابعة', en: 'Recovery frequency'),
              icon: Icons.schedule_outlined,
            ),
            onChanged: (value) => setState(() => _recoveryFrequency = value),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: _recoveryStartMonth,
                  items: List<int>.generate(12, (index) => index + 1)
                      .map(
                        (month) => DropdownMenuItem<int>(
                          value: month,
                          child: Text(month.toString()),
                        ),
                      )
                      .toList(),
                  decoration: appInputDecoration(
                    context: context,
                    label: _copy(
                      ar: 'شهر بداية التعافي',
                      en: 'Recovery start month',
                    ),
                    icon: Icons.calendar_today_outlined,
                  ),
                  onChanged: (value) =>
                      setState(() => _recoveryStartMonth = value),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: _recoveryStartYear,
                  items: _yearOptions
                      .map(
                        (year) => DropdownMenuItem<int>(
                          value: year,
                          child: Text(year.toString()),
                        ),
                      )
                      .toList(),
                  decoration: appInputDecoration(
                    context: context,
                    label: _copy(
                      ar: 'سنة بداية التعافي',
                      en: 'Recovery start year',
                    ),
                    icon: Icons.event_note_outlined,
                  ),
                  onChanged: (value) =>
                      setState(() => _recoveryStartYear = value),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralSupportSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: _glassDecoration(alpha: 0.34),
      child: Column(
        crossAxisAlignment: _contentAlignment,
        children: [
          Align(
            alignment: _sectionTitleAlignment,
            child: Text(
              _copy(
                ar: 'رسائل الدعم العامة',
                en: 'General Support Messages',
              ),
              textAlign: _isArabic ? TextAlign.center : TextAlign.left,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFFE7C766),
                  fontWeight: FontWeight.w900,
                ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          DropdownButtonFormField<String>(
            value: _supportFrequency,
            items: FollowUpRegistrySupportFrequency.values
                .map(
                  (value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(_supportFrequencyLabel(value)),
                  ),
                )
                .toList(),
            decoration: appInputDecoration(
              context: context,
              label: _copy(
                ar: 'وتيرة رسائل الدعم',
                en: 'Support frequency',
              ),
              icon: Icons.support_agent_outlined,
            ),
            onChanged: (value) => setState(() => _supportFrequency = value),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: _glassDecoration(alpha: 0.34),
      child: Column(
        crossAxisAlignment: _contentAlignment,
        children: [
          Align(
            alignment: _sectionTitleAlignment,
            child: Text(
              _copy(
                ar: 'الموضوعات التوعوية المفضلة',
                en: 'Preferred Educational Topics',
              ),
              textAlign: _isArabic ? TextAlign.center : TextAlign.left,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFFE7C766),
                  fontWeight: FontWeight.w900,
                ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            _copy(
              ar: 'اختر موضوعًا واحدًا أو أكثر.',
              en: 'Choose one or more topics.',
            ),
            textAlign: _contentTextAlign,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: const Color(0xFFFFF4D4)),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: FollowUpRegistryEducationalTopic.values.map((topic) {
              final selected = _selectedEducationalTopics.contains(topic);
              return FilterChip(
                label: Text(_educationTopicLabel(topic)),
                selected: selected,
                onSelected: (value) {
                  setState(() {
                    if (value) {
                      _selectedEducationalTopics.add(topic);
                    } else {
                      _selectedEducationalTopics.remove(topic);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
