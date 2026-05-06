import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/web_registration/data/web_registration_draft_store.dart';
import 'package:flutterprojects/features/web_registration/presentation/web_registration_background.dart';

class WebClinicianProfilePage extends StatefulWidget {
  const WebClinicianProfilePage({super.key});

  @override
  State<WebClinicianProfilePage> createState() =>
      _WebClinicianProfilePageState();
}

class _WebClinicianProfilePageState extends State<WebClinicianProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _photoUrlController = TextEditingController();
  final _bioController = TextEditingController();
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
    _photoUrlController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  String? get _uid =>
      FirebaseAuth.instance.currentUser?.uid ??
      WebRegistrationDraftStore.clinicianUid;

  Future<void> _saveProfileFields(String uid) async {
    final profileFields = {
      'photoUrl': _photoUrlController.text.trim(),
      'bio': _bioController.text.trim(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
    final docRef = FirebaseFirestore.instance.collection('clinicians').doc(uid);

    try {
      await docRef.update(profileFields);
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        await docRef.set(profileFields, SetOptions(merge: true));
        return;
      }
      rethrow;
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final authUser = FirebaseAuth.instance.currentUser;
    if (authUser == null) {
      setState(() => _error = 'Authentication session missing');
      return;
    }

    final uid = _uid;
    if (uid == null) {
      setState(() => _error = 'Please start registration from account step');
      return;
    }

    setState(() {
      _isSaving = true;
      _error = null;
    });

    try {
      await _saveProfileFields(uid);

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(Routes.webClinicianSessions);
    } on FirebaseException {
      if (mounted) {
        setState(() => _error = 'Unable to save profile');
      }
    } catch (_) {
      if (mounted) setState(() => _error = 'Unable to save profile');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                fileName: 'clinicians_step_2_profile.png',
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
                              const Text(
                                'Clinician Registration - Profile',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _textField(_photoUrlController, 'Photo URL'),
                              const SizedBox(height: 10),
                              _textField(_bioController, 'Bio', maxLines: 4),
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
                                  onPressed:
                                      _isSaving || _uid == null ? null : _save,
                                  child: _isSaving
                                      ? const CircularProgressIndicator()
                                      : const Text('Next: Sessions'),
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
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
