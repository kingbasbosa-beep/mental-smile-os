import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/asset_fallback_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';
import 'package:flutterprojects/features/centers/data/models/center_pricing.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class CenterRegisterPage extends StatefulWidget {
  const CenterRegisterPage({super.key});

  @override
  State<CenterRegisterPage> createState() => _CenterRegisterPageState();
}

class _CenterRegisterPageState extends State<CenterRegisterPage> {
  static const List<Map<String, String>> _centerCategories = [
    {
      'key': 'recovery',
      'labelAr': 'مراكز التعافي',
      'labelEn': 'Recovery Centers',
    },
    {
      'key': 'detox',
      'labelAr': 'مراكز سحب السموم',
      'labelEn': 'Detox Centers',
    },
    {
      'key': 'special_needs',
      'labelAr': 'مراكز رعاية ذوي الاحتياجات الخاصة',
      'labelEn': 'Special Needs Centers',
    },
    {
      'key': 'hospital',
      'labelAr': 'المستشفيات',
      'labelEn': 'Hospitals',
    },
  ];
  static const List<Map<String, String>> _centerTypes = [
    {
      'key': 'halfway_house',
      'labelAr': 'هاف واي',
      'labelEn': 'Halfway House',
    },
    {
      'key': 'detox',
      'labelAr': 'ديتوكس / أعراض انسحاب',
      'labelEn': 'Detox / Withdrawal Unit',
    },
    {
      'key': 'hospital',
      'labelAr': 'مستشفى',
      'labelEn': 'Hospital',
    },
    {
      'key': 'special_needs_care',
      'labelAr': 'رعاية ذوي الاحتياجات الخاصة',
      'labelEn': 'Special Needs Care',
    },
  ];

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _managerNameController = TextEditingController();
  final _coverImageUrlController = TextEditingController();
  final _coverImageAssetController = TextEditingController();
  final Map<String, TextEditingController> _accommodationPriceControllers = {};
  final Map<String, TextEditingController> _autismPriceControllers = {};

  bool _loading = false;
  String? _error;
  bool _resolvingLocation = false;
  String? _selectedCategoryKey;
  String? _selectedCenterTypeKey;
  bool _hasDetoxUnit = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  int _currentStep = 0;
  late List<AccommodationCostItem> _accommodationCosts;
  late List<AutismCareCostItem> _autismCareCosts;
  CenterCapabilityFlags _capabilities = const CenterCapabilityFlags();

  @override
  void initState() {
    super.initState();
    _accommodationCosts = defaultAccommodationCostItems();
    _autismCareCosts = defaultAutismCareCostItems();
    for (final item in _accommodationCosts) {
      _accommodationPriceControllers[item.key] =
          TextEditingController(text: item.price == 0 ? '' : '${item.price}');
    }
    for (final item in _autismCareCosts) {
      _autismPriceControllers[item.key] =
          TextEditingController(text: item.price == 0 ? '' : '${item.price}');
    }
  }

  bool get _isArabic =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  String _categoryLabelAr(String key) {
    final match = _centerCategories.where((e) => e['key'] == key);
    if (match.isEmpty) return '';
    return match.first['labelAr'] ?? '';
  }

  String _categoryLabelEn(String key) {
    final match = _centerCategories.where((e) => e['key'] == key);
    if (match.isEmpty) return '';
    return match.first['labelEn'] ?? '';
  }

  String _centerTypeLabelAr(String key) {
    final match = _centerTypes.where((e) => e['key'] == key);
    if (match.isEmpty) return '';
    return match.first['labelAr'] ?? '';
  }

  String _centerTypeLabelEn(String key) {
    final match = _centerTypes.where((e) => e['key'] == key);
    if (match.isEmpty) return '';
    return match.first['labelEn'] ?? '';
  }

  String? _defaultCenterTypeForCategory(String? categoryKey) {
    switch ((categoryKey ?? '').trim()) {
      case 'detox':
        return 'detox';
      case 'hospital':
        return 'hospital';
      case 'special_needs':
        return 'special_needs_care';
      case 'recovery':
        return 'halfway_house';
      default:
        return null;
    }
  }

  bool get _usesAutismPricing =>
      usesAutismCarePricing(_selectedCategoryKey ?? '');

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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    User? createdUser;
    var centerDocCreated = false;

