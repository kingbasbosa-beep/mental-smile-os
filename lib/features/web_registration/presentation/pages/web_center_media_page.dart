import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/web_registration/data/web_registration_draft_store.dart';
import 'package:flutterprojects/features/web_registration/presentation/web_registration_background.dart';

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
    final uid = FirebaseAuth.instance.currentUser?.uid ??
        WebRegistrationDraftStore.centerUid;
    if (uid == null) {
      setState(() => _error = 'Missing center session');
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
      if (mounted) setState(() => _error = 'Failed to save media');
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
                              const Text(
                                'Center Registration - Media & Gallery',
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
                                label: const Text('مكتبة الإرشاد'),
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
                                  _frontImageController, 'Front image URL'),
                              _textField(
                                _receptionImageController,
                                'Reception image URL',
                              ),
                              _textField(_inside1ImageController,
                                  'Inside image 1 URL'),
                              _textField(_inside2ImageController,
                                  'Inside image 2 URL'),
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
                                      : const Text(
                                          'Next: Pricing & Capabilities'),
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
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
