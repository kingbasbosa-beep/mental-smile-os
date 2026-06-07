import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';
import 'package:flutterprojects/features/centers/data/models/center_pricing.dart';
import 'package:flutterprojects/features/centers/presentation/center_document_requirements.dart';

class CenterOperationsPage extends StatefulWidget {
  const CenterOperationsPage({super.key});

  @override
  State<CenterOperationsPage> createState() => _CenterOperationsPageState();
}

class _CenterOperationsPageState extends State<CenterOperationsPage> {
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
  final _docReviewNoteController = TextEditingController();
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
            _isArabic(context) ? 'ØªÙ… Ø­ÙØ¸ ØµÙˆØ± Ø§Ù„Ù…Ø±ÙƒØ²' : 'Center images saved',
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
    final reviewNote = _docReviewNoteController.text.trim();

    if (type.isEmpty || fileName.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'Ø£Ø¯Ø®Ù„ Ù†ÙˆØ¹ Ø§Ù„ÙˆØ«ÙŠÙ‚Ø© ÙˆØ§Ø³Ù… Ø§Ù„Ù…Ù„Ù Ø¹Ù„Ù‰ Ø§Ù„Ø£Ù‚Ù„'
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
          'status': 'pending',
          'reviewNote': reviewNote,
          'storagePath': '',
        },
      ];

      await _submitCenterChangeRequest(
        currentData: currentData,
        currentDocs: updated,
      );

      _docFileNameController.clear();
      _docUrlController.clear();
      _docReviewNoteController.clear();
      _selectedDocType = null;
      /*

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context) ? 'ØªÙ…Øª Ø¥Ø¶Ø§ÙØ© Ø§Ù„ÙˆØ«ÙŠÙ‚Ø©' : 'Document added',
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
            _isArabic(context) ? 'ØªÙ… Ø­Ø°Ù Ø§Ù„ÙˆØ«ÙŠÙ‚Ø©' : 'Document removed',
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
        'status': 'pending',
        'adminDecision': '',
        'adminNote': '',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'ØªÙ… Ø¥Ø±Ø³Ø§Ù„ Ø·Ù„Ø¨ ØªØ¹Ø¯ÙŠÙ„ Ø¨ÙŠØ§Ù†Ø§Øª Ø§Ù„Ù…Ø±ÙƒØ² Ù„Ù„Ø¥Ø¯Ø§Ø±Ø©'
                : 'Center data change request sent to admin',
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
                  isArabic ? 'ØªØ¹Ø¯ÙŠÙ„ Ø¨ÙŠØ§Ù†Ø§ØªÙŠ' : 'Edit my data',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w800),
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                ),
                const SizedBox(height: 6),
                Text(
                  isArabic
                      ? 'Ø¥Ø±Ø³Ø§Ù„ Ø·Ù„Ø¨ ØªØ¹Ø¯ÙŠÙ„ Ø§Ù„ØµÙˆØ±Ø© Ø£Ùˆ Ø§Ù„Ù†Ø¨Ø°Ø©'
                      : 'Send a photo or profile change request',
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
            child: Text(isArabic ? 'ÙØªØ­' : 'Open'),
          ),
        ],
      ),
    );
  }

  String _docStatusLabel(String status, bool isArabic) {
    switch (status) {
      case 'approved':
        return isArabic ? 'Ù…Ù‚Ø¨ÙˆÙ„' : 'Approved';
      case 'rejected':
        return isArabic ? 'Ù…Ø±ÙÙˆØ¶' : 'Rejected';
      case 'needs_update':
        return isArabic ? 'ÙŠØ­ØªØ§Ø¬ ØªØ­Ø¯ÙŠØ«' : 'Needs update';
      case 'uploaded':
      case 'pending':
      default:
        return isArabic ? 'Ø¨Ø§Ù†ØªØ¸Ø§Ø± Ø§Ù„Ù…Ø±Ø§Ø¬Ø¹Ø©' : 'Pending review';
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
    _docReviewNoteController.dispose();
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
            isArabic ? 'Ù‚Ø¯Ø±Ø§Øª Ø§Ù„Ù…Ø±ÙƒØ²' : 'Center capabilities',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          _buildPricingToggle(
            context: context,
            title: isArabic
                ? 'ÙŠØ¯Ø¹Ù… Ø­Ø§Ù„Ø§Øª Ø§Ù„Ø¥Ø¯Ù…Ø§Ù† Ø§Ù„Ù…ØµØ§Ø­Ø¨Ø© Ù„ÙÙŠØ±ÙˆØ³ HIV'
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
                isArabic ? 'ÙŠØ³ØªÙ‚Ø¨Ù„ Ø­Ø§Ù„Ø§Øª Ø§Ù„Ø¥Ø¯Ù…Ø§Ù†' : 'Accepts addiction cases',
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
                ? 'ÙŠØ³ØªÙ‚Ø¨Ù„ Ø§Ù„Ø­Ø§Ù„Ø§Øª Ø§Ù„Ù†ÙØ³ÙŠØ© Ø¨Ø¯ÙˆÙ† Ø¥Ø¯Ù…Ø§Ù†'
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
              label: isArabic ? 'Ø§Ù„Ø³Ø¹Ø±' : 'Price',
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
              label: isArabic ? 'ÙˆØ­Ø¯Ø© Ø§Ù„ØªØ³Ø¹ÙŠØ±' : 'Pricing unit',
              icon: Icons.calendar_today_outlined,
            ),
            items: [
              DropdownMenuItem(
                value: 'day',
                child: Text(isArabic ? 'ÙŠÙˆÙ…ÙŠ' : 'Per day'),
              ),
              DropdownMenuItem(
                value: 'month',
                child: Text(isArabic ? 'Ø´Ù‡Ø±ÙŠ' : 'Per month'),
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
              label: isArabic ? 'Ù†ÙˆØ¹ Ø§Ù„ØªÙƒÙŠÙŠÙ' : 'AC mode',
              icon: Icons.ac_unit_outlined,
            ),
            items: [
              DropdownMenuItem(
                value: 'ac',
                child: Text(isArabic ? 'Ù…ÙƒÙŠÙ' : 'AC'),
              ),
              DropdownMenuItem(
                value: 'non_ac',
                child: Text(isArabic ? 'ØºÙŠØ± Ù…ÙƒÙŠÙ' : 'Non-AC'),
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
                label: Text(isArabic ? 'ÙŠØ´Ù…Ù„ Ø§Ù„Ø¯ÙˆØ§Ø¡' : 'Medication'),
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
                label: Text(isArabic ? 'ÙŠØ´Ù…Ù„ Ø§Ù„ÙˆØ¬Ø¨Ø§Øª' : 'Meals'),
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
                label: Text(isArabic ? 'Ø£Ù†Ø´Ø·Ø© Ø®Ø§Ø±Ø¬ÙŠØ©' : 'Outdoor activities'),
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
                label: Text(isArabic ? 'Ø§Ù„ÙØ­ÙˆØµØ§Øª Ø§Ù„Ù…Ø·Ù„ÙˆØ¨Ø©' : 'Required tests'),
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
                label: Text(isArabic ? 'Ø§Ø³ØªÙ‚Ø¨Ø§Ù„ Ø§Ù„Ù…Ø·Ø§Ø±' : 'Airport pickup'),
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
                label: Text(isArabic ? 'Ø¬ÙˆÙ„Ø§Øª Ø®Ø§Ø±Ø¬ÙŠØ©' : 'Tourism/outings'),
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
                label: Text(isArabic ? 'Ø§Ù„Ø¶Ø±ÙŠØ¨Ø© Ø´Ø§Ù…Ù„Ø©' : 'Tax included'),
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
              label: isArabic ? 'Ø§Ù„Ø³Ø¹Ø±' : 'Price',
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
              label: isArabic ? 'ÙˆØ­Ø¯Ø© Ø§Ù„ØªØ³Ø¹ÙŠØ±' : 'Pricing unit',
              icon: Icons.calendar_today_outlined,
            ),
            items: [
              DropdownMenuItem(
                value: 'day',
                child: Text(isArabic ? 'ÙŠÙˆÙ…ÙŠ' : 'Per day'),
              ),
              DropdownMenuItem(
                value: 'month',
                child: Text(isArabic ? 'Ø´Ù‡Ø±ÙŠ' : 'Per month'),
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
            label: Text(isArabic ? 'Ø§Ù„Ø¶Ø±ÙŠØ¨Ø© Ø´Ø§Ù…Ù„Ø©' : 'Tax included'),
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
          title: isArabic ? 'ØºØ±ÙØ© Ø¹Ù…Ù„ÙŠØ§Øª Ø§Ù„Ù…Ø±ÙƒØ²' : 'Center Operations',
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
                                        ? 'ØºØ±ÙØ© Ø¹Ù…Ù„ÙŠØ§Øª Ø§Ù„Ù…Ø±ÙƒØ²'
                                        : 'Center Operations')
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
                                    ? 'Ø§Ù„ÙˆØ¶Ø¹ Ø§Ù„Ø­Ø§Ù„ÙŠ Ø¨Ø¯ÙˆÙ† Firebase Storage. Ø§Ù„ØµÙˆØ± ÙˆØ§Ù„ÙˆØ«Ø§Ø¦Ù‚ ØªÙØ³Ø¬Ù„ Ù…Ø¤Ù‚ØªÙ‹Ø§ ÙƒØ¨ÙŠØ§Ù†Ø§Øª ÙˆØ±ÙˆØ§Ø¨Ø· Ø¯Ø§Ø®Ù„ Firestore Ù„Ø­ÙŠÙ† ØªÙØ¹ÙŠÙ„ Ø§Ù„ØªØ®Ø²ÙŠÙ†.'
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
                                    ? 'ØµÙˆØ± Ø§Ù„Ù…Ø±ÙƒØ² Ø§Ù„Ø£Ø³Ø§Ø³ÙŠØ©'
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
                                    ? 'Ø£Ø¯Ø®Ù„ Ø±ÙˆØ§Ø¨Ø· Ø§Ù„ØµÙˆØ± Ø§Ù„Ø£Ø±Ø¨Ø¹ Ø§Ù„Ø£Ø³Ø§Ø³ÙŠØ© Ù…Ø¤Ù‚ØªÙ‹Ø§. Ù„Ø§Ø­Ù‚Ù‹Ø§ Ø³Ù†Ø­ÙˆÙ‘Ù„Ù‡Ø§ Ù„Ø±ÙØ¹ Ù…Ø¨Ø§Ø´Ø±.'
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
                                      ? 'Ø±Ø§Ø¨Ø· ØµÙˆØ±Ø© Ø§Ù„ÙˆØ§Ø¬Ù‡Ø©'
                                      : 'Front image URL',
                                  icon: Icons.storefront_outlined,
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _receptionImageController,
                                decoration: InputDecoration(
                                  labelText: isArabic
                                      ? 'Ø±Ø§Ø¨Ø· ØµÙˆØ±Ø© Ø§Ù„Ø§Ø³ØªÙ‚Ø¨Ø§Ù„'
                                      : 'Reception image URL',
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _inside1ImageController,
                                decoration: InputDecoration(
                                  labelText: isArabic
                                      ? 'Ø±Ø§Ø¨Ø· Ø§Ù„ØµÙˆØ±Ø© Ø§Ù„Ø¯Ø§Ø®Ù„ÙŠØ© 1'
                                      : 'Inside image 1 URL',
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _inside2ImageController,
                                decoration: InputDecoration(
                                  labelText: isArabic
                                      ? 'Ø±Ø§Ø¨Ø· Ø§Ù„ØµÙˆØ±Ø© Ø§Ù„Ø¯Ø§Ø®Ù„ÙŠØ© 2'
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
                                            ? 'Ø¬Ø§Ø±Ù Ø§Ù„Ø­ÙØ¸...'
                                            : 'Saving...')
                                        : (isArabic
                                            ? 'Ø­ÙØ¸ Ø§Ù„ØµÙˆØ± Ø§Ù„Ø£Ø±Ø¨Ø¹'
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
                                    ? 'Ø±ÙØ¹ Ø§Ù„ÙˆØ«Ø§Ø¦Ù‚ Ø§Ù„Ù…Ù†Ø¸Ù…Ø©'
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
                                    ? 'Ø£Ø¯Ø®Ù„ Ø¨ÙŠØ§Ù†Ø§Øª Ø§Ù„ÙˆØ«ÙŠÙ‚Ø© ÙŠØ¯ÙˆÙŠÙ‹Ø§ Ù…Ø¤Ù‚ØªÙ‹Ø§: Ø§Ù„Ù†ÙˆØ¹ØŒ Ø§Ø³Ù… Ø§Ù„Ù…Ù„ÙØŒ ÙˆØ§Ù„Ø±Ø§Ø¨Ø· Ø¥Ù† ÙˆØ¬Ø¯.'
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
                                      ? 'Ù†ÙˆØ¹ Ø§Ù„ÙˆØ«ÙŠÙ‚Ø© *'
                                      : 'Document type *',
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _docFileNameController,
                                decoration: InputDecoration(
                                  labelText:
                                      isArabic ? 'Ø§Ø³Ù… Ø§Ù„Ù…Ù„Ù' : 'File name',
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _docUrlController,
                                decoration: InputDecoration(
                                  labelText: isArabic
                                      ? 'Ø±Ø§Ø¨Ø· Ø§Ù„Ù…Ù„Ù (Ø§Ø®ØªÙŠØ§Ø±ÙŠ)'
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
                                      ? 'ØªÙØ±Ø³Ù„ ÙƒÙ„ ÙˆØ«ÙŠÙ‚Ø© Ø¬Ø¯ÙŠØ¯Ø© Ø¨Ø­Ø§Ù„Ø© "Ø¨Ø§Ù†ØªØ¸Ø§Ø± Ø§Ù„Ù…Ø±Ø§Ø¬Ø¹Ø©"ØŒ ÙˆØªÙ‚ÙˆÙ… Ø§Ù„Ø¥Ø¯Ø§Ø±Ø© ÙÙ‚Ø· Ø¨ØªØ­Ø¯ÙŠØ« Ø­Ø§Ù„Ø© Ø§Ù„Ù…Ø±Ø§Ø¬Ø¹Ø© Ù„Ø§Ø­Ù‚Ù‹Ø§.'
                                      : 'Each new document is sent as "Pending review", and only admin updates the review status later.',
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
                              TextField(
                                controller: _docReviewNoteController,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  labelText: isArabic
                                      ? 'Ù…Ù„Ø§Ø­Ø¸Ø© Ø¥Ø¶Ø§ÙÙŠØ©'
                                      : 'Additional note',
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 14),
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
                                            ? 'Ø¬Ø§Ø±Ù Ø§Ù„Ø¥Ø¶Ø§ÙØ©...'
                                            : 'Adding...')
                                        : (isArabic
                                            ? 'Ø¥Ø¶Ø§ÙØ© ÙˆØ«ÙŠÙ‚Ø©'
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
                                      ? 'Ø§Ù„ÙˆØ«Ø§Ø¦Ù‚ Ø§Ù„Ø­Ø§Ù„ÙŠØ©'
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
                                      (doc['status'] ?? 'pending').toString();
                                  final reviewNote = (doc['reviewNote'] ?? '')
                                      .toString()
                                      .trim();

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
                                                  ? 'ÙˆØ«ÙŠÙ‚Ø©'
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
                                                ? 'Ø§Ù„Ù…Ù„Ù: $fileName'
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
                                        if (reviewNote.isNotEmpty) ...[
                                          const SizedBox(height: 6),
                                          Text(
                                            isArabic
                                                ? 'Ø§Ù„Ù…Ù„Ø§Ø­Ø¸Ø©: $reviewNote'
                                                : 'Note: $reviewNote',
                                          ),
                                        ],
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
                                                isArabic ? 'Ø­Ø°Ù' : 'Delete'),
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
                            label: Text(isArabic ? 'ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø®Ø±ÙˆØ¬' : 'Logout'),
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
        'status': 'pending',
        'adminDecision': '',
        'adminNote': '',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'ØªÙ… Ø¥Ø±Ø³Ø§Ù„ Ø·Ù„Ø¨ ØªØ¹Ø¯ÙŠÙ„ Ø¨ÙŠØ§Ù†Ø§Øª Ø§Ù„Ù…Ø±ÙƒØ² Ù„Ù„Ø¥Ø¯Ø§Ø±Ø©'
                : 'Center data change request sent to admin',
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
            isArabic ? 'Ø·Ù„Ø¨Ø§Øª Ø§Ù„ØªØ¹Ø¯ÙŠÙ„ Ø§Ù„Ø³Ø§Ø¨Ù‚Ø©' : 'Previous change requests',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 12),
          if (docs.isEmpty)
            Text(isArabic
                ? 'Ù„Ø§ ØªÙˆØ¬Ø¯ Ø·Ù„Ø¨Ø§Øª ØªØ¹Ø¯ÙŠÙ„ Ø­ØªÙ‰ Ø§Ù„Ø¢Ù†'
                : 'No change requests yet')
          else
            ...docs.map((doc) {
              final data = doc.data();
              final status = (data['status'] ?? 'pending').toString();
              final note = (data['adminNote'] ?? '').toString().trim();
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
                      status == 'approved'
                          ? (isArabic ? 'Ù…Ù‚Ø¨ÙˆÙ„' : 'Approved')
                          : status == 'rejected'
                              ? (isArabic ? 'Ù…Ø±ÙÙˆØ¶' : 'Rejected')
                              : (isArabic ? 'Ù‚ÙŠØ¯ Ø§Ù„Ù…Ø±Ø§Ø¬Ø¹Ø©' : 'Pending review'),
                      style: TextStyle(
                        color: scheme.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (note.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(isArabic
                          ? 'Ù…Ù„Ø§Ø­Ø¸Ø© Ø§Ù„Ø¥Ø¯Ø§Ø±Ø©: $note'
                          : 'Admin note: $note'),
                    ],
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
            isArabic ? 'Ø·Ù„Ø¨ ØªØ¹Ø¯ÙŠÙ„ Ø¨ÙŠØ§Ù†Ø§Øª Ø§Ù„Ù…Ø±ÙƒØ²' : 'Center data change request',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            isArabic
                ? 'Ø¹Ø¯Ù‘Ù„ Ø§Ù„Ø¨ÙŠØ§Ù†Ø§Øª Ù‡Ù†Ø§ Ø«Ù… Ø£Ø±Ø³Ù„Ù‡Ø§ Ù„Ù„Ø¥Ø¯Ø§Ø±Ø©. Ø³ÙŠØ¨Ù‚Ù‰ Ø§Ù„Ø·Ù„Ø¨ Ù‚ÙŠØ¯ Ø§Ù„Ù…Ø±Ø§Ø¬Ø¹Ø© Ø­ØªÙ‰ ÙŠØ¹ØªÙ…Ø¯.'
                : 'Update the fields here, then send them to admin for review.',
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
              label: isArabic ? 'Ø§Ø³Ù… Ø§Ù„Ù…Ø±ÙƒØ²' : 'Center name',
              icon: Icons.business_outlined,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _managerNameController,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            decoration: appInputDecoration(
              context: context,
              label: isArabic ? 'Ø§Ø³Ù… Ø§Ù„Ù…Ø³Ø¤ÙˆÙ„' : 'Manager name',
              icon: Icons.badge_outlined,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _cityController,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            decoration: appInputDecoration(
              context: context,
              label: isArabic ? 'Ø§Ù„Ù…Ø¯ÙŠÙ†Ø©' : 'City',
              icon: Icons.location_city_outlined,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _addressController,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            decoration: appInputDecoration(
              context: context,
              label: isArabic ? 'Ø§Ù„Ø¹Ù†ÙˆØ§Ù†' : 'Address',
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
              label: isArabic ? 'ÙˆØµÙ Ø§Ù„Ù…Ø±ÙƒØ²' : 'Center description',
              icon: Icons.notes_outlined,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isArabic
                ? 'Ø·Ù„Ø¨ Ø§Ø³ØªØ¨Ø¯Ø§Ù„ ØµÙˆØ± Ø§Ù„Ù…Ø±ÙƒØ²'
                : 'Center image replacement request',
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
                  ? 'Ø±Ø§Ø¨Ø· ØµÙˆØ±Ø© ÙˆØ§Ø¬Ù‡Ø© Ø¨Ø¯ÙŠÙ„Ø©'
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
                  ? 'Ø±Ø§Ø¨Ø· ØµÙˆØ±Ø© Ø§Ø³ØªÙ‚Ø¨Ø§Ù„ Ø¨Ø¯ÙŠÙ„Ø©'
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
                  ? 'Ø±Ø§Ø¨Ø· ØµÙˆØ±Ø© Ø¯Ø§Ø®Ù„ÙŠØ© Ø¨Ø¯ÙŠÙ„Ø© 1'
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
                  ? 'Ø±Ø§Ø¨Ø· ØµÙˆØ±Ø© Ø¯Ø§Ø®Ù„ÙŠØ© Ø¨Ø¯ÙŠÙ„Ø© 2'
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
                    ? (isArabic ? 'Ø¬Ø§Ø±Ù Ø§Ù„Ø¥Ø±Ø³Ø§Ù„...' : 'Sending...')
                    : (isArabic
                        ? 'Ø¥Ø±Ø³Ø§Ù„ Ø·Ù„Ø¨ ØªØ¹Ø¯ÙŠÙ„ Ø§Ù„Ø¨ÙŠØ§Ù†Ø§Øª'
                        : 'Send data change request'),
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
          title: isArabic ? 'ØªØ¹Ø¯ÙŠÙ„ Ø¨ÙŠØ§Ù†Ø§ØªÙŠ' : 'Edit my data',
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
                      (doc) => (doc.data()['status'] ?? 'pending') == 'pending',
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
                                  ? 'ÙŠÙˆØ¬Ø¯ Ø·Ù„Ø¨ ØªØ¹Ø¯ÙŠÙ„ Ø¨ÙŠØ§Ù†Ø§Øª Ù…Ø±ÙƒØ² Ù‚ÙŠØ¯ Ø§Ù„Ù…Ø±Ø§Ø¬Ø¹Ø©. ÙŠÙ…ÙƒÙ†Ùƒ Ù…ØªØ§Ø¨Ø¹Ø© Ø­Ø§Ù„ØªÙ‡ Ù‡Ù†Ø§.'
                                  : 'A center data change request is pending. You can track it here.',
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

