# LOCALIZATION DEBT REGISTRY

## Status

Mapping only.

## Debt Summary

| Debt Item | Count | Constitutional Impact |
|---|---:|---|
| Total localization keys | 205 | Baseline key universe |
| Active keys | 95 | Currently consumed outside generated localization files |
| Unused / dormant keys | 106 | Need lifecycle decision before freeze |
| Hardcoded candidates | 7003 | Bypass language governance and key ownership |
| Parsed hardcoded rows | 6945 | Clean table rows mapped directly |
| Complex hardcoded rows | 58 | Captured as complex rows due Markdown/code separators |
| Duplicate meaning groups | 22 | Require canonical semantic decisions |
| Missing key parity issues | 1 | Blocks Arabic/English parity |
| Old doctrine findings | 771 reported / 2653 doctrine category hits | Blocks freeze until remediated or confined to history |
| Mojibake key entries | 0 | Source ARB parsed as valid UTF-8; console display may be misleading |

## Missing Registries

- AUTH vocabulary has active consumers but no dedicated term registry in Phase 2.
- SAFETY vocabulary has active consumers but no dedicated term registry in Phase 2.
- Owner Room and Personal Space vocabularies need finer ownership.
- Consent, retention, data rights, and signal-sharing vocabulary need explicit governance.

## Parity Issues

- `statusCenterFollowUp` is missing English.
- Hardcoded English-only surfaces block parity until migrated or classified.
- Generated files mirror ARB and must not be counted as independent parity sources.

## Duplicate Meaning Groups

| Source | Item | Owner | Location / Consumers | Current Status | Classification | Doctrine | Remediation Mapping |
|---|---|---|---|---|---|---|---|
| DUPLICATE_MEANING | EN: confirm password | MULTIPLE | authConfirmPassword, webCenterConfirmPassword | Count 2 | REVISE | None | Later migration: keep concept only if consumer remains; revise wording through Language Engine. |
| DUPLICATE_MEANING | EN: invalid login details | MULTIPLE | authInvalidCredentials, authInvalidCredentialsMessage | Count 2 | REVISE | None | Later migration: keep concept only if consumer remains; revise wording through Language Engine. |
| DUPLICATE_MEANING | EN: log in | MULTIPLE | authLoginButton, authLoginTitle | Count 2 | REVISE | None | Later migration: keep concept only if consumer remains; revise wording through Language Engine. |
| DUPLICATE_MEANING | EN: name | MULTIPLE | authName, webClinicianName | Count 2 | REVISE | None | Later migration: keep concept only if consumer remains; revise wording through Language Engine. |
| DUPLICATE_MEANING | EN: completed | MULTIPLE | clinicianCompleted, statusCompleted | Count 2 | REVISE | None | Later migration: keep concept only if consumer remains; revise wording through Language Engine. |
| DUPLICATE_MEANING | EN: referred chat cases | MULTIPLE | clinicianReferredChatCases, clinicianReferredChatCasesCount | Count 2 | BLOCK | Assignment Doctrine, Ownership Doctrine | Must not enter active language as-is; doctrine: Assignment Doctrine, Ownership Doctrine. Replace with registered readiness, signal, declaration, support, resource, or visibility language. |
| DUPLICATE_MEANING | EN: reject request | MULTIPLE | clinicianRejectRequest, clinicianRejectRequestTitle | Count 2 | BLOCK | Approval Doctrine | Must not enter active language as-is; doctrine: Approval Doctrine. Replace with registered readiness, signal, declaration, support, resource, or visibility language. |
| DUPLICATE_MEANING | EN: back | MULTIPLE | commonBack, homeBack | Count 2 | REVISE | None | Later migration: keep concept only if consumer remains; revise wording through Language Engine. |
| DUPLICATE_MEANING | EN: centers | MULTIPLE | menuCenters, moduleCenters | Count 2 | REVISE | None | Later migration: keep concept only if consumer remains; revise wording through Language Engine. |
| DUPLICATE_MEANING | EN: special needs families | MULTIPLE | menuSpecialNeedsFamilies, moduleSpecialNeedsFamilies | Count 2 | REVISE | Diagnostic Doctrine | Later migration: keep concept only if consumer remains; revise wording through Language Engine. |
| DUPLICATE_MEANING | EN: specialists | MULTIPLE | menuSpecialists, moduleSpecialists | Count 2 | REVISE | None | Later migration: keep concept only if consumer remains; revise wording through Language Engine. |
| DUPLICATE_MEANING | EN: could not save profile | MULTIPLE | webCenterSaveProfileFailed, webClinicianSaveProfileFailed | Count 2 | REVISE | None | Later migration: keep concept only if consumer remains; revise wording through Language Engine. |
| DUPLICATE_MEANING | EN: could not submit documents | MULTIPLE | webCenterSubmitDocumentsFailed, webClinicianSubmitDocumentsFailed | Count 2 | REVISE | None | Later migration: keep concept only if consumer remains; revise wording through Language Engine. |
| DUPLICATE_MEANING | AR: تأكيد كلمة المرور | MULTIPLE | authConfirmPassword, webCenterConfirmPassword | Count 2 | REVISE | None | Later migration: keep concept only if consumer remains; revise wording through Language Engine. |
| DUPLICATE_MEANING | AR: بيانات الدخول غير صحيحة | MULTIPLE | authInvalidCredentials, authInvalidCredentialsMessage | Count 2 | REVISE | None | Later migration: keep concept only if consumer remains; revise wording through Language Engine. |
| DUPLICATE_MEANING | AR: تسجيل الدخول | MULTIPLE | authLoginTitle, homeLogin | Count 2 | REVISE | None | Later migration: keep concept only if consumer remains; revise wording through Language Engine. |
| DUPLICATE_MEANING | AR: الاسم | MULTIPLE | authName, webClinicianName | Count 2 | REVISE | None | Later migration: keep concept only if consumer remains; revise wording through Language Engine. |
| DUPLICATE_MEANING | AR: حالات الشات المحالة | MULTIPLE | clinicianReferredChatCases, clinicianReferredChatCasesCount | Count 2 | BLOCK | Assignment Doctrine, Ownership Doctrine | Must not enter active language as-is; doctrine: Assignment Doctrine, Ownership Doctrine. Replace with registered readiness, signal, declaration, support, resource, or visibility language. |
| DUPLICATE_MEANING | AR: رفض الطلب | MULTIPLE | clinicianRejectRequest, clinicianRejectRequestTitle | Count 2 | BLOCK | Approval Doctrine | Must not enter active language as-is; doctrine: Approval Doctrine. Replace with registered readiness, signal, declaration, support, resource, or visibility language. |
| DUPLICATE_MEANING | AR: رجوع | MULTIPLE | commonBack, homeBack | Count 2 | REVISE | None | Later migration: keep concept only if consumer remains; revise wording through Language Engine. |
| DUPLICATE_MEANING | AR: المراكز | MULTIPLE | menuCenters, moduleCenters | Count 2 | REVISE | None | Later migration: keep concept only if consumer remains; revise wording through Language Engine. |
| DUPLICATE_MEANING | AR: تعذر إرسال المستندات | MULTIPLE | webCenterSubmitDocumentsFailed, webClinicianSubmitDocumentsFailed | Count 2 | REVISE | None | Later migration: keep concept only if consumer remains; revise wording through Language Engine. |

## Debt Priority

1. Remove or rewrite BLOCK language.
2. Resolve missing parity.
3. Retire or migrate dormant old-doctrine keys.
4. Consolidate duplicate meanings.
5. Localize and govern hardcoded valid copy.
6. Add missing AUTH and SAFETY vocabulary ownership.
