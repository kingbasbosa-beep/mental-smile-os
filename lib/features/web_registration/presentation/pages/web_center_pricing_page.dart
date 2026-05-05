import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/centers/data/models/center_pricing.dart';
import 'package:flutterprojects/features/web_registration/data/web_registration_draft_store.dart';

class WebCenterPricingPage extends StatefulWidget {
  const WebCenterPricingPage({super.key});

  @override
  State<WebCenterPricingPage> createState() => _WebCenterPricingPageState();
}

class _WebCenterPricingPageState extends State<WebCenterPricingPage> {
  final _formKey = GlobalKey<FormState>();
  final _accommodationCostController = TextEditingController();
  final _sessionCostController = TextEditingController();
  final _notesController = TextEditingController();

  bool _isSaving = false;
  String? _error;

  @override
  void dispose() {
    _accommodationCostController.dispose();
    _sessionCostController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid ?? WebRegistrationDraftStore.centerUid;

    if (uid == null) {
      setState(() {
        _error = 'Please register or sign in before saving pricing.';
      });
      return;
    }

    setState(() {
      _isSaving = true;
      _error = null;
    });

    try {
      final accommodationPrice =
          double.tryParse(_accommodationCostController.text.trim()) ?? 0;
      final autismSessionPrice =
          double.tryParse(_sessionCostController.text.trim()) ?? 0;
      final accommodationCosts = defaultAccommodationCostItems()
          .map(
            (item) => item.key == 'shared_room'
                ? item.copyWith(
                    enabled: accommodationPrice > 0,
                    price: accommodationPrice,
                    pricingUnit: 'month',
                  )
                : item,
          )
          .map((item) => item.toMap())
          .toList();
      final autismCareCosts = defaultAutismCareCostItems()
          .map(
            (item) => item.key == 'daily_hosting_at_center'
                ? item.copyWith(
                    enabled: autismSessionPrice > 0,
                    price: autismSessionPrice,
                    pricingUnit: 'day',
                  )
                : item,
          )
          .map((item) => item.toMap())
          .toList();

      await FirebaseFirestore.instance.collection('centers').doc(uid).update({
        'accommodationCostText': _accommodationCostController.text.trim(),
        'sessionCostText': _sessionCostController.text.trim(),
        'pricingNotes': _notesController.text.trim(),
        'accommodationCosts': accommodationCosts,
        'autismCareCosts': autismCareCosts,
        'pricingReady': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pricing saved successfully')),
      );

      await Future<void>.delayed(const Duration(milliseconds: 350));
      if (!mounted) return;

      Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
        Routes.webCenterDocuments,
        (route) => false,
      );
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Failed to save pricing.';
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
      backgroundColor: const Color(0xFFF7F3EA),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Card(
            elevation: 8,
            margin: const EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Center Pricing',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _accommodationCostController,
                      decoration: const InputDecoration(
                        labelText: 'Accommodation cost',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _sessionCostController,
                      decoration: const InputDecoration(
                        labelText: 'Session cost',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _notesController,
                      decoration: const InputDecoration(
                        labelText: 'Pricing notes',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 14),
                      Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _save,
                        child: _isSaving
                            ? const CircularProgressIndicator()
                            : const Text('Save Pricing'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




