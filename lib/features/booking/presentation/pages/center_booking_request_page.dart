import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/features/centers/data/models/center_pricing.dart';

class CenterBookingRequestArgs {
  final String centerId;
  final String centerName;
  final String centerType;
  final bool hasDetoxUnit;
  final String? existingRequestId;

  const CenterBookingRequestArgs({
    required this.centerId,
    required this.centerName,
    this.centerType = '',
    this.hasDetoxUnit = false,
    this.existingRequestId,
  });
}

class CenterBookingRequestPage extends StatefulWidget {
  final CenterBookingRequestArgs args;

  const CenterBookingRequestPage({super.key, required this.args});

  @override
  State<CenterBookingRequestPage> createState() =>
      _CenterBookingRequestPageState();
}

class _CenterBookingRequestPageState extends State<CenterBookingRequestPage> {
  final TextEditingController _noteCtrl = TextEditingController();

  bool _submitting = false;
  bool _loadingDraft = false;
  String? _result;
  String _selectedAccommodationKey = '';
  String _lastCenterNote = '';
  String _lastSuggestedAlternativeKey = '';
  String _lastSuggestedAlternativeLabelAr = '';
  String _categoryKey = '';
  String _centerType = '';
  bool _centerHasDetoxUnit = false;
  List<AccommodationCostItem> _accommodationCosts =
      defaultAccommodationCostItems();
  List<AutismCareCostItem> _autismCareCosts = defaultAutismCareCostItems();

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  bool get _usesAutismPricing => usesAutismCarePricing(_categoryKey);

  Future<void> _bootstrap() async {
    setState(() => _loadingDraft = true);
    try {
      final centerDoc = await FirebaseFirestore.instance
          .collection('centers')
          .doc(widget.args.centerId)
          .get();
      final centerData = centerDoc.data() ?? const <String, dynamic>{};
      _categoryKey = (centerData['category'] ?? '').toString().trim();
      _centerType = (centerData['centerType'] ?? widget.args.centerType)
          .toString()
          .trim();
      _centerHasDetoxUnit =
          ((centerData['hasDetoxUnit'] ?? widget.args.hasDetoxUnit) == true) ||
              _centerType == 'detox';
      _accommodationCosts =
          mergeAccommodationCostItems(centerData['accommodationCosts']);
      _autismCareCosts =
          mergeAutismCareCostItems(centerData['autismCareCosts']);

      final existingId = widget.args.existingRequestId;
      if (existingId != null && existingId.trim().isNotEmpty) {
        final docs = await _existingRequestDocs(existingId);
        if (docs.isNotEmpty) {
          final primary = docs.first.data() ?? const <String, dynamic>{};
          _noteCtrl.text = (primary['note'] ?? '').toString();
          _selectedAccommodationKey =
              (primary['selectedAccommodationKey'] ?? '').toString().trim();
          _lastCenterNote =
              (primary['lastCenterAvailabilityNote'] ?? '').toString().trim();
          _lastSuggestedAlternativeKey =
              (primary['lastCenterSuggestedAlternativeKey'] ?? '')
                  .toString()
                  .trim();
          _lastSuggestedAlternativeLabelAr =
              (primary['lastCenterSuggestedAlternativeLabelAr'] ?? '')
                  .toString()
                  .trim();
        }
      }
    } finally {
      if (mounted) {
        setState(() => _loadingDraft = false);
      }
    }
  }

