# Federation Visual Identity Foundation

Wave M-6 creates one visual identity language for Mental Smile Federation.

This foundation does not create Flutter UI, widgets, themes, screens,
dashboards, exports, PDF, Excel, Firebase, or Firestore.

## Departments

The federation identity registry includes:

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

Each department has:

- department id
- Arabic display name
- English display name
- primary color token
- secondary color token
- icon key
- report prefix
- stripe color
- identity code

## Colors

`FederationColorToken` supports:

- gold
- deep blue
- turquoise
- purple
- orange
- green
- gray
- black
- white

No theme or rendering is introduced.

## Labels

`DepartmentLabelProfile` supports:

- short Arabic label
- short English label
- full Arabic label
- full English label

## Report Identity

`ReportIdentityProfile` supports:

- department id
- report prefix
- stripe color
- label style
- archive stamp

## Meeting Identity

`MeetingIdentityProfile` supports:

- meeting type
- header style
- summary style
- strategic style

## Archive Identity

`ArchiveIdentityProfile` supports:

- archive code prefix
- archive color
- retention marker
- classification marker

## Accessibility Profiles

`AccessibilityVisualProfile` supports:

- standard
- easy reading
- high visibility
- audio assisted
- visual assisted

No accessibility rendering is introduced in this wave.

## Universal Info Card Identity

`UniversalInfoCardContract` now supports identity metadata:

- card identity profile
- accessibility profile
- content type

No card UI is introduced.

## Report Codes

`ReportCodeConventionRegistry` defines examples:

- `RES-W-2026-001`
- `COM-W-2026-001`
- `TEC-W-2026-001`
- `SUP-W-2026-001`
- `MON-W-2026-001`
- `STR-M-2026-001`
- `CON-Q-2026-001`

## Identity Boundary

Identity naming must reject:

- booking
- session
- payment
- admin lifecycle

## Federation Separation Readiness

Localization Ready: YES

Naming Ready: YES

Monitoring Ready: YES

Archive Ready: YES

Visual Identity Ready: YES

Accessibility Ready: YES

Separation Ready: YES

## Success State

Every federation department now has:

```text
Name
+
Color
+
Label
+
Report Identity
+
Archive Identity
+
Accessibility Identity
```

The foundation chain is now:

```text
Monitoring
-> Memory
-> Reports
-> Identity
```
