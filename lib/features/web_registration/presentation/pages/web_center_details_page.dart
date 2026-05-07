import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';

class WebCenterDetailsPage extends StatefulWidget {
  const WebCenterDetailsPage({super.key});

  @override
  State<WebCenterDetailsPage> createState() => _WebCenterDetailsPageState();
}

class _WebCenterDetailsPageState extends State<WebCenterDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  String centerType = 'addiction';
  String residency = 'in';

  final roomsController = TextEditingController();
  final bedsController = TextEditingController();

  bool _isSaving = false;
  String? _error;

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
      _error = null;
    });

    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw Exception('User not logged in');

      await FirebaseFirestore.instance.collection('centers').doc(uid).update({
        'centerType': centerType,
        'residency': residency,
        'roomsCount': int.tryParse(roomsController.text.trim()) ?? 0,
        'bedsCount': int.tryParse(bedsController.text.trim()) ?? 0,
        'detailsReady': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        Routes.webRegistrationSuccess,
        arguments: const {'source': 'center'},
      );
    } catch (e) {
      setState(() {
        _error = 'Failed to save details';
      });
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  void dispose() {
    roomsController.dispose();
    bedsController.dispose();
    super.dispose();
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
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black12,
              )
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Center Details',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: centerType,
                  decoration: const InputDecoration(labelText: 'Center Type'),
                  items: const [
                    DropdownMenuItem(
                        value: 'addiction', child: Text('Addiction')),
                    DropdownMenuItem(
                        value: 'mental', child: Text('Mental Health')),
                    DropdownMenuItem(value: 'both', child: Text('Both')),
                  ],
                  onChanged: (v) => setState(() => centerType = v!),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: residency,
                  decoration: const InputDecoration(labelText: 'Residency'),
                  items: const [
                    DropdownMenuItem(value: 'in', child: Text('In-house')),
                    DropdownMenuItem(value: 'out', child: Text('Outpatient')),
                    DropdownMenuItem(value: 'both', child: Text('Both')),
                  ],
                  onChanged: (v) => setState(() => residency = v!),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: roomsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Rooms Count'),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: bedsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Beds Count'),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                if (_error != null)
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _isSaving ? null : _save,
                  child: _isSaving
                      ? const CircularProgressIndicator()
                      : const Text('Save & Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
