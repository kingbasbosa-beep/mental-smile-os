import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';
import 'package:flutterprojects/features/centers/data/models/center_pricing.dart';
import 'package:flutterprojects/features/centers/presentation/center_document_requirements.dart';

class CenterRoomPage extends StatefulWidget {
  const CenterRoomPage({super.key});

  @override
  State<CenterRoomPage> createState() => _CenterRoomPageState();
}
class _CenterRoomPageState extends State<CenterRoomPage> {
  final _centerNameController = TextEditingController();
  final _managerNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _requestedFrontImageController = TextEditingController();
  final _requestedReceptionImageController = TextEditingController();
  final _requestedInside1ImageController = TextEditingController();
  final _requestedInside2ImageController = TextEditingController();
  final _frontImageController = TextEditingController();
  final _receptionImageController = TextEditingController();
  final _inside1ImageController = TextEditingController();
  final _inside2ImageController = TextEditingController();

  final _docFileNameController = TextEditingController();
  final _docUrlController = TextEditingController();
  final Map<String, TextEditingController> _pricingControllers = {};
  final Map<String, TextEditingController> _autismPricingControllers = {};

  bool _savingImages = false;
  bool _savingDocument = false;
  bool _submittingChangeRequest = false;
  String _lastCenterProfileSeed = '';
  String _lastRequestedGallerySeed = '';
  String _lastPricingSeed = '';
  String? _selectedDocType;
  late List<AccommodationCostItem> _requestedAccommodationCosts;
  late List<AutismCareCostItem> _requestedAutismCareCosts;
  CenterCapabilityFlags _requestedCapabilities = const CenterCapabilityFlags();

  @override
  void initState() {
    super.initState();
    _requestedAccommodationCosts = defaultAccommodationCostItems();
    _requestedAutismCareCosts = defaultAutismCareCostItems();
    for (final item in _requestedAccommodationCosts) {
      _pricingControllers[item.key] =
          TextEditingController(text: item.price == 0 ? '' : '${item.price}');
    }
    for (final item in _requestedAutismCareCosts) {
      _autismPricingControllers[item.key] =
          TextEditingController(text: item.price == 0 ? '' : '${item.price}');
    }
  }

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  String _dashboardBackgroundAsset(double width) {
    if (width < 700) {
      return 'assets/branding/client_dashboard/mobile/client_dashboard_mobile_bg.png';
    }
    if (width <= 1100) {
      return 'assets/branding/client_dashboard/tablet/client_dashboard_tablet_bg.png';
    }
    return 'assets/branding/client_dashboard/desktop/client_dashboard_desktop_bg.png';
  }

  Alignment _dashboardBackgroundAlignment(double width) {
    if (width < 700) {
      return Alignment.topCenter;
    }
    return const Alignment(-0.08, 0);
  }

  double _dashboardBackgroundScale(double width) {
    if (width <= 1100) return 1.0;
    return 1.0;
  }

  double _dashboardOverlayAlpha(double width) {
    if (width < 700) return 0.50;
    if (width <= 1100) return 0.42;
    return 0.38;
  }

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  Stream<Map<String, dynamic>?> _centerStream() {
    final uid = _uid;
    if (uid == null || uid.isEmpty) return Stream.value(null);

    return FirebaseFirestore.instance
        .collection('centers')
        .doc(uid)
        .snapshots()
        .map((doc) => doc.exists ? doc.data() : null);
  }

  Future<void> _logout(BuildContext context) async {
    await AppShellActions.signOutToLogin(context);
  }

  List<Map<String, dynamic>> _readDocs(Map<String, dynamic> data) {
    final raw = data['documentItems'];
    if (raw is List) {
      return raw
          .whereType<Map>()
          .map((e) => e.map((k, v) => MapEntry('$k', v)))
          .toList();
    }
    return [];
  }

  List<Map<String, dynamic>> _readGallery(Map<String, dynamic> data) {
    final raw = data['galleryItems'];
    if (raw is List) {
      return raw
          .whereType<Map>()
          .map((e) => e.map((k, v) => MapEntry('$k', v)))
          .toList();
    }

    final fallback = data['galleryImages'];
    if (fallback is! List) return [];
    return fallback.whereType<String>().map((e) => {'url': e}).toList();
  }

  void _prefillGallery(List<Map<String, dynamic>> items) {
    String readUrl(String key) {
      final item = items.cast<Map<String, dynamic>?>().firstWhere(
            (e) => (e?['slotKey'] ?? '').toString() == key,
            orElse: () => null,
          );
      return (item?['url'] ?? '').toString();
    }

    _frontImageController.text = readUrl('front');
    _receptionImageController.text = readUrl('reception');
    _inside1ImageController.text = readUrl('inside_1');
    _inside2ImageController.text = readUrl('inside_2');
  }

  void _syncRequestedGalleryFields(List<Map<String, dynamic>> items) {
    String readUrl(String key) {
      final item = items.cast<Map<String, dynamic>?>().firstWhere(
            (e) => (e?['slotKey'] ?? '').toString() == key,
            orElse: () => null,
          );
      return (item?['url'] ?? '').toString();
    }

    final nextSeed = [
      readUrl('front'),
      readUrl('reception'),
      readUrl('inside_1'),
      readUrl('inside_2'),
    ].join('||');

    if (_lastRequestedGallerySeed == nextSeed) return;

    _requestedFrontImageController.text = readUrl('front');
    _requestedReceptionImageController.text = readUrl('reception');
    _requestedInside1ImageController.text = readUrl('inside_1');
    _requestedInside2ImageController.text = readUrl('inside_2');
    _lastRequestedGallerySeed = nextSeed;
  }

  List<Map<String, dynamic>> _buildGalleryItems() {
    return [
      {
        'slotKey': 'front',
        'label': 'Front View',
        'url': _frontImageController.text.trim(),
        'status':
            _frontImageController.text.trim().isEmpty ? 'pending' : 'uploaded',
      },
      {
        'slotKey': 'reception',
        'label': 'Reception',
        'url': _receptionImageController.text.trim(),
        'status': _receptionImageController.text.trim().isEmpty
            ? 'pending'
            : 'uploaded',
      },
      {
        'slotKey': 'inside_1',
        'label': 'Inside 1',
        'url': _inside1ImageController.text.trim(),
        'status': _inside1ImageController.text.trim().isEmpty
            ? 'pending'
            : 'uploaded',
      },
      {
        'slotKey': 'inside_2',
        'label': 'Inside 2',
        'url': _inside2ImageController.text.trim(),
        'status': _inside2ImageController.text.trim().isEmpty
            ? 'pending'
            : 'uploaded',
      },
    ];
  }

