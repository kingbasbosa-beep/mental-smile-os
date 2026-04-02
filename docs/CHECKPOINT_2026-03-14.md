# Mental Key — Checkpoint Save
**Date:** 2026-03-14  
**Checkpoint Name:** Chat + Booking Stable Checkpoint

## Summary
This checkpoint captures a stable version where:
- login works
- booking flow works across client/admin/clinician
- chat works
- AI escalation works
- admin assignment works
- clinician forwarding works
- safety escalation report generation works

---

## Verified working flows

### Login
- user can reach login page
- route wiring is stable enough for testing

### Booking
- client creates booking request
- admin sees request
- admin forwards to clinician
- clinician accepts / rejects
- client sees status update

### Chat
- thread is created or reused
- user messages are saved
- AI responses are saved
- critical risk can create chat escalation
- admin can assign escalation to self
- admin can forward escalation to clinician
- escalation can be resolved

### Safety Report
When critical / protected triggers are detected:
- escalation is created
- safety report is generated under escalation/reports
- report includes non-diagnostic structured safety context

---

## Firestore collections in active use
- admins
- clinicians
- booking_requests
- chat_threads
- chat_escalations
- chat_escalations/{id}/reports
- debug
- resources

---

## Important route/pages confirmed in project
- /
- /language
- /home
- /login
- /module/specialists
- /booking
- /booking/request
- /booking/my
- /clinician/inbox
- /admin/booking-queue
- /chat
- /chat/escalations

---

## Sensitive implementation notes
- Admins are represented through clinicians docs using isAdmin = true
- Firestore rules are essential and frequently the source of runtime failures
- Safety reports must remain non-diagnostic
- Disclosure escalation is only acceptable in critical ethical safety cases

---

## Known remaining gaps
- dedicated chat report viewer UI
- dedicated clinician escalated-chat inbox UI
- centers module implementation
- library/content completion
- legal/policy/store readiness

---

## If resuming work later
Resume from:
1. Chat finishing OR
2. Centers module

Avoid reworking:
- current AI core logic
- current escalation logic
unless there is a bug or explicit product decision

---

## Quick resume note
If a new chat starts, assume:
- current stable base is valid
- use full-file replacements when possible
- check Firestore rules before debugging UI behavior
