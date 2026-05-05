import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/web_registration/data/web_registration_draft_store.dart';

class WebCenterDocumentsPage extends StatefulWidget {
  const WebCenterDocumentsPage({super.key});

  @override
  State<WebCenterDocumentsPage> createState() => _WebCenterDocumentsPageState();
}

class _WebCenterDocumentsPageState extends State<WebCenterDocumentsPage> {
  bool _isSaving = false;
  String? _error;

  Future<void> _submit() async {
    setState(() {
      _isSaving = true;
      _error = null;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      final uid = user?.uid ?? WebRegistrationDraftStore.centerUid;

      if (uid == null) {
        setState(() {
          _error = 'Missing user session';
        });
        return;
      }

      final centerRef = FirebaseFirestore.instance.collection('centers').doc(uid);
      final centerDoc = await centerRef.get();
      final data = centerDoc.data() ?? const <String, dynamic>{};
      final documentItems = data['documentItems'];
      final hasDocuments = documentItems is List && documentItems.isNotEmpty;

      await centerRef.update({
        'documentsReady': hasDocuments,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Documents submitted successfully')),
      );

      Navigator.of(context)
          .pushReplacementNamed(Routes.webRegistrationSuccess);

    } catch (e) {
      setState(() {
        _error = 'Failed to submit documents';
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
      body: Center(
        child: Container(
          width: 420,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black12,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Center Documents',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              const Text(
                'Upload required documents (coming next)',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),

              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: _isSaving ? null : _submit,
                child: _isSaving
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Submit Documents'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
