# Federation Localization Foundation

Wave M-7 creates one localization language system for reports, identity,
guidance, info cards, archive labels, monitoring labels, and accessibility.

This foundation does not create UI, widgets, screens, dashboards, exports, PDF,
Excel, Firebase, Firestore, collections, writes, or audio generation.

## Localization Scopes

`LocalizationScopeRegistry` supports:

- department labels
- report sections
- report metadata
- archive labels
- meeting pack labels
- info card labels
- accessibility labels
- guidance labels
- monitoring labels
- commercial labels
- operational labels

## Localized Text

`FederationLocalizedText` supports:

- Arabic
- English
- plain text
- easy reading text
- audio label
- screen reader label

No audio files are generated.

## Department Labels

`DepartmentLocalizationMap` includes:

- residential
- commercial
- technical
- support
- registry
- declaration review
- commercial services
- archive
- monitoring
- owner strategy
- owner
- ecosystem

Every department has AR/EN names, short labels, easy reading labels, and screen
reader labels.

## Report Labels

`ReportLocalizationMap` includes labels for:

- Executive Summary
- Signals
- Aggregates
- Trends
- Risks
- Opportunities
- Recommendations
- Human Analysis
- AI Analysis
- Constitutional Alignment

## Archive Labels

`ArchiveLocalizationMap` includes:

- archive code
- retention class
- archive eligibility
- classification
- report version
- created at
- period
- department

## Info Card Localization

`UniversalInfoCardContract` now supports:

- title localized
- short description localized
- learn more label localized
- audio label localized
- screen reader label localized

No card UI is introduced.

## Accessibility Text Profiles

`AccessibilityTextProfile` supports:

- standard
- easy reading
- screen reader
- audio assisted
- visual assisted

## Guidance Text

`GuidanceTextContract` supports:

- guidance id
- title
- short text
- easy text
- audio label
- screen reader label
- category

## Forbidden Legacy Language

New federation text must reject:

- booking
- session request
- payment proof
- admin approval
- assignment
- payout
- commission
- حجز
- طلب جلسة
- إثبات دفع
- موافقة أدمن
- تعيين
- عمولة
- صرف مستحقات

These words may remain only in legacy or archive contexts, not in new
foundation language.

## Contact Language Standard

The official relationship term is:

- تواصل
- Contact

It replaces request, booking, appointment, and session language in new
federation surfaces.

## Federation Separation Readiness

Localization Ready: YES

Naming Ready: YES

Monitoring Ready: YES

Archive Ready: YES

Visual Identity Ready: YES

Accessibility Ready: YES

Separation Ready: YES

## Success State

New federation layers now speak one language across:

```text
Reports
+
Archive
+
Identity
+
Info Cards
+
Guidance
+
Accessibility
```

in Arabic and English from the start.
