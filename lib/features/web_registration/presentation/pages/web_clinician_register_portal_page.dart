import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';

class WebClinicianRegisterPortalPage extends StatefulWidget {
  const WebClinicianRegisterPortalPage({super.key});

  @override
  State<WebClinicianRegisterPortalPage> createState() =>
      _WebClinicianRegisterPortalPageState();
}

class _WebClinicianRegisterPortalPageState
    extends State<WebClinicianRegisterPortalPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _photoUrlController = TextEditingController();
  final _bioController = TextEditingController();
  final _sessionPriceController = TextEditingController();
  final _sessionDurationController = TextEditingController();
  final _identityFileNameController = TextEditingController();
  final _certificateFileNameController = TextEditingController();
  final _extraFileNameController = TextEditingController();

  bool _offersOnline = true;
  bool _offersInPerson = true;
  bool _offersGroupSessions = false;
  bool _isSubmitting = false;
  String? _error;
  String? _selectedProfessionalTitleKey;
  String? _selectedSpecialtyKey;

  static const List<Map<String, String>> _professionalTitles = [
    {'key': 'doctor', 'labelAr': 'د.', 'labelEn': 'Dr.'},
    {'key': 'specialist', 'labelAr': 'أ.', 'labelEn': 'Spec.'},
  ];

  static const List<Map<String, String>> _specialties = [
    {'key': 'psychologist', 'label': 'أخصائي نفسي'},
    {'key': 'clinical_psychologist', 'label': 'دكتور نفسي إكلينيكي'},
    {'key': 'addiction_counselor', 'label': 'مشير علاج سلوكيات إدمانية'},
    {'key': 'speech_specialist', 'label': 'أخصائي تخاطب'},
    {'key': 'family_counselor', 'label': 'أخصائي مشورة أسرية'},
    {'key': 'coach', 'label': 'كوتش'},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _photoUrlController.dispose();
    _bioController.dispose();
    _sessionPriceController.dispose();
    _sessionDurationController.dispose();
    _identityFileNameController.dispose();
    _certificateFileNameController.dispose();
    _extraFileNameController.dispose();
    super.dispose();
  }

  String _normalizeEmail(String value) => value.trim().toLowerCase();

  Map<String, String>? _selectedTitle() {
    for (final title in _professionalTitles) {
      if (title['key'] == _selectedProfessionalTitleKey) return title;
    }
    return null;
  }

  Map<String, String>? _selectedSpecialty() {
    for (final specialty in _specialties) {
      if (specialty['key'] == _selectedSpecialtyKey) return specialty;
    }
    return null;
  }

  List<String> _sessionModes() {
    final items = <String>[];
    if (_offersInPerson) items.add('In person');
    if (_offersOnline) items.add('Online');
    return items;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_offersOnline && !_offersInPerson) {
      setState(() => _error = 'اختر طريقة جلسة واحدة على الأقل');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _error = null;
    });

    try {
      final name = _nameController.text.trim();
      final email = _normalizeEmail(_emailController.text);
      final title = _selectedTitle();
      final specialty = _selectedSpecialty();
      final titleLabelAr = title?['labelAr'] ?? '';
      final titleLabelEn = title?['labelEn'] ?? '';
      final specialtyLabel = specialty?['label'] ?? '';
      final identityFileName = _identityFileNameController.text.trim();
      final certificateFileName = _certificateFileNameController.text.trim();
      final extraFileName = _extraFileNameController.text.trim();
      final documentsSubmitted =
          identityFileName.isNotEmpty && certificateFileName.isNotEmpty;

      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: _passwordController.text,
      );
      final user = credential.user;
      if (user == null) {
        throw Exception('Unable to create clinician account');
      }

      await user.updateDisplayName(name);
      await user.reload();

      final now = FieldValue.serverTimestamp();
      await FirebaseFirestore.instance.collection('clinicians').doc(user.uid).set({
        'displayName': name,
        'fullDisplayNameAr': titleLabelAr.isEmpty ? name : '$titleLabelAr $name',
        'fullDisplayNameEn': titleLabelEn.isEmpty ? name : '$titleLabelEn $name',
        'professionalTitleKey': _selectedProfessionalTitleKey,
        'professionalTitleLabelAr': titleLabelAr,
        'professionalTitleLabelEn': titleLabelEn,
        'email': email,
        'specialty': specialtyLabel,
        'specialtyKey': _selectedSpecialtyKey,
        'specialtyLabel': specialtyLabel,
        'offersGroupSessions': _offersGroupSessions,
        'bio': _bioController.text.trim(),
        'sessionPriceText': _sessionPriceController.text.trim(),
        'sessionDurationText': _sessionDurationController.text.trim(),
        'sessionModes': _sessionModes(),
        'role': 'clinician',
        'isActive': false,
        'isAdmin': false,
        'photoUrl': _photoUrlController.text.trim(),
        'photoAsset': '',
        'createdAt': now,
        'updatedAt': now,
        'documentsSubmitted': documentsSubmitted,
        'documentsUploadMode': 'web_registration',
        'approvalStatus': 'pending_review',
        'identityFileName': identityFileName,
        'certificateFileName': certificateFileName,
        'extraFileName': extraFileName,
        'identityDocumentUrl': '',
        'certificateDocumentUrl': '',
        'extraDocumentUrl': '',
      });

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(Routes.webRegistrationSuccess);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = e.message ?? 'فشل إنشاء حساب الأخصائي';
      });
    } catch (_) {
      setState(() {
        _error = 'فشل إنشاء حساب الأخصائي';
      });
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) return 'مطلوب';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3EA),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Clinician Registration Portal',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _textField(_nameController, 'Name', validator: _required),
                      const SizedBox(height: 14),
                      DropdownButtonFormField<String>(
                        value: _selectedProfessionalTitleKey,
                        decoration: const InputDecoration(
                          labelText: 'Professional title',
                          border: OutlineInputBorder(),
                        ),
                        items: _professionalTitles
                            .map(
                              (title) => DropdownMenuItem(
                                value: title['key'],
                                child: Text(title['labelAr'] ?? ''),
                              ),
                            )
                            .toList(),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'مطلوب' : null,
                        onChanged: (value) {
                          setState(() => _selectedProfessionalTitleKey = value);
                        },
                      ),
                      const SizedBox(height: 14),
                      DropdownButtonFormField<String>(
                        value: _selectedSpecialtyKey,
                        decoration: const InputDecoration(
                          labelText: 'Specialty',
                          border: OutlineInputBorder(),
                        ),
                        items: _specialties
                            .map(
                              (specialty) => DropdownMenuItem(
                                value: specialty['key'],
                                child: Text(specialty['label'] ?? ''),
                              ),
                            )
                            .toList(),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'مطلوب' : null,
                        onChanged: (value) {
                          setState(() => _selectedSpecialtyKey = value);
                        },
                      ),
                      const SizedBox(height: 14),
                      _textField(
                        _emailController,
                        'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          final email = value?.trim() ?? '';
                          if (email.isEmpty) return 'مطلوب';
                          if (!email.contains('@')) return 'Email invalid';
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      _textField(
                        _passwordController,
                        'Password',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      _textField(
                        _confirmPasswordController,
                        'Confirm password',
                        obscureText: true,
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      _textField(_photoUrlController, 'Photo URL'),
                      const SizedBox(height: 14),
                      _textField(_bioController, 'Bio', maxLines: 3),
                      const SizedBox(height: 14),
                      _textField(_sessionPriceController, 'Session price'),
                      const SizedBox(height: 14),
                      _textField(_sessionDurationController, 'Session duration'),
                      const SizedBox(height: 14),
                      CheckboxListTile(
                        value: _offersOnline,
                        onChanged: (value) {
                          setState(() => _offersOnline = value ?? false);
                        },
                        title: const Text('Online sessions'),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        value: _offersInPerson,
                        onChanged: (value) {
                          setState(() => _offersInPerson = value ?? false);
                        },
                        title: const Text('In-person sessions'),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        value: _offersGroupSessions,
                        onChanged: (value) {
                          setState(
                            () => _offersGroupSessions = value ?? false,
                          );
                        },
                        title: const Text('Offers group sessions'),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      const SizedBox(height: 14),
                      _textField(
                        _identityFileNameController,
                        'Identity file name',
                        validator: _required,
                      ),
                      const SizedBox(height: 14),
                      _textField(
                        _certificateFileNameController,
                        'Certificate file name',
                        validator: _required,
                      ),
                      const SizedBox(height: 14),
                      _textField(
                        _extraFileNameController,
                        'Extra file name (optional)',
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 14),
                        Text(
                          _error!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _isSubmitting ? null : _submit,
                          child: _isSubmitting
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Submit for review'),
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
    );
  }

  Widget _textField(
    TextEditingController controller,
    String label, {
    bool obscureText = false,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
