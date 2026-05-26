import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/web_registration/data/web_registration_draft_store.dart';
import 'package:flutterprojects/features/web_registration/presentation/web_registration_background.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';

class WebCenterMediaPage extends StatefulWidget {
  const WebCenterMediaPage({super.key});

  @override
  State<WebCenterMediaPage> createState() => _WebCenterMediaPageState();
}

class _WebCenterMediaPageState extends State<WebCenterMediaPage> {
  final _formKey = GlobalKey<FormState>();
  final _frontImageController = TextEditingController();
  final _receptionImageController = TextEditingController();
  final _inside1ImageController = TextEditingController();
  final _inside2ImageController = TextEditingController();
  bool _isSaving = false;
  String? _error;

  @override
  void dispose() {
    _frontImageController.dispose();
    _receptionImageController.dispose();
    _inside1ImageController.dispose();
    _inside2ImageController.dispose();
    super.dispose();
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
    final l10n = AppLocalizations.of(context)!;
    final uid = FirebaseAuth.instance.currentUser?.uid ??
        WebRegistrationDraftStore.centerUid;
    if (uid == null) {
      setState(() => _error = l10n.webCenterMissingSession);
      return;
    }

    setState(() {
      _isSaving = true;
      _error = null;
    });

    try {
      final galleryItems = _galleryItems();
      final galleryImages = galleryItems
          .map((item) => (item['url'] ?? '').toString().trim())
          .where((url) => url.isNotEmpty)
          .toList();

      await FirebaseFirestore.instance.collection('centers').doc(uid).update({
        'galleryItems': galleryItems,
        'galleryImages': galleryImages,
        'imageUrl': galleryImages.isEmpty ? '' : galleryImages.first,
        'coverImageUrl': galleryImages.isEmpty ? '' : galleryImages.first,
        'imagesReady': galleryImages.isNotEmpty,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(Routes.webCenterPricing);
    } catch (_) {
      if (mounted) setState(() => _error = l10n.webCenterSaveMediaFailed);
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
                fileName: 'centers_step_3_media.png',
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
                              _textField(
                                _frontImageController,
                                l10n.webCenterFrontImageUrl,
                              ),
                              _textField(
                                _receptionImageController,
                                l10n.webCenterReceptionImageUrl,
                              ),
                              _textField(
                                _inside1ImageController,
                                l10n.webCenterInsideImage1Url,
                              ),
                              _textField(
                                _inside2ImageController,
                                l10n.webCenterInsideImage2Url,
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
                                      : Text(
                                          l10n.webCenterNextPricingCapabilities,
                                        ),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
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
      ),
    );
  }
}
