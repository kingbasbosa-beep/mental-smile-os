import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/centers/presentation/center_document_requirements.dart';
import 'package:flutterprojects/features/web_registration/data/web_registration_draft_store.dart';
import 'package:flutterprojects/features/web_registration/presentation/web_registration_background.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';

class WebCenterDocumentsPage extends StatefulWidget {
  const WebCenterDocumentsPage({super.key});

  @override
  State<WebCenterDocumentsPage> createState() => _WebCenterDocumentsPageState();
}

class _WebCenterDocumentsPageState extends State<WebCenterDocumentsPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _fileNameControllers = {};
  final Map<String, TextEditingController> _fileUrlControllers = {};
  final Map<String, TextEditingController> _reviewNoteControllers = {};
  bool _isSaving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    for (final item in kRequiredCenterDocumentTypes) {
      final key = item['key'] ?? '';
      _fileNameControllers[key] = TextEditingController();
      _fileUrlControllers[key] = TextEditingController();
      _reviewNoteControllers[key] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final controller in _fileNameControllers.values) {
      controller.dispose();
    }
    for (final controller in _fileUrlControllers.values) {
      controller.dispose();
    }
    for (final controller in _reviewNoteControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  List<Map<String, dynamic>> _documentItems() {
    return kRequiredCenterDocumentTypes.map((item) {
      final type = item['key'] ?? '';
      final fileName = _fileNameControllers[type]?.text.trim() ?? '';
      return {
        'documentType': type,
        'fileName': fileName,
        'originalFileName': fileName,
        'fileUrl': _fileUrlControllers[type]?.text.trim() ?? '',
        'uploadedAt': DateTime.now().toIso8601String(),
        'status': 'pending',
        'reviewNote': _reviewNoteControllers[type]?.text.trim() ?? '',
        'storagePath': '',
      };
    }).toList();
  }

  bool _hasRequiredDocuments(List<Map<String, dynamic>> docs) {
    for (final item in kRequiredCenterDocumentTypes) {
      final type = item['key'] ?? '';
      final match = docs.where(
        (doc) =>
            (doc['documentType'] ?? '').toString() == type &&
            (doc['fileName'] ?? '').toString().trim().isNotEmpty,
      );
      if (match.isEmpty) return false;
    }
    return true;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context)!;

    setState(() {
      _isSaving = true;
      _error = null;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      final uid = user?.uid ?? WebRegistrationDraftStore.centerUid;

      if (uid == null) {
        setState(() => _error = l10n.webCenterMissingSession);
        return;
      }

      final docs = _documentItems();
      final documentsReady = _hasRequiredDocuments(docs);

      await FirebaseFirestore.instance.collection('centers').doc(uid).update({
        'documentItems': docs,
        'documentsReady': documentsReady,
        'approvalStatus': 'pending_admin',
        'isActive': false,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      WebRegistrationDraftStore.clearCenterUid();
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(
        Routes.webRegistrationSuccess,
        arguments: const {'source': 'center'},
      );
    } catch (_) {
      if (mounted) {
        setState(() => _error = l10n.webCenterSubmitDocumentsFailed);
      }
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
                fileName: 'centers_step_5_documents.png',
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
                              ...kRequiredCenterDocumentTypes
                                  .map((item) => _documentSection(context, item)),
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
                                  onPressed: _isSaving ? null : _submit,
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

  Widget _documentSection(BuildContext context, Map<String, String> item) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final type = item['key'] ?? '';
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(isArabic ? (item['labelAr'] ?? type) : (item['labelEn'] ?? type)),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          TextFormField(
            controller: _fileNameControllers[type],
            validator: _required,
            style: const TextStyle(
              color: Color(0xFFFFF6DE),
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              labelText: l10n.webCenterFileName,
              labelStyle: const TextStyle(color: Color(0xFFE8C878)),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFEDEDED), width: 1.2),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFEDEDED), width: 1.8),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _fileUrlControllers[type],
            style: const TextStyle(
              color: Color(0xFFFFF6DE),
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              labelText: l10n.webCenterFileUrlOptional,
              labelStyle: const TextStyle(color: Color(0xFFE8C878)),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFEDEDED), width: 1.2),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFEDEDED), width: 1.8),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _reviewNoteControllers[type],
            maxLines: 2,
            style: const TextStyle(
              color: Color(0xFFFFF6DE),
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              labelText: l10n.webCenterReviewNoteOptional,
              labelStyle: const TextStyle(color: Color(0xFFE8C878)),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFEDEDED), width: 1.2),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFEDEDED), width: 1.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
