import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_smile_os/features/signals/signals.dart';
import 'package:mental_smile_os/shared/ui_kit/app_design_system.dart';
import 'package:mental_smile_os/shared/ui_kit/app_shell_actions.dart';

class SupportIssueSelectorPage extends StatefulWidget {
  const SupportIssueSelectorPage({
    super.key,
    required this.supportType,
  });

  final String supportType;

  @override
  State<SupportIssueSelectorPage> createState() =>
      _SupportIssueSelectorPageState();
}

class _SupportIssueSelectorPageState extends State<SupportIssueSelectorPage> {
  String? _submittingIssueKey;

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  bool get _isRecoverySupport => widget.supportType == 'recovery_support';
  bool get _isClientSupport => widget.supportType == 'client_support';
  bool get _isCenterSupport => widget.supportType == 'center_support';
  bool get _isClinicianSupport => widget.supportType == 'clinician_support';

  String _backgroundAsset(double width) {
    if (width < 700) {
      return 'assets/images/backgrounds/specialists_bg_mobile.png';
    }
    if (width < 1100) {
      return 'assets/images/backgrounds/specialists_bg_tablet.png';
    }
    return 'assets/images/backgrounds/specialists_bg_desktop.png';
  }

  BoxDecoration _glassDecoration({double alpha = 0.36, double radius = 24}) {
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

  List<_SupportIssueOption> _options(bool isArabic) {
    if (_isClientSupport) {
      return [
        _SupportIssueOption(
          key: 'service_access_question',
          label: isArabic ? 'مساعدة في الوصول للخدمة' : 'Service access help',
        ),
        _SupportIssueOption(
          key: 'provider_contact_question',
          label:
              isArabic ? 'مساعدة في التواصل مع مختص' : 'Provider contact help',
        ),
        _SupportIssueOption(
          key: 'account_profile_issue',
          label: isArabic
              ? 'مشكلة في الحساب أو الملف الشخصي'
              : 'Account/profile issue',
        ),
        _SupportIssueOption(
          key: 'complaint_bad_experience',
          label: isArabic
              ? 'شكوى أو تجربة غير جيدة'
              : 'Complaint / bad experience',
        ),
        _SupportIssueOption(
          key: 'need_human_guidance',
          label: isArabic ? 'أحتاج إرشادًا بشريًا' : 'Need human guidance',
        ),
        _SupportIssueOption(
          key: 'general_support_question',
          label: isArabic ? 'استفسار دعم عام' : 'General support question',
        ),
      ];
    }

    if (_isCenterSupport) {
      return [
        _SupportIssueOption(
          key: 'profile_visibility_issue',
          label: isArabic ? 'مشكلة في ظهور الملف' : 'Profile visibility issue',
        ),
        _SupportIssueOption(
          key: 'contact_request_question',
          label:
              isArabic ? 'استفسار عن إشارة تواصل' : 'Contact signal question',
        ),
        _SupportIssueOption(
          key: 'accessibility_information_issue',
          label: isArabic
              ? 'مشكلة في معلومات الإتاحة'
              : 'Accessibility information issue',
        ),
        _SupportIssueOption(
          key: 'system_issue',
          label: isArabic ? 'مشكلة في النظام' : 'System issue',
        ),
        _SupportIssueOption(
          key: 'general_support_request',
          label: isArabic ? 'إشارة دعم عامة' : 'General support signal',
        ),
      ];
    }

    if (_isClinicianSupport) {
      return [
        _SupportIssueOption(
          key: 'profile_visibility_issue',
          label: isArabic ? 'مشكلة في ظهور الملف' : 'Profile visibility issue',
        ),
        _SupportIssueOption(
          key: 'client_communication_question',
          label: isArabic ? 'استفسار عن التواصل' : 'Communication question',
        ),
        _SupportIssueOption(
          key: 'recommendation_visibility_question',
          label: isArabic
              ? 'استفسار عن ظهور التوصيات'
              : 'Recommendation visibility question',
        ),
        _SupportIssueOption(
          key: 'system_issue',
          label: isArabic ? 'مشكلة في النظام' : 'System issue',
        ),
        _SupportIssueOption(
          key: 'need_support_room',
          label: isArabic ? 'أحتاج دعمًا' : 'Need support',
        ),
      ];
    }

    if (_isRecoverySupport) {
      return [
        _SupportIssueOption(
          key: 'need_specialist',
          label: isArabic ? 'محتاج أخصائي مناسب' : 'Need a suitable specialist',
        ),
        _SupportIssueOption(
          key: 'need_center',
          label: isArabic ? 'محتاج مركز مناسب' : 'Need a suitable center',
        ),
        _SupportIssueOption(
          key: 'recovery_support',
          label: isArabic ? 'دعم في التعافي' : 'Recovery support',
        ),
        _SupportIssueOption(
          key: 'relapse_concern',
          label: isArabic ? 'قلق من الانتكاسة' : 'Relapse concern',
        ),
        _SupportIssueOption(
          key: 'risk_report',
          label: isArabic ? 'بلاغ خطر' : 'Risk report',
        ),
        _SupportIssueOption(
          key: 'general_help',
          label: isArabic ? 'إشارة مساعدة عامة' : 'General help signal',
        ),
      ];
    }

    return [
      _SupportIssueOption(
        key: 'need_specialist',
        label: isArabic ? 'محتاج أخصائي مناسب' : 'Need a suitable specialist',
      ),
      _SupportIssueOption(
        key: 'need_center',
        label: isArabic ? 'محتاج مركز مناسب' : 'Need a suitable center',
      ),
      _SupportIssueOption(
        key: 'family_guidance',
        label: isArabic ? 'إرشاد أسري' : 'Family guidance',
      ),
      _SupportIssueOption(
        key: 'special_case_support',
        label: isArabic
            ? 'دعم لطفل / حالة خاصة'
            : 'Support for a child / special case',
      ),
      _SupportIssueOption(
        key: 'risk_report',
        label: isArabic ? 'بلاغ خطر' : 'Risk report',
      ),
      _SupportIssueOption(
        key: 'general_help',
        label: isArabic ? 'إشارة مساعدة عامة' : 'General help signal',
      ),
    ];
  }

  String _userRole() {
    if (_isCenterSupport) return 'center';
    if (_isClinicianSupport) return 'clinician';
    if (_isClientSupport) return 'session';

    final user = FirebaseAuth.instance.currentUser;
    return user == null || user.isAnonymous ? 'guest' : 'session';
  }

  Future<void> _submitIssue(_SupportIssueOption option) async {
    if (_submittingIssueKey != null) return;

    setState(() {
      _submittingIssueKey = option.key;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      final ref =
          FirebaseFirestore.instance.collection('support_requests').doc();

      await ref.set({
        'id': ref.id,
        'createdAt': FieldValue.serverTimestamp(),
        'createdByUid': user?.uid,
        'userRole': _userRole(),
        'supportType': widget.supportType,
        'issueType': option.key,
        'status': 'new',
        'source': 'structured_support',
        'priority': 'normal',
      });

      // Emit Support Started Signal (Fail-soft)
      try {
        await CleanSignalRuntime.firestore().emit(
          SignalPackageFactory.supportStarted(
            actorId: user?.uid ?? 'guest',
            actorRole: _userRole(),
            targetId: ref.id,
            signalSource: 'support_issue_selector',
          ),
        );
      } catch (e) {
        debugPrint('Support signal emission failed: $e');
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'تم استلام إشارة الدعم في غرفة الدعم'
                : 'Your support signal was received by the Support Room.',
          ),
        ),
      );
      Navigator.of(context).maybePop();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'تعذر إرسال إشارة الدعم الآن'
                : 'Unable to submit the support signal right now.',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _submittingIssueKey = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);
    final title = isArabic ? 'الدعم' : 'Support';
    final selectorTitle =
        isArabic ? 'اختر نوع المساعدة' : 'Choose support type';
    final options = _options(isArabic);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppShellActions.buildAppBar(
          context,
          title: title,
          showAccountBadge: false,
        ),
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
                ListView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: _glassDecoration(alpha: 0.34),
                      child: Column(
                        crossAxisAlignment: isArabic
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectorTitle,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: const Color(0xFFE7C766),
                                  fontWeight: FontWeight.w900,
                                ),
                            textAlign:
                                isArabic ? TextAlign.right : TextAlign.left,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            isArabic
                                ? 'اختر المشكلة الأقرب لاحتياجك الحالي ليتم استلامها كإشارة دعم منظمة.'
                                : 'Choose the issue that best matches your current need so it can be received as a structured support signal.',
                            textAlign:
                                isArabic ? TextAlign.right : TextAlign.left,
                            style: const TextStyle(color: Color(0xFFFFF4D4)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ...options.map(
                      (option) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(AppRadii.lg),
                          onTap: _submittingIssueKey == null
                              ? () => _submitIssue(option)
                              : null,
                          child: Container(
                            padding: const EdgeInsets.all(AppSpacing.lg),
                            decoration:
                                _glassDecoration(alpha: 0.30, radius: 22),
                            child: Row(
                              textDirection: isArabic
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              children: [
                                _submittingIssueKey == option.key
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Color(0xFFE7C766),
                                        ),
                                      )
                                    : const Icon(
                                        Icons.radio_button_unchecked_rounded,
                                        color: Color(0xFFE7C766),
                                      ),
                                const SizedBox(width: AppSpacing.sm),
                                Expanded(
                                  child: Text(
                                    option.label,
                                    textAlign: isArabic
                                        ? TextAlign.right
                                        : TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: const Color(0xFFFFF4D4),
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SupportIssueOption {
  const _SupportIssueOption({
    required this.key,
    required this.label,
  });

  final String key;
  final String label;
}
