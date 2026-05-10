# Mental Smile Production Firebase Checklist

## 1. Firebase Project Separation

- Create separate Firebase projects:
  - `mental-smile-dev`
  - `mental-smile-staging`
  - `mental-smile-prod`
- Ensure each environment has separate:
  - Firestore database
  - Firebase Auth users
  - Storage buckets
  - App Check config
  - web/mobile Firebase config files
- Do not point development builds to production Firestore.

## 2. Firestore Rules Deployment

- Review `firestore.rules` against all production flows before deploy.
- Deploy to staging first.
- Run role matrix tests before production:
  - client
  - clinician pending
  - clinician approved active
  - clinician rejected
  - clinician blocked
  - center pending
  - center approved active
  - center rejected
  - center blocked
  - admin
- Confirm deny-by-default fallback blocks unknown collections.
- Confirm users cannot edit:
  - `role`
  - `isAdmin`
  - `approvalStatus`
  - `isActive`
  - `isBlocked`

## 3. Firestore Indexes Deployment

- Deploy `firestore.indexes.json` to staging first.
- Confirm no runtime index link appears for:
  - chat
  - center list
  - specialist list
  - clinician ratings
  - booking requests
  - profile change requests
- Deploy indexes before deploying app builds that depend on them.

## 4. Firebase Auth Admin / Custom Claims Setup

- Create a server/Admin SDK-only process for setting custom claims.
- Required custom claims:
  - `{ role: 'admin' }`
  - `{ role: 'client' }`
  - `{ role: 'clinician' }`
  - `{ role: 'center' }`
- Do not let Flutter client assign or update custom claims.
- After registration approval:
  - set role claim server-side if missing
  - refresh user token in app after admin decision
- Keep Firestore `role` field only for display/app compatibility.
- Do not trust Firestore `role` field for admin decisions.

## 5. Admin Account Creation Policy

- No open admin self-registration.
- Admin accounts must be created by a controlled process:
  - owner approval
  - Admin SDK claim assignment
  - `admins/{uid}` audit document
- Store admin activation metadata:
  - createdBy
  - createdAt
  - active
  - permissions/scope if needed
- Disable or rotate compromised admin accounts immediately.

## 6. Backup Schedule

- Enable scheduled Firestore exports.
- Recommended:
  - daily export for production
  - weekly retained snapshot
  - monthly archive snapshot
- Store exports in a locked production backup bucket.
- Test restore process on staging.
- Include these collections in restore validation:
  - `clients`
  - `clinicians`
  - `centers`
  - `booking_requests`
  - `sessionRatings`
  - `support_requests`
  - `chat_threads`
  - `chat_escalations`
  - profile change requests

## 7. App Check Recommendation

- Enable Firebase App Check for:
  - Flutter Web
  - Android
  - iOS
- Start in monitor mode.
- Review rejected traffic.
- Enforce only after staging validation.
- Add App Check to Firestore and Storage.

## 8. Storage Rules Review

- Current audit focused on Firestore.
- Review Firebase Storage separately before production.
- Required checks:
  - users can upload only their own files
  - provider documents are private until admin review
  - admin-only access for identity/license documents
  - public images limited to approved active provider profiles
  - deny deletes except admin/server cleanup
- Confirm no registration document URL can be overwritten after approval without request review.

## 9. Test Matrix For All Roles

Client:
- register
- login
- dashboard
- create booking
- upload payment proof
- submit review
- create support request
- blocked client denied where expected

Clinician:
- web registration account/profile/sessions/documents
- pending account cannot access dashboard
- approved active account can access operations
- rejected account blocked from protected routes
- blocked account routed to blocked screen
- own ratings visible
- profile edit request creates pending request
- cannot directly edit protected account fields

Center:
- web registration account/profile/media/pricing/documents
- pending account cannot access dashboard
- approved active account can access dashboard/operations
- rejected account blocked
- blocked account routed to blocked screen
- profile/media/document changes go through request flow
- cannot directly edit live core profile after approval

Admin:
- admin hub opens only with admin custom claim
- approve/reject/block center
- approve/reject/block clinician
- review profile change requests
- view registration maintenance
- view admin clients
- view archives/payments/sessions

Guest/public:
- confirm whether guest access is supported.
- If guest support is required, rules must be explicitly adjusted.

## 10. Blocked / Rejected / Inactive Test Cases

- clinician:
  - `approvalStatus: pending_review`, `isActive: false`
  - `approvalStatus: rejected`, `isActive: false`
  - `approvalStatus: approved`, `isActive: false`
  - `approvalStatus: approved`, `isActive: true`, `isBlocked: true`

- center:
  - `approvalStatus: pending_admin`, `isActive: false`
  - `approvalStatus: rejected`, `isActive: false`
  - `approvalStatus: approved`, `isActive: false`
  - `approvalStatus: approved`, `isActive: true`, `isBlocked: true`

- client:
  - normal
  - blocked

Expected:
- protected dashboards blocked unless account is approved/active/not blocked where applicable.
- admin pages only open with admin custom claim.

## 11. Rollback Plan

- Keep previous deployed rules version available.
- Before deploy:
  - export current Firestore rules
  - export current indexes
  - tag app release
- Deploy order:
  1. indexes to staging
  2. rules to staging
  3. app staging smoke test
  4. indexes to production
  5. rules to production
  6. app production rollout
- If production breaks:
  - rollback rules first
  - keep indexes; indexes are usually safe
  - disable new app release if required
  - review denied request logs

## 12. Final Pre-Production Gate

- No Firebase console index error links in normal flows.
- No permission-denied during expected user flows.
- No user can update protected account fields.
- No unapproved clinician/center appears in public listings.
- No admin page opens without admin custom claim.
- No Storage document exposure without review.
