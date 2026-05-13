import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/web_registration/data/web_registration_draft_store.dart';
import 'package:flutterprojects/features/web_registration/presentation/web_registration_background.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';

class WebClinicianSessionsPage extends StatefulWidget {
  const WebClinicianSessionsPage({super.key});

  @override
  State<WebClinicianSessionsPage> createState() =>
      _WebClinicianSessionsPageState();
}

class _WebClinicianSessionsPageState extends State<WebClinicianSessionsPage> {
  final _formKey = GlobalKey<FormState>();
  final _sessionPriceController = TextEditingController();
  final _sessionDurationController = TextEditingController();
  bool _offersOnline = true;
  bool _offersInPerson = true;
  bool _offersGroupSessions = false;
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
    _sessionPriceController.dispose();
    _sessionDurationController.dispose();
    super.dispose();
  }

  String? get _uid =>
      FirebaseAuth.instance.currentUser?.uid ??
      WebRegistrationDraftStore.clinicianUid;

  List<String> _sessionModes() {
    final items = <String>[];
    if (_offersInPerson) items.add('In person');
    if (_offersOnline) items.add('Online');
    return items;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_offersOnline && !_offersInPerson) {
      setState(() => _error = 'اختر طريقة جلسة واحدة على الأقل');
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
      await FirebaseFirestore.instance
          .collection('clinicians')
          .doc(uid)
          .update({
        'sessionPriceText': _sessionPriceController.text.trim(),
        'sessionDurationText': _sessionDurationController.text.trim(),
        'sessionModes': _sessionModes(),
        'offersGroupSessions': _offersGroupSessions,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(Routes.webClinicianDocuments);
    } catch (_) {
      if (mounted) setState(() => _error = 'Failed to save sessions');
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
                roleFolder: 'clinicians',
                fileName: 'clinicians_step_3_sessions.png',
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
                              Text(
                                l10n.webClinicianSessionsTitle,
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
                              _textField(
                                _sessionPriceController,
                                l10n.webClinicianSessionPrice,
                              ),
                              const SizedBox(height: 10),
                              _textField(
                                _sessionDurationController,
                                l10n.webClinicianSessionDuration,
                              ),
                              const SizedBox(height: 10),
                              CheckboxListTile(
                                value: _offersOnline,
                                onChanged: _isSaving
                                    ? null
                                    : (value) {
                                        setState(() =>
                                            _offersOnline = value ?? false);
                                      },
                                title: Text(l10n.webClinicianOnlineSessions),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                              CheckboxListTile(
                                value: _offersInPerson,
                                onChanged: _isSaving
                                    ? null
                                    : (value) {
                                        setState(
                                          () =>
                                              _offersInPerson = value ?? false,
                                        );
                                      },
                                title: Text(l10n.webClinicianInPersonSessions),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                              CheckboxListTile(
                                value: _offersGroupSessions,
                                onChanged: _isSaving
                                    ? null
                                    : (value) {
                                        setState(
                                          () => _offersGroupSessions =
                                              value ?? false,
                                        );
                                      },
                                title: Text(l10n.webClinicianGroupSessions),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
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
                                  onPressed:
                                      _isSaving || _uid == null ? null : _save,
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

  Widget _textField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
