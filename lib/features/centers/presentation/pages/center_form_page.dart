import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterprojects/features/centers/data/models/center_model.dart';
import 'package:flutterprojects/features/centers/data/models/center_pricing.dart';
import 'package:flutterprojects/features/centers/data/services/centers_firestore_service.dart';

class CenterFormPage extends StatefulWidget {
  final CenterModel? initial;

  const CenterFormPage({
    super.key,
    this.initial,
  });

  @override
  State<CenterFormPage> createState() => _CenterFormPageState();
}

class _CenterFormPageState extends State<CenterFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _service = CentersFirestoreService();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _categoryCtrl;
  late final TextEditingController _categoryLabelArCtrl;
  late final TextEditingController _categoryLabelEnCtrl;
  late final TextEditingController _cityCtrl;
  late final TextEditingController _areaCtrl;
  late final TextEditingController _descriptionCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _whatsappCtrl;
  late final TextEditingController _addressCtrl;
  late final TextEditingController _servicesCtrl;
  late final TextEditingController _sortOrderCtrl;
  late final TextEditingController _imageUrlCtrl;
  late final TextEditingController _coverImageUrlCtrl;
  late final TextEditingController _coverImageAssetCtrl;
  late final TextEditingController _gallery1Ctrl;
  late final TextEditingController _gallery2Ctrl;
  late final TextEditingController _gallery3Ctrl;
  late final TextEditingController _gallery4Ctrl;
  late final TextEditingController _galleryAsset1Ctrl;
  late final TextEditingController _galleryAsset2Ctrl;
  late final TextEditingController _galleryAsset3Ctrl;
  late final TextEditingController _galleryAsset4Ctrl;
  late final TextEditingController _documentsCtrl;

  bool _isActive = true;
  bool _saving = false;

  static const Map<String, String> _categoryLabelArByKey = {
    'recovery': 'مراكز التعافي',
    'detox': 'مراكز سحب السموم',
    'hospitals': 'المستشفيات',
    'special_needs': 'مراكز رعاية ذوي الاحتياجات الخاصة',
  };

  @override
  void initState() {
    super.initState();
    final c = widget.initial;

    _nameCtrl = TextEditingController(text: c?.name ?? '');
    _categoryCtrl = TextEditingController(text: c?.category ?? '');
    _categoryLabelArCtrl = TextEditingController(
      text: c?.categoryLabelAr ??
          (c?.category != null
              ? (_categoryLabelArByKey[c!.category] ?? '')
              : ''),
    );
    _categoryLabelEnCtrl =
        TextEditingController(text: c?.categoryLabelEn ?? '');
    _cityCtrl = TextEditingController(text: c?.city ?? '');
    _areaCtrl = TextEditingController(text: c?.area ?? '');
    _descriptionCtrl = TextEditingController(text: c?.description ?? '');
    _phoneCtrl = TextEditingController(text: c?.phone ?? '');
    _whatsappCtrl = TextEditingController(text: c?.whatsapp ?? '');
    _addressCtrl = TextEditingController(text: c?.address ?? '');
    _servicesCtrl = TextEditingController(text: (c?.services ?? []).join(', '));
    _sortOrderCtrl =
        TextEditingController(text: (c?.sortOrder ?? 0).toString());
    _imageUrlCtrl = TextEditingController(text: c?.imageUrl ?? '');
    _coverImageUrlCtrl = TextEditingController(text: c?.coverImageUrl ?? '');
    _coverImageAssetCtrl =
        TextEditingController(text: c?.coverImageAsset ?? '');

    final galleryUrls = (c?.galleryImageUrls ?? const <String>[]).toList();
    String urlAt(int index) =>
        index < galleryUrls.length ? galleryUrls[index] : '';
    _gallery1Ctrl = TextEditingController(text: urlAt(0));
    _gallery2Ctrl = TextEditingController(text: urlAt(1));
    _gallery3Ctrl = TextEditingController(text: urlAt(2));
    _gallery4Ctrl = TextEditingController(text: urlAt(3));

    final galleryAssets = (c?.galleryImageAssets ?? const <String>[]).toList();
    String assetAt(int index) =>
        index < galleryAssets.length ? galleryAssets[index] : '';
    _galleryAsset1Ctrl = TextEditingController(text: assetAt(0));
    _galleryAsset2Ctrl = TextEditingController(text: assetAt(1));
    _galleryAsset3Ctrl = TextEditingController(text: assetAt(2));
    _galleryAsset4Ctrl = TextEditingController(text: assetAt(3));

    _documentsCtrl = TextEditingController(
      text: (c?.documents ?? const [])
          .map((d) => '${d.name} | ${d.type} | ${d.url}')
          .join('\n'),
    );

    _isActive = c?.isActive ?? true;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _categoryCtrl.dispose();
    _categoryLabelArCtrl.dispose();
    _categoryLabelEnCtrl.dispose();
    _cityCtrl.dispose();
    _areaCtrl.dispose();
    _descriptionCtrl.dispose();
    _phoneCtrl.dispose();
    _whatsappCtrl.dispose();
    _addressCtrl.dispose();
    _servicesCtrl.dispose();
    _sortOrderCtrl.dispose();
    _imageUrlCtrl.dispose();
    _coverImageUrlCtrl.dispose();
    _coverImageAssetCtrl.dispose();
    _gallery1Ctrl.dispose();
    _gallery2Ctrl.dispose();
    _gallery3Ctrl.dispose();
    _gallery4Ctrl.dispose();
    _galleryAsset1Ctrl.dispose();
    _galleryAsset2Ctrl.dispose();
    _galleryAsset3Ctrl.dispose();
    _galleryAsset4Ctrl.dispose();
    _documentsCtrl.dispose();
    super.dispose();
  }

  String? _required(String? v) {
    final t = (v ?? '').trim();
    if (t.isEmpty) return 'هذا الحقل مطلوب';
    return null;
  }

  List<String> _parseServices(String raw) {
    return raw
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  int _parseSortOrder(String raw) {
    return int.tryParse(raw.trim()) ?? 0;
  }

  List<String> _parseGalleryUrls() {
    final raw = <String>[
      _gallery1Ctrl.text,
      _gallery2Ctrl.text,
      _gallery3Ctrl.text,
      _gallery4Ctrl.text,
    ];
    return raw.map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  }

  List<String> _parseGalleryAssets() {
    final raw = <String>[
      _galleryAsset1Ctrl.text,
      _galleryAsset2Ctrl.text,
      _galleryAsset3Ctrl.text,
      _galleryAsset4Ctrl.text,
    ];
    return raw.map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  }

  List<CenterDocument> _parseDocuments(String raw) {
    final lines =
        raw.split('\n').map((e) => e.trim()).where((e) => e.isNotEmpty);
    final out = <CenterDocument>[];

    for (final line in lines) {
      final parts = line
          .split('|')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
      if (parts.length < 3) continue;
      final name = parts[0];
      final type = parts[1];
      final url = parts.sublist(2).join(' | ');
      if (name.isEmpty || type.isEmpty || url.isEmpty) continue;
      out.add(CenterDocument(name: name, type: type, url: url));
    }

    return out;
  }

  Future<void> _save() async {
    if (_saving) return;
    final ok = _formKey.currentState?.validate() == true;
    if (!ok) return;

    setState(() => _saving = true);
    final messenger = ScaffoldMessenger.of(context);

    try {
      final existing = widget.initial;
      final id = existing?.id ?? '';

      final model = CenterModel(
        id: id,
        name: _nameCtrl.text.trim(),
        category: _categoryCtrl.text.trim(),
        categoryLabelAr: _categoryLabelArCtrl.text.trim(),
        categoryLabelEn: _categoryLabelEnCtrl.text.trim(),
        city: _cityCtrl.text.trim(),
        area: _areaCtrl.text.trim(),
        description: _descriptionCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
        whatsapp: _whatsappCtrl.text.trim(),
        address: _addressCtrl.text.trim(),
        services: _parseServices(_servicesCtrl.text),
        isActive: _isActive,
        sortOrder: _parseSortOrder(_sortOrderCtrl.text),
        imageUrl: _imageUrlCtrl.text.trim(),
        coverImageUrl: _coverImageUrlCtrl.text.trim(),
        coverImageAsset: _coverImageAssetCtrl.text.trim(),
        galleryImageUrls: _parseGalleryUrls(),
        galleryImageAssets: _parseGalleryAssets(),
        documents: _parseDocuments(_documentsCtrl.text),
        accommodationCosts:
            existing?.accommodationCosts ?? defaultAccommodationCostItems(),
        autismCareCosts:
            existing?.autismCareCosts ?? defaultAutismCareCostItems(),
        capabilities:
            existing?.capabilities ?? const CenterCapabilityFlags(),
        createdAt: existing?.createdAt,
        updatedAt: existing?.updatedAt,
      );

      if (existing == null) {
        await _service.createCenter(model);
        if (!mounted) return;
        messenger
            .showSnackBar(const SnackBar(content: Text('تمت إضافة المركز')));
      } else {
        await _service.updateCenter(model);
        if (!mounted) return;
        messenger
            .showSnackBar(const SnackBar(content: Text('تم حفظ التعديلات')));
      }

      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(SnackBar(content: Text('فشل الحفظ: $e')));
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        textAlign: TextAlign.right,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initial != null;
    final scheme = Theme.of(context).colorScheme;

    final knownCategories = <String>{
      ..._categoryLabelArByKey.keys,
      if (_categoryCtrl.text.trim().isNotEmpty) _categoryCtrl.text.trim(),
    }.toList()
      ..sort();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isEdit ? 'تعديل مركز' : 'إضافة مركز'),
          actions: [
            TextButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text(
                      'حفظ',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(18),
                  border:
                      Border.all(color: scheme.outline.withValues(alpha: 0.12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _sectionTitle('البيانات الأساسية'),
                    TextFormField(
                      controller: _nameCtrl,
                      textDirection: TextDirection.rtl,
                      decoration: const InputDecoration(
                        labelText: 'اسم المركز *',
                        border: OutlineInputBorder(),
                      ),
                      validator: _required,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _categoryCtrl.text.trim().isEmpty
                          ? null
                          : _categoryCtrl.text.trim(),
                      decoration: const InputDecoration(
                        labelText: 'الفئة (category) *',
                        border: OutlineInputBorder(),
                      ),
                      items: knownCategories
                          .map(
                            (k) => DropdownMenuItem(
                              value: k,
                              child: Text(
                                _categoryLabelArByKey[k] ?? k,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        if (v == null) return;
                        setState(() {
                          _categoryCtrl.text = v;
                          final ar = _categoryLabelArByKey[v];
                          if (ar != null &&
                              _categoryLabelArCtrl.text.trim().isEmpty) {
                            _categoryLabelArCtrl.text = ar;
                          }
                        });
                      },
                      validator: (v) => _required(v),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _categoryLabelArCtrl,
                      textDirection: TextDirection.rtl,
                      decoration: const InputDecoration(
                        labelText: 'اسم الفئة بالعربية *',
                        border: OutlineInputBorder(),
                      ),
                      validator: _required,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _categoryLabelEnCtrl,
                      textDirection: TextDirection.ltr,
                      decoration: const InputDecoration(
                        labelText: 'Category label (EN) *',
                        border: OutlineInputBorder(),
                      ),
                      validator: _required,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _cityCtrl,
                            textDirection: TextDirection.rtl,
                            decoration: const InputDecoration(
                              labelText: 'المدينة *',
                              border: OutlineInputBorder(),
                            ),
                            validator: _required,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _areaCtrl,
                            textDirection: TextDirection.rtl,
                            decoration: const InputDecoration(
                              labelText: 'المنطقة / الحي',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _descriptionCtrl,
                      textDirection: TextDirection.rtl,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'الوصف',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(18),
                  border:
                      Border.all(color: scheme.outline.withValues(alpha: 0.12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _sectionTitle('التواصل والموقع'),
                    TextFormField(
                      controller: _phoneCtrl,
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'رقم الهاتف',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _whatsappCtrl,
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'واتساب (رقم أو رابط)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _addressCtrl,
                      textDirection: TextDirection.rtl,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'العنوان',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _imageUrlCtrl,
                      textDirection: TextDirection.ltr,
                      decoration: const InputDecoration(
                        labelText: 'صورة قديمة (imageUrl)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _coverImageUrlCtrl,
                      textDirection: TextDirection.ltr,
                      decoration: const InputDecoration(
                        labelText: 'صورة الغلاف القديمة (coverImageUrl)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _coverImageAssetCtrl,
                      textDirection: TextDirection.ltr,
                      decoration: const InputDecoration(
                        labelText: 'صورة الغلاف المحلية (coverImageAsset)',
                        hintText:
                            'assets/c6_library/hero/center_placeholder.png',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(18),
                  border:
                      Border.all(color: scheme.outline.withValues(alpha: 0.12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _sectionTitle('الوسائط'),
                    TextFormField(
                      controller: _gallery1Ctrl,
                      textDirection: TextDirection.ltr,
                      decoration: const InputDecoration(
                        labelText: 'رابط صورة المعرض 1',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _gallery2Ctrl,
                      textDirection: TextDirection.ltr,
                      decoration: const InputDecoration(
                        labelText: 'رابط صورة المعرض 2',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _gallery3Ctrl,
                      textDirection: TextDirection.ltr,
                      decoration: const InputDecoration(
                        labelText: 'رابط صورة المعرض 3',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _gallery4Ctrl,
                      textDirection: TextDirection.ltr,
                      decoration: const InputDecoration(
                        labelText: 'رابط صورة المعرض 4',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _galleryAsset1Ctrl,
                      textDirection: TextDirection.ltr,
                      decoration: const InputDecoration(
                        labelText: 'صورة معرض محلية 1',
                        hintText:
                            'assets/c6_library/hero/center_placeholder.png',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _galleryAsset2Ctrl,
                      textDirection: TextDirection.ltr,
                      decoration: const InputDecoration(
                        labelText: 'صورة معرض محلية 2',
                        hintText:
                            'assets/c6_library/hero/center_placeholder.png',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _galleryAsset3Ctrl,
                      textDirection: TextDirection.ltr,
                      decoration: const InputDecoration(
                        labelText: 'صورة معرض محلية 3',
                        hintText:
                            'assets/c6_library/hero/center_placeholder.png',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _galleryAsset4Ctrl,
                      textDirection: TextDirection.ltr,
                      decoration: const InputDecoration(
                        labelText: 'صورة معرض محلية 4',
                        hintText:
                            'assets/c6_library/hero/center_placeholder.png',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _documentsCtrl,
                      textDirection: TextDirection.ltr,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'مستندات (سطر لكل مستند)',
                        hintText:
                            'الاسم | النوع | الرابط\nمثال: ملف PDF | pdf | https://example.com/file.pdf',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'اكتب كل مستند في سطر بالشكل: الاسم | النوع | الرابط',
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onSurface.withValues(alpha: 0.65)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(18),
                  border:
                      Border.all(color: scheme.outline.withValues(alpha: 0.12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _sectionTitle('إعدادات العرض'),
                    SwitchListTile(
                      value: _isActive,
                      onChanged:
                          _saving ? null : (v) => setState(() => _isActive = v),
                      title: const Text('مفعّل (isActive)'),
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _sortOrderCtrl,
                      textDirection: TextDirection.ltr,
                      decoration: const InputDecoration(
                        labelText: 'ترتيب العرض (sortOrder) *',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: _required,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _servicesCtrl,
                      textDirection: TextDirection.rtl,
                      decoration: const InputDecoration(
                        labelText: 'الخدمات (افصل بفواصل , )',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'مثال: جلسات فردية, برنامج تعافي, دعم أسري',
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onSurface.withValues(alpha: 0.65)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              FilledButton(
                onPressed: _saving ? null : _save,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    _saving ? 'جارٍ الحفظ…' : 'حفظ',
                    style: const TextStyle(fontWeight: FontWeight.w800),
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