  List<Map<String, dynamic>> _availableAccommodationOptions() {
    if (_usesAutismPricing) {
      return _autismCareCosts
          .where((item) => item.enabled && item.price > 0)
          .map(
            (item) => {
              'key': item.key,
              'labelAr': item.labelAr,
              'price': item.price,
              'pricingUnit': item.pricingUnit,
              'snapshot': item.toMap(),
            },
          )
          .toList();
    }

    return _accommodationCosts
        .where((item) => item.enabled && item.price > 0)
        .map(
          (item) => {
            'key': item.key,
            'labelAr': item.labelAr,
            'price': item.price,
            'pricingUnit': item.pricingUnit,
            'snapshot': item.toMap(),
          },
        )
        .toList();
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> _existingRequestDocs(
    String requestId,
  ) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final currentUid = currentUser?.uid ?? '';
    final existing = <DocumentSnapshot<Map<String, dynamic>>>[];
    final ref = FirebaseFirestore.instance
        .collection('booking_requests')
        .doc(requestId);
    debugPrint(
      'CENTER_RESUBMIT_READ existingRequestId=$requestId '
      'collection=${ref.parent.id} currentUid=$currentUid',
    );
    try {
      final snap = await ref.get();
      debugPrint(
        'READ_SUCCESS collection=${ref.parent.id} docId=$requestId',
      );
      if (snap.exists) existing.add(snap);
    } catch (e) {
      debugPrint(
        'READ_ERROR collection=${ref.parent.id} error=$e',
      );
    }
    return existing;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _resolveCenterAdmins() async {
    final adminsSnap = await FirebaseFirestore.instance
        .collection('admins')
        .where('active', isEqualTo: true)
        .get();

    final allAdmins =
        adminsSnap.docs.where((doc) => doc.id.trim().length == 28).toList();
    if (allAdmins.isEmpty) {
      throw Exception('لم يتم العثور على حسابات إدارة مفعلة');
    }
    allAdmins.sort((a, b) => a.id.compareTo(b.id));
    debugPrint(
      'CENTER_CREATE admins_resolved count=${allAdmins.length} '
      'ids=${allAdmins.map((doc) => doc.id).join(',')}',
    );
    return allAdmins;
  }

  Future<void> _submit() async {
    print('CENTER_DIAG entered_submit_v2');
    if (_submitting) {
      debugPrint('CENTER_CREATE early_return reason=already_submitting');
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid ?? '';
    final isAnonymous = user?.isAnonymous == true;
    final email = user?.email ?? '';
    debugPrint(
      'CENTER_SUBMIT auth_check uid=$uid isAnonymous=$isAnonymous email=$email',
    );
    if (user == null || isAnonymous) {
      debugPrint('BLOCK_SUBMIT: user not authenticated properly');
      setState(() => _result = 'Session expired. Please log in again.');
      return;
    }

    setState(() {
      _submitting = true;
      _result = null;
    });

    final messenger = ScaffoldMessenger.of(context);
    final firebaseApp = Firebase.app();
    final firebaseOptions = firebaseApp.options;

    debugPrint('CENTER_SUBMIT submit_uid=$uid');
    debugPrint('CENTER_SUBMIT submit_email=$email');
    debugPrint('CENTER_SUBMIT submit_isAnonymous=$isAnonymous');
    debugPrint(
      'CENTER_SUBMIT existingRequestId=${widget.args.existingRequestId ?? ''}',
    );
    debugPrint(
      'CENTER_SUBMIT firebase_binding '
      'projectId=${firebaseOptions.projectId} '
      'appId=${firebaseOptions.appId} '
      'authDomain=${firebaseOptions.authDomain ?? ''}',
    );

    try {
      print('CENTER_TRACE before_admin_lookup');
      final admins = await _resolveCenterAdmins();
      print('CENTER_TRACE after_admin_lookup count=${admins.length}');

      print('CENTER_TRACE before_prepare_payload');
      final note = _noteCtrl.text.trim();
      final options = _availableAccommodationOptions();
      final selection = options.cast<Map<String, dynamic>?>().firstWhere(
            (item) =>
                (item?['key'] ?? '').toString() == _selectedAccommodationKey,
            orElse: () => null,
          );
      if (options.isNotEmpty && selection == null) {
        debugPrint(
          'CENTER_CREATE early_return reason=missing_accommodation_selection',
        );
        throw Exception('اختر نوع الإقامة أولًا');
      }
      final firestore = FirebaseFirestore.instance;
      debugPrint(
        'CENTER_SUBMIT firestore_instance app=${firebaseApp.name} '
        'projectId=${firebaseOptions.projectId}',
      );
      final createdAt = Timestamp.now();
      final requestGroupId = firestore.collection('booking_requests').doc().id;

      final sentToNames = admins
          .map((adminDoc) => (adminDoc.data()['displayName'] ??
                  adminDoc.data()['email'] ??
                  'Admin')
              .toString())
          .toList();
      final sentToIds = admins.map((adminDoc) => adminDoc.id).toList();

      final selectedLabelAr = (selection?['labelAr'] ?? '').toString();
      final selectedPricingUnit =
          (selection?['pricingUnit'] ?? '').toString().trim();
      final selectedPrice = (selection?['price'] is num)
          ? (selection!['price'] as num).toDouble()
          : 0.0;
      final contractDraft = {
        'status': 'draft',
        'version': 1,
        'room': {
          'key': _selectedAccommodationKey,
          'label': selectedLabelAr,
          'price': selectedPrice,
          'pricingUnit': selectedPricingUnit,
          'snapshot': selection?['snapshot'] ?? const <String, dynamic>{},
        },
        'duration': {
          'basis': 'external_diagnosis',
        },
        'pricing': {
          'baseAmount': selectedPrice,
        },
        'meta': {
          'source': 'center_request_v1',
          'createdAt': createdAt,
        },
      };
      final payload = <String, dynamic>{
        'requestKind': 'center',
        'requestGroupId': requestGroupId,
        'clientId': uid,
        'clientName': (user?.displayName ?? user?.email ?? 'Client').trim(),
        'centerId': widget.args.centerId,
        'centerName': widget.args.centerName,
        'selectedCenterType': _centerType,
        'centerHasDetoxUnit': _centerHasDetoxUnit,
        'status': 'pending_admin',
        'workflowStage': 'pending_admin',
        'createdAt': createdAt,
        'updatedAt': createdAt,
        'note': note,
        'adminApproved': false,
        'adminRejected': false,
        'adminForwarded': false,
        'adminDecisionType': '',
        'adminDecisionBy': '',
        'adminDecisionAt': null,
        'adminAssignedBy': '',
        'adminAssignedAt': null,
        'paymentStatus': 'not_started',
        'sessionStatus': 'not_created',
        'reviewStatus': 'not_started',
        'payoutStatus': 'blocked',
        // Canonical ownership field.
        'assignedClinicianId': '',
        'assignedClinicianName': '',
        'clinicianId': '',
        'clinicianName': '',
        // Legacy compatibility field.
        'clinicianUid': '',
        'centerAvailabilityStatus': 'pending',
        'centerAvailabilityNote': '',
        'centerAvailabilityRespondedAt': null,
        'centerAvailabilityRespondedBy': '',
        'centerSuggestedAlternativeKey': '',
        'centerSuggestedAlternativeLabelAr': '',
        'selectedAccommodationKey': _selectedAccommodationKey,
        'selectedAccommodationLabelAr': selectedLabelAr,
        'selectedAccommodationPricingSnapshot':
            selection?['snapshot'] ?? const <String, dynamic>{},
        'selectedAccommodationPrice': selectedPrice,
        'selectedAccommodationPricingUnit': selectedPricingUnit,
        // PHASE 1: Center Contract Draft (Structured, Passive)
        // - No behavior change
        // - No acceptance yet
        // - No admin flow change
        // - No free-text fields allowed
        // - Future phases will activate contract lifecycle
        'contract': contractDraft,
        'lastCenterAvailabilityStatus': '',
        'lastCenterAvailabilityNote': _lastCenterNote,
        'lastCenterSuggestedAlternativeKey': _lastSuggestedAlternativeKey,
        'lastCenterSuggestedAlternativeLabelAr':
            _lastSuggestedAlternativeLabelAr,
        'clientRevisionNumber': 0,
        'lastCenterFeedbackRevisionNumber': 0,
        'clientUpdatedAfterCenterFeedback': false,
        'adminCanApproveWithoutCenterRecheck': false,
        'targetAdminIds': sentToIds,
        'targetAdminNames': sentToNames,
      };
      print(
        'CENTER_TRACE after_prepare_payload '
        'requestGroupId=$requestGroupId '
        'selectedAccommodationKey=$_selectedAccommodationKey '
        'targetAdmins=${sentToIds.length}',
      );

      final existingId = widget.args.existingRequestId;
      var shouldCreate = existingId == null || existingId.trim().isEmpty;
      print(
        'CENTER_TRACE before_existing_check '
        'existingId=${existingId ?? ''} '
        'initialShouldCreate=$shouldCreate',
      );
      debugPrint('CENTER_CREATE existingId=${existingId ?? ''}');
      debugPrint('CENTER_CREATE shouldCreate=$shouldCreate');
      if (!shouldCreate) {
        print(
          'CENTER_TRACE before_existing_query '
          'existingId=${existingId ?? ''} '
          'collection=booking_requests',
        );
        final requestDocs = await _existingRequestDocs(existingId);
        print(
          'CENTER_TRACE after_existing_query '
          'existingId=${existingId ?? ''} '
          'docsFound=${requestDocs.length}',
        );
        debugPrint(
          'CENTER_RESUBMIT existingRequestId=$existingId '
          'currentUserUid=${user?.uid ?? ''} '
          'docsFound=${requestDocs.length}',
        );
        if (requestDocs.isEmpty) {
          shouldCreate = true;
        }
        for (final doc in requestDocs) {
          final data = doc.data() ?? const <String, dynamic>{};
          debugPrint(
            'CENTER_RESUBMIT doc_found '
            'docId=${doc.id} '
            'collection=${doc.reference.parent.id} '
            'status=${(data['status'] ?? '').toString()} '
            'clientId=${(data['clientId'] ?? '').toString()} '
            'centerId=${(data['centerId'] ?? '').toString()} '
            'currentUserUid=${user?.uid ?? ''}',
          );
        }
        var clientRevisionNumber = 0;
        if (requestDocs.isNotEmpty) {
          final current = requestDocs.first.data() ?? const <String, dynamic>{};
          final previousRevision = (current['clientRevisionNumber'] ?? 0);
          if (previousRevision is num) {
            clientRevisionNumber = previousRevision.toInt();
          }
        }
        final updatePayload = <String, dynamic>{
          'status': 'pending_admin',
          'workflowStage': 'pending_admin',
          'updatedAt': FieldValue.serverTimestamp(),
          'note': note,
          'centerAvailabilityStatus': 'pending',
          'centerAvailabilityNote': '',
          'centerAvailabilityRespondedAt': null,
          'centerAvailabilityRespondedBy': '',
          'centerSuggestedAlternativeKey': '',
          'centerSuggestedAlternativeLabelAr': '',
          'selectedAccommodationKey': _selectedAccommodationKey,
          'selectedAccommodationLabelAr': selectedLabelAr,
          'selectedAccommodationPricingSnapshot':
              selection?['snapshot'] ?? const <String, dynamic>{},
          'selectedAccommodationPrice': selectedPrice,
          'selectedAccommodationPricingUnit': selectedPricingUnit,
          'contract': contractDraft,
          'selectedCenterType': _centerType,
          'centerHasDetoxUnit': _centerHasDetoxUnit,
          'clientRevisionNumber': clientRevisionNumber + 1,
          'clientUpdatedAfterCenterFeedback': true,
          'adminCanApproveWithoutCenterRecheck':
              _lastSuggestedAlternativeKey.isNotEmpty &&
                  _lastSuggestedAlternativeKey == _selectedAccommodationKey,
        };
        for (final doc in requestDocs) {
          final data = doc.data() ?? const <String, dynamic>{};
          debugPrint(
            'CENTER_RESUBMIT update_attempt '
            'docId=${doc.id} '
            'collection=${doc.reference.parent.id} '
            'statusBefore=${(data['status'] ?? '').toString()} '
            'clientId=${(data['clientId'] ?? '').toString()} '
            'centerId=${(data['centerId'] ?? '').toString()} '
            'currentUserUid=${user?.uid ?? ''}',
          );
          try {
            await doc.reference.update(updatePayload);
            debugPrint(
              'CENTER_RESUBMIT update_success '
              'docId=${doc.id} '
              'collection=${doc.reference.parent.id}',
            );
          } catch (e) {
            debugPrint(
              'CENTER_RESUBMIT update_error '
              'docId=${doc.id} '
              'collection=${doc.reference.parent.id} '
              'statusBefore=${(data['status'] ?? '').toString()} '
              'clientId=${(data['clientId'] ?? '').toString()} '
              'centerId=${(data['centerId'] ?? '').toString()} '
              'currentUserUid=${user?.uid ?? ''} '
              'error=$e',
            );
            rethrow;
          }
        }
      }
      print(
        'CENTER_TRACE after_existing_check '
        'existingId=${existingId ?? ''} '
        'finalShouldCreate=$shouldCreate',
      );
      if (shouldCreate) {
        print('CENTER_TRACE before_create_prep');
        debugPrint('CENTER_CREATE branch=create');
        debugPrint(
          'CENTER_CREATE payload_ready centerId=${widget.args.centerId} centerName=${widget.args.centerName}',
        );
        print('CENTER_DIAG skipped_diag_write_v3');
        print('CENTER_TRACE after_create_prep');
        print('CENTER_CREATE before_create_request');
        print('CENTER_CREATE requestGroupId=$requestGroupId');
        print(
            'CENTER_CREATE selectedAccommodationKey=$_selectedAccommodationKey');
        print('CENTER_CREATE noteLength=${note.length}');
        print('CENTER_CREATE targetAdminIds=$sentToIds');
        final requestRef = firestore.collection('booking_requests').doc();
        debugPrint(
          'CENTER_CREATE create_request '
          'docId=${requestRef.id} '
          'collection=booking_requests '
          'status=pending_admin '
          'clientId=$uid '
          'centerId=${widget.args.centerId}',
        );
        print('CENTER_CREATE payload_clientId=${payload['clientId']}');
        print('CENTER_CREATE payload_centerId=${payload['centerId']}');
        print('CENTER_CREATE payload_centerName=${payload['centerName']}');
        debugPrint('CENTER_CREATE write_attempt');
        try {
          await requestRef.set(payload);
          debugPrint('CENTER_CREATE write_success docId=${requestRef.id}');
        } catch (e) {
          debugPrint('CENTER_CREATE write_error error=$e');
          rethrow;
        }
      }

      if (!mounted) {
        return;
      }

      final routedNames = sentToNames.toSet().join(' / ');
      setState(() => _result = 'تم إرسال طلب المركز إلى الإدارة بنجاح');

      messenger.showSnackBar(
        SnackBar(
          content: Text(
            routedNames.isEmpty
                ? 'تم إرسال طلب المركز إلى الإدارة'
                : 'تم إرسال طلب المركز إلى: $routedNames',
          ),
        ),
      );
    } catch (e) {
      debugPrint('CENTER_CREATE submit_error error=$e');
      if (!mounted) return;
      setState(() => _result = 'تعذر إرسال الطلب');
      messenger.showSnackBar(
        SnackBar(content: Text('فشل الإرسال: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
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

  Widget _glassCard({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
  }) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE7C766).withValues(alpha: 0.32),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE7C766).withValues(alpha: 0.08),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: Color(0xFFFFF4D4), height: 1.35),
        child: IconTheme(
          data: const IconThemeData(color: Color(0xFFE7C766)),
          child: child,
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: const Color(0xFFFFF4D4).withValues(alpha: 0.62),
      ),
      filled: true,
      fillColor: Colors.black.withValues(alpha: 0.26),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: const Color(0xFFE7C766).withValues(alpha: 0.26),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: const Color(0xFFE7C766).withValues(alpha: 0.56),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: const Color(0xFFE7C766).withValues(alpha: 0.14),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black.withValues(alpha: 0.30),
          foregroundColor: const Color(0xFFFFE7B2),
          elevation: 0,
          title: const Text('طلب حجز مركز'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                _backgroundAsset(MediaQuery.of(context).size.width),
              ),
              fit: BoxFit.cover,
              alignment: MediaQuery.of(context).size.width < 700
                  ? Alignment.topCenter
                  : Alignment.center,
            ),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.52),
                  Colors.black.withValues(alpha: 0.32),
                  Colors.black.withValues(alpha: 0.68),
                ],
              ),
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 860),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _glassCard(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor:
                                const Color(0xFFE7C766).withValues(alpha: 0.18),
                            foregroundColor: const Color(0xFFFFE7B2),
                            child: Text(
                              widget.args.centerName.trim().isEmpty
                                  ? 'م'
                                  : widget.args.centerName
                                      .trim()
                                      .characters
                                      .first,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.args.centerName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: const Color(0xFFFFE7B2),
                                        fontWeight: FontWeight.w900,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'سيتم إرسال طلبك أولًا إلى الإدارة، وتظل المتابعة كلها عبر الإدارة فقط بدون تواصل مباشر مع المركز من جهة العميل.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: const Color(0xFFFFF4D4)
                                            .withValues(alpha: 0.82),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _glassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ملاحظات إضافية',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: const Color(0xFFFFE7B2),
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'اكتب أي تفاصيل تريد أن تصل إلى الإدارة بخصوص طلب المركز.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: const Color(0xFFFFF4D4)
                                      .withValues(alpha: 0.82),
                                ),
                          ),
                          const SizedBox(height: 12),
                          if (_availableAccommodationOptions().isNotEmpty) ...[
                            Text(
                              'اختيار نوع الإقامة',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: const Color(0xFFFFE7B2),
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              initialValue: _selectedAccommodationKey.isEmpty
                                  ? null
                                  : _selectedAccommodationKey,
                              isExpanded: true,
                              dropdownColor: const Color(0xFF090704),
                              iconEnabledColor: const Color(0xFFE7C766),
                              style: const TextStyle(
                                color: Color(0xFFFFF4D4),
                                fontWeight: FontWeight.w800,
                              ),
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18)),
                                  borderSide:
                                      BorderSide(color: Color(0x44E7C766)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18)),
                                  borderSide:
                                      BorderSide(color: Color(0x88E7C766)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18)),
                                ),
                                filled: true,
                                fillColor: Color(0x42000000),
                                hintText: 'اختر نوع الإقامة',
                              ),
                              items:
                                  _availableAccommodationOptions().map((item) {
                                final unit =
                                    (item['pricingUnit'] ?? '').toString();
                                final unitLabel = unit == 'month'
                                    ? 'شهري'
                                    : unit == 'day'
                                        ? 'يومي'
                                        : '';
                                return DropdownMenuItem<String>(
                                  value: (item['key'] ?? '').toString(),
                                  child: Text(
                                    '${item['labelAr']} - ${item['price']}${unitLabel.isEmpty ? '' : ' / $unitLabel'}',
                                  ),
                                );
                              }).toList(),
                              onChanged: _submitting
                                  ? null
                                  : (value) {
                                      setState(() {
                                        _selectedAccommodationKey = value ?? '';
                                      });
                                    },
                            ),
                            const SizedBox(height: 12),
                          ],
                          if (_lastCenterNote.isNotEmpty ||
                              _lastSuggestedAlternativeLabelAr.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.24),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFFE7C766)
                                      .withValues(alpha: 0.20),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'آخر ملاحظة من المركز',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          color: const Color(0xFFFFE7B2),
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ),
                                  const SizedBox(height: 6),
                                  if (_lastCenterNote.isNotEmpty)
                                    Text(
                                      _lastCenterNote,
                                      style: const TextStyle(
                                        color: Color(0xFFFFF4D4),
                                      ),
                                    ),
                                  if (_lastSuggestedAlternativeLabelAr
                                      .isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        'البديل المقترح: $_lastSuggestedAlternativeLabelAr',
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          if (_lastCenterNote.isNotEmpty ||
                              _lastSuggestedAlternativeLabelAr.isNotEmpty)
                            const SizedBox(height: 12),
                          TextField(
                            controller: _noteCtrl,
                            style: const TextStyle(
                              color: Color(0xFFFFF4D4),
                              fontWeight: FontWeight.w700,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'اكتب ملاحظتك هنا...',
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                                borderSide:
                                    BorderSide(color: Color(0x44E7C766)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                                borderSide:
                                    BorderSide(color: Color(0x88E7C766)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                              ),
                              filled: true,
                              fillColor: Color(0x42000000),
                            ),
                            maxLines: 5,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 54,
                      child: FilledButton.icon(
                        onPressed:
                            (_submitting || _loadingDraft) ? null : _submit,
                        style: FilledButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFE7C766).withValues(alpha: 0.16),
                          foregroundColor: const Color(0xFFFFE7B2),
                          disabledBackgroundColor:
                              Colors.black.withValues(alpha: 0.22),
                          disabledForegroundColor:
                              const Color(0xFFFFF4D4).withValues(alpha: 0.45),
                          side: BorderSide(
                            color:
                                const Color(0xFFE7C766).withValues(alpha: 0.44),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        icon: _submitting
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.send_outlined),
                        label: Text(
                          _submitting
                              ? 'جارٍ الإرسال...'
                              : 'إرسال الطلب إلى الإدارة',
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_result != null)
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.34),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color:
                                const Color(0xFFE7C766).withValues(alpha: 0.26),
                          ),
                        ),
                        child: Text(
                          _result!,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: const Color(0xFFFFF4D4),
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
    );
  }
}
