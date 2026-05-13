import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/centers/data/models/center_pricing.dart';
import 'package:flutterprojects/features/web_registration/data/web_registration_draft_store.dart';
import 'package:flutterprojects/features/web_registration/presentation/web_registration_background.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';

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
    final uid = FirebaseAuth.instance.currentUser?.uid ??
        WebRegistrationDraftStore.centerUid;
    if (uid == null) {
      setState(() => _error = 'Please register or sign in before saving.');
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
        'pricingReady': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(Routes.webCenterDocuments);
    } catch (_) {
      if (mounted) setState(() => _error = 'Failed to save pricing.');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
                              Text(
                                l10n.webCenterPricingCapabilitiesTitle,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              OutlinedButton.icon(
                                onPressed: () =>
                                    Navigator.of(context).pushNamed(
                                  Routes.webLibrary,
                                ),
                                icon: const Icon(Icons.menu_book_outlined,
                                    size: 16),
                                label: Text(l10n.webCenterGuidanceLibrary),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: webRegistrationTextTurquoise,
                                  side: BorderSide(
                                    color: webRegistrationBorderTurquoise
                                        .withValues(
                                      alpha: 0.55,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  textStyle: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    shadows: webRegistrationTextShadows,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              _capabilityTile(
                                'Supports addiction cases with HIV',
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
                                'Accepts addiction cases',
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
                                'Accepts psychiatric cases without addiction',
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
                                  child: _isSaving
                                      ? const CircularProgressIndicator()
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

    return ExpansionTile(
      title: Text(item.labelEn),
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
              'Medication',
              item.includesMedication,
              (value) => item.copyWith(includesMedication: value),
            ),
            _accommodationChip(
              item,
              'Meals',
              item.includesMeals,
              (value) => item.copyWith(includesMeals: value),
            ),
            _accommodationChip(
              item,
              'Outdoor',
              item.includesOutdoorActivities,
              (value) => item.copyWith(includesOutdoorActivities: value),
            ),
            _accommodationChip(
              item,
              'Tests',
              item.includesRequiredTests,
              (value) => item.copyWith(includesRequiredTests: value),
            ),
            _accommodationChip(
              item,
              'Airport',
              item.includesAirportPickup,
              (value) => item.copyWith(includesAirportPickup: value),
            ),
            _accommodationChip(
              item,
              'Outings',
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

    return ExpansionTile(
      title: Text(item.labelEn),
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
          items: const ['session', 'day', 'month'],
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
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
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
