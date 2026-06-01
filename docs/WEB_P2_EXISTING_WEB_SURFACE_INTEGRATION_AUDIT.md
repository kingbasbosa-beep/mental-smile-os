# WEB_P2_EXISTING_WEB_SURFACE_INTEGRATION_AUDIT

## 1. Existing Provider Registration Pages / Routes

### Current Pages

* `WebClinicianRegisterPortalPage`
* `WebClinicianProfilePage`
* `WebClinicianSessionsPage`
* `WebClinicianDocumentsPage`
* `WebRegistrationSuccessPage`

### Current Routes

* `Routes.webClinicianRegister` = `/web/clinician/register`
* `Routes.webClinicianProfile` = `/web/clinician/profile`
* `Routes.webClinicianSessions` = `/web/clinician/sessions`
* `Routes.webClinicianDocuments` = `/web/clinician/documents`
* `Routes.webRegistrationSuccess` = `/web/register/success`
* legacy alias: `Routes.clinicianRegister` = `/register/clinician`

### Current Dependencies

The existing provider registration flow uses:

* `FirebaseAuth.instance.createUserWithEmailAndPassword`
* `FirebaseAuth.instance.currentUser`
* `FirebaseAuth.instance.signOut`
* `FirebaseFirestore.instance.collection('clinicians')`
* route navigation through `Routes.webClinicianProfile`, `Routes.webClinicianSessions`, `Routes.webClinicianDocuments`, and success route

### Firebase/Auth/Firestore Status

Yes. The existing provider registration pages are not skeleton-only. They create auth users and write/update `clinicians`.

### Suitability For Sovereign Web Portal

Partially suitable, but not as Phase 1 Portal Skeleton.

They are closer to an existing active registration workflow than to the new email-driven sovereign intake doctrine. They can be reused later only after an Owner decision about whether Phase 1 should remain email-driven or can expose the current Firebase-backed registration flow.

---

## 2. Existing Center Registration Pages / Routes

### Current Pages

* `WebCenterRegisterPortalPage`
* `WebCenterProfilePage`
* `WebCenterMediaPage`
* `WebCenterPricingPage`
* `WebCenterDocumentsPage`
* `WebRegistrationSuccessPage`

### Current Routes

* `Routes.webCenterRegister` = `/web/center/register`
* `Routes.webCenterProfile` = `/web/center/profile`
* `Routes.webCenterMedia` = `/web/center/media`
* `Routes.webCenterPricing` = `/web/center/pricing`
* `Routes.webCenterDocuments` = `/web/center/documents`
* `Routes.webRegistrationSuccess` = `/web/register/success`
* legacy alias: `Routes.centerRegister` = `/register/center`

### Current Dependencies

The existing center registration flow uses:

* `FirebaseAuth.instance.createUserWithEmailAndPassword`
* `FirebaseAuth.instance.currentUser`
* `FirebaseAuth.instance.signOut`
* `FirebaseFirestore.instance.collection('centers')`
* profile/media/pricing/documents updates
* route navigation through center registration steps and success route

### Firebase/Auth/Firestore Status

Yes. The existing center registration pages create auth users and write/update `centers`.

### Suitability For Sovereign Web Portal

Partially suitable, but not for Phase 1 Skeleton as-is.

It may be reused as a later active intake flow, but it conflicts with the Phase 1 doctrine of email-driven intake and no backend/Firebase setup.

---

## 3. Existing Library Pages / Routes

### Current Pages

* `LibraryPage`
* `LibraryPolicyPage`

### Current Routes

* `Routes.webLibrary` = `/web/library`
* `Routes.webLibraryPolicy` = `/web/library/policy`
* in-app route: `Routes.library` = `/module/library`
* current portal skeleton route: `Routes.portalLibrary` = `/library`

### Current Dependencies

The library pages use:

* Flutter UI.
* image assets.
* navigation via `Navigator`.
* route references to `Routes.webLibraryPolicy`, `Routes.webLibrary`, and return routes.

No direct Firebase/Auth/Firestore dependency was found in the library pages during this audit.

### Firebase/Auth/Firestore Status

No direct Firebase/Auth/Firestore usage observed.

### Suitability For Sovereign Web Portal

High.

The library is the best candidate for safe reuse in Portal Phase 2 because it already behaves like a content surface and does not appear to require auth or Firestore.

---

## 4. Current Route Names

### Portal Skeleton Routes

* `/`
* `/about`
* `/library`
* `/register/provider`
* `/register/center`
* `/request/service`
* `/request/package`
* `/contact`

### Existing Web Registration Routes

* `/web/clinician/register`
* `/web/clinician/profile`
* `/web/clinician/sessions`
* `/web/clinician/documents`
* `/web/center/register`
* `/web/center/profile`
* `/web/center/media`
* `/web/center/pricing`
* `/web/center/documents`
* `/web/register/success`

### Existing Library Routes

* `/web/library`
* `/web/library/policy`
* `/module/library`

---

## 5. Current Dependencies

