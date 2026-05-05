import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/web_registration/data/web_registration_draft_store.dart';

class WebCenterProfilePage extends StatefulWidget {
  const WebCenterProfilePage({super.key});

  @override
  State<WebCenterProfilePage> createState() => _WebCenterProfilePageState();
}

class _WebCenterProfilePageState extends State<WebCenterProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _managerNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _cityController = TextEditingController();
  final _areaController = TextEditingController();
  final _addressController = TextEditingController();
  final _servicesController = TextEditingController();
  final _frontImageController = TextEditingController();
  final _receptionImageController = TextEditingController();
  final _inside1ImageController = TextEditingController();
  final _inside2ImageController = TextEditingController();

  bool _isSaving = false;
  bool _hasDetoxUnit = false;
  bool _supportsHiv = false;
  bool _acceptsAddiction = true;
  bool _acceptsPsychiatric = false;
  String _category = 'recovery';
  String _centerType = 'halfway_house';
  String? _error;

  @override
  void dispose() {
    _managerNameController.dispose();
    _phoneController.dispose();
    _whatsappController.dispose();
    _descriptionController.dispose();
    _cityController.dispose();
    _areaController.dispose();
    _addressController.dispose();
    _servicesController.dispose();
    _frontImageController.dispose();
    _receptionImageController.dispose();
    _inside1ImageController.dispose();
    _inside2ImageController.dispose();
    super.dispose();
  }

  Map<String, String> _categoryLabels(String key) {
    switch (key) {
      case 'detox':
        return {
          'ar': 'مراكز سحب السموم',
          'en': 'Detox centers',
        };
      case 'hospital':
        return {
          'ar': 'المستشفيات',
          'en': 'Hospitals',
        };
      case 'special_needs':
        return {
          'ar': 'مراكز رعاية ذوي الاحتياجات الخاصة',
          'en': 'Special needs care centers',
        };
      case 'recovery':
      default:
        return {
          'ar': 'مراكز التعافي',
          'en': 'Recovery centers',
        };
    }
  }

  List<Map<String, dynamic>> _galleryItems() {
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

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid ?? WebRegistrationDraftStore.centerUid;

    if (uid == null) {
      setState(() {
        _error = 'Please register or sign in before saving profile.';
      });
      return;
    }

    setState(() {
      _isSaving = true;
      _error = null;
    });

    try {
      final labels = _categoryLabels(_category);
      final galleryItems = _galleryItems();
      final galleryImages = galleryItems
          .map((item) => (item['url'] ?? '').toString().trim())
          .where((url) => url.isNotEmpty)
          .toList();
      final services = _servicesController.text
          .split(',')
          .map((item) => item.trim())
          .where((item) => item.isNotEmpty)
          .toList();

      await FirebaseFirestore.instance.collection('centers').doc(uid).update({
        'category': _category,
        'categoryLabelAr': labels['ar'],
        'categoryLabelEn': labels['en'],
        'sortOrder': 0,
        'centerType': _centerType,
        'managerName': _managerNameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'whatsapp': _whatsappController.text.trim(),
        'description': _descriptionController.text.trim(),
        'city': _cityController.text.trim(),
        'area': _areaController.text.trim(),
        'address': _addressController.text.trim(),
        'hasDetoxUnit': _hasDetoxUnit || _centerType == 'detox',
        'centerCapabilities': {
          'supportsAddictionCasesWithHiv': _supportsHiv,
          'acceptsAddictionCases': _acceptsAddiction,
          'acceptsPsychiatricCasesWithoutAddiction': _acceptsPsychiatric,
        },
        'services': services,
        'galleryItems': galleryItems,
        'galleryImages': galleryImages,
        'imageUrl': galleryImages.isEmpty ? '' : galleryImages.first,
        'coverImageUrl': galleryImages.isEmpty ? '' : galleryImages.first,
        'imagesReady': galleryImages.isNotEmpty,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully')),
      );

      await Future<void>.delayed(const Duration(milliseconds: 400));
      if (!mounted) return;

      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.webCenterPricing,
        (route) => false,
      );
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Failed to save profile';
      });
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3EA),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Card(
            elevation: 8,
            margin: const EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const Text(
                      'Center Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _category,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'recovery',
                          child: Text('Recovery'),
                        ),
                        DropdownMenuItem(value: 'detox', child: Text('Detox')),
                        DropdownMenuItem(
                          value: 'hospital',
                          child: Text('Hospital'),
                        ),
                        DropdownMenuItem(
                          value: 'special_needs',
                          child: Text('Special needs'),
                        ),
                      ],
                      onChanged: _isSaving
                          ? null
                          : (value) {
                              if (value == null) return;
                              setState(() {
                                _category = value;
                                if (value == 'detox') {
                                  _centerType = 'detox';
                                } else if (value == 'hospital') {
                                  _centerType = 'hospital';
                                } else if (value == 'special_needs') {
                                  _centerType = 'special_needs_care';
                                } else {
                                  _centerType = 'halfway_house';
                                }
                              });
                            },
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      value: _centerType,
                      decoration: const InputDecoration(
                        labelText: 'Center type',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'halfway_house',
                          child: Text('Halfway house'),
                        ),
                        DropdownMenuItem(value: 'detox', child: Text('Detox')),
                        DropdownMenuItem(
                          value: 'hospital',
                          child: Text('Hospital'),
                        ),
                        DropdownMenuItem(
                          value: 'special_needs_care',
                          child: Text('Special needs care'),
                        ),
                      ],
                      onChanged: _isSaving
                          ? null
                          : (value) {
                              if (value != null) {
                                setState(() => _centerType = value);
                              }
                            },
                    ),
                    const SizedBox(height: 14),
                    _textField(_managerNameController, 'Manager name'),
                    _textField(_phoneController, 'Phone',
                        keyboardType: TextInputType.phone),
                    _textField(_whatsappController, 'WhatsApp',
                        keyboardType: TextInputType.phone),
                    _textField(_descriptionController, 'Description',
                        maxLines: 3),
                    _textField(_cityController, 'City'),
                    _textField(_areaController, 'Area'),
                    _textField(_addressController, 'Address'),
                    _textField(_servicesController, 'Services, comma separated',
                        required: false),
                    _textField(_frontImageController, 'Front image URL',
                        required: false),
                    _textField(_receptionImageController, 'Reception image URL',
                        required: false),
                    _textField(_inside1ImageController, 'Inside image 1 URL',
                        required: false),
                    _textField(_inside2ImageController, 'Inside image 2 URL',
                        required: false),
                    CheckboxListTile(
                      value: _hasDetoxUnit,
                      onChanged: _isSaving
                          ? null
                          : (value) {
                              setState(() => _hasDetoxUnit = value ?? false);
                            },
                      title: const Text('Has detox unit'),
                    ),
                    CheckboxListTile(
                      value: _acceptsAddiction,
                      onChanged: _isSaving
                          ? null
                          : (value) {
                              setState(
                                () => _acceptsAddiction = value ?? false,
                              );
                            },
                      title: const Text('Accepts addiction cases'),
                    ),
                    CheckboxListTile(
                      value: _acceptsPsychiatric,
                      onChanged: _isSaving
                          ? null
                          : (value) {
                              setState(
                                () => _acceptsPsychiatric = value ?? false,
                              );
                            },
                      title: const Text('Accepts psychiatric cases'),
                    ),
                    CheckboxListTile(
                      value: _supportsHiv,
                      onChanged: _isSaving
                          ? null
                          : (value) {
                              setState(() => _supportsHiv = value ?? false);
                            },
                      title: const Text('Supports addiction cases with HIV'),
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 14),
                      Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _save,
                        child: _isSaving
                            ? const CircularProgressIndicator()
                            : const Text('Save Profile'),
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

  Widget _textField(
    TextEditingController controller,
    String label, {
    bool required = true,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (!required) return null;
          if (value == null || value.trim().isEmpty) return 'Required';
          return null;
        },
      ),
    );
  }
}
