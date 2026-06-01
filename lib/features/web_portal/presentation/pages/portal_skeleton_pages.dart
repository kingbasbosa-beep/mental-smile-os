import 'package:flutter/material.dart';

class PortalHomePage extends StatelessWidget {
  const PortalHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PortalScaffold(
      currentRoute: '/',
      child: _PortalHeroHome(),
    );
  }
}

class PortalAboutPage extends StatelessWidget {
  const PortalAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PortalScaffold(
      currentRoute: '/about',
      child: _PortalTextPage(
        title: 'About Mental Smile',
        subtitle: 'Mental Smile Service Marketplace + Operational Federation',
        body:
            'Mental Smile is not a centralized session booking platform. It is a service marketplace and operational federation for access, support, transparency, education, and professional services.',
      ),
    );
  }
}

class PortalLibraryPage extends StatelessWidget {
  const PortalLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PortalScaffold(
      currentRoute: '/library',
      child: _PortalTextPage(
        title: 'Library Project',
        subtitle: 'Coming Soon',
        body:
            'The Mental Smile Library will host education, prevention, support content, exercises, guides, and future accessibility-aware resources.',
      ),
    );
  }
}

class PortalProviderRegistrationPage extends StatelessWidget {
  const PortalProviderRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PortalScaffold(
      currentRoute: '/register/provider',
      child: _PortalTextPage(
        title: 'Provider Registration',
        subtitle: 'Phase 1 Intake Form',
        body:
            'Coming Next Phase. This page will become the first intake point for providers without approval automation, Firebase writes, or runtime registration logic.',
      ),
    );
  }
}

class PortalCenterRegistrationPage extends StatelessWidget {
  const PortalCenterRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PortalScaffold(
      currentRoute: '/register/center',
      child: _PortalTextPage(
        title: 'Center Registration',
        subtitle: 'Phase 1 Intake Form',
        body:
            'Coming Next Phase. This page will become the first intake point for centers without approval automation, Firebase writes, or runtime registration logic.',
      ),
    );
  }
}

class PortalServiceRequestPage extends StatelessWidget {
  const PortalServiceRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _PortalScaffold(
      currentRoute: '/request/service',
      child: _PortalIntakePage(
        title: 'Service Request',
        subtitle: 'Commerce Intake + Service Request',
        disclaimer:
            'This is an intake request only. Mental Smile will review the request and contact you manually. No quote, approval, payment, or execution is guaranteed by submitting this form.',
        submitLabel: 'Submit request - coming next phase',
        fields: [
          _PortalReadOnlyField(label: 'Requester name'),
          _PortalReadOnlyField(label: 'Email'),
          _PortalReadOnlyField(label: 'Phone'),
          _PortalReadOnlyField(label: 'Organization name'),
          _PortalSelectField(
            label: 'Service type',
            value: 'Marketing Campaign',
            options: [
              'Marketing Campaign',
              'Content Creation',
              'Technical Service',
              'AI Service',
              'White Label / Tenant',
              'Partnership',
            ],
          ),
          _PortalReadOnlyField(label: 'Request summary', maxLines: 4),
          _PortalReadOnlyField(label: 'Budget range'),
          _PortalReadOnlyField(label: 'Timeline'),
          _PortalBooleanField(label: 'Needs discovery call'),
          _PortalReadOnlyField(label: 'Notes', maxLines: 3),
        ],
      ),
    );
  }
}

class PortalPackageRequestPage extends StatelessWidget {
  const PortalPackageRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _PortalScaffold(
      currentRoute: '/request/package',
      child: _PortalIntakePage(
        title: 'Package Request',
        subtitle: 'Package + Subscription Intake',
        disclaimer:
            'Package requests are reviewed manually. Payment instructions and receipts are issued only after review by Mental Smile.',
        submitLabel: 'Request package - coming next phase',
        fields: [
          _PortalReadOnlyField(label: 'Requester name'),
          _PortalReadOnlyField(label: 'Email'),
          _PortalReadOnlyField(label: 'Phone'),
          _PortalReadOnlyField(label: 'Provider / center name'),
          _PortalSelectField(
            label: 'Package type',
            value: 'Subscription',
            options: [
              'Subscription',
              'Verification',
              'Visibility Package',
              'Tool / AI Package',
              'Optional Module Rental',
            ],
          ),
          _PortalReadOnlyField(label: 'Billing preference'),
          _PortalBooleanField(label: 'Needs quote'),
          _PortalReadOnlyField(label: 'Notes', maxLines: 3),
        ],
      ),
    );
  }
}

class PortalContactPage extends StatelessWidget {
  const PortalContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _PortalScaffold(
      currentRoute: '/contact',
      child: _PortalIntakePage(
        title: 'Contact',
        subtitle: 'General Contact Gateway',
        disclaimer:
            'This contact form is for general intake only. Urgent or emergency support is not handled through this portal.',
        submitLabel: 'Send message - coming next phase',
        fields: [
          _PortalReadOnlyField(label: 'Name'),
          _PortalReadOnlyField(label: 'Email'),
          _PortalReadOnlyField(label: 'Phone'),
          _PortalSelectField(
            label: 'Topic',
            value: 'General inquiry',
            options: [
              'General inquiry',
              'Provider question',
              'Center question',
              'Business request',
              'Support program',
              'Other',
            ],
          ),
          _PortalReadOnlyField(label: 'Message', maxLines: 4),
          _PortalReadOnlyField(label: 'Preferred contact method'),
        ],
      ),
    );
  }
}