| Surface | Firebase Auth | Firestore | Runtime Coupling | Notes |
| --- | --- | --- | --- | --- |
| Provider registration | Yes | Yes, `clinicians` | Medium/High | Active registration flow, not placeholder |
| Center registration | Yes | Yes, `centers` | Medium/High | Active multi-step registration flow |
| Library | No direct usage observed | No direct usage observed | Low/Medium | Content surface with navigation |
| Library policy | No direct usage observed | No direct usage observed | Low | Informational policy page |

---

## 6. هل فيها Firebase/Auth/Firestore؟

### Provider Registration

Yes:

* Firebase Auth account creation.
* Firestore writes/updates to `clinicians`.

### Center Registration

Yes:

* Firebase Auth account creation.
* Firestore writes/updates to `centers`.

### Library

No direct Firebase/Auth/Firestore usage observed.

---

## 7. هل مناسبة لـ Sovereign Web Portal؟

### Provider / Center Registration

مناسبة كمادة إعادة استخدام لاحقة، لكنها ليست مناسبة كـ Phase 1 email-driven skeleton.

السبب:

* تعتمد على Auth.
* تكتب Firestore.
* تنشئ/تعدل provider and center records.
* تحتاج rules/security review قبل ربطها من Portal CTA.

### Library

مناسبة جدًا للـ Sovereign Web Portal لأنها Web-first content surface، ويمكن ربط `/library` بها لاحقًا بأقل مخاطرة.

---

## 8. What Can Be Reused?

### Safe Reuse Candidate

* `LibraryPage`
* `LibraryPolicyPage`
* `/web/library`
* `/web/library/policy`

### Conditional Reuse Candidate

* `WebClinicianRegisterPortalPage`
* `WebCenterRegisterPortalPage`
* registration step pages
* success page

Reuse condition:

* Owner confirms that Portal Phase 2 may use Firebase-backed intake.
* Firestore rules are reviewed.
* Auth/session behavior is documented.
* Copy is aligned with Sovereign Intake, not app runtime registration.

---

## 9. What Needs Relabel Or Containment?

### Provider / Center Registration

Needs containment around:

* "registration" language vs "intake request".
* account creation side effects.
* Firestore write behavior.
* approval expectations.
* provider/center activation promises.

Recommended relabel later:

```text
Registration
↓
Intake / Review Request
```

### Library

May need only light containment:

* make it clear content is education/support, not diagnosis or therapy.
* ensure return route from web context goes back to Portal, not operational menu.

---

## 10. What Must Not Be Rebuilt?

Do not rebuild from scratch now:

* Library content surface.
* Library policy page.
* Existing provider registration flow.
* Existing center registration flow.

Instead:

* reuse library safely.
* audit registration flows before reuse.
* keep Portal skeleton placeholders until Owner approves Firebase-backed intake.

---

## 11. Safe Integration Plan

### Phase 2A - Library Reuse

Safe direction:

```text
Portal Library CTA
↓
Routes.webLibrary
```

Reason:

* no direct Firebase/Auth/Firestore observed.
* already Web-friendly.
* lower route/security risk.

### Phase 2B - Provider Registration Reuse

Conditional direction:

```text
Portal Providers CTA
↓
Routes.webClinicianRegister
```

Only after:

* Owner approves Firebase/Auth-backed registration.
* rules review is complete.
* copy clarifies this is intake/review, not automatic approval.

### Phase 2C - Center Registration Reuse

Conditional direction:

```text
Portal Centers CTA
↓
Routes.webCenterRegister
```

Only after:

* Owner approves Firebase/Auth-backed registration.
* rules review is complete.
* center documents/pricing/media steps are confirmed suitable for Portal.

---

## 12. Risks

### Route Collision

Current Portal routes use `/library`, `/register/provider`, `/register/center`.

Existing web surfaces use `/web/library`, `/web/clinician/register`, `/web/center/register`.

No direct collision if Portal links to existing web routes, but route language becomes mixed.

### Auth Dependency

Provider/center registration uses Firebase Auth. Linking from public Portal makes Auth a live dependency.

### App Runtime Coupling

Some existing flows may still behave like app registration/runtime rather than sovereign email intake.

### Firestore Rules Dependency

Provider/center registration writes to `clinicians` and `centers`, so rules and data shape matter immediately.

### User Expectation Risk

If Portal CTA opens existing registration flow, users may think registration is immediate onboarding rather than intake/review.

---

## 13. Final Recommendation

Recommended order:

1. Reuse Library first.
2. Keep Provider/Center Portal placeholders for now.
3. Run a separate registration-flow containment audit before linking provider/center CTAs to existing Firebase-backed flows.
4. Do not rebuild existing registration pages.
5. Do not connect Portal provider/center CTAs to Firebase-backed flows until Owner approves Auth/Firestore intake behavior.

Final verdict:

```text
Portal Library CTA can safely integrate with the existing web library route.

Provider and Center registration surfaces are reusable, but not yet safe as direct Portal Phase 2 links without Auth/Firestore/rules containment review.
```

This audit does not change runtime.

This audit does not change routes.

This audit does not change UI.

This audit does not change Firestore rules.