  List<Map<String, dynamic>> _buildRequestedGalleryItems() {
    return [
      {
        'slotKey': 'front',
        'label': 'Front View',
        'url': _requestedFrontImageController.text.trim(),
        'status': _requestedFrontImageController.text.trim().isEmpty
            ? 'pending'
            : 'uploaded',
      },
      {
        'slotKey': 'reception',
        'label': 'Reception',
        'url': _requestedReceptionImageController.text.trim(),
        'status': _requestedReceptionImageController.text.trim().isEmpty
            ? 'pending'
            : 'uploaded',
      },
      {
        'slotKey': 'inside_1',
        'label': 'Inside 1',
        'url': _requestedInside1ImageController.text.trim(),
        'status': _requestedInside1ImageController.text.trim().isEmpty
            ? 'pending'
            : 'uploaded',
      },
      {
        'slotKey': 'inside_2',
        'label': 'Inside 2',
        'url': _requestedInside2ImageController.text.trim(),
        'status': _requestedInside2ImageController.text.trim().isEmpty
            ? 'pending'
            : 'uploaded',
      },
    ];
  }

  void _syncProfileFields(Map<String, dynamic> data) {
    final nextSeed = [
      (data['centerName'] ?? data['displayName'] ?? '').toString(),
      (data['managerName'] ?? '').toString(),
      (data['city'] ?? '').toString(),
      (data['address'] ?? '').toString(),
      (data['description'] ?? '').toString(),
    ].join('||');

    if (_lastCenterProfileSeed == nextSeed) return;

    _centerNameController.text =
        (data['centerName'] ?? data['displayName'] ?? '').toString();
    _managerNameController.text = (data['managerName'] ?? '').toString();
    _cityController.text = (data['city'] ?? '').toString();
    _addressController.text = (data['address'] ?? '').toString();
    _descriptionController.text = (data['description'] ?? '').toString();
    _lastCenterProfileSeed = nextSeed;
  }

  double _readPrice(TextEditingController? controller) {
    return double.tryParse((controller?.text ?? '').trim()) ?? 0;
  }

  List<AccommodationCostItem> _currentRequestedAccommodationCosts() {
    return _requestedAccommodationCosts
        .map(
          (item) => item.copyWith(
            price: _readPrice(_pricingControllers[item.key]),
          ),
        )
        .toList();
  }

  List<AutismCareCostItem> _currentRequestedAutismCareCosts() {
    return _requestedAutismCareCosts
        .map(
          (item) => item.copyWith(
            price: _readPrice(_autismPricingControllers[item.key]),
          ),
        )
        .toList();
  }

  void _syncPricingFields(Map<String, dynamic> data) {
    final category = (data['category'] ?? '').toString().trim();
    final nextAccommodation =
        mergeAccommodationCostItems(data['accommodationCosts']);
    final nextAutism = mergeAutismCareCostItems(data['autismCareCosts']);
    final nextCapabilities = CenterCapabilityFlags.fromMap(
      data['centerCapabilities'] is Map
          ? Map<String, dynamic>.from(data['centerCapabilities'])
          : const <String, dynamic>{},
    );

    final nextSeed = [
      category,
      ...nextAccommodation.map((item) => item.toMap().toString()),
      ...nextAutism.map((item) => item.toMap().toString()),
      nextCapabilities.toMap().toString(),
    ].join('||');

    if (_lastPricingSeed == nextSeed) return;

    _requestedAccommodationCosts = nextAccommodation;
    _requestedAutismCareCosts = nextAutism;
    _requestedCapabilities = nextCapabilities;

    for (final item in nextAccommodation) {
      _pricingControllers[item.key]?.text =
          item.price == 0 ? '' : '${item.price}';
    }
    for (final item in nextAutism) {
      _autismPricingControllers[item.key]?.text =
          item.price == 0 ? '' : '${item.price}';
    }

    _lastPricingSeed = nextSeed;
  }

  Future<void> _saveImages({
    required Map<String, dynamic> currentData,
    required List<Map<String, dynamic>> currentDocs,
  }) async {
    final uid = _uid;
    if (uid == null) return;

    setState(() => _savingImages = true);
    try {
      _requestedFrontImageController.text = _frontImageController.text.trim();
      _requestedReceptionImageController.text =
          _receptionImageController.text.trim();
      _requestedInside1ImageController.text =
          _inside1ImageController.text.trim();
      _requestedInside2ImageController.text =
          _inside2ImageController.text.trim();

      await _submitCenterChangeRequest(
        currentData: currentData,
        currentDocs: currentDocs,
      );
      /*

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context) ? 'تم حفظ صور المركز' : 'Center images saved',
          ),
        ),
      );
      */
    } finally {
      if (mounted) setState(() => _savingImages = false);
    }
  }

