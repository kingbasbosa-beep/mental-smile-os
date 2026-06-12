import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/web_registration/data/web_registration_draft_store.dart';
import 'package:flutterprojects/features/web_registration/presentation/web_registration_background.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';

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
  final _cityController = TextEditingController();
  final _areaController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _isSaving = false;
  bool _hasDetoxUnit = false;
  String? _error;

  @override
  void dispose() {
    _managerNameController.dispose();
    _phoneController.dispose();
    _whatsappController.dispose();
    _cityController.dispose();
    _areaController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context)!;

    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid ?? WebRegistrationDraftStore.centerUid;
    if (uid == null) {
      setState(() => _error = l10n.webCenterPleaseRegisterBeforeSaving);
      return;
    }

    setState(() {
      _isSaving = true;
      _error = null;
    });

    try {
      final ref = FirebaseFirestore.instance.collection('centers').doc(uid);
      final snap = await ref.get();
      final data = snap.data() ?? const <String, dynamic>{};
      final centerType = (data['centerType'] ?? '').toString();

      await ref.update({
        'managerName': _managerNameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'whatsapp': _whatsappController.text.trim(),
        'city': _cityController.text.trim(),
        'area': _areaController.text.trim(),
        'address': _addressController.text.trim(),
        'description': _descriptionController.text.trim(),
        'hasDetoxUnit': _hasDetoxUnit || centerType == 'detox',
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(Routes.webCenterMedia);
    } catch (_) {
      if (mounted) setState(() => _error = l10n.webCenterSaveProfileFailed);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.authRequiredField;
    }
    return null;
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
                fileName: 'centers_step_2_profile.png',
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
                    constraints: const BoxConstraints(maxWidth: 460),
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
                                'Center declaration step: visibility depends on required readiness signals and safety status.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  height: 1.35,
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextButton(
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(Routes.portalHome),
                                child: Text(
                                  Localizations.localeOf(context)
                                              .languageCode
                                              .toLowerCase() ==
                                          'ar'
                                      ? 'العودة إلى بوابة Mental Smile'
                                      : 'Back to Mental Smile Portal',
                                ),
                              ),
                              const SizedBox(height: 8),
                              _textField(
                                _managerNameController,
                                l10n.webCenterManagerName,
                              ),
                              _textField(
                                _phoneController,
                                l10n.centerPhone,
                                keyboardType: TextInputType.phone,
                              ),
                              _textField(
                                _whatsappController,
                                l10n.centerWhatsapp,
                                keyboardType: TextInputType.phone,
                              ),
                              _textField(_cityController, l10n.centerCity),
                              _textField(
                                _areaController,
                                l10n.webCenterArea,
                                required: false,
                              ),
                              _textField(
                                _addressController,
                                l10n.centerAddress,
                              ),
                              _textField(
                                _descriptionController,
                                l10n.webCenterDescription,
                                maxLines: 3,
                              ),
                              CheckboxListTile(
                                value: _hasDetoxUnit,
                                onChanged: _isSaving
                                    ? null
                                    : (value) {
                                        setState(() =>
                                            _hasDetoxUnit = value ?? false);
                                      },
                                title: Text(l10n.webCenterHasDetoxUnit),
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
                                      : Text(l10n.webCenterNextMediaGallery),
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
        validator: (value) {
          if (!required) return null;
          return _required(value);
        },
      ),
    );
  }
}
