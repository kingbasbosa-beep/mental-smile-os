# Client Registration Localization Audit V1

Status: LOCALIZATION_AUDIT_COMPLETE
Prompt Asset: PROMPT_ASSET_021

## 1. Purpose

Audit localization used by the current Mental Smile Core client registration page before any Mental Smile OS field decision.

## 2. Generated Localization Keys

| Key | Arabic | English | Source | Review Notes | Suggested Review Status |
| --- | --- | --- | --- | --- | --- |
| authName | الاسم | Name | ARB/generated localization | Should become chosen-name friendly if kept. | CHANGE_LANGUAGE_CANDIDATE |
| authEmail | البريد الإلكتروني | Email | ARB/generated localization | Account identifier; keep but privacy wording may be needed nearby. | KEEP_CANDIDATE |
| authPassword | كلمة المرور | Password | ARB/generated localization | Standard credential label. | KEEP_CANDIDATE |
| authConfirmPassword | تأكيد كلمة المرور | Confirm password | ARB/generated localization | Standard credential label. | KEEP_CANDIDATE |
| authClientRegister | إنشاء حساب عميل | Create client account | ARB/generated localization | "Client" may need OS term review. | CHANGE_LANGUAGE_CANDIDATE |
| authCreatingAccount | جارٍ إنشاء الحساب... | Creating account... | ARB/generated localization | Acceptable status text. | KEEP_CANDIDATE |
| authNameRequired | اكتب الاسم | Enter your name | ARB/generated localization | Could say chosen name. | CHANGE_LANGUAGE_CANDIDATE |
| authEmailRequired | اكتب البريد الإلكتروني | Enter your email | ARB/generated localization | Acceptable. | KEEP_CANDIDATE |
| authInvalidEmail | البريد الإلكتروني غير صالح | Invalid email address | ARB/generated localization | Acceptable. | KEEP_CANDIDATE |
| authWeakPassword | كلمة المرور يجب أن تكون 6 أحرف على الأقل | Password must be at least 6 characters | ARB/generated localization | Technical requirement only. | KEEP_CANDIDATE |
| authPasswordsDoNotMatch | تأكيد كلمة المرور غير مطابق | Passwords do not match | ARB/generated localization | Acceptable. | KEEP_CANDIDATE |
| authRegistrationFailed | فشل إنشاء الحساب | Could not create account | ARB/generated localization | Acceptable but may need softer wording. | KEEP_CANDIDATE |

## 3. Hardcoded Registration Section Titles

| Current Arabic | Current English | Section | Review Notes | Suggested Review Status |
| --- | --- | --- | --- | --- |
| أهدافي | My goals | Goal signals | Non-clinical, but registration timing needs review. | UNKNOWN_NEEDS_OWNER_REVIEW |
| اهتماماتي | Interests | Interest signals | Broad but may expose sensitive labels. | UNKNOWN_NEEDS_OWNER_REVIEW |
| تفضيلات الوصول | Accessibility | Accessibility signals | Good concept; sensitive-data caution. | KEEP_CANDIDATE |
| طريقة التواصل | Communication | Communication signals | Good concept; may be later preferences. | KEEP_CANDIDATE |

## 4. Hardcoded Option Labels Requiring Language Review

| Key | Arabic | English | Risk / Notes | Suggested Review Status |
| --- | --- | --- | --- | --- |
| need_specialist | أحتاج أخصائي | Find specialist | "Need" may imply urgent service matching. | CHANGE_LANGUAGE_CANDIDATE |
| need_center | أحتاج مركز | Find center | "Need" and center direction may be too early. | CHANGE_LANGUAGE_CANDIDATE |
| addiction | الإدمان | Addiction | Sensitive and potentially labeling. | CHANGE_LANGUAGE_CANDIDATE |
| special_needs | ذوي الاحتياجات | Special needs | Could feel labeling; needs dignity-first wording. | CHANGE_LANGUAGE_CANDIDATE |
| speech_support | دعم/مساعدة التخاطب | Speech support | Sensitive support area; keep only with user choice. | CHANGE_LANGUAGE_CANDIDATE |
| hearing_support | دعم/مساعدة السمع | Hearing support | Sensitive support area; keep only with user choice. | CHANGE_LANGUAGE_CANDIDATE |
| family_guidance | إرشاد أسري | Family guidance | "Guidance" may imply advisory authority. | CHANGE_LANGUAGE_CANDIDATE |

## 5. Privacy Preference Labels

| Current Arabic | Current English | Review Notes | Suggested Review Status |
| --- | --- | --- | --- |
| إبقاء تفضيلات الدعم خاصة | Keep support preferences private | Strong default, good privacy direction. | KEEP_CANDIDATE |
| استخدام التفضيلات للتوصيات | Use preferences for recommendations | Consent wording should be explicit and reversible. | KEEP_CANDIDATE |

## 6. Localization Boundary

No approved OS localization is created by this audit. This document only identifies current language and review needs.