  Future<void> _addDocument({
    required Map<String, dynamic> currentData,
    required List<Map<String, dynamic>> currentDocs,
  }) async {
    final uid = _uid;
    if (uid == null) return;

    final type = (_selectedDocType ?? '').trim();
    final fileName = _docFileNameController.text.trim();
    final fileUrl = _docUrlController.text.trim();
    if (type.isEmpty || fileName.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'أدخل نوع الوثيقة واسم الملف على الأقل'
                : 'Enter document type and file name at minimum',
          ),
        ),
      );
      return;
    }

    setState(() => _savingDocument = true);
    try {
      final updated = <Map<String, dynamic>>[
        ...currentDocs,
        {
          'documentType': type,
          'fileName': fileName,
          'originalFileName': fileName,
          'fileUrl': fileUrl,
          'uploadedAt': DateTime.now().toIso8601String(),
          'status': 'submitted',
          'storagePath': '',
        },
      ];

      await _submitCenterChangeRequest(
        currentData: currentData,
        currentDocs: updated,
      );

      _docFileNameController.clear();
      _docUrlController.clear();
      _selectedDocType = null;
      /*

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context) ? 'تمت إضافة الوثيقة' : 'Document added',
          ),
        ),
      );
      */
    } finally {
      if (mounted) setState(() => _savingDocument = false);
    }
  }

  Future<void> _removeDocument({
    required int index,
    required Map<String, dynamic> currentData,
    required List<Map<String, dynamic>> currentDocs,
  }) async {
    final uid = _uid;
    if (uid == null) return;

    setState(() => _savingDocument = true);
    try {
      final updated = <Map<String, dynamic>>[];
      for (int i = 0; i < currentDocs.length; i++) {
        if (i != index) {
          updated.add(currentDocs[i]);
        }
      }

      await _submitCenterChangeRequest(
        currentData: currentData,
        currentDocs: updated,
      );
      /*

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context) ? 'تم حذف الوثيقة' : 'Document removed',
          ),
        ),
      );
      */
    } finally {
      if (mounted) setState(() => _savingDocument = false);
    }
  }

  Future<void> _submitCenterChangeRequest({
    required Map<String, dynamic> currentData,
    required List<Map<String, dynamic>> currentDocs,
  }) async {
    final uid = _uid;
    if (uid == null) return;

    setState(() => _submittingChangeRequest = true);
    try {
      final requestedGalleryItems = _buildRequestedGalleryItems();
      final requestedImagesReady = requestedGalleryItems
              .where((item) => (item['url'] ?? '').toString().trim().isNotEmpty)
              .length ==
          4;

      await FirebaseFirestore.instance
          .collection('center_profile_change_requests')
          .add({
        'centerId': uid,
        'centerName': _centerNameController.text.trim(),
        'centerEmail': (currentData['email'] ?? '').toString().trim(),
        'requestType': 'profile_update',
        'currentCenterName':
            (currentData['centerName'] ?? currentData['displayName'] ?? '')
                .toString()
                .trim(),
        'requestedCenterName': _centerNameController.text.trim(),
        'currentManagerName':
            (currentData['managerName'] ?? '').toString().trim(),
        'requestedManagerName': _managerNameController.text.trim(),
        'currentDescription':
            (currentData['description'] ?? '').toString().trim(),
        'requestedDescription': _descriptionController.text.trim(),
        'currentCity': (currentData['city'] ?? '').toString().trim(),
        'requestedCity': _cityController.text.trim(),
        'currentAddress': (currentData['address'] ?? '').toString().trim(),
        'requestedAddress': _addressController.text.trim(),
        'currentGalleryItems': _readGallery(currentData),
        'requestedGalleryItems': requestedGalleryItems,
        'currentDocumentItems': _readDocs(currentData),
        'requestedDocumentItems': currentDocs,
        'currentAccommodationCosts': mergeAccommodationCostItems(
          currentData['accommodationCosts'],
        ).map((e) => e.toMap()).toList(),
        'requestedAccommodationCosts': _currentRequestedAccommodationCosts()
            .map((e) => e.toMap())
            .toList(),
        'currentAutismCareCosts': mergeAutismCareCostItems(
          currentData['autismCareCosts'],
        ).map((e) => e.toMap()).toList(),
        'requestedAutismCareCosts':
            _currentRequestedAutismCareCosts().map((e) => e.toMap()).toList(),
        'currentCenterCapabilities': CenterCapabilityFlags.fromMap(
          currentData['centerCapabilities'] is Map
              ? Map<String, dynamic>.from(currentData['centerCapabilities'])
              : const <String, dynamic>{},
        ).toMap(),
        'requestedCenterCapabilities': _requestedCapabilities.toMap(),
        'requestedImagesReady': requestedImagesReady,
        'requestedDocumentsReady': currentDocs.isNotEmpty,
        'status': 'submitted',
        'declarationSignals': {
          'profile.identity': true,
          'profile.location': true,
          'profile.media': requestedImagesReady,
          'profile.documents': currentDocs.isNotEmpty,
          'profile.pricing': true,
          'profile.capabilities': true,
        },
        'profileSignals': {
          'centerName': _centerNameController.text.trim(),
          'managerName': _managerNameController.text.trim(),
          'city': _cityController.text.trim(),
          'address': _addressController.text.trim(),
        },
        'changeSummary': 'profile_update',
        'submittedAt': FieldValue.serverTimestamp(),
        'submittedBy': uid,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'تم تقديم إعلان تحديث ملف المركز'
                : 'Center profile update declaration submitted',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _submittingChangeRequest = false);
      }
    }
  }

  Widget _buildProfileEditRequestEntryCard({
    required BuildContext context,
    required bool isArabic,
  }) {
    final scheme = Theme.of(context).colorScheme;

    return AppSurfaceCard(
      padding: const EdgeInsets.all(18),
      child: Row(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.manage_accounts_outlined, color: scheme.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic ? 'تعديل بياناتي' : 'Edit my data',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w800),
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                ),
                const SizedBox(height: 6),
                Text(
                  isArabic
                      ? 'فتح إعلان تحديث الملف الشخصي'
                      : 'Open profile update declaration',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          FilledButton(
            onPressed: () => Navigator.of(context).pushNamed(
              Routes.centerProfileEditRequest,
            ),
            child: Text(isArabic ? 'فتح' : 'Open'),
          ),
        ],
      ),
    );
  }

  String _docStatusLabel(String status, bool isArabic) {
    switch (status) {
      case 'processed':
        return isArabic ? 'تمت المعالجة' : 'Processed';
      case 'stored':
        return isArabic ? 'مؤرشف' : 'Stored';
      case 'needs_update':
        return isArabic ? 'يحتاج تحديث' : 'Needs update';
      case 'uploaded':
      case 'submitted':
      default:
        return isArabic ? 'تم التقديم' : 'Submitted';
    }
  }

  @override
  void dispose() {
    _centerNameController.dispose();
    _managerNameController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    _requestedFrontImageController.dispose();
    _requestedReceptionImageController.dispose();
    _requestedInside1ImageController.dispose();
    _requestedInside2ImageController.dispose();
    _frontImageController.dispose();
    _receptionImageController.dispose();
    _inside1ImageController.dispose();
    _inside2ImageController.dispose();
    _docFileNameController.dispose();
    _docUrlController.dispose();
    for (final controller in _pricingControllers.values) {
      controller.dispose();
    }
    for (final controller in _autismPricingControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildPricingToggle({
    required BuildContext context,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile.adaptive(
      value: value,
      onChanged: _submittingChangeRequest ? null : onChanged,
      title: Text(
        title,
        textAlign: _isArabic(context) ? TextAlign.right : TextAlign.left,
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildCapabilityEditor(BuildContext context) {
    final isArabic = _isArabic(context);
    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isArabic ? 'قدرات المركز' : 'Center capabilities',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          _buildPricingToggle(
            context: context,
            title: isArabic
                ? 'يدعم حالات الإدمان المصاحبة لفيروس HIV'
                : 'Supports addiction cases with HIV',
            value: _requestedCapabilities.supportsAddictionCasesWithHiv,
            onChanged: (value) {
              setState(() {
                _requestedCapabilities = _requestedCapabilities.copyWith(
                  supportsAddictionCasesWithHiv: value,
                );
              });
            },
          ),
          _buildPricingToggle(
            context: context,
            title:
                isArabic ? 'يستقبل حالات الإدمان' : 'Accepts addiction cases',
            value: _requestedCapabilities.acceptsAddictionCases,
            onChanged: (value) {
              setState(() {
                _requestedCapabilities = _requestedCapabilities.copyWith(
                  acceptsAddictionCases: value,
                );
              });
            },
          ),
          _buildPricingToggle(
            context: context,
            title: isArabic
                ? 'يستقبل الحالات النفسية بدون إدمان'
                : 'Accepts psychiatric cases without addiction',
            value:
                _requestedCapabilities.acceptsPsychiatricCasesWithoutAddiction,
            onChanged: (value) {
              setState(() {
                _requestedCapabilities = _requestedCapabilities.copyWith(
                  acceptsPsychiatricCasesWithoutAddiction: value,
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAccommodationEditor(
    BuildContext context,
    AccommodationCostItem item,
  ) {
    final isArabic = _isArabic(context);
    return AppSectionPanel(
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          _buildPricingToggle(
            context: context,
            title: isArabic ? item.labelAr : item.labelEn,
            value: item.enabled,
            onChanged: (value) {
              setState(() {
                _requestedAccommodationCosts = _requestedAccommodationCosts
                    .map((current) => current.key == item.key
                        ? current.copyWith(enabled: value)
                        : current)
                    .toList();
              });
            },
          ),
          TextField(
            controller: _pricingControllers[item.key],
            decoration: appInputDecoration(
              context: context,
              label: isArabic ? 'السعر' : 'Price',
              icon: Icons.sell_outlined,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: item.pricingUnit.isEmpty ? null : item.pricingUnit,
            isExpanded: true,
            decoration: appInputDecoration(
              context: context,
              label: isArabic ? 'وحدة التسعير' : 'Pricing unit',
              icon: Icons.calendar_today_outlined,
            ),
            items: [
              DropdownMenuItem(
                value: 'day',
                child: Text(isArabic ? 'يومي' : 'Per day'),
              ),
              DropdownMenuItem(
                value: 'month',
                child: Text(isArabic ? 'شهري' : 'Per month'),
              ),
            ],
            onChanged: _submittingChangeRequest
                ? null
                : (value) {
                    setState(() {
                      _requestedAccommodationCosts =
                          _requestedAccommodationCosts
                              .map((current) => current.key == item.key
                                  ? current.copyWith(pricingUnit: value ?? '')
                                  : current)
                              .toList();
                    });
                  },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: item.acMode.isEmpty ? null : item.acMode,
            isExpanded: true,
            decoration: appInputDecoration(
              context: context,
              label: isArabic ? 'نوع التكييف' : 'AC mode',
              icon: Icons.ac_unit_outlined,
            ),
            items: [
              DropdownMenuItem(
                value: 'ac',
                child: Text(isArabic ? 'مكيف' : 'AC'),
              ),
              DropdownMenuItem(
                value: 'non_ac',
                child: Text(isArabic ? 'غير مكيف' : 'Non-AC'),
              ),
            ],
            onChanged: _submittingChangeRequest
                ? null
                : (value) {
                    setState(() {
                      _requestedAccommodationCosts =
                          _requestedAccommodationCosts
                              .map((current) => current.key == item.key
                                  ? current.copyWith(acMode: value ?? '')
                                  : current)
                              .toList();
                    });
                  },
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              FilterChip(
                label: Text(isArabic ? 'يشمل الدواء' : 'Medication'),
                selected: item.includesMedication,
                onSelected: _submittingChangeRequest
                    ? null
                    : (value) {
                        setState(() {
                          _requestedAccommodationCosts =
                              _requestedAccommodationCosts
                                  .map((current) => current.key == item.key
                                      ? current.copyWith(
                                          includesMedication: value,
                                        )
                                      : current)
                                  .toList();
                        });
                      },
              ),
              FilterChip(
                label: Text(isArabic ? 'يشمل الوجبات' : 'Meals'),
                selected: item.includesMeals,
                onSelected: _submittingChangeRequest
                    ? null
                    : (value) {
                        setState(() {
                          _requestedAccommodationCosts =
                              _requestedAccommodationCosts
                                  .map((current) => current.key == item.key
                                      ? current.copyWith(includesMeals: value)
                                      : current)
                                  .toList();
                        });
                      },
              ),
              FilterChip(
                label: Text(isArabic ? 'أنشطة خارجية' : 'Outdoor activities'),
                selected: item.includesOutdoorActivities,
                onSelected: _submittingChangeRequest
                    ? null
                    : (value) {
                        setState(() {
                          _requestedAccommodationCosts =
                              _requestedAccommodationCosts
                                  .map((current) => current.key == item.key
                                      ? current.copyWith(
                                          includesOutdoorActivities: value,
                                        )
                                      : current)
                                  .toList();
                        });
                      },
              ),
              FilterChip(
                label: Text(isArabic ? 'الفحوصات المطلوبة' : 'Required tests'),
                selected: item.includesRequiredTests,
                onSelected: _submittingChangeRequest
                    ? null
                    : (value) {
                        setState(() {
                          _requestedAccommodationCosts =
                              _requestedAccommodationCosts
                                  .map((current) => current.key == item.key
                                      ? current.copyWith(
                                          includesRequiredTests: value,
                                        )
                                      : current)
                                  .toList();
                        });
                      },
              ),
              FilterChip(
                label: Text(isArabic ? 'استقبال المطار' : 'Airport pickup'),
                selected: item.includesAirportPickup,
                onSelected: _submittingChangeRequest
                    ? null
                    : (value) {
                        setState(() {
                          _requestedAccommodationCosts =
                              _requestedAccommodationCosts
                                  .map((current) => current.key == item.key
                                      ? current.copyWith(
                                          includesAirportPickup: value,
                                        )
                                      : current)
                                  .toList();
                        });
                      },
              ),
              FilterChip(
                label: Text(isArabic ? 'جولات خارجية' : 'Tourism/outings'),
                selected: item.includesTourismOrExternalOutings,
                onSelected: _submittingChangeRequest
                    ? null
                    : (value) {
                        setState(() {
                          _requestedAccommodationCosts =
                              _requestedAccommodationCosts
                                  .map((current) => current.key == item.key
                                      ? current.copyWith(
                                          includesTourismOrExternalOutings:
                                              value,
                                        )
                                      : current)
                                  .toList();
                        });
                      },
              ),
              FilterChip(
                label: Text(isArabic ? 'الضريبة شاملة' : 'Tax included'),
                selected: item.taxIncluded,
                onSelected: _submittingChangeRequest
                    ? null
                    : (value) {
                        setState(() {
                          _requestedAccommodationCosts =
                              _requestedAccommodationCosts
                                  .map((current) => current.key == item.key
                                      ? current.copyWith(taxIncluded: value)
                                      : current)
                                  .toList();
                        });
                      },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAutismPricingEditor(
    BuildContext context,
    AutismCareCostItem item,
  ) {
    final isArabic = _isArabic(context);
    return AppSectionPanel(
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          _buildPricingToggle(
            context: context,
            title: isArabic ? item.labelAr : item.labelEn,
            value: item.enabled,
            onChanged: (value) {
              setState(() {
                _requestedAutismCareCosts = _requestedAutismCareCosts
                    .map((current) => current.key == item.key
                        ? current.copyWith(enabled: value)
                        : current)
                    .toList();
              });
            },
          ),
          TextField(
            controller: _autismPricingControllers[item.key],
            decoration: appInputDecoration(
              context: context,
              label: isArabic ? 'السعر' : 'Price',
              icon: Icons.sell_outlined,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: item.pricingUnit.isEmpty ? null : item.pricingUnit,
            isExpanded: true,
            decoration: appInputDecoration(
              context: context,
              label: isArabic ? 'وحدة التسعير' : 'Pricing unit',
              icon: Icons.calendar_today_outlined,
            ),
            items: [
              DropdownMenuItem(
                value: 'day',
                child: Text(isArabic ? 'يومي' : 'Per day'),
              ),
              DropdownMenuItem(
                value: 'month',
                child: Text(isArabic ? 'شهري' : 'Per month'),
              ),
            ],
            onChanged: _submittingChangeRequest
                ? null
                : (value) {
                    setState(() {
                      _requestedAutismCareCosts = _requestedAutismCareCosts
                          .map((current) => current.key == item.key
                              ? current.copyWith(pricingUnit: value ?? '')
                              : current)
                          .toList();
                    });
                  },
          ),
          const SizedBox(height: 12),
          FilterChip(
            label: Text(isArabic ? 'الضريبة شاملة' : 'Tax included'),
            selected: item.taxIncluded,
            onSelected: _submittingChangeRequest
                ? null
                : (value) {
                    setState(() {
                      _requestedAutismCareCosts = _requestedAutismCareCosts
                          .map((current) => current.key == item.key
                              ? current.copyWith(taxIncluded: value)
                              : current)
                          .toList();
                    });
                  },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppShellActions.buildAppBar(
          context,
          title: isArabic ? 'غرفة المركز' : 'Center Room',
        ),
        body: LayoutBuilder(
          builder: (context, backgroundConstraints) {
            final width = backgroundConstraints.maxWidth;

            return Stack(
              fit: StackFit.expand,
              children: [
                Transform.scale(
                  scale: _dashboardBackgroundScale(width),
                  child: Image.asset(
                    _dashboardBackgroundAsset(width),
                    fit: BoxFit.cover,
                    alignment: _dashboardBackgroundAlignment(width),
                  ),
                ),
                ColoredBox(
                  color: Colors.black
                      .withValues(alpha: _dashboardOverlayAlpha(width)),
                ),
                StreamBuilder<Map<String, dynamic>?>(
                  stream: _centerStream(),
                  builder: (context, snapshot) {
                    final scheme = Theme.of(context).colorScheme;
                    final data = snapshot.data ?? <String, dynamic>{};
                    final centerName =
                        (data['centerName'] ?? data['displayName'] ?? '')
                            .toString()
                            .trim();

                    final docs = _readDocs(data);
                    final gallery = _readGallery(data);
                    _syncProfileFields(data);
                    _syncRequestedGalleryFields(gallery);
                    _syncPricingFields(data);
                    final category = (data['category'] ?? '').toString().trim();
                    final usesAutismPricing = usesAutismCarePricing(category);

                    if (snapshot.hasData && gallery.isNotEmpty) {
                      _prefillGallery(gallery);
                    }

                    return ListView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.symmetric(
                        horizontal: width < 700 ? 14 : 24,
                        vertical: width < 700 ? 14 : 20,
                      ),
                      children: [
                        AppSurfaceCard(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          child: Column(
                            crossAxisAlignment: isArabic
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                centerName.isEmpty
                                    ? (isArabic
                                        ? 'غرفة عمليات المركز'
                                        : 'Center Room')
                                    : centerName,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                isArabic
                                    ? 'الوضع الحالي بدون Firebase Storage. الصور والوثائق تُسجل مؤقتًا كبيانات وروابط داخل Firestore لحين تفعيل التخزين.'
                                    : 'Temporary mode without Firebase Storage. Images and documents are stored as metadata/links in Firestore until storage is enabled.',
                                textAlign:
                                    isArabic ? TextAlign.right : TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(height: 1.35),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _buildProfileEditRequestEntryCard(
                          context: context,
                          isArabic: isArabic,
                        ),
                        const SizedBox(height: 12),
                        AppSurfaceCard(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          child: Column(
                            crossAxisAlignment: isArabic
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                isArabic
                                    ? 'صور المركز الأساسية'
                                    : 'Main Center Images',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                isArabic
                                    ? 'أدخل روابط الصور الأربع الأساسية مؤقتًا. لاحقًا سنحوّلها لرفع مباشر.'
                                    : 'Enter the 4 main image URLs temporarily. Later we will switch them to direct uploads.',
                                textAlign:
                                    isArabic ? TextAlign.right : TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(height: 1.35),
                              ),
                              const SizedBox(height: AppSpacing.md),
                              TextField(
                                controller: _frontImageController,
                                decoration: appInputDecoration(
                                  context: context,
                                  label: isArabic
                                      ? 'رابط صورة الواجهة'
                                      : 'Front image URL',
                                  icon: Icons.storefront_outlined,
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _receptionImageController,
                                decoration: InputDecoration(
                                  labelText: isArabic
                                      ? 'رابط صورة الاستقبال'
                                      : 'Reception image URL',
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _inside1ImageController,
                                decoration: InputDecoration(
                                  labelText: isArabic
                                      ? 'رابط الصورة الداخلية 1'
                                      : 'Inside image 1 URL',
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _inside2ImageController,
                                decoration: InputDecoration(
                                  labelText: isArabic
                                      ? 'رابط الصورة الداخلية 2'
                                      : 'Inside image 2 URL',
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 14),
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: FilledButton.icon(
                                  onPressed: _savingImages
                                      ? null
                                      : () => _saveImages(
                                            currentData: data,
                                            currentDocs: docs,
                                          ),
                                  icon: _savingImages
                                      ? const SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.photo_library_outlined),
                                  label: Text(
                                    _savingImages
                                        ? (isArabic
                                            ? 'جارٍ الحفظ...'
                                            : 'Saving...')
                                        : (isArabic
                                            ? 'حفظ الصور الأربع'
                                            : 'Save 4 images'),
                                    maxLines: 2,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: scheme.surface,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: scheme.outline.withValues(alpha: 0.12),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: isArabic
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                isArabic
                                    ? 'رفع الوثائق المنظمة'
                                    : 'Structured Documents',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                isArabic
                                    ? 'أدخل بيانات الوثيقة يدويًا مؤقتًا: النوع، اسم الملف، والرابط إن وجد.'
                                    : 'Temporarily enter document metadata manually: type, file name, and URL if available.',
                              ),
                              const SizedBox(height: 14),
                              DropdownButtonFormField<String>(
                                initialValue: _selectedDocType,
                                isExpanded: true,
                                items: kRequiredCenterDocumentTypes
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: item['key'],
                                        child: Text(
                                          centerDocumentLabel(
                                            item['key'] ?? '',
                                            isArabic,
                                          ),
                                          textAlign: isArabic
                                              ? TextAlign.right
                                              : TextAlign.left,
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: _savingDocument
                                    ? null
                                    : (value) {
                                        setState(
                                            () => _selectedDocType = value);
                                      },
                                decoration: InputDecoration(
                                  labelText: isArabic
                                      ? 'نوع الوثيقة *'
                                      : 'Document type *',
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _docFileNameController,
                                decoration: InputDecoration(
                                  labelText:
                                      isArabic ? 'اسم الملف' : 'File name',
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _docUrlController,
                                decoration: InputDecoration(
                                  labelText: isArabic
                                      ? 'رابط الملف (اختياري)'
                                      : 'File URL (optional)',
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 12),
                              AppSectionPanel(
                                color: AppColors.accentLavender
                                    .withValues(alpha: 0.08),
                                borderColor: AppColors.accentLavender
                                    .withValues(alpha: 0.12),
                                child: Text(
                                  isArabic
                                      ? 'تُرسل كل وثيقة جديدة كإشارة إقرار للملف، ويمكن رصد حالتها لاحقًا.'
                                      : 'Each document is included as a submitted profile declaration signal.',
                                  textAlign: isArabic
                                      ? TextAlign.right
                                      : TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(height: 1.35),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: FilledButton.icon(
                                  onPressed: _savingDocument
                                      ? null
                                      : () => _addDocument(
                                            currentData: data,
                                            currentDocs: docs,
                                          ),
                                  icon: _savingDocument
                                      ? const SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Icon(Icons.upload_file_outlined),
                                  label: Text(
                                    _savingDocument
                                        ? (isArabic
                                            ? 'جارٍ الإضافة...'
                                            : 'Adding...')
                                        : (isArabic
                                            ? 'إضافة وثيقة'
                                            : 'Add document'),
                                    maxLines: 2,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (docs.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: scheme.surface,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: scheme.outline.withValues(alpha: 0.12),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: isArabic
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isArabic
                                      ? 'الوثائق الحالية'
                                      : 'Current Documents',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                                const SizedBox(height: 12),
                                ...docs.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final doc = entry.value;

                                  final type =
                                      (doc['documentType'] ?? '').toString();
                                  final fileName = (doc['originalFileName'] ??
                                          doc['fileName'] ??
                                          '')
                                      .toString();
                                  final status =
                                      (doc['status'] ?? 'submitted').toString();

                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: scheme.primary
                                          .withValues(alpha: 0.05),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: isArabic
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          type.isEmpty
                                              ? (isArabic
                                                  ? 'وثيقة'
                                                  : 'Document')
                                              : type,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        if (fileName.isNotEmpty) ...[
                                          const SizedBox(height: 4),
                                          Text(
                                            isArabic
                                                ? 'الملف: $fileName'
                                                : 'File: $fileName',
                                          ),
                                        ],
                                        const SizedBox(height: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF6C55B3)
                                                .withValues(alpha: 0.10),
                                            borderRadius:
                                                BorderRadius.circular(999),
                                          ),
                                          child: Text(
                                            _docStatusLabel(status, isArabic),
                                            style: const TextStyle(
                                              color: Color(0xFF6C55B3),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Align(
                                          alignment: isArabic
                                              ? Alignment.centerLeft
                                              : Alignment.centerRight,
                                          child: OutlinedButton.icon(
                                            onPressed: _savingDocument
                                                ? null
                                                : () => _removeDocument(
                                                      index: index,
                                                      currentData: data,
                                                      currentDocs: docs,
                                                    ),
                                            icon: const Icon(
                                                Icons.delete_outline),
                                            label: Text(
                                                isArabic ? 'حذف' : 'Delete'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 52,
                          child: OutlinedButton.icon(
                            onPressed: () => _logout(context),
                            icon: const Icon(Icons.logout),
                            label: Text(isArabic ? 'تسجيل الخروج' : 'Logout'),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
class CenterProfileEditRequestPage extends StatefulWidget {
  const CenterProfileEditRequestPage({super.key});

  @override
  State<CenterProfileEditRequestPage> createState() =>
      _CenterProfileEditRequestPageState();
}

class _CenterProfileEditRequestPageState
    extends State<CenterProfileEditRequestPage> {
  final _centerNameController = TextEditingController();
  final _managerNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _requestedFrontImageController = TextEditingController();
  final _requestedReceptionImageController = TextEditingController();
  final _requestedInside1ImageController = TextEditingController();
  final _requestedInside2ImageController = TextEditingController();

  bool _submitting = false;
  String _lastSeed = '';

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  Stream<Map<String, dynamic>?> _centerStream() {
    final uid = _uid;
    if (uid == null || uid.isEmpty) return Stream.value(null);
    return FirebaseFirestore.instance
        .collection('centers')
        .doc(uid)
        .snapshots()
        .map((doc) => doc.exists ? doc.data() : null);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _requestsStream() {
    final uid = _uid ?? '';
    return FirebaseFirestore.instance
        .collection('center_profile_change_requests')
        .where('centerId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  List<Map<String, dynamic>> _readDocs(Map<String, dynamic> data) {
    final raw = data['documentItems'];
    if (raw is List) {
      return raw
          .whereType<Map>()
          .map((e) => e.map((k, v) => MapEntry('$k', v)))
          .toList();
    }
    return [];
  }

  List<Map<String, dynamic>> _readGallery(Map<String, dynamic> data) {
    final raw = data['galleryItems'];
    if (raw is List) {
      return raw
          .whereType<Map>()
          .map((e) => e.map((k, v) => MapEntry('$k', v)))
          .toList();
    }
    final fallback = data['galleryImages'];
    if (fallback is! List) return [];
    return fallback.whereType<String>().map((e) => {'url': e}).toList();
  }

  void _seedFields(Map<String, dynamic> data) {
    final seed = [
      data['centerName'],
      data['managerName'],
      data['city'],
      data['address'],
      data['description'],
      data['galleryItems'],
      data['galleryImages'],
    ].join('|');
    if (seed == _lastSeed) return;
    _lastSeed = seed;

    _centerNameController.text =
        (data['centerName'] ?? data['displayName'] ?? '').toString();
    _managerNameController.text = (data['managerName'] ?? '').toString();
    _cityController.text = (data['city'] ?? '').toString();
    _addressController.text = (data['address'] ?? '').toString();
    _descriptionController.text = (data['description'] ?? '').toString();

    String readUrl(String key) {
      final item = _readGallery(data).cast<Map<String, dynamic>?>().firstWhere(
            (e) => (e?['slotKey'] ?? '').toString() == key,
            orElse: () => null,
          );
      return (item?['url'] ?? '').toString();
    }

    _requestedFrontImageController.text = readUrl('front');
    _requestedReceptionImageController.text = readUrl('reception');
    _requestedInside1ImageController.text = readUrl('inside_1');
    _requestedInside2ImageController.text = readUrl('inside_2');
  }

  List<Map<String, dynamic>> _buildRequestedGalleryItems() {
    Map<String, dynamic> item(String key, String label, String url) => {
          'slotKey': key,
          'label': label,
          'url': url.trim(),
        };

    return [
      item('front', 'Front', _requestedFrontImageController.text),
      item('reception', 'Reception', _requestedReceptionImageController.text),
      item('inside_1', 'Inside 1', _requestedInside1ImageController.text),
      item('inside_2', 'Inside 2', _requestedInside2ImageController.text),
    ];
  }

  Future<void> _submit(Map<String, dynamic> currentData) async {
    final uid = _uid;
    if (uid == null || uid.isEmpty) return;

    setState(() => _submitting = true);
    try {
      final requestedGalleryItems = _buildRequestedGalleryItems();
      final requestedImagesReady = requestedGalleryItems
              .where((item) => (item['url'] ?? '').toString().trim().isNotEmpty)
              .length ==
          4;

      await FirebaseFirestore.instance
          .collection('center_profile_change_requests')
          .add({
        'centerId': uid,
        'centerName': _centerNameController.text.trim(),
        'centerEmail': (currentData['email'] ?? '').toString().trim(),
        'requestType': 'profile_update',
        'currentCenterName':
            (currentData['centerName'] ?? currentData['displayName'] ?? '')
                .toString()
                .trim(),
        'requestedCenterName': _centerNameController.text.trim(),
        'currentManagerName':
            (currentData['managerName'] ?? '').toString().trim(),
        'requestedManagerName': _managerNameController.text.trim(),
        'currentDescription':
            (currentData['description'] ?? '').toString().trim(),
        'requestedDescription': _descriptionController.text.trim(),
        'currentCity': (currentData['city'] ?? '').toString().trim(),
        'requestedCity': _cityController.text.trim(),
        'currentAddress': (currentData['address'] ?? '').toString().trim(),
        'requestedAddress': _addressController.text.trim(),
        'currentGalleryItems': _readGallery(currentData),
        'requestedGalleryItems': requestedGalleryItems,
        'currentDocumentItems': _readDocs(currentData),
        'requestedDocumentItems': _readDocs(currentData),
        'currentAccommodationCosts': mergeAccommodationCostItems(
          currentData['accommodationCosts'],
        ).map((e) => e.toMap()).toList(),
        'requestedAccommodationCosts': mergeAccommodationCostItems(
          currentData['accommodationCosts'],
        ).map((e) => e.toMap()).toList(),
        'currentAutismCareCosts': mergeAutismCareCostItems(
          currentData['autismCareCosts'],
        ).map((e) => e.toMap()).toList(),
        'requestedAutismCareCosts': mergeAutismCareCostItems(
          currentData['autismCareCosts'],
        ).map((e) => e.toMap()).toList(),
        'currentCenterCapabilities': CenterCapabilityFlags.fromMap(
          currentData['centerCapabilities'] is Map
              ? Map<String, dynamic>.from(currentData['centerCapabilities'])
              : const <String, dynamic>{},
        ).toMap(),
        'requestedCenterCapabilities': CenterCapabilityFlags.fromMap(
          currentData['centerCapabilities'] is Map
              ? Map<String, dynamic>.from(currentData['centerCapabilities'])
              : const <String, dynamic>{},
        ).toMap(),
        'requestedImagesReady': requestedImagesReady,
        'requestedDocumentsReady': _readDocs(currentData).isNotEmpty,
        'status': 'submitted',
        'declarationSignals': {
          'profile.identity': true,
          'profile.location': true,
          'profile.media': requestedImagesReady,
          'profile.documents': _readDocs(currentData).isNotEmpty,
          'profile.pricing': true,
          'profile.capabilities': true,
        },
        'profileSignals': {
          'centerName': _centerNameController.text.trim(),
          'managerName': _managerNameController.text.trim(),
          'city': _cityController.text.trim(),
          'address': _addressController.text.trim(),
        },
        'changeSummary': 'profile_update',
        'submittedAt': FieldValue.serverTimestamp(),
        'submittedBy': uid,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'تم تقديم إعلان تحديث ملف المركز'
                : 'Center profile update declaration submitted',
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Widget _buildStatusList(
    BuildContext context,
    bool isArabic,
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return AppSurfaceCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isArabic
                ? 'إعلانات تحديث ملف المركز'
                : 'Center profile update declarations',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 12),
          if (docs.isEmpty)
            Text(isArabic
                ? 'لا توجد إعلانات تحديث لملف المركز حتى الآن'
                : 'No center profile update declarations yet')
          else
            ...docs.map((doc) {
              final data = doc.data();
              final status = (data['status'] ?? 'submitted').toString();
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: isArabic
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      status == 'processed'
                          ? (isArabic ? 'تمت المعالجة' : 'Processed')
                          : status == 'stored'
                              ? (isArabic ? 'مؤرشف' : 'Stored')
                              : (isArabic ? 'تم التقديم' : 'Submitted'),
                      style: TextStyle(
                        color: scheme.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildForm(
    BuildContext context,
    bool isArabic,
    Map<String, dynamic> data,
  ) {
    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isArabic
                ? 'إعلان تحديث ملف المركز'
                : 'Center profile update declaration',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            isArabic
                ? 'عدّل البيانات هنا ثم قدّم إعلان تحديث ملف المركز.'
                : 'Update the fields here, then submit a profile update declaration.',
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.35),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _centerNameController,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            decoration: appInputDecoration(
              context: context,
              label: isArabic ? 'اسم المركز' : 'Center name',
              icon: Icons.business_outlined,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _managerNameController,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            decoration: appInputDecoration(
              context: context,
              label: isArabic ? 'اسم المسؤول' : 'Manager name',
              icon: Icons.badge_outlined,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _cityController,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            decoration: appInputDecoration(
              context: context,
              label: isArabic ? 'المدينة' : 'City',
              icon: Icons.location_city_outlined,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _addressController,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            decoration: appInputDecoration(
              context: context,
              label: isArabic ? 'العنوان' : 'Address',
              icon: Icons.location_on_outlined,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descriptionController,
            maxLines: 4,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            decoration: appInputDecoration(
              context: context,
              label: isArabic ? 'وصف المركز' : 'Center description',
              icon: Icons.notes_outlined,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isArabic
                ? 'إقرار تحديث صور المركز'
                : 'Center image update declaration',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _requestedFrontImageController,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            decoration: appInputDecoration(
              context: context,
              label: isArabic
                  ? 'رابط صورة واجهة بديلة'
                  : 'Replacement front image URL',
              icon: Icons.storefront_outlined,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _requestedReceptionImageController,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            decoration: appInputDecoration(
              context: context,
              label: isArabic
                  ? 'رابط صورة استقبال بديلة'
                  : 'Replacement reception image URL',
              icon: Icons.meeting_room_outlined,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _requestedInside1ImageController,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            decoration: appInputDecoration(
              context: context,
              label: isArabic
                  ? 'رابط صورة داخلية بديلة 1'
                  : 'Replacement inside image 1 URL',
              icon: Icons.photo_outlined,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _requestedInside2ImageController,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            decoration: appInputDecoration(
              context: context,
              label: isArabic
                  ? 'رابط صورة داخلية بديلة 2'
                  : 'Replacement inside image 2 URL',
              icon: Icons.photo_library_outlined,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              onPressed: _submitting ? null : () => _submit(data),
              icon: _submitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send_outlined),
              label: Text(
                _submitting
                    ? (isArabic ? 'جارٍ الإرسال...' : 'Sending...')
                    : (isArabic
                        ? 'إرسال طلب تعديل البيانات'
                        : 'Submit declaration'),
                maxLines: 2,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _centerNameController.dispose();
    _managerNameController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    _requestedFrontImageController.dispose();
    _requestedReceptionImageController.dispose();
    _requestedInside1ImageController.dispose();
    _requestedInside2ImageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppShellActions.buildAppBar(
          context,
          title: isArabic ? 'تعديل بياناتي' : 'Edit my data',
        ),
        body: SafeArea(
          child: AppPageBackground(
            child: StreamBuilder<Map<String, dynamic>?>(
              stream: _centerStream(),
              builder: (context, centerSnapshot) {
                final data = centerSnapshot.data ?? <String, dynamic>{};
                _seedFields(data);

                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _requestsStream(),
                  builder: (context, requestSnapshot) {
                    final docs = requestSnapshot.data?.docs ?? const [];
                    final hasPending = docs.any(
                      (doc) => (doc.data()['status'] ?? 'submitted') == 'submitted',
                    );

                    return ListView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.md,
                      ),
                      children: [
                        if (hasPending)
                          AppSurfaceCard(
                            padding: const EdgeInsets.all(18),
                            child: Text(
                              isArabic
                                  ? 'تم تقديم إعلان تحديث لملف المركز. يمكنك متابعة حالته هنا.'
                                  : 'A center profile update declaration is submitted. You can track it here.',
                              textAlign:
                                  isArabic ? TextAlign.right : TextAlign.left,
                            ),
                          )
                        else
                          _buildForm(context, isArabic, data),
                        const SizedBox(height: 12),
                        _buildStatusList(context, isArabic, docs),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
