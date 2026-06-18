import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_smile_os/app/router/routes.dart';
import 'package:mental_smile_os/features/centers/data/models/center_pricing.dart';
import 'package:mental_smile_os/features/web_registration/data/web_registration_draft_store.dart';
import 'package:mental_smile_os/features/web_registration/presentation/web_registration_background.dart';
import 'package:mental_smile_os/l10n/app_localizations.dart';

class WebCenterPricingPage extends StatefulWidget {
  const WebCenterPricingPage({super.key});

  @override
  State<WebCenterPricingPage> createState() => _WebCenterPricingPageState();
}

class _WebCenterPricingPageState extends State<WebCenterPricingPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _accommodationPriceControllers = {};
  final Map<String, TextEditingController> _autismPriceControllers = {};
  late List<AccommodationCostItem> _accommodationCosts;
  late List<AutismCareCostItem> _autismCareCosts;
  CenterCapabilityFlags _capabilities = const CenterCapabilityFlags();
  bool _isSaving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _accommodationCosts = defaultAccommodationCostItems();
    _autismCareCosts = defaultAutismCareCostItems();
    for (final item in _accommodationCosts) {
      _accommodationPriceControllers[item.key] = TextEditingController();
    }
    for (final item in _autismCareCosts) {
      _autismPriceControllers[item.key] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final controller in _accommodationPriceControllers.values) {
      controller.dispose();
    }
    for (final controller in _autismPriceControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  double _readPrice(TextEditingController? controller) {
    return double.tryParse((controller?.text ?? '').trim()) ?? 0;
  }

  List<AccommodationCostItem> _currentAccommodationCosts() {
    return _accommodationCosts
        .map(
          (item) => item.copyWith(
            price: _readPrice(_accommodationPriceControllers[item.key]),
          ),
        )
        .toList();
  }

  List<AutismCareCostItem> _currentAutismCareCosts() {
    return _autismCareCosts
        .map(
          (item) => item.copyWith(
            price: _readPrice(_autismPriceControllers[item.key]),
          ),
        )
        .toList();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context)!;
    final uid = FirebaseAuth.instance.currentUser?.uid ??
        WebRegistrationDraftStore.centerUid;
    if (uid == null) {
      setState(() => _error = l10n.webCenterPleaseRegisterBeforeSaving);
      return;
    }

    setState(() {
      _isSaving = true;
      _error = null;
    });

    try {
      await FirebaseFirestore.instance.collection('centers').doc(uid).update({
        'accommodationCosts':
            _currentAccommodationCosts().map((item) => item.toMap()).toList(),
        'autismCareCosts':
            _currentAutismCareCosts().map((item) => item.toMap()).toList(),
        'centerCapabilities': _capabilities.toMap(),
        'signalSchemaVersion': 'center_signals_v1',
        'pricingReady': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(Routes.webCenterDocuments);
    } catch (_) {
      if (mounted) setState(() => _error = l10n.webCenterSavePricingFailed);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.black,
      body: webRegistrationCompactFormTheme(
        context,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              webRegistrationBackgroundAsset(
                context,
                roleFolder: 'centers',
                fileName: 'centers_step_4_pricing.png',
              ),
              fit: BoxFit.contain,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    20,
                    20,
                    webRegistrationFormBottomPadding(context),
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Card(
                      elevation: 6,
                      color: webRegistrationPanelNavy.withValues(alpha: 0.18),
                      shadowColor: Colors.black.withValues(alpha: 0.32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(
                          color: webRegistrationBorderTurquoise.withValues(
                              alpha: 0.28),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 16),
                              const Text(
                                'Service disclosure step: prices and capabilities are center-declared readiness signals.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  height: 1.35,
                                ),
                              ),
                              _capabilityTile(
                                isArabic
                                    ? 'مناسب للأطفال'
                                    : 'Suitable for children',
                                _capabilities.supportsChildren,
                                (value) {
                                  setState(() {
                                    _capabilities = _capabilities.copyWith(
                                      supportsChildren: value,
                                    );
                                  });
                                },
                              ),
                              _capabilityTile(
                                isArabic
                                    ? 'مناسب للأسر'
                                    : 'Suitable for families',
                                _capabilities.supportsFamilies,
                                (value) {
                                  setState(() {
                                    _capabilities = _capabilities.copyWith(
                                      supportsFamilies: value,
                                    );
                                  });
                                },
                              ),
                              _capabilityTile(
                                isArabic
                                    ? 'يدعم خدمات مرتبطة بالتعافي'
                                    : 'Supports recovery-related services',
                                _capabilities.supportsRecovery,
                                (value) {
                                  setState(() {
                                    _capabilities = _capabilities.copyWith(
                                      supportsRecovery: value,
                                    );
                                  });
                                },
                              ),
                              _capabilityTile(
                                isArabic
                                    ? 'يدعم صعوبات السمع'
                                    : 'Supports hearing difficulties',
                                _capabilities.supportsHearingSupport,
                                (value) {
                                  setState(() {
                                    _capabilities = _capabilities.copyWith(
                                      supportsHearingSupport: value,
                                    );
                                  });
                                },
                              ),
                              _capabilityTile(
                                isArabic
                                    ? 'يدعم صعوبات النطق'
                                    : 'Supports speech difficulties',
                                _capabilities.supportsSpeechSupport,
                                (value) {
                                  setState(() {
                                    _capabilities = _capabilities.copyWith(
                                      supportsSpeechSupport: value,
                                    );
                                  });
                                },
                              ),
                              _capabilityTile(
                                isArabic
                                    ? 'يدعم احتياجات الوصول والإتاحة'
                                    : 'Supports accessibility needs',
                                _capabilities.supportsAccessibilitySupport,
                                (value) {
                                  setState(() {
                                    _capabilities = _capabilities.copyWith(
                                      supportsAccessibilitySupport: value,
                                    );
                                  });
                                },
                              ),
                              _capabilityTile(
                                isArabic
                                    ? 'يدعم برامج الكوتشينج'
                                    : 'Supports coaching programs',
                                _capabilities.supportsCoachingPrograms,
                                (value) {
                                  setState(() {
                                    _capabilities = _capabilities.copyWith(
                                      supportsCoachingPrograms: value,
                                    );
                                  });
                                },
                              ),
                              _capabilityTile(
                                isArabic
                                    ? 'يدعم البرامج التعليمية'
                                    : 'Supports education programs',
                                _capabilities.supportsEducationPrograms,
                                (value) {
                                  setState(() {
                                    _capabilities = _capabilities.copyWith(
                                      supportsEducationPrograms: value,
                                    );
                                  });
                                },
                              ),
                              const SizedBox(height: 12),
                              TextButton(
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(Routes.portalHome),
                                child: Text(
                                  isArabic
                                      ? 'العودة إلى بوابة Mental Smile'
                                      : 'Back to Mental Smile Portal',
                                ),
                              ),
                              const SizedBox(height: 8),
                              _capabilityTile(
                                isArabic
                                    ? 'يدعم حالات الإدمان المصابة بفيروس نقص المناعة'
                                    : 'Supports addiction cases with HIV',
                                _capabilities.supportsAddictionCasesWithHiv,
                                (value) {
                                  setState(() {
                                    _capabilities = _capabilities.copyWith(
                                      supportsAddictionCasesWithHiv: value,
                                    );
                                  });
                                },
                              ),
                              _capabilityTile(
                                isArabic
                                    ? 'يقبل حالات الإدمان'
                                    : 'Accepts addiction cases',
                                _capabilities.acceptsAddictionCases,
                                (value) {
                                  setState(() {
                                    _capabilities = _capabilities.copyWith(
                                      acceptsAddictionCases: value,
                                    );
                                  });
                                },
                              ),
                              _capabilityTile(
                                isArabic
                                    ? 'يقبل الحالات النفسية بدون إدمان'
                                    : 'Accepts psychiatric cases without addiction',
                                _capabilities
                                    .acceptsPsychiatricCasesWithoutAddiction,
                                (value) {
                                  setState(() {
                                    _capabilities = _capabilities.copyWith(
                                      acceptsPsychiatricCasesWithoutAddiction:
                                          value,
                                    );
                                  });
                                },
                              ),
                              const SizedBox(height: 12),
                              ..._accommodationCosts.map(
                                (item) => _accommodationTile(context, item),
                              ),
                              const SizedBox(height: 8),
                              ..._autismCareCosts.map(
                                (item) => _autismTile(context, item),
                              ),
                              if (_error != null) ...[
                                const SizedBox(height: 10),
                                Text(
                                  _error!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                height: 44,
                                child: ElevatedButton(
                                  onPressed: _isSaving ? null : _save,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFE8C878),
                                    foregroundColor: const Color(0xFF17100A),
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  child: _isSaving
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Color(0xFF17100A),
                                          ),
                                        )
                                      : Text(l10n.webCenterNextDocuments),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _capabilityTile(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return CheckboxListTile(
      value: value,
      onChanged: _isSaving ? null : (next) => onChanged(next ?? false),
      title: Text(title),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget _accommodationTile(BuildContext context, AccommodationCostItem item) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return ExpansionTile(
      title: Text(isArabic ? item.labelAr : item.labelEn),
      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        CheckboxListTile(
          value: item.enabled,
          onChanged: _isSaving
              ? null
              : (value) {
                  setState(() {
                    _accommodationCosts = _accommodationCosts
                        .map((current) => current.key == item.key
                            ? current.copyWith(enabled: value ?? false)
                            : current)
                        .toList();
                  });
                },
          title: Text(l10n.webCenterEnabled),
          controlAffinity: ListTileControlAffinity.leading,
        ),
        _priceField(
          _accommodationPriceControllers[item.key],
          l10n.webCenterPrice,
        ),
        const SizedBox(height: 12),
        _dropdown(
          value: item.pricingUnit.isEmpty ? null : item.pricingUnit,
          label: l10n.webCenterPricingUnit,
          items: const ['day', 'week', 'month'],
          onChanged: (value) {
            setState(() {
              _accommodationCosts = _accommodationCosts
                  .map((current) => current.key == item.key
                      ? current.copyWith(pricingUnit: value ?? '')
                      : current)
                  .toList();
            });
          },
        ),
        const SizedBox(height: 12),
        _dropdown(
          value: item.acMode.isEmpty ? null : item.acMode,
          label: l10n.webCenterAcMode,
          items: const ['included', 'extra', 'not_available'],
          onChanged: (value) {
            setState(() {
              _accommodationCosts = _accommodationCosts
                  .map((current) => current.key == item.key
                      ? current.copyWith(acMode: value ?? '')
                      : current)
                  .toList();
            });
          },
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _accommodationChip(
              item,
              isArabic ? 'أدوية' : 'Medication',
              item.includesMedication,
              (value) => item.copyWith(includesMedication: value),
            ),
            _accommodationChip(
              item,
              isArabic ? 'وجبات' : 'Meals',
              item.includesMeals,
              (value) => item.copyWith(includesMeals: value),
            ),
            _accommodationChip(
              item,
              isArabic ? 'أنشطة خارجية' : 'Outdoor',
              item.includesOutdoorActivities,
              (value) => item.copyWith(includesOutdoorActivities: value),
            ),
            _accommodationChip(
              item,
              isArabic ? 'تحاليل' : 'Tests',
              item.includesRequiredTests,
              (value) => item.copyWith(includesRequiredTests: value),
            ),
            _accommodationChip(
              item,
              isArabic ? 'توصيل مطار' : 'Airport',
              item.includesAirportPickup,
              (value) => item.copyWith(includesAirportPickup: value),
            ),
            _accommodationChip(
              item,
              isArabic ? 'نزهات خارجية' : 'Outings',
              item.includesTourismOrExternalOutings,
              (value) => item.copyWith(
                includesTourismOrExternalOutings: value,
              ),
            ),
            _accommodationChip(
              item,
              l10n.webCenterTaxIncluded,
              item.taxIncluded,
              (value) => item.copyWith(taxIncluded: value),
            ),
          ],
        ),
      ],
    );
  }

  Widget _autismTile(BuildContext context, AutismCareCostItem item) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return ExpansionTile(
      title: Text(isArabic ? item.labelAr : item.labelEn),
      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        CheckboxListTile(
          value: item.enabled,
          onChanged: _isSaving
              ? null
              : (value) {
                  setState(() {
                    _autismCareCosts = _autismCareCosts
                        .map((current) => current.key == item.key
                            ? current.copyWith(enabled: value ?? false)
                            : current)
                        .toList();
                  });
                },
          title: Text(l10n.webCenterEnabled),
          controlAffinity: ListTileControlAffinity.leading,
        ),
        _priceField(
          _autismPriceControllers[item.key],
          l10n.webCenterPrice,
        ),
        const SizedBox(height: 12),
        _dropdown(
          value: item.pricingUnit.isEmpty ? null : item.pricingUnit,
          label: l10n.webCenterPricingUnit,
          items: const ['visit', 'day', 'month'],
          onChanged: (value) {
            setState(() {
              _autismCareCosts = _autismCareCosts
                  .map((current) => current.key == item.key
                      ? current.copyWith(pricingUnit: value ?? '')
                      : current)
                  .toList();
            });
          },
        ),
        FilterChip(
          label: Text(l10n.webCenterTaxIncluded),
          selected: item.taxIncluded,
          onSelected: _isSaving
              ? null
              : (value) {
                  setState(() {
                    _autismCareCosts = _autismCareCosts
                        .map((current) => current.key == item.key
                            ? current.copyWith(taxIncluded: value)
                            : current)
                        .toList();
                  });
                },
        ),
      ],
    );
  }

  Widget _accommodationChip(
    AccommodationCostItem item,
    String label,
    bool selected,
    AccommodationCostItem Function(bool value) update,
  ) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: _isSaving
          ? null
          : (value) {
              setState(() {
                _accommodationCosts = _accommodationCosts
                    .map((current) =>
                        current.key == item.key ? update(value) : current)
                    .toList();
              });
            },
    );
  }

  Widget _priceField(TextEditingController? controller, String label) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(
        color: Color(0xFFFFF6DE),
        fontWeight: FontWeight.w700,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFE8C878)),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFEDEDED), width: 1.2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFEDEDED), width: 1.8),
        ),
      ),
    );
  }

  Widget _dropdown({
    required String? value,
    required String label,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: _isSaving ? null : onChanged,
    );
  }
}