    try {
      final auth = FirebaseAuth.instance;
      final firestore = FirebaseFirestore.instance;

      final cred = await auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      final user = cred.user;
      if (user == null) {
        throw Exception(
          _isArabic ? 'تعذر إنشاء الحساب' : 'Failed to create account',
        );
      }
      createdUser = user;

      final categoryKey = (_selectedCategoryKey ?? '').trim();
      final categoryLabelAr = _categoryLabelAr(categoryKey);
      final categoryLabelEn = _categoryLabelEn(categoryKey);
      final centerTypeKey = (_selectedCenterTypeKey ?? '').trim();

      await firestore.collection('centers').doc(user.uid).set({
        'name': _nameController.text.trim(),
        'role': 'center',
        'active': false,
        'isActive': false,
        'displayName': _nameController.text.trim(),
        'centerName': _nameController.text.trim(),
        'category': categoryKey,
        'centerType': centerTypeKey,
        'centerTypeLabelAr': _centerTypeLabelAr(centerTypeKey),
        'centerTypeLabelEn': _centerTypeLabelEn(centerTypeKey),
        'categoryLabelAr': categoryLabelAr,
        'categoryLabelEn': categoryLabelEn,
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'city': _cityController.text.trim(),
        'address': _addressController.text.trim(),
        'description': _descriptionController.text.trim(),
        'hasDetoxUnit': centerTypeKey == 'detox' ? true : _hasDetoxUnit,
        'managerName': _managerNameController.text.trim(),
        'sortOrder': 999,
        'imageUrl': _coverImageUrlController.text.trim(),
        'coverImageUrl': _coverImageUrlController.text.trim(),
        'coverImageAsset': _coverImageAssetController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'approvalStatus': 'pending_admin',
        'imagesReady': false,
        'documentsReady': false,
        'galleryImages': <String>[],
        'documentItems': <Map<String, dynamic>>[],
        'accommodationCosts':
            _currentAccommodationCosts().map((e) => e.toMap()).toList(),
        'autismCareCosts':
            _currentAutismCareCosts().map((e) => e.toMap()).toList(),
        'centerCapabilities': _capabilities.toMap(),
      });
      centerDocCreated = true;

      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.centerDashboard,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error =
            e.message ?? (_isArabic ? 'فشل التسجيل' : 'Registration failed');
      });
    } on FirebaseException catch (e) {
      if (!centerDocCreated && createdUser != null) {
        try {
          await createdUser.delete();
        } catch (_) {
          // Best-effort cleanup only. If delete fails, surface the original error.
        }
      }

      final isPermissionDenied = e.code == 'permission-denied';
      setState(() {
        _error = isPermissionDenied
            ? (_isArabic
                ? 'تم إنشاء حساب Firebase Auth لكن تعذر حفظ ملف المركز في Firestore بسبب الصلاحيات. تحقق من قواعد Firestore لنقطة centers/{uid}.'
                : 'Firebase Auth account was created, but saving the center profile to Firestore was denied. Check Firestore rules for centers/{uid}.')
            : (_isArabic
                ? 'فشل حفظ بيانات المركز: ${e.message ?? e.code}'
                : 'Failed to save center profile: ${e.message ?? e.code}');
      });
    } catch (e) {
      if (!centerDocCreated && createdUser != null) {
        try {
          await createdUser.delete();
        } catch (_) {
          // Best-effort cleanup only. If delete fails, surface the original error.
        }
      }

      setState(() {
        _error = _isArabic ? 'فشل التسجيل: $e' : 'Registration failed: $e';
      });
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _fillFromCurrentLocation() async {
    if (_resolvingLocation) return;

    setState(() {
      _resolvingLocation = true;
    });

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception(
          _isArabic
              ? 'خدمة الموقع غير مفعلة على الجهاز'
              : 'Location services are disabled',
        );
      }

      var permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        throw Exception(
          _isArabic ? 'تم رفض إذن الموقع' : 'Location permission denied',
        );
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          _isArabic
              ? 'إذن الموقع مرفوض نهائيًا، فعّله من إعدادات المتصفح أو النظام'
              : 'Location permission permanently denied',
        );
      }

      final position = await Geolocator.getCurrentPosition().timeout(
        const Duration(seconds: 12),
      );

      if (kIsWeb) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isArabic
                  ? 'تم تحديد موقعك الحالي، لكن تعبئة العنوان التلقائية على الويب غير مفعلة الآن. أدخل المدينة والعنوان يدويًا.'
                  : 'Your location was detected, but automatic address filling is disabled on web for now. Please enter city and address manually.',
            ),
          ),
        );
        return;
      }

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      ).timeout(const Duration(seconds: 10));

      if (placemarks.isEmpty) {
        throw Exception(
          _isArabic
              ? 'تعذر تحديد العنوان من الموقع الحالي'
              : 'No address found',
        );
      }

      final place = placemarks.first;

      final cityParts = [
        place.locality,
        place.subAdministrativeArea,
        place.administrativeArea,
      ]
          .where((e) => e != null && e.trim().isNotEmpty)
          .map((e) => e!.trim())
          .toList();

      final addressParts = [
        place.street,
        place.subLocality,
        place.locality,
        place.administrativeArea,
        place.country,
      ]
          .where((e) => e != null && e.trim().isNotEmpty)
          .map((e) => e!.trim())
          .toList();

      final resolvedCity = cityParts.isNotEmpty ? cityParts.first : '';
      final resolvedAddress = addressParts.join('، ').trim();

      if (resolvedCity.length >= 2) {
        _cityController.text = resolvedCity;
      }

      if (resolvedAddress.length >= 6) {
        _addressController.text = resolvedAddress;
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic
                ? 'تم تحميل الموقع الحالي'
                : 'Current location loaded successfully',
          ),
        ),
      );

      setState(() {});
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic
                ? 'تعذر تحميل الموقع الحالي، يمكنك إدخال العنوان يدويًا'
                : 'Unable to load current location, you can enter it manually',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _resolvingLocation = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    _managerNameController.dispose();
    _coverImageUrlController.dispose();
    _coverImageAssetController.dispose();
    for (final controller in _accommodationPriceControllers.values) {
      controller.dispose();
    }
    for (final controller in _autismPriceControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _pricingToggleRow({
    required BuildContext context,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile.adaptive(
      value: value,
      onChanged: _loading ? null : onChanged,
      title: Text(
        title,
        textAlign: _isArabic ? TextAlign.right : TextAlign.left,
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildCapabilitySection(BuildContext context) {
    return AppSectionPanel(
      color: AppColors.deepTeal.withValues(alpha: 0.05),
      borderColor: AppColors.deepTeal.withValues(alpha: 0.10),
      child: Column(
        crossAxisAlignment:
            _isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            _isArabic ? 'قدرات المركز' : 'Center capabilities',
            textAlign: _isArabic ? TextAlign.right : TextAlign.left,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _pricingToggleRow(
            context: context,
            title: _isArabic
                ? 'يدعم حالات الإدمان المصاحبة لفيروس HIV'
                : 'Supports addiction cases with HIV',
            value: _capabilities.supportsAddictionCasesWithHiv,
            onChanged: (value) {
              setState(() {
                _capabilities = _capabilities.copyWith(
                  supportsAddictionCasesWithHiv: value,
                );
              });
            },
          ),
          _pricingToggleRow(
            context: context,
            title:
                _isArabic ? 'يستقبل حالات الإدمان' : 'Accepts addiction cases',
            value: _capabilities.acceptsAddictionCases,
            onChanged: (value) {
              setState(() {
                _capabilities = _capabilities.copyWith(
                  acceptsAddictionCases: value,
                );
              });
            },
          ),
          _pricingToggleRow(
            context: context,
            title: _isArabic
                ? 'يستقبل الحالات النفسية بدون إدمان'
                : 'Accepts psychiatric cases without addiction',
            value: _capabilities.acceptsPsychiatricCasesWithoutAddiction,
            onChanged: (value) {
              setState(() {
                _capabilities = _capabilities.copyWith(
                  acceptsPsychiatricCasesWithoutAddiction: value,
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAccommodationCostCard(
    BuildContext context,
    AccommodationCostItem item,
  ) {
    final isArabic = _isArabic;
    return AppSectionPanel(
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          _pricingToggleRow(
            context: context,
            title: isArabic ? item.labelAr : item.labelEn,
            value: item.enabled,
            onChanged: (value) {
              setState(() {
                _accommodationCosts = _accommodationCosts
                    .map((current) => current.key == item.key
                        ? current.copyWith(enabled: value)
                        : current)
                    .toList();
              });
            },
          ),
          TextFormField(
            controller: _accommodationPriceControllers[item.key],
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: appInputDecoration(
              context: context,
              label: isArabic ? 'السعر' : 'Price',
              icon: Icons.payments_outlined,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          DropdownButtonFormField<String>(
            initialValue: item.pricingUnit.isEmpty ? null : item.pricingUnit,
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
            onChanged: _loading
                ? null
                : (value) {
                    setState(() {
                      _accommodationCosts = _accommodationCosts
                          .map((current) => current.key == item.key
                              ? current.copyWith(pricingUnit: value ?? '')
                              : current)
                          .toList();
                    });
                  },
          ),
          const SizedBox(height: AppSpacing.sm),
          DropdownButtonFormField<String>(
            initialValue: item.acMode.isEmpty ? null : item.acMode,
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
            onChanged: _loading
                ? null
                : (value) {
                    setState(() {
                      _accommodationCosts = _accommodationCosts
                          .map((current) => current.key == item.key
                              ? current.copyWith(acMode: value ?? '')
                              : current)
                          .toList();
                    });
                  },
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              FilterChip(
                label: Text(isArabic ? 'يشمل الدواء' : 'Medication'),
                selected: item.includesMedication,
                onSelected: _loading
                    ? null
                    : (value) {
                        setState(() {
                          _accommodationCosts = _accommodationCosts
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
                onSelected: _loading
                    ? null
                    : (value) {
                        setState(() {
                          _accommodationCosts = _accommodationCosts
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
                onSelected: _loading
                    ? null
                    : (value) {
                        setState(() {
                          _accommodationCosts = _accommodationCosts
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
                onSelected: _loading
                    ? null
                    : (value) {
                        setState(() {
                          _accommodationCosts = _accommodationCosts
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
                onSelected: _loading
                    ? null
                    : (value) {
                        setState(() {
                          _accommodationCosts = _accommodationCosts
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
                onSelected: _loading
                    ? null
                    : (value) {
                        setState(() {
                          _accommodationCosts = _accommodationCosts
                              .map((current) => current.key == item.key
                                  ? current.copyWith(
                                      includesTourismOrExternalOutings: value,
                                    )
                                  : current)
                              .toList();
                        });
                      },
              ),
              FilterChip(
                label: Text(isArabic ? 'الضريبة شاملة' : 'Tax included'),
                selected: item.taxIncluded,
                onSelected: _loading
                    ? null
                    : (value) {
                        setState(() {
                          _accommodationCosts = _accommodationCosts
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

  Widget _buildAutismCostCard(BuildContext context, AutismCareCostItem item) {
    final isArabic = _isArabic;
    return AppSectionPanel(
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          _pricingToggleRow(
            context: context,
            title: isArabic ? item.labelAr : item.labelEn,
            value: item.enabled,
            onChanged: (value) {
              setState(() {
                _autismCareCosts = _autismCareCosts
                    .map((current) => current.key == item.key
                        ? current.copyWith(enabled: value)
                        : current)
                    .toList();
              });
            },
          ),
          TextFormField(
            controller: _autismPriceControllers[item.key],
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: appInputDecoration(
              context: context,
              label: isArabic ? 'السعر' : 'Price',
              icon: Icons.payments_outlined,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          DropdownButtonFormField<String>(
            initialValue: item.pricingUnit.isEmpty ? null : item.pricingUnit,
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
            onChanged: _loading
                ? null
                : (value) {
                    setState(() {
                      _autismCareCosts = _autismCareCosts
                          .map((current) => current.key == item.key
                              ? current.copyWith(pricingUnit: value ?? '')
                              : current)
                          .toList();
                    });
                  },
          ),
          const SizedBox(height: AppSpacing.sm),
          FilterChip(
            label: Text(isArabic ? 'الضريبة شاملة' : 'Tax included'),
            selected: item.taxIncluded,
            onSelected: _loading
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
      ),
    );
  }

  Widget _buildPricingSection(BuildContext context) {
    final isArabic = _isArabic;
    return AppSectionPanel(
      color: AppColors.accentLavender.withValues(alpha: 0.05),
      borderColor: AppColors.accentLavender.withValues(alpha: 0.10),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isArabic ? 'تكلفة الإقامة' : 'Cost of stay',
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            _usesAutismPricing
                ? (isArabic
                    ? 'هذا النوع من المراكز يستخدم تسعير الاستضافة اليومية والزيارات المنزلية بدل فئات الغرف.'
                    : 'This center type uses daily hosting and home-visit pricing instead of room categories.')
                : (isArabic
                    ? 'أدخل الفئات المتاحة فقط، واترك غير المتاح بدون تفعيل.'
                    : 'Fill only the available accommodation categories and leave the unavailable ones disabled.'),
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
          ),
          const SizedBox(height: AppSpacing.md),
          ...(_usesAutismPricing
              ? _autismCareCosts
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: _buildAutismCostCard(context, item),
                      ))
                  .toList()
              : _accommodationCosts
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: _buildAccommodationCostCard(context, item),
                      ))
                  .toList()),
        ],
      ),
    );
  }

  bool _validateStepOne() {
    return _formKey.currentState?.validate() ?? false;
  }

  String _stepTitle(int step) {
    if (step == 0) {
      return _isArabic ? 'البيانات الأساسية' : 'Core details';
    }
    return _isArabic ? 'الهوية والتسعير' : 'Brand and pricing';
  }

  String _stepSubtitle(int step) {
    if (step == 0) {
      return _isArabic
          ? 'الاسم، الحساب، التواصل، والعنوان الرئيسي للمركز'
          : 'Name, account, contact, and main address details';
    }
    return _isArabic
        ? 'صورة كارت المركز، قدرات المركز، وفئات التسعير'
        : 'Center card image, capabilities, and pricing bands';
  }

  Widget _buildStepperHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StepBadge(
            index: 1,
            title: _isArabic ? 'الخطوة الأولى' : 'Step 1',
            subtitle: _isArabic ? 'البيانات الأساسية' : 'Core details',
            active: _currentStep == 0,
            done: _currentStep > 0,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StepBadge(
            index: 2,
            title: _isArabic ? 'الخطوة الثانية' : 'Step 2',
            subtitle: _isArabic ? 'الهوية والتسعير' : 'Brand and pricing',
            active: _currentStep == 1,
            done: false,
          ),
        ),
      ],
    );
  }

  Widget _imageFallback() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          normalizeAssetPath('assets/c7_branding/home/hero_art.png'),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const AppMissingAssetPlaceholder(),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.deepTeal.withValues(alpha: 0.14),
          ),
        ),
      ],
    );
  }

  Widget _buildImageSection(BuildContext context) {
    final imageUrl = _coverImageUrlController.text.trim();
    final assetPath = _coverImageAssetController.text.trim();

    Widget preview;
    if (imageUrl.isNotEmpty) {
      preview = Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _imageFallback(),
      );
    } else if (assetPath.isNotEmpty) {
      preview = Image.asset(
        normalizeAssetPath(assetPath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _imageFallback(),
      );
    } else {
      preview = _imageFallback();
    }

    return AppSectionPanel(
      color: AppColors.mutedGold.withValues(alpha: 0.06),
      borderColor: AppColors.mutedGold.withValues(alpha: 0.14),
      child: Column(
        crossAxisAlignment:
            _isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            _isArabic ? 'صورة كارت المركز' : 'Center card image',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            _isArabic
                ? 'يمكنك ربط صورة غلاف أو لوجو يظهر في كارت المركز وصفحة التفاصيل. استخدم رابط صورة أو مسار أصل محلي داخل المشروع.'
                : 'Link a cover image or logo that appears on the center card and details page. Use an image URL or a local asset path.',
            textAlign: _isArabic ? TextAlign.right : TextAlign.left,
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.lg),
            child: SizedBox(
              height: 190,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  preview,
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.08),
                          Colors.black.withValues(alpha: 0.38),
                        ],
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: 14,
                    start: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(AppRadii.pill),
                      ),
                      child: Text(
                        _isArabic ? 'معاينة الكارت' : 'Card preview',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    bottom: 16,
                    end: 16,
                    child: Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: AppColors.mutedGold.withValues(alpha: 0.26),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: preview,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _coverImageUrlController,
            onChanged: (_) => setState(() {}),
            decoration: appInputDecoration(
              context: context,
              label: _isArabic ? 'رابط صورة الغلاف' : 'Cover image URL',
              icon: Icons.image_outlined,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _coverImageAssetController,
            onChanged: (_) => setState(() {}),
            decoration: appInputDecoration(
              context: context,
              label: _isArabic ? 'مسار أصل محلي للصورة' : 'Local asset path',
              icon: Icons.photo_library_outlined,
              hintText: 'assets/images/centers/covers/center_1.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepOne(BuildContext context) {
    return Column(
      crossAxisAlignment:
          _isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          _isArabic ? 'بيانات المركز' : 'Center information',
          textAlign: _isArabic ? TextAlign.right : TextAlign.left,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          _isArabic
              ? 'أدخل بيانات المركز الأساسية لإعداد الصفحة الشخصية ولوحة التشغيل لاحقًا.'
              : 'Enter the core center information to prepare the profile and dashboard.',
          textAlign: _isArabic ? TextAlign.right : TextAlign.left,
        ),
      ],
    );
  }

  Widget _buildStepTwo(BuildContext context) {
    return Column(
      crossAxisAlignment:
          _isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          _isArabic ? 'هوية المركز وتسعيره' : 'Center identity and pricing',
          textAlign: _isArabic ? TextAlign.right : TextAlign.left,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          _isArabic
              ? 'هذه الخطوة تضبط صورة الكارت، قدرات المركز، وفئات التسعير التي ستظهر لاحقًا.'
              : 'This step prepares the card image, capabilities, and pricing bands that will appear later.',
          textAlign: _isArabic ? TextAlign.right : TextAlign.left,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: AppPageBackground(
          child: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                    vertical: AppSpacing.xxl,
                  ),
                  children: [
                    const SizedBox(height: AppSpacing.lg),
                    AppHeroHeader(
                      title: _isArabic
                          ? 'تسجيل مركز جديد'
                          : 'Create center account',
                      subtitle: _isArabic
                          ? 'تسجيل أوضح على خطوتين مع معاينة مبكرة لصورة كارت المركز.'
                          : 'A clearer two-step registration flow with an early center card preview.',
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppSurfaceCard(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: _isArabic
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            _buildStepperHeader(context),
                            const SizedBox(height: AppSpacing.md),
                            AppSectionPanel(
                              color: _currentStep == 0
                                  ? AppColors.mutedGold.withValues(alpha: 0.05)
                                  : AppColors.deepTeal.withValues(alpha: 0.05),
                              borderColor: _currentStep == 0
                                  ? AppColors.mutedGold.withValues(alpha: 0.12)
                                  : AppColors.deepTeal.withValues(alpha: 0.12),
                              child: _currentStep == 0
                                  ? _buildStepOne(context)
                                  : _buildStepTwo(context),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            if (_currentStep == 0) ...[
                            TextFormField(
                              controller: _nameController,
                              decoration: appInputDecoration(
                                context: context,
                                label: _isArabic ? 'اسم المركز' : 'Center name',
                                icon: Icons.business_outlined,
                              ),
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? (_isArabic
                                      ? 'أدخل اسم المركز'
                                      : 'Enter center name')
                                  : null,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            DropdownButtonFormField<String>(
                              initialValue: _selectedCategoryKey,
                              isExpanded: true,
                              decoration: appInputDecoration(
                                context: context,
                                label: _isArabic
                                    ? 'فئة / تخصص المركز'
                                    : 'Center category / specialty',
                                icon: Icons.category_outlined,
                              ),
                              items: _centerCategories
                                  .map(
                                    (item) => DropdownMenuItem<String>(
                                      value: item['key'],
                                      child: Text(
                                        _isArabic
                                            ? (item['labelAr'] ?? '')
                                            : (item['labelEn'] ?? ''),
                                        textAlign: _isArabic
                                            ? TextAlign.right
                                            : TextAlign.left,
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: _loading
                                  ? null
                                  : (value) {
                                      setState(() {
                                        _selectedCategoryKey = value;
                                        _selectedCenterTypeKey =
                                            _defaultCenterTypeForCategory(
                                                  value,
                                                ) ??
                                                _selectedCenterTypeKey;
                                        if (_selectedCenterTypeKey == 'detox') {
                                          _hasDetoxUnit = true;
                                        }
                                      });
                                    },
                              validator: (value) =>
                                  (value == null || value.trim().isEmpty)
                                      ? (_isArabic
                                          ? 'اختر فئة المركز'
                                          : 'Select the center category')
                                      : null,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            DropdownButtonFormField<String>(
                              initialValue: _selectedCenterTypeKey,
                              isExpanded: true,
                              decoration: appInputDecoration(
                                context: context,
                                label: _isArabic
                                    ? 'نوع المركز التشغيلي'
                                    : 'Operational center type',
                                icon: Icons.account_tree_outlined,
                              ),
                              items: _centerTypes
                                  .map(
                                    (item) => DropdownMenuItem<String>(
                                      value: item['key'],
                                      child: Text(
                                        _isArabic
                                            ? (item['labelAr'] ?? '')
                                            : (item['labelEn'] ?? ''),
                                        textAlign: _isArabic
                                            ? TextAlign.right
                                            : TextAlign.left,
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: _loading
                                  ? null
                                  : (value) {
                                      setState(() {
                                        _selectedCenterTypeKey = value;
                                        if (value == 'detox') {
                                          _hasDetoxUnit = true;
                                        }
                                      });
                                    },
                              validator: (value) =>
                                  (value == null || value.trim().isEmpty)
                                      ? (_isArabic
                                          ? 'اختر نوع المركز'
                                          : 'Select the center type')
                                      : null,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            SwitchListTile.adaptive(
                              value: _selectedCenterTypeKey == 'detox'
                                  ? true
                                  : _hasDetoxUnit,
                              onChanged: _loading
                                  ? null
                                  : _selectedCenterTypeKey == 'detox'
                                      ? null
                                      : (value) {
                                          setState(() {
                                            _hasDetoxUnit = value;
                                          });
                                        },
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                _isArabic
                                    ? 'يوجد قسم داخلي لأعراض الانسحاب'
                                    : 'Includes an internal withdrawal unit',
                                textAlign: _isArabic
                                    ? TextAlign.right
                                    : TextAlign.left,
                              ),
                              subtitle: Text(
                                _selectedCenterTypeKey == 'detox'
                                    ? (_isArabic
                                        ? 'مراكز الديتوكس تعتبر هذا القسم متاحًا تلقائيًا.'
                                        : 'Detox centers always include this unit by default.')
                                    : (_isArabic
                                        ? 'فعّل هذا الخيار إذا كان المركز يحتوي على وحدة ديتوكس داخلية بجانب خدمته الأساسية.'
                                        : 'Enable this if the center includes an internal detox/withdrawal unit alongside its main service.'),
                                textAlign: _isArabic
                                    ? TextAlign.right
                                    : TextAlign.left,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            TextFormField(
                              controller: _managerNameController,
                              decoration: appInputDecoration(
                                context: context,
                                label:
                                    _isArabic ? 'اسم المسؤول' : 'Manager name',
                                icon: Icons.badge_outlined,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: appInputDecoration(
                                context: context,
                                label:
                                    _isArabic ? 'البريد الإلكتروني' : 'Email',
                                icon: Icons.alternate_email,
                              ),
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? (_isArabic
                                      ? 'أدخل البريد الإلكتروني'
                                      : 'Enter email')
                                  : null,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: appInputDecoration(
                                context: context,
                                label: _isArabic ? 'كلمة المرور' : 'Password',
                                icon: Icons.lock_outline,
                                suffixIcon: IconButton(
                                  onPressed: _loading
                                      ? null
                                      : () {
                                          setState(() {
                                            _obscurePassword =
                                                !_obscurePassword;
                                          });
                                        },
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                  tooltip: _isArabic
                                      ? (_obscurePassword
                                          ? 'إظهار كلمة المرور'
                                          : 'إخفاء كلمة المرور')
                                      : (_obscurePassword
                                          ? 'Show password'
                                          : 'Hide password'),
                                ),
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return _isArabic
                                      ? 'أدخل كلمة المرور'
                                      : 'Enter password';
                                }
                                if (v.length < 6) {
                                  return _isArabic
                                      ? '6 أحرف على الأقل'
                                      : 'At least 6 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: AppSpacing.md),
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: _obscureConfirmPassword,
                              decoration: appInputDecoration(
                                context: context,
                                label: _isArabic
                                    ? 'تأكيد كلمة المرور'
                                    : 'Confirm password',
                                icon: Icons.lock_reset_outlined,
                                suffixIcon: IconButton(
                                  onPressed: _loading
                                      ? null
                                      : () {
                                          setState(() {
                                            _obscureConfirmPassword =
                                                !_obscureConfirmPassword;
                                          });
                                        },
                                  icon: Icon(
                                    _obscureConfirmPassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                  tooltip: _isArabic
                                      ? (_obscureConfirmPassword
                                          ? 'إظهار تأكيد كلمة المرور'
                                          : 'إخفاء تأكيد كلمة المرور')
                                      : (_obscureConfirmPassword
                                          ? 'Show confirm password'
                                          : 'Hide confirm password'),
                                ),
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return _isArabic
                                      ? 'أدخل تأكيد كلمة المرور'
                                      : 'Enter confirm password';
                                }
                                if (v != _passwordController.text) {
                                  return _isArabic
                                      ? 'كلمتا المرور غير متطابقتين'
                                      : 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: AppSpacing.md),
                            TextFormField(
                              controller: _phoneController,
                              decoration: appInputDecoration(
                                context: context,
                                label: _isArabic ? 'رقم الهاتف' : 'Phone',
                                icon: Icons.phone_outlined,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            TextFormField(
                              controller: _cityController,
                              decoration: appInputDecoration(
                                context: context,
                                label: _isArabic ? 'المدينة' : 'City',
                                icon: Icons.location_city_outlined,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Align(
                              alignment: _isArabic
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: OutlinedButton.icon(
                                onPressed: _resolvingLocation
                                    ? null
                                    : () {
                                        if (kIsWeb) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                _isArabic
                                                    ? 'ميزة تعبئة العنوان من اللوكيشن غير مفعلة على الويب حاليًا. اكتب المدينة والعنوان يدويًا.'
                                                    : 'Automatic address filling is not enabled on web for now. Please enter city and address manually.',
                                              ),
                                            ),
                                          );
                                          return;
                                        }

                                        _fillFromCurrentLocation();
                                      },
                                icon: _resolvingLocation
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Icon(Icons.my_location_rounded),
                                label: Text(
                                  kIsWeb
                                      ? (_isArabic
                                          ? 'اكتب العنوان يدويًا'
                                          : 'Enter address manually')
                                      : (_resolvingLocation
                                          ? (_isArabic
                                              ? 'جارٍ تحديد موقعك...'
                                              : 'Detecting location...')
                                          : (_isArabic
                                              ? 'استخدم موقعي الحالي'
                                              : 'Use current location')),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            TextFormField(
                              controller: _addressController,
                              decoration: appInputDecoration(
                                context: context,
                                label: _isArabic ? 'العنوان' : 'Address',
                                icon: Icons.location_on_outlined,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            TextFormField(
                              controller: _descriptionController,
                              maxLines: 4,
                              decoration: appInputDecoration(
                                context: context,
                                label: _isArabic
                                    ? 'وصف المركز'
                                    : 'Center description',
                                icon: Icons.notes_outlined,
                              ),
                            ),
                            ],
                            if (_currentStep == 1) ...[
                              const SizedBox(height: AppSpacing.md),
                              _buildImageSection(context),
                              const SizedBox(height: AppSpacing.md),
                              _buildCapabilitySection(context),
                              const SizedBox(height: AppSpacing.md),
                              _buildPricingSection(context),
                              const SizedBox(height: AppSpacing.md),
                              AppSectionPanel(
                                color:
                                    AppColors.deepTeal.withValues(alpha: 0.08),
                                borderColor:
                                    AppColors.deepTeal.withValues(alpha: 0.10),
                                child: Text(
                                  _isArabic
                                      ? 'بعد التسجيل سيتم إنشاء الصفحة الشخصية وغرفة العمليات للمركز، ثم لاحقًا نربط الصور والوثائق والاعتماد.'
                                      : 'After registration, the center dashboard and operations room will be created. Images, documents, and approval will be connected next.',
                                  style:
                                      Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ],
                            if (_error != null) ...[
                              const SizedBox(height: AppSpacing.md),
                              AppMessageBanner(message: _error!),
                            ],
                            const SizedBox(height: AppSpacing.md),
                            Row(
                              children: [
                                if (_currentStep == 1) ...[
                                  Expanded(
                                    child: SizedBox(
                                      height: 56,
                                      child: OutlinedButton.icon(
                                        onPressed: _loading
                                            ? null
                                            : () {
                                                setState(() {
                                                  _currentStep = 0;
                                                });
                                              },
                                        icon:
                                            const Icon(Icons.arrow_back_rounded),
                                        label:
                                            Text(_isArabic ? 'رجوع' : 'Back'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                ],
                                Expanded(
                                  child: SizedBox(
                                    height: 56,
                                    child: FilledButton.icon(
                                      onPressed: _loading
                                          ? null
                                          : () {
                                              if (_currentStep == 0) {
                                                if (!_validateStepOne()) return;
                                                setState(() {
                                                  _currentStep = 1;
                                                });
                                                return;
                                              }
                                              _submit();
                                            },
                                      icon: _loading
                                          ? const SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Icon(
                                              _currentStep == 0
                                                  ? Icons.arrow_forward_rounded
                                                  : Icons.app_registration,
                                            ),
                                      label: Text(
                                        _loading
                                            ? (_isArabic
                                                ? 'جارٍ الإنشاء...'
                                                : 'Creating...')
                                            : (_currentStep == 0
                                                ? (_isArabic
                                                    ? 'التالي'
                                                    : 'Next')
                                                : (_isArabic
                                                    ? 'إنشاء حساب المركز'
                                                    : 'Create center account')),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  _isArabic
                                      ? 'لديك حساب بالفعل؟ تسجيل الدخول'
                                      : 'Already have an account? Sign in',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
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

class _StepBadge extends StatelessWidget {
  const _StepBadge({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.active,
    required this.done,
  });

  final int index;
  final String title;
  final String subtitle;
  final bool active;
  final bool done;

  @override
  Widget build(BuildContext context) {
    final color = done
        ? AppColors.success
        : (active ? AppColors.deepTeal : AppColors.mist);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: active ? 0.12 : 0.07),
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(
          color: color.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$index',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

