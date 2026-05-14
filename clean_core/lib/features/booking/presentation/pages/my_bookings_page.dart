import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';
import 'package:flutterprojects/features/booking/presentation/pages/center_booking_request_page.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  String _viewFilter = 'current';

  static const List<Map<String, String>> _tabs = [
    {'key': 'current'},
    {'key': 'action_needed'},
    {'key': 'completed'},
    {'key': 'closed'},
  ];

  String _tabLabel(AppLocalizations l10n, String key) {
    switch (key) {
      case 'action_needed':
        return l10n.bookingActionNeeded;
      case 'completed':
        return l10n.bookingCompleted;
      case 'closed':
        return l10n.bookingClosed;
      case 'current':
      default:
        return l10n.bookingCurrent;
    }
  }

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

  Widget _statusTabs(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Wrap(
        spacing: 10,
        runSpacing: 8,
        children: [
          for (final it in _tabs)
            ChoiceChip(
              label: Text(_tabLabel(l10n, it['key']!)),
              selected: _viewFilter == it['key'],
              backgroundColor: Colors.black.withValues(alpha: 0.30),
              selectedColor: const Color(0xFFE7C766).withValues(alpha: 0.22),
              side: BorderSide(
                color: const Color(0xFFE7C766).withValues(alpha: 0.34),
              ),
              labelStyle: TextStyle(
                color: _viewFilter == it['key']
                    ? const Color(0xFFFFE8A6)
                    : const Color(0xFFFFF4D4),
                fontWeight: FontWeight.w800,
              ),
              checkmarkColor: const Color(0xFFE7C766),
              onSelected: (value) => setState(() => _viewFilter = it['key']!),
            ),
        ],
      ),
    );
  }

  Query<Map<String, dynamic>> _query(String uid) {
    return FirebaseFirestore.instance
        .collection('booking_requests')
        .where('clientId', isEqualTo: uid);
  }

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> _requestsStream(
    String uid,
  ) {
    return _query(uid).snapshots().map(
          (snapshot) => snapshot.docs.toList()..sort(_compareCreatedAt),
        );
  }

  String _fmtTime(dynamic v) {
    try {
      DateTime? dt;
      if (v == null) return '';
      if (v is Timestamp) dt = v.toDate();
      if (v is DateTime) dt = v;
      if (v is String) dt = DateTime.tryParse(v);
      if (dt == null) return v.toString();

      final y = dt.year.toString().padLeft(4, '0');
      final m = dt.month.toString().padLeft(2, '0');
      final d = dt.day.toString().padLeft(2, '0');
      final hh = dt.hour.toString().padLeft(2, '0');
      final mm = dt.minute.toString().padLeft(2, '0');
      return '$y-$m-$d $hh:$mm';
    } catch (_) {
      return v.toString();
    }
  }

  DateTime? _asDateTime(dynamic v) {
    if (v == null) return null;
    if (v is Timestamp) return v.toDate();
    if (v is DateTime) return v;
    if (v is String) return DateTime.tryParse(v);
    return null;
  }

  Map<String, dynamic> _asStringMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return Map<String, dynamic>.from(value);
    }
    if (value is Map) {
      return value.map((key, item) => MapEntry(key.toString(), item));
    }
    return <String, dynamic>{};
  }

  Future<void> _createCenterRequestFromExisting(
    BuildContext context,
    String oldRequestId,
    Map<String, dynamic> source,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid ?? '';
    if (uid.isEmpty) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.bookingCreateNewFromRequest),
        content: const Text(
          'سيتم إنشاء طلب جديد بنفس بيانات المركز والإقامة، ولن يتم تعديل الطلب الحالي.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.authCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.bookingCreateNewRequest),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final firestore = FirebaseFirestore.instance;
    final createdAt = Timestamp.now();
    final requestGroupId = firestore.collection('booking_requests').doc().id;
    final selectedAccommodationPricingSnapshot =
        _asStringMap(source['selectedAccommodationPricingSnapshot']);
    final selectedAccommodationKey =
        (source['selectedAccommodationKey'] ?? '').toString();
    final selectedAccommodationLabelAr =
        (source['selectedAccommodationLabelAr'] ?? '').toString();
    final selectedAccommodationPricingUnit =
        (source['selectedAccommodationPricingUnit'] ?? '').toString();
    final selectedAccommodationPrice =
        (source['selectedAccommodationPrice'] is num)
            ? (source['selectedAccommodationPrice'] as num).toDouble()
            : 0.0;
    final centerId = (source['centerId'] ?? '').toString();
    final centerName = (source['centerName'] ?? '').toString();
    if (centerId.trim().isEmpty || centerName.trim().isEmpty) return;
    final contractDraft = <String, dynamic>{
      'status': 'draft',
      'version': 1,
      'room': {
        'key': selectedAccommodationKey,
        'label': selectedAccommodationLabelAr,
        'price': selectedAccommodationPrice,
        'pricingUnit': selectedAccommodationPricingUnit,
        'snapshot': selectedAccommodationPricingSnapshot,
      },
      'duration': {
        'basis': 'external_diagnosis',
      },
      'pricing': {
        'baseAmount': selectedAccommodationPrice,
      },
      'meta': {
        'source': 'center_request_copy_v1',
        'createdAt': createdAt,
      },
    };

    final requestRef = firestore.collection('booking_requests').doc();
    await requestRef.set(<String, dynamic>{
      'requestKind': 'center',
      'requestGroupId': requestGroupId,
      'clientId': uid,
      'clientName': (user?.displayName ?? user?.email ?? 'Client').trim(),
      'centerId': centerId,
      'centerName': centerName,
      'selectedCenterType': (source['selectedCenterType'] ?? '').toString(),
      'centerHasDetoxUnit': (source['centerHasDetoxUnit'] ?? false) == true,
      'status': 'pending_admin',
      'createdAt': createdAt,
      'updatedAt': createdAt,
      'note': (source['note'] ?? '').toString(),
      'assignedClinicianId': '',
      'assignedClinicianName': '',
      'clinicianId': '',
      'clinicianName': '',
      'clinicianUid': '',
      'centerAvailabilityStatus': 'pending',
      'centerAvailabilityNote': '',
      'centerAvailabilityRespondedAt': null,
      'centerAvailabilityRespondedBy': '',
      'centerSuggestedAlternativeKey': '',
      'centerSuggestedAlternativeLabelAr': '',
      'selectedAccommodationKey': selectedAccommodationKey,
      'selectedAccommodationLabelAr': selectedAccommodationLabelAr,
      'selectedAccommodationPricingSnapshot':
          selectedAccommodationPricingSnapshot,
      'selectedAccommodationPrice': selectedAccommodationPrice,
      'selectedAccommodationPricingUnit': selectedAccommodationPricingUnit,
      'contract': contractDraft,
      'lastCenterAvailabilityStatus': '',
      'lastCenterAvailabilityNote': '',
      'lastCenterSuggestedAlternativeKey': '',
      'lastCenterSuggestedAlternativeLabelAr': '',
      'clientRevisionNumber': 0,
      'lastCenterFeedbackRevisionNumber': 0,
      'clientUpdatedAfterCenterFeedback': false,
      'adminCanApproveWithoutCenterRecheck': false,
      'replacesRequestId': oldRequestId,
    });

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.bookingNewCenterRequestCreated)),
    );
  }

  Future<Map<String, dynamic>?> _showIntakeDialog(
    BuildContext context,
    Map<String, dynamic> requestData,
  ) async {
    final reasonController = TextEditingController();
    final substanceTypeController = TextEditingController();
    final lastUseController = TextEditingController();
    final withdrawalSymptomsController = TextEditingController();
    final priorDetoxHistoryController = TextEditingController();
    final priorDiagnosisController = TextEditingController();
    final medicationsController = TextEditingController();
    final symptomsController = TextEditingController();
    final riskNotesController = TextEditingController();
    final familyNotesController = TextEditingController();
    final specialNeedsConditionController = TextEditingController();
    final mobilitySupportController = TextEditingController();
    final nutritionSupportController = TextEditingController();
    final specialCareNotesController = TextEditingController();

    var hasSubstanceUse = false;
    var hasPriorDiagnosis = false;
    var hasPriorTreatment = false;
    var needsCompanion = false;
    final selectedCenterType =
        (requestData['selectedCenterType'] ?? '').toString().trim();
    final centerHasDetoxUnit =
        (requestData['centerHasDetoxUnit'] ?? false) == true;
    final showDetoxSection =
        selectedCenterType == 'detox' || centerHasDetoxUnit;
    final showSpecialNeedsSection = selectedCenterType == 'special_needs_care';

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('بيانات التقييم الأولي'),
              content: SizedBox(
                width: 560,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: reasonController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: 'سبب طلب الإقامة',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        value: hasSubstanceUse,
                        onChanged: (value) =>
                            setState(() => hasSubstanceUse = value ?? false),
                        title: const Text('يوجد تعاطٍ حالي أو سابق'),
                      ),
                      if (hasSubstanceUse) ...[
                        TextField(
                          controller: substanceTypeController,
                          decoration: const InputDecoration(
                            labelText: 'نوع المادة/المخدر',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (showDetoxSection) ...[
                          TextField(
                            controller: lastUseController,
                            decoration: const InputDecoration(
                              labelText: 'آخر تعاطٍ أو توقيت آخر جرعة',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: withdrawalSymptomsController,
                            maxLines: 2,
                            decoration: const InputDecoration(
                              labelText:
                                  'أعراض الانسحاب الحالية إن وجدت (رجفة، قيء، هياج، تعرق...)',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: priorDetoxHistoryController,
                            maxLines: 2,
                            decoration: const InputDecoration(
                              labelText:
                                  'تاريخ سابق مع الديتوكس أو أعراض الانسحاب',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ],
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        value: hasPriorDiagnosis,
                        onChanged: (value) =>
                            setState(() => hasPriorDiagnosis = value ?? false),
                        title: const Text('يوجد تشخيص سابق'),
                      ),
                      if (hasPriorDiagnosis) ...[
                        TextField(
                          controller: priorDiagnosisController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: 'التشخيص السابق',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        value: hasPriorTreatment,
                        onChanged: (value) =>
                            setState(() => hasPriorTreatment = value ?? false),
                        title: const Text('سبق العلاج أو دخول مركز'),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: medicationsController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: 'الأدوية الحالية إن وجدت',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: symptomsController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText:
                              'الأعراض العامة الحالية (نوم، قلق، هياج، انسحاب، هلاوس...)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: riskNotesController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText:
                              'ملاحظات الخطورة أو السلوك (عدوانية، أفكار انتحارية، نوبات...)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: familyNotesController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'ملاحظات الأسرة',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      if (showSpecialNeedsSection) ...[
                        const SizedBox(height: 12),
                        TextField(
                          controller: specialNeedsConditionController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: 'نوع الاحتياج أو الحالة الخاصة',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          value: needsCompanion,
                          onChanged: (value) =>
                              setState(() => needsCompanion = value ?? false),
                          title: const Text('الحالة تحتاج مرافق أو إشراف لصيق'),
                        ),
                        TextField(
                          controller: mobilitySupportController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: 'احتياجات الحركة أو الدعم اليومي',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: nutritionSupportController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText:
                                'احتياجات التغذية أو الحساسية أو الروتين الطبي',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: specialCareNotesController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'ملاحظات الرعاية الخاصة',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('إلغاء'),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop({
                      'intakeReason': reasonController.text.trim(),
                      'intakeHasSubstanceUse': hasSubstanceUse,
                      'intakeSubstanceType':
                          substanceTypeController.text.trim(),
                      'intakeLastSubstanceUseAt': lastUseController.text.trim(),
                      'intakeWithdrawalSymptomsText':
                          withdrawalSymptomsController.text.trim(),
                      'intakePriorDetoxHistory':
                          priorDetoxHistoryController.text.trim(),
                      'intakeHasPriorDiagnosis': hasPriorDiagnosis,
                      'intakePriorDiagnosisText':
                          priorDiagnosisController.text.trim(),
                      'intakeHasPriorTreatment': hasPriorTreatment,
                      'intakeCurrentMedications':
                          medicationsController.text.trim(),
                      'intakeSymptomsText': symptomsController.text.trim(),
                      'intakeRiskNotes': riskNotesController.text.trim(),
                      'intakeFamilyNotes': familyNotesController.text.trim(),
                      'intakeSpecialNeedsConditionType':
                          specialNeedsConditionController.text.trim(),
                      'intakeNeedsCompanion': needsCompanion,
                      'intakeMobilitySupport':
                          mobilitySupportController.text.trim(),
                      'intakeNutritionSupport':
                          nutritionSupportController.text.trim(),
                      'intakeSpecialCareNotes':
                          specialCareNotesController.text.trim(),
                    });
                  },
                  child: const Text('إرسال البيانات'),
                ),
              ],
            );
          },
        );
      },
    );

    reasonController.dispose();
    substanceTypeController.dispose();
    lastUseController.dispose();
    withdrawalSymptomsController.dispose();
    priorDetoxHistoryController.dispose();
    priorDiagnosisController.dispose();
    medicationsController.dispose();
    symptomsController.dispose();
    riskNotesController.dispose();
    familyNotesController.dispose();
    specialNeedsConditionController.dispose();
    mobilitySupportController.dispose();
    nutritionSupportController.dispose();
    specialCareNotesController.dispose();
    return result;
  }

  Future<void> _submitInitialIntake(
    BuildContext context,
    String requestId,
    Map<String, dynamic> requestData,
  ) async {
    final result = await _showIntakeDialog(context, requestData);
    if (result == null) return;
    if ((result['intakeReason'] ?? '').toString().trim().isEmpty) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('أدخل سبب طلب الإقامة أولًا')),
      );
      return;
    }

    await FirebaseFirestore.instance
        .collection('booking_requests')
        .doc(requestId)
        .update({
      ...result,
      'intakeFormSubmitted': true,
      'intakeSubmittedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إرسال بيانات التقييم الأولي للمركز')),
    );
  }

  String _statusLabel(
    String requestKind,
    String status,
    AppLocalizations l10n,
  ) {
    final isCenter = requestKind == 'center';

    if (isCenter) {
      switch (status) {
        case 'pending_admin':
          return l10n.statusRequestUnderReview;
        case 'center_follow_up':
          return l10n.statusCenterFollowUp;
        case 'client_update_required':
          return l10n.statusClientUpdateRequired;
        case 'center_intake_pending':
          return l10n.statusCenterIntakePending;
        case 'center_recommendation_pending':
          return l10n.statusCenterRecommendationPending;
        case 'approved':
          return l10n.statusRequestApproved;
        case 'awaiting_payment':
          return l10n.statusAwaitingPayment;
        case 'payment_review':
          return l10n.statusPaymentReview;
        case 'session_setup_pending':
          return l10n.statusResidencySetupPending;
        case 'session_scheduled':
          return l10n.statusResidencyScheduled;
        case 'session_in_progress':
          return l10n.statusResidencyInProgress;
        case 'session_completed_pending_reviews':
          return l10n.statusPendingReviews;
        case 'payout_pending':
          return l10n.statusPayoutPending;
        case 'rejected':
        case 'rejected_admin':
          return l10n.statusRejected;
        case 'completed_success':
          return l10n.statusCompletedSuccessfully;
        default:
          return l10n.statusRequestUpdateInProgress;
      }
    }

    switch (status) {
      case 'pending_admin':
        return l10n.statusRequestUnderReview;
      case 'assigned_clinician':
        return l10n.statusRequestCoordination;
      case 'awaiting_payment':
        return l10n.statusUploadPaymentProof;
      case 'payment_review':
        return l10n.statusPaymentReview;
      case 'session_setup_pending':
        return l10n.statusSessionSetupPending;
      case 'session_scheduled':
        return l10n.statusSessionScheduled;
      case 'session_in_progress':
        return l10n.statusSessionInProgress;
      case 'session_completed_pending_reviews':
        return l10n.statusPendingReviews;
      case 'payout_pending':
        return l10n.statusPayoutPending;
      case 'completed_success':
        return l10n.statusRequestCompleted;
      case 'rejected_admin':
        return l10n.statusRejected;
      case 'clinician_rejected':
        return l10n.statusClinicianRejected;
      case 'reschedule_pending':
        return l10n.statusReschedulePending;
      case 'cancellation_pending':
        return l10n.statusCancellationPending;
      case 'dispute_pending':
        return l10n.statusDisputeReceived;
      default:
        return l10n.statusRequestUpdateInProgress;
    }
  }

  bool _matchesClientView(String status) {
    switch (_viewFilter) {
      case 'action_needed':
        return status == 'awaiting_payment' ||
            status == 'client_update_required' ||
            status == 'center_intake_pending';
      case 'completed':
        return status == 'completed_success';
      case 'closed':
        return status == 'rejected' ||
            status == 'rejected_admin' ||
            status == 'clinician_rejected' ||
            status == 'cancellation_pending' ||
            status == 'dispute_pending';
      case 'current':
      default:
        return status != 'rejected' &&
            status != 'completed_success' &&
            status != 'rejected_admin' &&
            status != 'clinician_rejected' &&
            status != 'cancellation_pending' &&
            status != 'dispute_pending';
    }
  }

  int _compareCreatedAt(
    QueryDocumentSnapshot<Map<String, dynamic>> a,
    QueryDocumentSnapshot<Map<String, dynamic>> b,
  ) {
    final da = _asDateTime(a.data()['createdAt']);
    final db = _asDateTime(b.data()['createdAt']);
    if (da == null && db == null) return 0;
    if (da == null) return 1;
    if (db == null) return -1;
    return db.compareTo(da);
  }

  String _badgeLabel(
    String requestKind,
    String status,
    AppLocalizations l10n,
  ) {
    return _statusLabel(requestKind, status, l10n);
  }

  String _centerAvailabilityOutcomeLabel(
    String value,
    AppLocalizations l10n,
  ) {
    switch (value.trim()) {
      case 'available':
        return l10n.statusCenterAvailableResponse;
      case 'unavailable':
        return l10n.statusCenterUnavailableResponse;
      case 'pending':
      case '':
        return l10n.statusCenterNoResponse;
      default:
        return l10n.statusCenterNoResponse;
    }
  }

  String _centerCareLevelLabel(String value) {
    switch (value.trim()) {
      case 'residential_psych':
        return 'إقامة نفسية داخلية';
      case 'detox':
        return 'سحب سموم ومتابعة';
      case 'dual_diagnosis':
        return 'رعاية مزدوجة';
      case 'diagnostic_observation':
        return 'ملاحظة تشخيصية داخلية';
      default:
        return value.trim();
    }
  }

  String _requestTypeLabel(bool isCenter) {
    return isCenter ? 'طلب مركز' : 'طلب أخصائي';
  }

  List<String> _clientDetails(
    Map<String, dynamic> data,
    AppLocalizations l10n,
  ) {
    final requestKind = (data['requestKind'] ?? 'clinician').toString();
    final isCenter = requestKind == 'center';
    final status = (data['status'] ?? '').toString();
    final note = (data['note'] ?? '').toString();
    final createdAt = _fmtTime(data['createdAt']);
    final approvedSlot = (data['approvedSlot'] ?? '').toString();
    final rejectReason = (data['rejectReason'] ?? '').toString();
    final selectedAccommodationLabelAr =
        (data['selectedAccommodationLabelAr'] ?? '').toString();
    final contract = data['contract'];
    final contractRoom = contract is Map ? contract['room'] : null;
    final contractDuration = contract is Map ? contract['duration'] : null;
    final contractPricing = contract is Map ? contract['pricing'] : null;
    final contractMeta = contract is Map ? contract['meta'] : null;
    final contractStatus =
        contract is Map ? (contract['status'] ?? '').toString() : '';
    final contractVersion =
        contract is Map ? (contract['version'] ?? '').toString() : '';
    final contractRoomLabel =
        contractRoom is Map ? (contractRoom['label'] ?? '').toString() : '';
    final contractRoomPrice =
        contractRoom is Map ? (contractRoom['price'] ?? '').toString() : '';
    final contractPricingUnit = contractRoom is Map
        ? (contractRoom['pricingUnit'] ?? '').toString()
        : '';
    final contractDurationBasis = contractDuration is Map
        ? (contractDuration['basis'] ?? '').toString()
        : '';
    final contractBaseAmount = contractPricing is Map
        ? (contractPricing['baseAmount'] ?? '').toString()
        : '';
    final contractSource =
        contractMeta is Map ? (contractMeta['source'] ?? '').toString() : '';
    final selectedCenterType =
        (data['selectedCenterType'] ?? '').toString().trim();
    final centerHasDetoxUnit = (data['centerHasDetoxUnit'] ?? false) == true;
    final centerAvailabilityStatus =
        (data['centerAvailabilityStatus'] ?? 'pending').toString();
    final intakeReason = (data['intakeReason'] ?? '').toString();
    final intakeWithdrawalSymptomsText =
        (data['intakeWithdrawalSymptomsText'] ?? '').toString();
    final intakeSpecialNeedsConditionType =
        (data['intakeSpecialNeedsConditionType'] ?? '').toString();
    final lastCenterAvailabilityNote =
        (data['lastCenterAvailabilityNote'] ?? '').toString();
    final lastCenterSuggestedAlternativeLabelAr =
        (data['lastCenterSuggestedAlternativeLabelAr'] ?? '').toString();
    final paymentReceiptFileName =
        (data['paymentReceiptFileName'] ?? '').toString();
    final paymentClientNote = (data['paymentClientNote'] ?? '').toString();
    final stayStartDateText = (data['stayStartDateText'] ?? '').toString();
    final stayEndDateText = (data['stayEndDateText'] ?? '').toString();
    final stayDurationDays = (data['stayDurationDays'] ?? '').toString();
    final paymentBreakdownText =
        (data['paymentBreakdownText'] ?? '').toString();
    final stayTotalAmount = (data['stayTotalAmount'] ?? '').toString();
    final centerRecommendedCareLevel =
        (data['centerRecommendedCareLevel'] ?? '').toString();
    final centerRecommendedStayDays =
        (data['centerRecommendedStayDays'] ?? '').toString();
    final centerNeedsInternalAssessment =
        (data['centerNeedsInternalAssessment'] ?? false) == true;
    final centerRecommendationSubmittedAt =
        _fmtTime(data['centerRecommendationSubmittedAt']);
    final sessionDateText = (data['sessionDateText'] ?? '').toString();
    final sessionLink = (data['sessionLink'] ?? '').toString();
    final sessionCode = (data['sessionCode'] ?? '').toString();
    final finalReviewPercentage =
        ((data['finalReviewPercentage'] ?? 0) as num).toDouble();

    return <String>[
      _requestTypeLabel(isCenter),
      if (createdAt.isNotEmpty) 'تاريخ الطلب: $createdAt',
      if (approvedSlot.isNotEmpty) 'الموعد المعتمد: $approvedSlot',
      if (selectedAccommodationLabelAr.isNotEmpty)
        'نوع الإقامة: $selectedAccommodationLabelAr',
      if (isCenter)
        _centerAvailabilityOutcomeLabel(centerAvailabilityStatus, l10n),
      if (isCenter && contractStatus.isNotEmpty) 'مسودة العقد: $contractStatus',
      if (isCenter && contractRoomLabel.isNotEmpty)
        'غرفة العقد: $contractRoomLabel',
      if (isCenter && contractRoomPrice.isNotEmpty)
        'سعر غرفة العقد: $contractRoomPrice',
      if (isCenter && contractPricingUnit.isNotEmpty)
        'وحدة التسعير: $contractPricingUnit',
      if (isCenter && contractDurationBasis.isNotEmpty)
        'أساس المدة: $contractDurationBasis',
      if (isCenter && contractBaseAmount.isNotEmpty)
        'المبلغ الأساسي للعقد: $contractBaseAmount',
      if (isCenter && contractVersion.isNotEmpty)
        'إصدار العقد: $contractVersion',
      if (isCenter && contractSource.isNotEmpty) 'مصدر العقد: $contractSource',
      if (selectedCenterType.isNotEmpty)
        'نوع المركز: ${_centerTypeLabel(selectedCenterType)}',
      if (centerHasDetoxUnit && selectedCenterType != 'detox')
        'يوجد قسم أعراض انسحاب داخلي',
      if (intakeReason.isNotEmpty) 'سبب الإقامة: $intakeReason',
      if (intakeWithdrawalSymptomsText.isNotEmpty)
        'أعراض الانسحاب الحالية: $intakeWithdrawalSymptomsText',
      if (intakeSpecialNeedsConditionType.isNotEmpty)
        'نوع الاحتياج الخاص: $intakeSpecialNeedsConditionType',
      if (stayStartDateText.isNotEmpty) 'بداية الإقامة: $stayStartDateText',
      if (stayEndDateText.isNotEmpty)
        'نهاية الإقامة المبدئية: $stayEndDateText',
      if (stayDurationDays.isNotEmpty)
        'مدة الإقامة المبدئية: $stayDurationDays يوم',
      if (paymentBreakdownText.isNotEmpty) 'بيان الدفع: $paymentBreakdownText',
      if (stayTotalAmount.isNotEmpty) 'الإجمالي المستحق: $stayTotalAmount',
      if (isCenter && centerRecommendedCareLevel.isNotEmpty)
        'توصية المركز: ${_centerCareLevelLabel(centerRecommendedCareLevel)}',
      if (isCenter && centerRecommendedStayDays.isNotEmpty)
        'مدة مقترحة من المركز: $centerRecommendedStayDays يوم',
      if (isCenter && centerRecommendationSubmittedAt.isNotEmpty)
        'تم استلام توصية المركز: $centerRecommendationSubmittedAt',
      if (isCenter && centerNeedsInternalAssessment)
        'قد يحتاج المركز تقييمًا داخليًا عند الوصول',
      if (lastCenterAvailabilityNote.isNotEmpty)
        'ملاحظة المركز الأخيرة: $lastCenterAvailabilityNote',
      if (lastCenterSuggestedAlternativeLabelAr.isNotEmpty)
        'البديل المقترح: $lastCenterSuggestedAlternativeLabelAr',
      if (sessionDateText.isNotEmpty) 'موعد الجلسة: $sessionDateText',
      if (sessionCode.isNotEmpty) 'كود الجلسة: $sessionCode',
      if (paymentReceiptFileName.isNotEmpty)
        'مرجع إثبات الدفع: $paymentReceiptFileName',
      if (paymentClientNote.isNotEmpty) 'ملاحظة الدفع: $paymentClientNote',
      if (rejectReason.isNotEmpty) 'سبب التعذر: $rejectReason',
      if (sessionLink.isNotEmpty && status == 'session_scheduled')
        'رابط الجلسة متاح',
      if (note.isNotEmpty) 'ملاحظتك: $note',
      if (finalReviewPercentage > 0)
        'التقييم النهائي: ${finalReviewPercentage.toStringAsFixed(1)}%',
    ];
  }

  Color _badgeTint(String requestKind, String status) {
    final isCenter = requestKind == 'center';
    if (isCenter) {
      switch (status) {
        case 'approved':
          return Colors.green.withValues(alpha: 0.10);
        case 'rejected':
        case 'rejected_admin':
          return Colors.red.withValues(alpha: 0.10);
        case 'center_follow_up':
          return Colors.orange.withValues(alpha: 0.10);
        default:
          return Colors.blueGrey.withValues(alpha: 0.10);
      }
    }

    switch (status) {
      case 'completed_success':
        return Colors.green.withValues(alpha: 0.10);
      case 'rejected_admin':
      case 'clinician_rejected':
      case 'cancellation_pending':
      case 'dispute_pending':
        return Colors.red.withValues(alpha: 0.10);
      case 'awaiting_payment':
      case 'payment_review':
      case 'reschedule_pending':
      case 'payout_pending':
        return Colors.orange.withValues(alpha: 0.10);
      case 'session_setup_pending':
      case 'session_scheduled':
      case 'session_in_progress':
        return Colors.blue.withValues(alpha: 0.10);
      default:
        return Colors.blueGrey.withValues(alpha: 0.10);
    }
  }

  Widget _emptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String text;
    switch (_viewFilter) {
      case 'action_needed':
        text = l10n.bookingEmptyActionNeeded;
        break;
      case 'completed':
        text = l10n.bookingEmptyCompleted;
        break;
      case 'closed':
        text = l10n.bookingEmptyClosed;
        break;
      case 'current':
      default:
        text = l10n.bookingEmptyCurrent;
        break;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFFFF4D4),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final u = FirebaseAuth.instance.currentUser;
    final l10n = AppLocalizations.of(context)!;
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppShellActions.buildAppBar(
          context,
          title: l10n.bookingMyRequestsTitle,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return DefaultTextStyle.merge(
              style: const TextStyle(color: Color(0xFFFFF4D4)),
              child: Stack(
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
                  Column(
                    children: [
                      _statusTabs(context),
                      Expanded(
                        child: (u == null)
                            ? const Center(
                                child: Text(
                                  'سجّل الدخول أولًا',
                                  style: TextStyle(color: Color(0xFFFFF4D4)),
                                ),
                              )
                            : StreamBuilder<
                                List<
                                    QueryDocumentSnapshot<
                                        Map<String, dynamic>>>>(
                                stream: _requestsStream(u.uid),
                                builder: (context, snap) {
                                  if (snap.hasError) {
                                    return Center(
                                      child: Text(
                                        'خطأ: ${snap.error}',
                                        style: const TextStyle(
                                          color: Color(0xFFFFF4D4),
                                        ),
                                      ),
                                    );
                                  }
                                  if (!snap.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Color(0xFFE7C766),
                                      ),
                                    );
                                  }

                                  final docs = snap.data ?? const [];
                                  if (docs.isEmpty) {
                                    return _emptyState(context);
                                  }

                                  final deduped = <String,
                                      QueryDocumentSnapshot<
                                          Map<String, dynamic>>>{};

                                  for (final doc in docs) {
                                    final d = doc.data();
                                    final kind =
                                        (d['requestKind'] ?? 'clinician')
                                            .toString();
                                    final requestGroupId =
                                        (d['requestGroupId'] ?? '').toString();
                                    final centerId =
                                        (d['centerId'] ?? '').toString();
                                    final clinicianId =
                                        (d['assignedClinicianId'] ??
                                                d['clinicianId'] ??
                                                '')
                                            .toString();
                                    final createdAt = _fmtTime(d['createdAt']);

                                    final key = kind == 'center'
                                        ? (requestGroupId.isNotEmpty
                                            ? 'center-group|$requestGroupId'
                                            : 'center|$centerId|$createdAt')
                                        : 'clinician|$clinicianId|$createdAt';

                                    deduped.putIfAbsent(key, () => doc);
                                  }

                                  final visibleDocs = deduped.values.toList()
                                    ..retainWhere((doc) {
                                      final data = doc.data();
                                      final status =
                                          (data['status'] ?? '').toString();
                                      return _matchesClientView(status);
                                    })
                                    ..sort(_compareCreatedAt);

                                  if (visibleDocs.isEmpty) {
                                    return _emptyState(context);
                                  }

                                  return ListView.separated(
                                    padding: const EdgeInsets.all(12),
                                    itemCount: visibleDocs.length,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 10),
                                    itemBuilder: (context, i) {
                                      final d = visibleDocs[i].data();

                                      final requestKind =
                                          (d['requestKind'] ?? 'clinician')
                                              .toString();
                                      final isCenter = requestKind == 'center';
                                      final clinicianName =
                                          (d['assignedClinicianName'] ??
                                                  d['clinicianName'] ??
                                                  '')
                                              .toString();
                                      final centerId =
                                          (d['centerId'] ?? '').toString();
                                      final centerName =
                                          (d['centerName'] ?? '').toString();
                                      final status =
                                          (d['status'] ?? '').toString();
                                      final centerAvailabilityStatus =
                                          (d['centerAvailabilityStatus'] ?? '')
                                              .toString()
                                              .trim();
                                      final centerAvailable = isCenter &&
                                          centerAvailabilityStatus ==
                                              'available';
                                      final centerUnavailable = isCenter &&
                                          centerAvailabilityStatus ==
                                              'unavailable';

                                      final title = isCenter
                                          ? (centerName.isEmpty
                                              ? 'طلب مركز'
                                              : centerName)
                                          : (clinicianName.isEmpty
                                              ? 'الأخصائي'
                                              : clinicianName);

                                      final subtitleParts =
                                          _clientDetails(d, l10n);

                                      return Container(
                                        decoration:
                                            _glassDecoration(alpha: 0.34),
                                        child: Padding(
                                          padding: const EdgeInsets.all(14),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          title,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium
                                                                  ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    color: const Color(
                                                                        0xFFE7C766),
                                                                  ),
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        Text(
                                                          subtitleParts
                                                              .join(' • '),
                                                          style:
                                                              const TextStyle(
                                                            height: 1.5,
                                                            color: Color(
                                                                0xFFFFF4D4),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                      vertical: 6,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: _badgeTint(
                                                        requestKind,
                                                        status,
                                                      ),
                                                      border: Border.all(
                                                        color: const Color(
                                                                0xFFE7C766)
                                                            .withValues(
                                                                alpha: 0.24),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              999),
                                                    ),
                                                    child: Text(
                                                      _badgeLabel(
                                                        requestKind,
                                                        status,
                                                        l10n,
                                                      ),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xFFFFF4D4),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (isCenter &&
                                                  status ==
                                                      'client_update_required') ...[
                                                const SizedBox(height: 12),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .centerStart,
                                                  child: FilledButton.icon(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                        Routes
                                                            .centerBookingRequest,
                                                        arguments:
                                                            CenterBookingRequestArgs(
                                                          centerId:
                                                              (d['centerId'] ??
                                                                      '')
                                                                  .toString(),
                                                          centerName:
                                                              centerName,
                                                          centerType:
                                                              (d['selectedCenterType'] ??
                                                                      '')
                                                                  .toString(),
                                                          hasDetoxUnit:
                                                              (d['centerHasDetoxUnit'] ??
                                                                      false) ==
                                                                  true,
                                                          existingRequestId:
                                                              visibleDocs[i].id,
                                                        ),
                                                      );
                                                    },
                                                    icon: const Icon(
                                                        Icons.edit_outlined),
                                                    label: Text(
                                                      l10n
                                                          .bookingEditAccommodation,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              if (isCenter &&
                                                  status ==
                                                      'center_intake_pending') ...[
                                                const SizedBox(height: 12),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .centerStart,
                                                  child: FilledButton.icon(
                                                    onPressed: () =>
                                                        _submitInitialIntake(
                                                      context,
                                                      visibleDocs[i].id,
                                                      d,
                                                    ),
                                                    icon: const Icon(
                                                      Icons.assignment_outlined,
                                                    ),
                                                    label: Text(
                                                      l10n
                                                          .bookingCompleteInitialIntake,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              if (status ==
                                                  'awaiting_payment') ...[
                                                const SizedBox(height: 12),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .centerStart,
                                                  child: FilledButton.icon(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                        Routes
                                                            .clientPaymentProof,
                                                      );
                                                    },
                                                    icon: const Icon(Icons
                                                        .upload_file_outlined),
                                                    label: Text(
                                                      l10n
                                                          .bookingUploadPaymentProof,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              if (centerAvailable) ...[
                                                const SizedBox(height: 12),
                                                Container(
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    color: Colors.green
                                                        .withValues(
                                                            alpha: 0.10),
                                                    border: Border.all(
                                                      color: Colors.green
                                                          .withValues(
                                                              alpha: 0.30),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                  ),
                                                  child: const Text(
                                                    'المركز متاح لهذا الطلب. يتم تجهيز الطلب للخطوة التالية دون الحاجة إلى إجراء منك الآن.',
                                                    style:
                                                        TextStyle(height: 1.5),
                                                  ),
                                                ),
                                              ],
                                              if (centerUnavailable) ...[
                                                const SizedBox(height: 12),
                                                Container(
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    color: Colors.orange
                                                        .withValues(
                                                            alpha: 0.10),
                                                    border: Border.all(
                                                      color: Colors.orange
                                                          .withValues(
                                                              alpha: 0.30),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                  ),
                                                  child: const Text(
                                                    'المركز المختار غير متاح لهذا الطلب. يمكنك إنشاء طلب جديد بنفس البيانات لاختيار مسار مناسب دون تعديل الطلب الحالي.',
                                                    style:
                                                        TextStyle(height: 1.5),
                                                  ),
                                                ),
                                              ],
                                              if (isCenter) ...[
                                                const SizedBox(height: 12),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .centerStart,
                                                  child: centerUnavailable
                                                      ? FilledButton.icon(
                                                          onPressed: centerId
                                                                      .trim()
                                                                      .isEmpty ||
                                                                  centerName
                                                                      .trim()
                                                                      .isEmpty
                                                              ? null
                                                              : () =>
                                                                  _createCenterRequestFromExisting(
                                                                    context,
                                                                    visibleDocs[
                                                                            i]
                                                                        .id,
                                                                    d,
                                                                  ),
                                                          icon: const Icon(
                                                            Icons
                                                                .copy_all_outlined,
                                                          ),
                                                          label: Text(
                                                            l10n
                                                                .bookingCreateNewFromRequest,
                                                          ),
                                                        )
                                                      : OutlinedButton.icon(
                                                          onPressed: centerId
                                                                      .trim()
                                                                      .isEmpty ||
                                                                  centerName
                                                                      .trim()
                                                                      .isEmpty
                                                              ? null
                                                              : () =>
                                                                  _createCenterRequestFromExisting(
                                                                    context,
                                                                    visibleDocs[
                                                                            i]
                                                                        .id,
                                                                    d,
                                                                  ),
                                                          icon: const Icon(
                                                            Icons
                                                                .copy_all_outlined,
                                                          ),
                                                          label: Text(
                                                            l10n
                                                                .bookingCreateNewFromRequest,
                                                          ),
                                                        ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
