import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/features/external_follow_up/data/models/follow_up_registry_entry.dart';
import 'package:flutterprojects/features/external_follow_up/data/services/follow_up_registry_service.dart';
import 'package:flutterprojects/features/external_follow_up/domain/follow_up_registry_constants.dart';
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
  final Set<String> _selectedFollowUpTypes = <String>{};
  final Set<String> _selectedEducationalTopics = <String>{};

  bool _consentAccepted = false;
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

  bool get _isEducationSelected =>
      _selectedFollowUpTypes.contains(FollowUpRegistryType.educationalAwareness);

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
      return 'Select at least one follow-up type.';
    }

    if (_preferredContactChannel == null) {
      return 'Enter a WhatsApp number or an email address.';
    }

    if (!_consentAccepted) {
      return 'Consent is required to continue.';
    }

    if (_isBirthdaySelected && (_birthDay == null || _birthMonth == null)) {
      return 'Birthday day and month are required.';
    }

    if (_isRecoverySelected &&
        (_recoveryFrequency == null ||
            _recoveryStartMonth == null ||
            _recoveryStartYear == null)) {
      return 'Recovery frequency, start month, and start year are required.';
    }

    if (_isGeneralSupportSelected && _supportFrequency == null) {
      return 'Support frequency is required.';
    }

    if (_isEducationSelected && _selectedEducationalTopics.isEmpty) {
      return 'Select at least one educational topic.';
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
      _birthDay = null;
      _birthMonth = null;
      _supportFrequency = null;
      _recoveryFrequency = null;
      _recoveryStartMonth = null;
      _recoveryStartYear = null;
    });
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
                constraints: const BoxConstraints(maxWidth: 760),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                      vertical: AppSpacing.xxl,
                    ),
                    children: [
                      const AppHeroHeader(
                        title: 'Follow-up Registration',
                        subtitle:
                            'Register once to receive the follow-up categories you choose later. This form creates a registry entry only.',
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AppSurfaceCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Follow-up types',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              'Choose one or more categories.',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            _buildTypeSelector(
                              title: 'Birthday greetings',
                              value: FollowUpRegistryType.birthday,
                            ),
                            _buildTypeSelector(
                              title: 'Recovery follow-up',
                              value: FollowUpRegistryType.recoverySupport,
                            ),
                            _buildTypeSelector(
                              title: 'General support messages',
                              value: FollowUpRegistryType.generalSupport,
                            ),
                            _buildTypeSelector(
                              title: 'Educational / awareness content',
                              value:
                                  FollowUpRegistryType.educationalAwareness,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AppSurfaceCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Contact details',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            TextFormField(
                              controller: _displayNameController,
                              decoration: appInputDecoration(
                                context: context,
                                label: 'Name or nickname',
                                icon: Icons.person_outline,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            TextFormField(
                              controller: _phoneNumberController,
                              keyboardType: TextInputType.phone,
                              onChanged: (_) => setState(() {}),
                              decoration: appInputDecoration(
                                context: context,
                                label: 'WhatsApp number',
                                icon: Icons.phone_outlined,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (_) => setState(() {}),
                              decoration: appInputDecoration(
                                context: context,
                                label: 'Email',
                                icon: Icons.email_outlined,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            AppSectionPanel(
                              child: Row(
                                children: [
                                  const Icon(Icons.link_outlined),
                                  const SizedBox(width: AppSpacing.sm),
                                  Expanded(
                                    child: Text(
                                      'Preferred contact channel: ${_preferredContactChannel ?? 'Not available yet'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
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
                      AppSurfaceCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Consent',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            CheckboxListTile(
                              value: _consentAccepted,
                              contentPadding: EdgeInsets.zero,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: const Text(
                                'I agree to receive follow-up, support, and awareness messages from Mental Smile.',
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
                          icon: _submitting
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.how_to_reg_outlined),
                          label: Text(
                            _submitting
                                ? 'Submitting...'
                                : 'Submit registration',
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
        title: Text(title),
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
              } else if (value ==
                  FollowUpRegistryType.educationalAwareness) {
                _selectedEducationalTopics.clear();
              }
            }
          });
        },
      ),
    );
  }

  Widget _buildBirthdaySection() {
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Birthday details', style: Theme.of(context).textTheme.titleLarge),
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
                    label: 'Birth day',
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
                    label: 'Birth month',
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
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recovery follow-up', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.md),
          DropdownButtonFormField<String>(
            value: _recoveryFrequency,
            items: FollowUpRegistryRecoveryFrequency.values
                .map(
                  (value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                .toList(),
            decoration: appInputDecoration(
              context: context,
              label: 'Recovery frequency',
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
                    label: 'Recovery start month',
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
                    label: 'Recovery start year',
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
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'General support messages',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.md),
          DropdownButtonFormField<String>(
            value: _supportFrequency,
            items: FollowUpRegistrySupportFrequency.values
                .map(
                  (value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                .toList(),
            decoration: appInputDecoration(
              context: context,
              label: 'Support frequency',
              icon: Icons.support_agent_outlined,
            ),
            onChanged: (value) => setState(() => _supportFrequency = value),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationSection() {
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Educational topics',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Choose one or more topics.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: FollowUpRegistryEducationalTopic.values.map((topic) {
              final selected = _selectedEducationalTopics.contains(topic);
              return FilterChip(
                label: Text(topic),
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
