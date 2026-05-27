import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class CenterResidenciesPage extends StatefulWidget {
  const CenterResidenciesPage({super.key});

  @override
  State<CenterResidenciesPage> createState() => _CenterResidenciesPageState();
}

class _CenterResidenciesPageState extends State<CenterResidenciesPage> {
  String _tab = 'scheduled';

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  String _workflowActivationLabel(bool isArabic) {
    return isArabic ? 'قيد تفعيل مسار العمل' : 'Pending workflow activation';
  }

  String _centerTypeLabel(String type) {
    switch (type.trim()) {
      case 'detox':
        return 'ديتوكس / أعراض انسحاب';
      case 'hospital':
        return 'مستشفى';
      case 'special_needs_care':
        return 'رعاية ذوي الاحتياجات الخاصة';
      case 'halfway_house':
      default:
        return 'هاف واي';
    }
  }

  bool _isCenterRequestData(Map<String, dynamic> data, String centerId) {
    final requestKind = (data['requestKind'] ?? '').toString().trim();
    final dataCenterId = (data['centerId'] ?? '').toString().trim();
    final centerName = (data['centerName'] ?? '').toString().trim();
    return requestKind == 'center' ||
        dataCenterId == centerId ||
        centerName.isNotEmpty;
  }

  String _dateText(dynamic value) {
    if (value is Timestamp) {
      final d = value.toDate();
      final day = d.day.toString().padLeft(2, '0');
      final month = d.month.toString().padLeft(2, '0');
      final year = d.year.toString();
      final hour = d.hour.toString().padLeft(2, '0');
      final minute = d.minute.toString().padLeft(2, '0');
      return '$hour:$minute $day-$month-$year';
    }
    return '';
  }

  bool _matchesTab(String status) {
    switch (_tab) {
      case 'in_progress':
        return status == 'session_in_progress';
      case 'pending_reviews':
        return status == 'session_completed_pending_reviews';
      case 'scheduled':
      default:
        return status == 'center_recommendation_pending' ||
            status == 'session_setup_pending' ||
            status == 'session_scheduled' ||
            status == 'reschedule_pending';
    }
  }

  String _statusLabel(String status, bool isArabic) {
    switch (status) {
      case 'center_recommendation_pending':
        return isArabic
            ? 'بانتظار التوصية الأولية'
            : 'Awaiting initial recommendation';
      case 'session_setup_pending':
        return isArabic ? 'بانتظار تجهيز الإقامة' : 'Residency setup pending';
      case 'session_scheduled':
        return isArabic ? 'إقامة مجدولة' : 'Residency scheduled';
      case 'session_in_progress':
        return isArabic ? 'الإقامة جارية' : 'Residency in progress';
      case 'session_completed_pending_reviews':
        return isArabic ? 'بانتظار تقارير الخروج' : 'Pending discharge reviews';
      case 'reschedule_pending':
        return isArabic ? 'بانتظار إعادة الجدولة' : 'Reschedule pending';
      default:
        return status;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'center_recommendation_pending':
        return const Color(0xFFE39B2E);
      case 'session_scheduled':
      case 'session_in_progress':
        return const Color(0xFF2E5AAC);
      case 'session_completed_pending_reviews':
        return const Color(0xFF1F9D63);
      case 'reschedule_pending':
        return const Color(0xFFE39B2E);
      default:
        return const Color(0xFF6C55B3);
    }
  }

  bool _isAwaitingResidencyStart(
    String status,
    bool centerArrivalConfirmed,
    bool clientCheckInConfirmed,
  ) {
    return status == 'session_scheduled' &&
        (!centerArrivalConfirmed || !clientCheckInConfirmed);
  }

  bool _hasPreliminaryResidencyDetails(Map<String, dynamic> data) {
    return (data['stayStartDateText'] ?? data['sessionDateText'] ?? '')
            .toString()
            .trim()
            .isNotEmpty &&
        (data['stayEndDateText'] ?? '').toString().trim().isNotEmpty &&
        (data['stayDurationReason'] ?? '').toString().trim().isNotEmpty;
  }

