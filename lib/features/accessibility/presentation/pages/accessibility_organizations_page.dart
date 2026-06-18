import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/models/accessibility_organization.dart';
import '../../domain/models/accessibility_organization_category.dart';
import '../../domain/registries/accessibility_organization_registry.dart';

class AccessibilityOrganizationsPage extends StatefulWidget {
  const AccessibilityOrganizationsPage({super.key});

  @override
  State<AccessibilityOrganizationsPage> createState() =>
      _AccessibilityOrganizationsPageState();
}

class _AccessibilityOrganizationsPageState
    extends State<AccessibilityOrganizationsPage> {
  AccessibilityOrganizationCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final organizations =
        AccessibilityOrganizationRegistry.byCategory(_selectedCategory);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EF),
      appBar: AppBar(
        title: const Text('Organizations Directory'),
        backgroundColor: const Color(0xFFF7F4EF),
        foregroundColor: const Color(0xFF17201B),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          children: [
            _DirectoryHeader(
              onPartnershipRequest: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const PartnershipRequestPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('All'),
                  selected: _selectedCategory == null,
                  onSelected: (_) => setState(() => _selectedCategory = null),
                ),
                for (final category
                    in AccessibilityOrganizationRegistry.categories)
                  ChoiceChip(
                    label: Text(category.label),
                    selected: _selectedCategory == category,
                    onSelected: (_) {
                      setState(() => _selectedCategory = category);
                    },
                  ),
              ],
            ),
            const SizedBox(height: 16),
            if (organizations.isEmpty)
              const _EmptyDirectory()
            else
              for (final organization in organizations) ...[
                _OrganizationCard(organization: organization),
                const SizedBox(height: 12),
              ],
          ],
        ),
      ),
    );
  }
}

class _DirectoryHeader extends StatelessWidget {
  const _DirectoryHeader({required this.onPartnershipRequest});

  final VoidCallback onPartnershipRequest;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF17201B).withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Organizations Directory',
            style: TextStyle(
              color: Color(0xFF17201B),
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'A governed directory for accessibility, family, recovery, and mental health organizations. Entries require review before publication.',
            style: TextStyle(
              color: const Color(0xFF17201B).withValues(alpha: 0.70),
              fontSize: 14,
              height: 1.35,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: onPartnershipRequest,
            icon: const Icon(Icons.handshake_outlined),
            label: const Text('Request Partnership'),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF116A5B),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrganizationCard extends StatelessWidget {
  const _OrganizationCard({required this.organization});

  final AccessibilityOrganization organization;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: const Color(0xFF17201B).withValues(alpha: 0.08),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              organization.name,
              style: const TextStyle(
                color: Color(0xFF17201B),
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _MetaChip(label: organization.country),
                _MetaChip(label: organization.category.label),
                if (organization.isVerified) const _MetaChip(label: 'Verified'),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (organization.website.trim().isNotEmpty)
                  _LinkButton(
                    icon: Icons.language_outlined,
                    label: 'Website',
                    uri: Uri.tryParse(organization.website),
                  ),
                if (organization.email.trim().isNotEmpty)
                  _LinkButton(
                    icon: Icons.mail_outline,
                    label: 'Email',
                    uri: Uri(
                      scheme: 'mailto',
                      path: organization.email.trim(),
                    ),
                  ),
                if (organization.whatsapp.trim().isNotEmpty)
                  _LinkButton(
                    icon: Icons.chat_outlined,
                    label: 'WhatsApp',
                    uri: Uri.https('wa.me', '/${organization.whatsapp}'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PartnershipRequestPage extends StatefulWidget {
  const PartnershipRequestPage({super.key});

  @override
  State<PartnershipRequestPage> createState() => _PartnershipRequestPageState();
}

class _PartnershipRequestPageState extends State<PartnershipRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _country = TextEditingController();
  final _website = TextEditingController();
  final _email = TextEditingController();
  final _whatsapp = TextEditingController();
  AccessibilityOrganizationCategory _category =
      AccessibilityOrganizationCategory.familySupport;

  @override
  void dispose() {
    _name.dispose();
    _country.dispose();
    _website.dispose();
    _email.dispose();
    _whatsapp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EF),
      appBar: AppBar(
        title: const Text('Partnership Request'),
        backgroundColor: const Color(0xFFF7F4EF),
        foregroundColor: const Color(0xFF17201B),
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            children: [
              _TextInput(controller: _name, label: 'Name', required: true),
              _TextInput(
                controller: _country,
                label: 'Country',
                required: true,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<AccessibilityOrganizationCategory>(
                value: _category,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (final category
                      in AccessibilityOrganizationRegistry.categories)
                    DropdownMenuItem(
                      value: category,
                      child: Text(category.label),
                    ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _category = value);
                },
              ),
              const SizedBox(height: 12),
              _TextInput(controller: _website, label: 'Website'),
              _TextInput(controller: _email, label: 'Email'),
              _TextInput(controller: _whatsapp, label: 'WhatsApp'),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.assignment_turned_in_outlined),
                label: const Text('Prepare Request'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF116A5B),
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Partnership request prepared for governed review. No data was submitted.',
        ),
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({
    required this.controller,
    required this.label,
    this.required = false,
  });

  final TextEditingController controller;
  final String label;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: required
            ? (value) {
                if ((value ?? '').trim().isEmpty) return '$label is required';
                return null;
              }
            : null,
      ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  const _LinkButton({
    required this.icon,
    required this.label,
    required this.uri,
  });

  final IconData icon;
  final String label;
  final Uri? uri;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: uri == null
          ? null
          : () => launchUrl(uri!, mode: LaunchMode.externalApplication),
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF17201B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF17201B).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF17201B),
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _EmptyDirectory extends StatelessWidget {
  const _EmptyDirectory();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF17201B).withValues(alpha: 0.08),
        ),
      ),
      child: const Text(
        'No organizations are published yet. Partnership requests must be reviewed before an organization appears in the directory.',
        style: TextStyle(
          color: Color(0xFF17201B),
          fontSize: 14,
          height: 1.35,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
