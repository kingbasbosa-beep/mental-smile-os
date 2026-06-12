import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/web_registration/data/web_registration_draft_store.dart';
import 'package:flutterprojects/features/web_registration/domain/declaration_readiness.dart';
import 'package:flutterprojects/features/web_registration/presentation/web_registration_background.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';

class WebClinicianDocumentsPage extends StatefulWidget {
  const WebClinicianDocumentsPage({super.key});

  @override
  State<WebClinicianDocumentsPage> createState() =>
      _WebClinicianDocumentsPageState();
}

class _WebClinicianDocumentsPageState extends State<WebClinicianDocumentsPage> {
  final _formKey = GlobalKey<FormState>();
  final _identityFileNameController = TextEditingController();
  final _certificateFileNameController = TextEditingController();
  final _extraFileNameController = TextEditingController();
  bool _isSaving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (_uid == null) {
      _error = 'Please start registration from account step';
    }
  }

  @override
  void dispose() {
    _identityFileNameController.dispose();
    _certificateFileNameController.dispose();
    _extraFileNameController.dispose();
    super.dispose();
  }

  String? get _uid =>
      FirebaseAuth.instance.currentUser?.uid ??
      WebRegistrationDraftStore.clinicianUid;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context)!;
    final uid = _uid;
    if (uid == null) {
      setState(() => _error = l10n.webClinicianStartFromAccountStep);
      return;
    }

    setState(() {
      _isSaving = true;
      _error = null;
    });

    try {
      final docRef =
          FirebaseFirestore.instance.collection('clinicians').doc(uid);
      final snapshot = await docRef.get();
      final changes = <String, dynamic>{
        'documentsSubmitted': true,
        'documentsUploadMode': 'web_registration',
        'identityFileName': _identityFileNameController.text.trim(),
        'certificateFileName': _certificateFileNameController.text.trim(),
        'extraFileName': _extraFileNameController.text.trim(),
        'identityDocumentUrl': '',
        'certificateDocumentUrl': '',
        'extraDocumentUrl': '',
        'updatedAt': FieldValue.serverTimestamp(),
      };
      await docRef.update(
        DeclarationReadiness.clinicianPayload(
          currentData: snapshot.data() ?? const <String, dynamic>{},
          changes: changes,
        ),
      );

      WebRegistrationDraftStore.clearClinicianUid();
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(
        Routes.webRegistrationSuccess,
        arguments: const {'source': 'clinician'},
      );
    } catch (_) {
      if (mounted) {
        setState(() => _error = l10n.webClinicianSubmitDocumentsFailed);
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.authRequiredField;
    }
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
                roleFolder: 'clinicians',
                fileName: 'clinicians_step_4_documents.png',
              ),
              fit: BoxFit.contain,
            ),
            Container(color: Colors.black.withValues(alpha: 0.10)),
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
                    constraints: const BoxConstraints(maxWidth: 440),
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
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 16),
                              const Text(
                                'Document declaration step: submitted licenses and documents remain the applicant responsibility. Visibility depends on readiness completeness.',
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
                                _identityFileNameController,
                                l10n.webClinicianIdentityFileName,
                                validator: _required,
                              ),
                              const SizedBox(height: 10),
                              _textField(
                                _certificateFileNameController,
                                l10n.webClinicianCertificateFileName,
                                validator: _required,
                              ),
                              const SizedBox(height: 10),
                              _textField(
                                _extraFileNameController,
                                l10n.webClinicianExtraFileNameOptional,
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
                                  onPressed: _isSaving || _uid == null
                                      ? null
                                      : _submit,
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
                                      : Text(l10n.webCenterSubmitForReview),
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
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
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
}