  bool _canCenterDischargeReview(Map<String, dynamic> data) {
    final status = (data['status'] ?? '').toString();
    final centerReviewSubmitted =
        ((data['centerReviewSubmitted'] ?? data['clinicianReviewSubmitted']) ??
                false) ==
            true;
    if (centerReviewSubmitted) return false;
    return status == 'session_completed_pending_reviews' ||
        (status == 'payout_pending' &&
            (data['reviewStatus'] ?? '').toString() == 'partial');
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);
    final centerId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppShellActions.buildAppBar(
          context,
          title: isArabic ? 'إقامات المركز' : 'Center Residencies',
        ),
        body: centerId.isEmpty
            ? Center(
                child: Text(
                  isArabic ? 'يجب تسجيل الدخول أولًا' : 'Please sign in first',
                ),
              )
            : SafeArea(
                child: AppPageBackground(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('booking_requests')
                        .where('centerId', isEqualTo: centerId)
                        .where(
                      'status',
                      whereIn: const [
                        'center_recommendation_pending',
                        'session_setup_pending',
                        'session_scheduled',
                        'session_in_progress',
                        'session_completed_pending_reviews',
                        'reschedule_pending',
                      ],
                    ).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return AppEmptyState(
                          message: isArabic
                              ? 'تعذر تحميل الإقامات'
                              : 'Unable to load residencies',
                          icon: Icons.error_outline,
                        );
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final docs = snapshot.data!.docs.where((doc) {
                        if ((doc.data()['archived'] ?? false) == true) {
                          return false;
                        }
                        final status = (doc.data()['status'] ?? '').toString();
                        return _matchesTab(status);
                      }).toList()
                        ..sort((a, b) {
                          final aTs =
                              a.data()['updatedAt'] ?? a.data()['createdAt'];
                          final bTs =
                              b.data()['updatedAt'] ?? b.data()['createdAt'];
                          DateTime ad = DateTime.fromMillisecondsSinceEpoch(0);
                          DateTime bd = DateTime.fromMillisecondsSinceEpoch(0);
                          if (aTs is Timestamp) ad = aTs.toDate();
                          if (bTs is Timestamp) bd = bTs.toDate();
                          return bd.compareTo(ad);
                        });

                      return ListView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                          vertical: AppSpacing.md,
                        ),
                        children: [
                          AppSurfaceCard(
                            padding: const EdgeInsets.all(AppSpacing.lg),
                            child: Wrap(
                              spacing: AppSpacing.sm,
                              runSpacing: AppSpacing.sm,
                              alignment: WrapAlignment.end,
                              children: [
                                ChoiceChip(
                                  selected: _tab == 'scheduled',
                                  label: Text(
                                    isArabic
                                        ? 'الإقامات المجدولة'
                                        : 'Scheduled stays',
                                  ),
                                  onSelected: (_) =>
                                      setState(() => _tab = 'scheduled'),
                                ),
                                ChoiceChip(
                                  selected: _tab == 'in_progress',
                                  label: Text(
                                    isArabic
                                        ? 'الإقامات الجارية'
                                        : 'Active stays',
                                  ),
                                  onSelected: (_) =>
                                      setState(() => _tab = 'in_progress'),
                                ),
                                ChoiceChip(
                                  selected: _tab == 'pending_reviews',
                                  label: Text(
                                    isArabic
                                        ? 'بانتظار تقارير الخروج'
                                        : 'Pending discharge reviews',
                                  ),
                                  onSelected: (_) =>
                                      setState(() => _tab = 'pending_reviews'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          if (docs.isEmpty)
                            AppEmptyState(
                              message: isArabic
                                  ? 'لا توجد إقامات في هذا القسم'
                                  : 'No residencies in this section',
                            )
                          else
                            ...docs
                                .where(
                              (doc) => _isCenterRequestData(
                                doc.data(),
                                centerId,
                              ),
                            )
                                .map((doc) {
                              final data = doc.data();
                              final requestId = doc.id;
                              final clientName =
                                  (data['clientName'] ?? 'Client').toString();
                              final note =
                                  (data['note'] ?? '').toString().trim();
                              final accommodation =
                                  (data['selectedAccommodationLabelAr'] ?? '')
                                      .toString()
                                      .trim();
                              final selectedCenterType =
                                  (data['selectedCenterType'] ?? '')
                                      .toString()
                                      .trim();
                              final centerHasDetoxUnit =
                                  (data['centerHasDetoxUnit'] ?? false) == true;
                              final sessionDate =
                                  (data['sessionDateText'] ?? '')
                                      .toString()
                                      .trim();
                              final stayStartText =
                                  (data['stayStartDateText'] ??
                                          data['sessionDateText'] ??
                                          '')
                                      .toString()
                                      .trim();
                              final stayEndText =
                                  (data['stayEndDateText'] ?? '')
                                      .toString()
                                      .trim();
                              final stayDurationDays =
                                  (data['stayDurationDays'] ?? '')
                                      .toString()
                                      .trim();
                              final stayDurationReason =
                                  (data['stayDurationReason'] ?? '')
                                      .toString()
                                      .trim();
                              final intakeReason = (data['intakeReason'] ?? '')
                                  .toString()
                                  .trim();
                              final intakeSymptomsText =
                                  (data['intakeSymptomsText'] ?? '')
                                      .toString()
                                      .trim();
                              final intakeLastSubstanceUseAt =
                                  (data['intakeLastSubstanceUseAt'] ?? '')
                                      .toString()
                                      .trim();
                              final intakeWithdrawalSymptomsText =
                                  (data['intakeWithdrawalSymptomsText'] ?? '')
                                      .toString()
                                      .trim();
                              final intakePriorDetoxHistory =
                                  (data['intakePriorDetoxHistory'] ?? '')
                                      .toString()
                                      .trim();
                              final intakeRiskNotes =
                                  (data['intakeRiskNotes'] ?? '')
                                      .toString()
                                      .trim();
                              final intakeCurrentMedications =
                                  (data['intakeCurrentMedications'] ?? '')
                                      .toString()
                                      .trim();
                              final intakeFamilyNotes =
                                  (data['intakeFamilyNotes'] ?? '')
                                      .toString()
                                      .trim();
                              final intakeSpecialNeedsConditionType =
                                  (data['intakeSpecialNeedsConditionType'] ??
                                          '')
                                      .toString()
                                      .trim();
                              final intakeNeedsCompanion =
                                  (data['intakeNeedsCompanion'] ?? false) ==
                                      true;
                              final intakeMobilitySupport =
                                  (data['intakeMobilitySupport'] ?? '')
                                      .toString()
                                      .trim();
                              final intakeNutritionSupport =
                                  (data['intakeNutritionSupport'] ?? '')
                                      .toString()
                                      .trim();
                              final intakeSpecialCareNotes =
                                  (data['intakeSpecialCareNotes'] ?? '')
                                      .toString()
                                      .trim();
                              final centerInitialRecommendation =
                                  (data['centerInitialRecommendation'] ?? '')
                                      .toString()
                                      .trim();
                              final centerRecommendedCareLevel =
                                  (data['centerRecommendedCareLevel'] ?? '')
                                      .toString()
                                      .trim();
                              final centerRecommendedStayDays =
                                  (data['centerRecommendedStayDays'] ?? '')
                                      .toString()
                                      .trim();
                              final centerRecommendationNotes =
                                  (data['centerRecommendationNotes'] ?? '')
                                      .toString()
                                      .trim();
                              final stayDurationIsPreliminary =
                                  (data['stayDurationIsPreliminary'] ??
                                          false) ==
                                      true;
                              final sessionLink =
                                  (data['sessionLink'] ?? '').toString().trim();
                              final sessionCode =
                                  (data['sessionCode'] ?? '').toString().trim();
                              final adminNotes =
                                  (data['sessionAdminNotes'] ?? '')
                                      .toString()
                                      .trim();
                              final createdAt = _dateText(data['createdAt']);
                              final status = (data['status'] ?? '').toString();
                              final centerArrivalConfirmed =
                                  (data['centerArrivalConfirmed'] ?? false) ==
                                      true;
                              final clientCheckInConfirmed =
                                  (data['clientCheckInConfirmed'] ?? false) ==
                                      true;
                              final centerReviewSubmitted = ((data[
                                              'centerReviewSubmitted'] ??
                                          data['clinicianReviewSubmitted']) ??
                                      false) ==
                                  true;
                              final awaitingResidencyStart =
                                  _isAwaitingResidencyStart(
                                status,
                                centerArrivalConfirmed,
                                clientCheckInConfirmed,
                              );
                              final hasPreliminaryResidencyDetails =
                                  _hasPreliminaryResidencyDetails(data);

                              return AppSurfaceCard(
                                padding: const EdgeInsets.all(AppSpacing.md),
                                color: Colors.white.withValues(alpha: 0.84),
                                child: Column(
                                  crossAxisAlignment: isArabic
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      textDirection: isArabic
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            clientName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w800,
                                                ),
                                          ),
                                        ),
                                        AppStatusBadge(
                                          label: awaitingResidencyStart
                                              ? (isArabic
                                                  ? 'بانتظار تأكيد البداية'
                                                  : 'Awaiting start confirmations')
                                              : _statusLabel(status, isArabic),
                                          color: awaitingResidencyStart
                                              ? const Color(0xFFE39B2E)
                                              : _statusColor(status),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppSpacing.xs),
                                    Text(
                                      isArabic ? 'طلب مركز' : 'Center request',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    if (createdAt.isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'تاريخ الطلب: $createdAt'
                                            : 'Request date: $createdAt',
                                      ),
                                    ],
                                    if (note.isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'ملاحظة العميل: $note'
                                            : 'Client note: $note',
                                      ),
                                    ],
                                    if (accommodation.isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'الإقامة المحجوزة: $accommodation'
                                            : 'Booked accommodation: $accommodation',
                                      ),
                                    ],
                                    if (selectedCenterType.isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'نوع المركز: ${_centerTypeLabel(selectedCenterType)}'
                                            : 'Center type: ${_centerTypeLabel(selectedCenterType)}',
                                      ),
                                    ],
                                    if (centerHasDetoxUnit &&
                                        selectedCenterType != 'detox') ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'يوجد قسم داخلي لأعراض الانسحاب.'
                                            : 'Internal withdrawal unit available.',
                                      ),
                                    ],
                                    if (stayStartText.isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'موعد بداية الإقامة: $stayStartText'
                                            : 'Stay start: $stayStartText',
                                      ),
                                    ],
                                    if (stayEndText.isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'نهاية الإقامة المبدئية: $stayEndText'
                                            : 'Preliminary residency end: $stayEndText',
                                      ),
                                    ],
                                    if (stayDurationDays.isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'مدة الإقامة المبدئية: $stayDurationDays يوم'
                                            : 'Preliminary stay duration: $stayDurationDays day(s)',
                                      ),
                                    ],
                                    if (stayDurationReason.isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'سبب تحديد المدة مبدئيًا: $stayDurationReason'
                                            : 'Reason for preliminary duration: $stayDurationReason',
                                      ),
                                    ],
                                    if (intakeReason.isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'سبب طلب الإقامة: $intakeReason'
                                            : 'Reason for residency request: $intakeReason',
                                      ),
                                    ],
                                    if (intakeSymptomsText.isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'الأعراض العامة الحالية: $intakeSymptomsText'
                                            : 'Current general symptoms: $intakeSymptomsText',
                                      ),
                                    ],
                                    if (intakeLastSubstanceUseAt
                                        .isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'آخر تعاطٍ أو آخر جرعة: $intakeLastSubstanceUseAt'
                                            : 'Last substance use: $intakeLastSubstanceUseAt',
                                      ),
                                    ],
                                    if (intakeWithdrawalSymptomsText
                                        .isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'أعراض الانسحاب الحالية: $intakeWithdrawalSymptomsText'
                                            : 'Current withdrawal symptoms: $intakeWithdrawalSymptomsText',
                                      ),
                                    ],
                                    if (intakePriorDetoxHistory.isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'تاريخ سابق مع الديتوكس: $intakePriorDetoxHistory'
                                            : 'Prior detox history: $intakePriorDetoxHistory',
                                      ),
                                    ],
                                    if (intakeCurrentMedications
                                        .isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'الأدوية الحالية: $intakeCurrentMedications'
                                            : 'Current medications: $intakeCurrentMedications',
                                      ),
                                    ],
                                    if (intakeRiskNotes.isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'ملاحظات الخطورة والسلوك: $intakeRiskNotes'
                                            : 'Risk and behavior notes: $intakeRiskNotes',
                                      ),
                                    ],
                                    if (intakeFamilyNotes.isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'ملاحظات الأسرة: $intakeFamilyNotes'
                                            : 'Family notes: $intakeFamilyNotes',
                                      ),
                                    ],
                                    if (intakeSpecialNeedsConditionType
                                        .isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'نوع الاحتياج الخاص: $intakeSpecialNeedsConditionType'
                                            : 'Special needs condition: $intakeSpecialNeedsConditionType',
                                      ),
                                    ],
                                    if (intakeNeedsCompanion) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'الحالة تحتاج مرافق أو إشراف لصيق.'
                                            : 'The case needs a companion or close supervision.',
                                      ),
                                    ],
                                    if (intakeMobilitySupport.isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'احتياجات الحركة أو الدعم اليومي: $intakeMobilitySupport'
                                            : 'Mobility or daily support needs: $intakeMobilitySupport',
                                      ),
                                    ],
                                    if (intakeNutritionSupport.isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'احتياجات التغذية أو الحساسية: $intakeNutritionSupport'
                                            : 'Nutrition or sensitivity needs: $intakeNutritionSupport',
                                      ),
                                    ],
                                    if (intakeSpecialCareNotes.isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'ملاحظات الرعاية الخاصة: $intakeSpecialCareNotes'
                                            : 'Special care notes: $intakeSpecialCareNotes',
                                      ),
                                    ],
                                    if (centerInitialRecommendation
                                        .isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'التوصية الأولية: $centerInitialRecommendation'
                                            : 'Initial recommendation: $centerInitialRecommendation',
                                      ),
                                    ],
                                    if (centerRecommendedCareLevel
                                        .isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'مستوى الرعاية المقترح: $centerRecommendedCareLevel'
                                            : 'Recommended care level: $centerRecommendedCareLevel',
                                      ),
                                    ],
                                    if (centerRecommendedStayDays
                                        .isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'المدة المقترحة من المركز: $centerRecommendedStayDays يوم'
                                            : 'Recommended stay duration: $centerRecommendedStayDays day(s)',
                                      ),
                                    ],
                                    if (centerRecommendationNotes
                                        .isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'ملاحظات التوصية: $centerRecommendationNotes'
                                            : 'Recommendation notes: $centerRecommendationNotes',
                                      ),
                                    ],
                                    if (stayDurationIsPreliminary) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'ملاحظة: هذه المدة مبدئية حتى تقييم الاستقبال داخل المركز.'
                                            : 'Note: This duration is preliminary until intake assessment at the center.',
                                      ),
                                    ],
                                    if (sessionLink.isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      SelectableText(
                                        isArabic
                                            ? 'رابط المتابعة: $sessionLink'
                                            : 'Follow-up link: $sessionLink',
                                      ),
                                    ],
                                    if (sessionCode.isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      SelectableText(
                                        isArabic
                                            ? 'الكود: $sessionCode'
                                            : 'Code: $sessionCode',
                                      ),
                                    ],
                                    if (adminNotes.isNotEmpty) ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'ملاحظات الإدارة: $adminNotes'
                                            : 'Admin notes: $adminNotes',
                                      ),
                                    ],
                                    const SizedBox(height: AppSpacing.sm),
                                    Text(
                                      isArabic
                                          ? 'تأكيد المركز للوصول: ${centerArrivalConfirmed ? 'تم' : 'بانتظار التأكيد'}'
                                          : 'Center arrival confirmation: ${centerArrivalConfirmed ? 'confirmed' : 'pending'}',
                                    ),
                                    const SizedBox(height: AppSpacing.xs),
                                    Text(
                                      isArabic
                                          ? 'تأكيد الأسرة لبداية الإقامة: ${clientCheckInConfirmed ? 'تم' : 'بانتظار التأكيد'}'
                                          : 'Client check-in confirmation: ${clientCheckInConfirmed ? 'confirmed' : 'pending'}',
                                    ),
                                    if (status ==
                                            'session_completed_pending_reviews' ||
                                        status == 'payout_pending') ...[
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'تقرير خروج المركز: ${centerReviewSubmitted ? 'تم الإرسال' : 'بانتظار الإرسال'}'
                                            : 'Center discharge report: ${centerReviewSubmitted ? 'submitted' : 'pending'}',
                                      ),
                                    ],
                                    if (status == 'session_setup_pending' ||
                                        status ==
                                            'center_recommendation_pending' ||
                                        status == 'session_scheduled' ||
                                        status == 'reschedule_pending') ...[
                                      const SizedBox(height: AppSpacing.md),
                                      if (status ==
                                          'center_recommendation_pending')
                                        FilledButton.icon(
                                          onPressed: null,
                                          icon: const Icon(
                                              Icons.lock_clock_outlined),
                                          label: Text(
                                            isArabic
                                                ? 'إرسال التوصية الأولية'
                                                : 'Submit initial recommendation',
                                          ),
                                        ),
                                      if (status ==
                                          'center_recommendation_pending') ...[
                                        const SizedBox(height: AppSpacing.xs),
                                        Text(
                                          _workflowActivationLabel(isArabic),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                      if (!centerArrivalConfirmed &&
                                          status !=
                                              'center_recommendation_pending' &&
                                          hasPreliminaryResidencyDetails)
                                        FilledButton.icon(
                                          onPressed: null,
                                          icon: const Icon(
                                              Icons.lock_clock_outlined),
                                          label: Text(
                                            isArabic
                                                ? 'تأكيد الوصول والتقييم الأولي'
                                                : 'Confirm arrival & initial assessment',
                                          ),
                                        ),
                                      if (!centerArrivalConfirmed &&
                                          status !=
                                              'center_recommendation_pending' &&
                                          hasPreliminaryResidencyDetails) ...[
                                        const SizedBox(height: AppSpacing.xs),
                                        Text(
                                          _workflowActivationLabel(isArabic),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                      if (!hasPreliminaryResidencyDetails)
                                        Text(
                                          isArabic
                                              ? (status ==
                                                      'center_recommendation_pending'
                                                  ? 'بعد إرسال التوصية الأولية سيظهر الطلب للإدارة في تجهيز الإقامة.'
                                                  : 'سيظهر تأكيد الوصول بعد إرسال بيانات الإقامة المبدئية كاملة من الإدارة.')
                                              : (status ==
                                                      'center_recommendation_pending'
                                                  ? 'After sending the initial recommendation, the admin will receive the request for residency setup.'
                                                  : 'Arrival confirmation will appear after the admin sends the full preliminary residency details.'),
                                        ),
                                    ],
                                    if (_canCenterDischargeReview(data)) ...[
                                      const SizedBox(height: AppSpacing.md),
                                      FilledButton.icon(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                            Routes.sessionReview,
                                            arguments: {
                                              'requestId': requestId,
                                              'reviewerType': 'center',
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                            Icons.assignment_outlined),
                                        label: Text(
                                          isArabic
                                              ? 'إرسال تقرير الخروج'
                                              : 'Submit discharge report',
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              );
                            }),
                        ],
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
