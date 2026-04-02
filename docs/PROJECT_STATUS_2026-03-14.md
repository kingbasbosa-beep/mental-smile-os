# Mental Key — Project Status
**Date:** 2026-03-14  
**Project:** mental_key_v2

## Current Status
Mental Key is currently at a **stable functional checkpoint**.

### Working now
- Login basics
- Specialists/clinicians setup
- Booking flow:
  - client request
  - admin review
  - clinician accept/reject
  - client status tracking
- Chat flow:
  - user messages
  - AI responses
  - risk scoring
  - escalation creation
  - assign escalation to admin
  - forward escalation to clinician
  - resolve escalation
- Safety Escalation Report generation in Firestore

## Core Product Philosophy
- Non-medical
- Non-diagnostic
- Supportive
- Safety-first
- Family-aware

## Main Firestore Collections
- clinicians
- booking_requests
- chat_threads
- chat_escalations
- chat_escalations/{id}/reports

## Important Notes
- Firestore rules are critical and must be reviewed with every new feature.
- Safety reports are non-diagnostic and only for critical ethical safety cases.
- Preferred work style: full-file replacement or short clean patches.

## Remaining Major Work
1. Centers module
2. Chat finishing:
   - report viewer UI
   - clinician escalated inbox UI
3. Booking polish
4. Library/content completion
5. Store readiness:
   - privacy policy
   - disclaimer
   - release prep
   - Play Store assets
   - QA

## Recommended Next Task Options
- Build Centers module
- Finish chat operational UI
- Polish booking details
- Prepare store/legal release package