class _PortalScaffold extends StatelessWidget {
  const _PortalScaffold({
    required this.currentRoute,
    required this.child,
  });

  final String currentRoute;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _PortalNavbar(currentRoute: currentRoute),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1100),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 42,
                      ),
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
            const _PortalFooter(),
          ],
        ),
      ),
    );
  }
}

class _PortalNavbar extends StatelessWidget {
  const _PortalNavbar({required this.currentRoute});

  final String currentRoute;

  static const List<_PortalNavItem> _items = <_PortalNavItem>[
    _PortalNavItem('Home', '/'),
    _PortalNavItem('About', '/about'),
    _PortalNavItem('Library', '/library'),
    _PortalNavItem('Providers', '/register/provider'),
    _PortalNavItem('Centers', '/register/center'),
    _PortalNavItem('Services', '/request/service'),
    _PortalNavItem('Packages', '/request/package'),
    _PortalNavItem('Contact', '/contact'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE1E5EE))),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              runSpacing: 8,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsetsDirectional.only(end: 20),
                  child: Text(
                    'Mental Smile',
                    style: TextStyle(
                      color: Color(0xFF172033),
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                for (final item in _items)
                  _PortalNavButton(
                    label: item.label,
                    route: item.route,
                    selected: currentRoute == item.route,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PortalNavButton extends StatelessWidget {
  const _PortalNavButton({
    required this.label,
    required this.route,
    required this.selected,
  });

  final String label;
  final String route;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: selected ? null : () => Navigator.of(context).pushNamed(route),
      style: TextButton.styleFrom(
        foregroundColor:
            selected ? const Color(0xFF4A6CF7) : const Color(0xFF33415C),
        disabledForegroundColor: const Color(0xFF4A6CF7),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
      child: Text(label),
    );
  }
}

class _PortalHeroHome extends StatelessWidget {
  const _PortalHeroHome();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Mental Smile',
          style: TextStyle(
            color: Color(0xFF172033),
            fontSize: 48,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Constitutional Operational Federation',
          style: TextStyle(
            color: Color(0xFF4A6CF7),
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 28),
        const Text(
          'Marketplace\n+\nSupport Ecosystem\n+\nProfessional Services',
          style: TextStyle(
            color: Color(0xFF26324A),
            fontSize: 30,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const <Widget>[
            _PortalActionButton(
              label: 'Register as Provider',
              route: '/register/provider',
            ),
            _PortalActionButton(
              label: 'Register as Center',
              route: '/register/center',
            ),
            _PortalActionButton(
              label: 'Request Service',
              route: '/request/service',
            ),
            _PortalActionButton(label: 'Library', route: '/library'),
            _PortalActionButton(label: 'Contact', route: '/contact'),
            _PortalActionButton(
              label: 'Open Mental Smile App / الدخول إلى التطبيق',
              route: '/splash',
            ),
          ],
        ),
      ],
    );
  }
}

class _PortalTextPage extends StatelessWidget {
  const _PortalTextPage({
    required this.title,
    required this.subtitle,
    required this.body,
  });

  final String title;
  final String subtitle;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF172033),
            fontSize: 40,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFF4A6CF7),
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          body,
          style: const TextStyle(
            color: Color(0xFF33415C),
            fontSize: 18,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _PortalIntakePage extends StatelessWidget {
  const _PortalIntakePage({
    required this.title,
    required this.subtitle,
    required this.disclaimer,
    required this.submitLabel,
    required this.fields,
  });

  final String title;
  final String subtitle;
  final String disclaimer;
  final String submitLabel;
  final List<Widget> fields;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF172033),
            fontSize: 40,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFF4A6CF7),
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE8D8A8)),
          ),
          child: Text(
            disclaimer,
            style: const TextStyle(
              color: Color(0xFF5E4B1B),
              fontSize: 15,
              height: 1.45,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 22),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE1E5EE)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'Phase 1 UI only',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 14),
                  for (final field in fields) ...[
                    field,
                    const SizedBox(height: 14),
                  ],
                  FilledButton(
                    onPressed: null,
                    child: Text(submitLabel),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PortalReadOnlyField extends StatelessWidget {
  const _PortalReadOnlyField({
    required this.label,
    this.maxLines = 1,
  });

  final String label;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        helperText: 'Coming next phase',
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class _PortalSelectField extends StatelessWidget {
  const _PortalSelectField({
    required this.label,
    required this.value,
    required this.options,
  });

  final String label;
  final String value;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        helperText: 'Coming next phase',
        border: const OutlineInputBorder(),
      ),
      items: options
          .map(
            (option) => DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            ),
          )
          .toList(),
      onChanged: null,
    );
  }
}

class _PortalBooleanField extends StatelessWidget {
  const _PortalBooleanField({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: false,
      onChanged: null,
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      subtitle: const Text('Coming next phase'),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}

class _PortalActionButton extends StatelessWidget {
  const _PortalActionButton({
    required this.label,
    required this.route,
  });

  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => Navigator.of(context).pushNamed(route),
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFF4A6CF7),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      ),
      child: Text(label),
    );
  }
}

class _PortalFooter extends StatelessWidget {
  const _PortalFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE1E5EE))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: const Text(
        'Mental Smile  |  Owner Operated Portal  |  Phase 1 Skeleton',
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xFF5C667A)),
      ),
    );
  }
}

class _PortalNavItem {
  const _PortalNavItem(this.label, this.route);

  final String label;
  final String route;
}
