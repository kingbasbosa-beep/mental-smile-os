import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

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

  List<_SupportIssueOption> _options(bool isArabic) {
    if (_isClientSupport) {
      return [
        _SupportIssueOption(
          key: 'booking_issue',
          label: isArabic ? 'مشكلة في الحجز' : 'Booking issue',
        ),
        _SupportIssueOption(
          key: 'payment_follow_up',
          label: isArabic ? 'متابعة دفعة أو تحويل' : 'Payment follow-up',
        ),
        _SupportIssueOption(
          key: 'session_timing_issue',
          label: isArabic ? 'مشكلة في موعد الجلسة' : 'Session timing issue',
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
          key: 'need_human_follow_up',
          label: isArabic ? 'أحتاج متابعة بشرية' : 'Need human follow-up',
        ),
        _SupportIssueOption(
          key: 'general_admin_question',
          label: isArabic ? 'استفسار إداري عام' : 'General admin question',
        ),
      ];
    }

    if (_isRecoverySupport) {
      return [
        _SupportIssueOption(
          key: 'need_specialist',
          label:
              isArabic ? 'محتاج أخصائي مناسب' : 'Need a suitable specialist',
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
          label:
              isArabic ? 'طلب مساعدة عامة' : 'General help request',
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
        label: isArabic ? 'طلب مساعدة عامة' : 'General help request',
      ),
    ];
  }

  Future<void> _submitIssue(_SupportIssueOption option) async {
    if (_submittingIssueKey != null) return;

    setState(() {
      _submittingIssueKey = option.key;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      final isGuest = user == null || user.isAnonymous;
      final userRole = _isClientSupport ? 'client' : (isGuest ? 'guest' : 'client');
      final priority = option.key == 'risk_report' ? 'high' : 'normal';

      final ref =
          FirebaseFirestore.instance.collection('support_requests').doc();

      await ref.set({
        'id': ref.id,
        'createdAt': FieldValue.serverTimestamp(),
        'createdByUid': user?.uid,
        'userRole': userRole,
        'supportType': widget.supportType,
        'issueType': option.key,
        'status': 'new',
        'source': 'structured_support',
        'priority': priority,
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'تم استلام طلبك وسيتم متابعته'
                : 'Your request was received and will be reviewed.',
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
                ? 'تعذر إرسال الطلب الآن'
                : 'Unable to submit the request right now.',
          ),
        ),
      );
    } finally {
      if (!mounted) return;
      setState(() {
        _submittingIssueKey = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);
    final title = isArabic ? 'اختر نوع المساعدة' : 'Choose support type';
    final options = _options(isArabic);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(context, title: title),
        body: AppPageBackground(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              AppSurfaceCard(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: isArabic
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      isArabic
                          ? 'اختر المشكلة الأقرب لاحتياجك الحالي ليتم استلامها كطلب منظم.'
                          : 'Choose the issue that best matches your current need so it can be received as a structured request.',
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
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
                    child: AppSurfaceCard(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Row(
                        textDirection:
                            isArabic ? TextDirection.rtl : TextDirection.ltr,
                        children: [
                          _submittingIssueKey == option.key
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.radio_button_unchecked_rounded),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              option.label,
                              textAlign:
                                  isArabic ? TextAlign.right : TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
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
