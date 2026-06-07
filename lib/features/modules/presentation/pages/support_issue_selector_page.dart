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
          key: 'booking_issue',
          label: isArabic ? 'Ù…Ø´ÙƒÙ„Ø© ÙÙŠ Ø·Ù„Ø¨ Ø§Ù„Ø®Ø¯Ù…Ø©' : 'Service request issue',
        ),
        _SupportIssueOption(
          key: 'session_timing_issue',
          label: isArabic ? 'Ù…Ø´ÙƒÙ„Ø© ÙÙŠ Ù…ÙˆØ¹Ø¯ Ø§Ù„Ø¬Ù„Ø³Ø©' : 'Session timing issue',
        ),
        _SupportIssueOption(
          key: 'account_profile_issue',
          label: isArabic
              ? 'Ù…Ø´ÙƒÙ„Ø© ÙÙŠ Ø§Ù„Ø­Ø³Ø§Ø¨ Ø£Ùˆ Ø§Ù„Ù…Ù„Ù Ø§Ù„Ø´Ø®ØµÙŠ'
              : 'Account/profile issue',
        ),
        _SupportIssueOption(
          key: 'complaint_bad_experience',
          label: isArabic
              ? 'Ø´ÙƒÙˆÙ‰ Ø£Ùˆ ØªØ¬Ø±Ø¨Ø© ØºÙŠØ± Ø¬ÙŠØ¯Ø©'
              : 'Complaint / bad experience',
        ),
        _SupportIssueOption(
          key: 'need_human_follow_up',
          label: isArabic ? 'Ø£Ø­ØªØ§Ø¬ Ù…ØªØ§Ø¨Ø¹Ø© Ø¨Ø´Ø±ÙŠØ©' : 'Need human follow-up',
        ),
        _SupportIssueOption(
          key: 'general_admin_question',
          label: isArabic ? 'Ø§Ø³ØªÙØ³Ø§Ø± Ø¥Ø¯Ø§Ø±ÙŠ Ø¹Ø§Ù…' : 'General admin question',
        ),
      ];
    }

    if (_isCenterSupport) {
      return [
        _SupportIssueOption(
          key: 'booking_issue',
          label: isArabic ? 'Ù…Ø´ÙƒÙ„Ø© ÙÙŠ Ø·Ù„Ø¨ Ø§Ù„Ø®Ø¯Ù…Ø©' : 'Service request issue',
        ),
        _SupportIssueOption(
          key: 'client_no_show',
          label: isArabic ? 'Ø§Ù„Ø¹Ù…ÙŠÙ„ Ù„Ù… ÙŠØ­Ø¶Ø±' : 'Client no-show',
        ),
        _SupportIssueOption(
          key: 'scheduling_problem',
          label: isArabic ? 'Ù…Ø´ÙƒÙ„Ø© ÙÙŠ Ø§Ù„Ø¬Ø¯ÙˆÙ„Ø©' : 'Scheduling problem',
        ),
        _SupportIssueOption(
          key: 'system_issue',
          label: isArabic ? 'Ù…Ø´ÙƒÙ„Ø© ÙÙŠ Ø§Ù„Ù†Ø¸Ø§Ù…' : 'System issue',
        ),
        _SupportIssueOption(
          key: 'general_admin_request',
          label: isArabic ? 'Ø·Ù„Ø¨ Ø¥Ø¯Ø§Ø±ÙŠ Ø¹Ø§Ù…' : 'General admin request',
        ),
      ];
    }

    if (_isClinicianSupport) {
      return [
        _SupportIssueOption(
          key: 'case_issue',
          label: isArabic ? 'Ù…Ø´ÙƒÙ„Ø© ÙÙŠ Ø§Ù„Ø­Ø§Ù„Ø©' : 'Case issue',
        ),
        _SupportIssueOption(
          key: 'session_problem',
          label: isArabic ? 'Ù…Ø´ÙƒÙ„Ø© ÙÙŠ Ø§Ù„Ø¬Ù„Ø³Ø©' : 'Session problem',
        ),
        _SupportIssueOption(
          key: 'assignment_problem',
          label: isArabic ? 'Ù…Ø´ÙƒÙ„Ø© ÙÙŠ Ø§Ù„Ø¥Ø³Ù†Ø§Ø¯' : 'Assignment problem',
        ),
        _SupportIssueOption(
          key: 'system_issue',
          label: isArabic ? 'Ù…Ø´ÙƒÙ„Ø© ÙÙŠ Ø§Ù„Ù†Ø¸Ø§Ù…' : 'System issue',
        ),
        _SupportIssueOption(
          key: 'need_admin_support',
          label: isArabic ? 'Ø£Ø­ØªØ§Ø¬ Ø¯Ø¹Ù… Ø¥Ø¯Ø§Ø±ÙŠ' : 'Need admin support',
        ),
      ];
    }

    if (_isRecoverySupport) {
      return [
        _SupportIssueOption(
          key: 'need_specialist',
          label: isArabic ? 'Ù…Ø­ØªØ§Ø¬ Ø£Ø®ØµØ§Ø¦ÙŠ Ù…Ù†Ø§Ø³Ø¨' : 'Need a suitable specialist',
        ),
        _SupportIssueOption(
          key: 'need_center',
          label: isArabic ? 'Ù…Ø­ØªØ§Ø¬ Ù…Ø±ÙƒØ² Ù…Ù†Ø§Ø³Ø¨' : 'Need a suitable center',
        ),
        _SupportIssueOption(
          key: 'recovery_support',
          label: isArabic ? 'Ø¯Ø¹Ù… ÙÙŠ Ø§Ù„ØªØ¹Ø§ÙÙŠ' : 'Recovery support',
        ),
        _SupportIssueOption(
          key: 'relapse_concern',
          label: isArabic ? 'Ù‚Ù„Ù‚ Ù…Ù† Ø§Ù„Ø§Ù†ØªÙƒØ§Ø³Ø©' : 'Relapse concern',
        ),
        _SupportIssueOption(
          key: 'risk_report',
          label: isArabic ? 'Ø¨Ù„Ø§Øº Ø®Ø·Ø±' : 'Risk report',
        ),
        _SupportIssueOption(
          key: 'general_help',
          label: isArabic ? 'Ø·Ù„Ø¨ Ù…Ø³Ø§Ø¹Ø¯Ø© Ø¹Ø§Ù…Ø©' : 'General help request',
        ),
      ];
    }

    return [
      _SupportIssueOption(
        key: 'need_specialist',
        label: isArabic ? 'Ù…Ø­ØªØ§Ø¬ Ø£Ø®ØµØ§Ø¦ÙŠ Ù…Ù†Ø§Ø³Ø¨' : 'Need a suitable specialist',
      ),
      _SupportIssueOption(
        key: 'need_center',
        label: isArabic ? 'Ù…Ø­ØªØ§Ø¬ Ù…Ø±ÙƒØ² Ù…Ù†Ø§Ø³Ø¨' : 'Need a suitable center',
      ),
      _SupportIssueOption(
        key: 'family_guidance',
        label: isArabic ? 'Ø¥Ø±Ø´Ø§Ø¯ Ø£Ø³Ø±ÙŠ' : 'Family guidance',
      ),
      _SupportIssueOption(
        key: 'special_case_support',
        label: isArabic
            ? 'Ø¯Ø¹Ù… Ù„Ø·ÙÙ„ / Ø­Ø§Ù„Ø© Ø®Ø§ØµØ©'
            : 'Support for a child / special case',
      ),
      _SupportIssueOption(
        key: 'risk_report',
        label: isArabic ? 'Ø¨Ù„Ø§Øº Ø®Ø·Ø±' : 'Risk report',
      ),
      _SupportIssueOption(
        key: 'general_help',
        label: isArabic ? 'Ø·Ù„Ø¨ Ù…Ø³Ø§Ø¹Ø¯Ø© Ø¹Ø§Ù…Ø©' : 'General help request',
      ),
    ];
  }

  String _userRole() {
    if (_isCenterSupport) return 'center';
    if (_isClinicianSupport) return 'clinician';
    if (_isClientSupport) return 'client';

    final user = FirebaseAuth.instance.currentUser;
    return user == null || user.isAnonymous ? 'guest' : 'client';
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

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'ØªÙ… Ø§Ø³ØªÙ„Ø§Ù… Ø·Ù„Ø¨Ùƒ ÙˆØ³ÙŠØªÙ… Ù…ØªØ§Ø¨Ø¹ØªÙ‡'
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
                ? 'ØªØ¹Ø°Ø± Ø¥Ø±Ø³Ø§Ù„ Ø§Ù„Ø·Ù„Ø¨ Ø§Ù„Ø¢Ù†'
                : 'Unable to submit the request right now.',
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
    final title = isArabic ? 'Ø§Ù„Ø¯Ø¹Ù…' : 'Support';
    final selectorTitle =
        isArabic ? 'Ø§Ø®ØªØ± Ù†ÙˆØ¹ Ø§Ù„Ù…Ø³Ø§Ø¹Ø¯Ø©' : 'Choose support type';
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
                                ? 'Ø§Ø®ØªØ± Ø§Ù„Ù…Ø´ÙƒÙ„Ø© Ø§Ù„Ø£Ù‚Ø±Ø¨ Ù„Ø§Ø­ØªÙŠØ§Ø¬Ùƒ Ø§Ù„Ø­Ø§Ù„ÙŠ Ù„ÙŠØªÙ… Ø§Ø³ØªÙ„Ø§Ù…Ù‡Ø§ ÙƒØ·Ù„Ø¨ Ù…Ù†Ø¸Ù….'
                                : 'Choose the issue that best matches your current need so it can be received as a structured request.',
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
