# mk_write_savepoint_md.ps1
# (Paste FULL script content here, then save)
# mk_write_savepoint_md.ps1
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$root = "C:\flutterprojects\mental_key_v2"
Set-Location $root

$mdPath = Join-Path $root "C0_SAVEPOINT_SYSTEM_OVERVIEW.md"
$stamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")

$md = @"
# Mental Key V2 — Savepoint (C5 + C6) — $stamp

## 0) Quick status
- MVP demo-ready (Friendly UI default) + Dev hooks behind dart-define.
- Primary dev target: Web (Chrome).
- Firebase/Firestore read/write OK; Firestore rules tightened (C4).
- Assets C5 + C6 imported + linked in pubspec.yaml.
- C6 Library UI implemented + tuned for mobile-ish layout on web.

## 1) Roles
### Client
- Sends booking request to a specific clinician with multiple suggested time slots.
- Tracks status: pending / approved / rejected.
- Payment later (handled by admin).

### Clinician
- Receives forwarded requests in inbox.
- Approve/Reject + choose slot.
- No sensitive edits; limited transitions only.

### Admin
- Receives client requests.
- Manually forwards to clinician (initial phase).
- Handles payment outside app (for now).
- After payment, generates time-bound Zoom code and sends to both parties.

## 2) Screens
### Implemented/Existing
- HomePage
- Booking:
  - BookingPage
  - BookingRequestPage (client sends request)
  - MyBookingsPage (client tracking)
  - ClinicianInboxPage (clinician view)
- LibraryPage (C6 UI)
- LanguagePage / SplashPage

### Planned next
- Specialists page:
  - Friendly clinician list
  - Locked clinician section (inbox) visible only for role=clinician
- Admin dashboard (prefer Web):
  - Requests inbox
  - Manual assignment/forwarding
  - Payment confirmation tracking
  - Session code generation & notifications
  - Audit log

## 3) Booking workflow (end-to-end)
A) Client request
1) Client selects clinician and sends request with suggested slots + note
2) booking_requests created with status=pending

B) Admin review + forward (manual)
3) Admin reviews and forwards to clinician (or rejects)
4) Clinician sees item in inbox

C) Clinician decision
5) Clinician approves (chooses slot) or rejects (reason)
6) booking_requests updated accordingly

D) Admin payment + session code
7) Admin completes payment steps (external) after clinician approval
8) Admin generates Zoom code (time-bound) and sends to both parties

## 4) Firestore data model (current direction)
- booking_requests:
  - status, clientId, clinicianId
  - suggestedSlots, approvedSlot, rejectReason
  - handledByClinicianId (strict uid)
  - createdAt/updatedAt (serverTimestamp)

- clinicians:
  - profile, role

Planned:
- sessions:
  - bookingRequestId, startAt, expiresAt, zoomCode, paymentStatus
- payments (later)

## 5) Security / Rules (C4 direction)
- Client can update limited fields while pending.
- Clinician can only transition pending -> approved/rejected with limited fields.
- Read restricted to owner or assigned clinician.
- Dev rules must be locked down before release.

## 6) Tech decisions
- Flutter Web-first.
- Riverpod/codegen OK.
- Friendly UI default; Dev hooks behind:
  --dart-define=MK_DEV=true

## 7) Assets structure
- C5: assets/c5/
- C6: assets/c6_library/

pubspec.yaml:
flutter:
  assets:
    - assets/c5/
    - assets/c6_library/

Web note:
If assets 404 on web, rebuild:
flutter clean
flutter pub get
flutter build web --no-wasm-dry-run

## 8) Work style / process
- PowerShell-first, scripts saved as files then executed.
- Dart inside PowerShell strings uses @' ... '@ (avoid $" expansion issues).
- mk_checkpoint.ps1 refreshes _handoff_latest.zip each checkpoint.

## 9) Checklist
Done:
- C3 inbox fixes + handledByClinicianId strict
- C4 Firestore rules tightening
- C5 assets + friendly UI pass
- C6 library assets + UI + layout tuning
- pubspec assets linked; web asset build verified

Next:
- Booking UI style unify + resize targets
- Specialists page with clinician locked section
- Admin dashboard (web) for request forwarding + session codes
- Session code model + audit logging
"@

Set-Content -Path $mdPath -Value $md -Encoding UTF8
Write-Host "✅ Wrote: $mdPath" -ForegroundColor Green

Write-Host "Opening Savepoint..." -ForegroundColor Yellow
notepad $mdPath