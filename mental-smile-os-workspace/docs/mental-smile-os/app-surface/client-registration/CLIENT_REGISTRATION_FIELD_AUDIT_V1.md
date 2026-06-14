# Client Registration Field Audit V1

Status: FIELD_AUDIT_COMPLETE
Prompt Asset: PROMPT_ASSET_021
Source: Mental Smile Core `lib/features/auth/presentation/pages/client_register_page.dart`

## 1. Scope

This audit inventories visible and stored client registration fields only.

No final classification is made. Suggested review status is provisional for Owner review.

## 2. Field Inventory

| Field ID | Current Label Arabic | Current Label English | Input Type | Required / Optional | Validation Rules | Stored Target If Known | Related Localization Key | Related UI Section | Current Purpose | Risk / Notes | Suggested Review Status |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| CLIENT_REG_FIELD_NAME | الاسم | Name | Text input | Required | Must not be empty. Trimmed. | Firebase Auth displayName; `clients/{uid}.displayName` | `authName`, `authNameRequired` | Account fields | Create visible client display name. | Non-clinical but should allow chosen name, not legal-name pressure. | CHANGE_LANGUAGE_CANDIDATE |
| CLIENT_REG_FIELD_EMAIL | البريد الإلكتروني | Email | Email text input | Required | Must not be empty; must contain `@`; normalized trim/lowercase. | Firebase Auth email; `clients/{uid}.email` | `authEmail`, `authEmailRequired`, `authInvalidEmail` | Account fields | Account credential and contact identifier. | Personal data; sensitive-data caution required. | KEEP_CANDIDATE |
| CLIENT_REG_FIELD_PASSWORD | كلمة المرور | Password | Password input | Required | Minimum 6 characters. | Firebase Auth credential only; not stored in Firestore by page. | `authPassword`, `authWeakPassword` | Account fields | Account credential creation. | Sensitive credential; keep out of memory/storage. | KEEP_CANDIDATE |
| CLIENT_REG_FIELD_CONFIRM_PASSWORD | تأكيد كلمة المرور | Confirm password | Password input | Required | Must match password. | Not stored; validation only. | `authConfirmPassword`, `authPasswordsDoNotMatch` | Account fields | Prevent password entry mismatch. | Credential handling only. | KEEP_CANDIDATE |
| CLIENT_REG_FIELD_AVATAR_ASSET | Not shown as text | Not shown as text | Avatar image selection | Optional with default | Defaults to `images/avatar_client_fmale.png`; selected by tapping avatar. | `clients/{uid}.avatarAsset` | None | Avatar selection | Pick a profile visual. | Current options include clinician avatars; may force gendered/role-coded visuals. | CHANGE_LANGUAGE_CANDIDATE |
| CLIENT_REG_FIELD_GOAL_SIGNALS | أهدافي | My goals | Multi-select FilterChip set | Optional | Any subset; sorted before storage; first selected emits signal. | `clients/{uid}.clientSignals.goalSignals`; clean signal runtime emits first selected goal | Hardcoded labels | Signal sections | Capture initial support goal signals. | Mostly non-clinical, but "need specialist/center" may imply service routing too early. | UNKNOWN_NEEDS_OWNER_REVIEW |
| CLIENT_REG_FIELD_INTEREST_SIGNALS | اهتماماتي | Interests | Multi-select FilterChip set | Optional | Any subset; sorted before storage; first selected emits signal. | `clients/{uid}.clientSignals.interestSignals`; clean signal runtime emits first selected interest | Hardcoded labels | Signal sections | Capture areas of interest for future content/support. | Includes addiction, special needs, speech/hearing/children; sensitive and may feel labeling. | UNKNOWN_NEEDS_OWNER_REVIEW |
| CLIENT_REG_FIELD_ACCESSIBILITY_SIGNALS | تفضيلات الوصول | Accessibility | Multi-select FilterChip set | Optional | Any subset; sorted before storage; first selected emits signal. | `clients/{uid}.clientSignals.accessibilitySignals`; clean signal runtime emits first selected accessibility interest | Hardcoded labels | Signal sections | Capture accessibility support preferences. | Sensitive access needs; should be optional, user-controlled, and maybe later preferences. | KEEP_CANDIDATE |
| CLIENT_REG_FIELD_COMMUNICATION_SIGNALS | طريقة التواصل | Communication | Multi-select FilterChip set | Optional | Any subset; sorted before storage; first selected emits signal. | `clients/{uid}.clientSignals.communicationSignals`; clean signal runtime emits first selected communication preference | Hardcoded labels | Signal sections | Capture preferred communication modes. | Non-clinical but may belong in later preferences if registration should stay light. | KEEP_CANDIDATE |
| CLIENT_REG_FIELD_KEEP_SUPPORT_PRIVATE | إبقاء تفضيلات الدعم خاصة | Keep support preferences private | Switch | Optional; default true | Boolean switch. | `clients/{uid}.privacyPreferences.keepSupportPreferencesPrivate` | Hardcoded labels | Privacy preferences | Preference visibility boundary. | Strong privacy-positive default; needs plain language. | KEEP_CANDIDATE |
| CLIENT_REG_FIELD_USE_PREFS_RECOMMENDATIONS | استخدام التفضيلات للتوصيات | Use preferences for recommendations | Switch | Optional; default false | Boolean switch. | `clients/{uid}.privacyPreferences.usePreferencesForRecommendations` | Hardcoded labels | Privacy preferences | Consent for recommendation use. | Requires clear consent wording and ability to change later. | KEEP_CANDIDATE |
| CLIENT_REG_FIELD_ROLE | Not visible | Not visible | Stored constant | System-set | Always `client`. | `clients/{uid}.role` | None | Stored metadata | Role marker for access system. | Not visible; authority/claim model needs future review. | UNKNOWN_NEEDS_OWNER_REVIEW |
| CLIENT_REG_FIELD_SIGNAL_SCHEMA_VERSION | Not visible | Not visible | Stored constant | System-set | Always `client_signals_v1`. | `clients/{uid}.signalSchemaVersion` | None | Stored metadata | Signal schema versioning. | Internal metadata; safe if documented. | KEEP_CANDIDATE |
| CLIENT_REG_FIELD_CREATED_AT | Not visible | Not visible | Server timestamp | System-set | `FieldValue.serverTimestamp()`. | `clients/{uid}.createdAt` | None | Stored metadata | Creation time. | Personal data timeline; normal but privacy-sensitive. | KEEP_CANDIDATE |
| CLIENT_REG_FIELD_UPDATED_AT | Not visible | Not visible | Server timestamp | System-set | `FieldValue.serverTimestamp()`. | `clients/{uid}.updatedAt` | None | Stored metadata | Update time. | Personal data timeline; normal but privacy-sensitive. | KEEP_CANDIDATE |
| CLIENT_REG_ACTION_CREATE_ACCOUNT | إنشاء حساب عميل | Create client account | Button action | Required to submit | Disabled when loading; calls `_register`. | Triggers Firebase Auth, Firestore write, signal emit, route to client dashboard. | `authClientRegister`, `authCreatingAccount` | Submit action | Complete account creation. | Runtime action not migrated; label uses "client" which may need OS language review. | CHANGE_LANGUAGE_CANDIDATE |
| CLIENT_REG_ACTION_LOGOUT | Not shown as label | Not shown as label | Icon button | Optional action | Calls Firebase signOut and routes to login. | Firebase Auth sign out only. | None | Top action | Leave current account session. | Not registration field; may be legacy residue for this screen. | REMOVE_CANDIDATE |
| CLIENT_REG_VISUAL_BACKGROUND | Not shown as text | Not shown as text | Image asset | Visual | `assets/branding/web_registration/clients/mobile/client_register.png`. | Not stored. | None | Background | Visual registration frame. | Visible asset, not a data field; source candidate only. | UNKNOWN_NEEDS_OWNER_REVIEW |

## 3. Signal Options Inventory

### Goal Signals

| Key | Arabic Label | English Label | Stored Group | Suggested Review Status |
| --- | --- | --- | --- | --- |
| need_specialist | أحتاج أخصائي | Find specialist | goalSignals | CHANGE_LANGUAGE_CANDIDATE |
| need_center | أحتاج مركز | Find center | goalSignals | CHANGE_LANGUAGE_CANDIDATE |
| recovery_support | دعم التعافي | Recovery support | goalSignals | KEEP_CANDIDATE |
| family_guidance | إرشاد أسري | Family guidance | goalSignals | CHANGE_LANGUAGE_CANDIDATE |
| general_help | مساعدة عامة | General help | goalSignals | KEEP_CANDIDATE |

### Interest Signals

| Key | Arabic Label | English Label | Stored Group | Suggested Review Status |
| --- | --- | --- | --- | --- |
| addiction | الإدمان | Addiction | interestSignals | CHANGE_LANGUAGE_CANDIDATE |
| recovery | التعافي | Recovery | interestSignals | KEEP_CANDIDATE |
| family_support | دعم الأسرة | Family support | interestSignals | KEEP_CANDIDATE |
| special_needs | ذوي الاحتياجات | Special needs | interestSignals | CHANGE_LANGUAGE_CANDIDATE |
| prevention_awareness | التوعية الوقائية | Prevention awareness | interestSignals | KEEP_CANDIDATE |
| family_awareness | التوعية الأسرية | Family awareness | interestSignals | KEEP_CANDIDATE |
| coaching | الكوتشنج | Coaching | interestSignals | UNKNOWN_NEEDS_OWNER_REVIEW |
| speech_support | دعم التخاطب | Speech support | interestSignals | CHANGE_LANGUAGE_CANDIDATE |
| children_support | دعم الأطفال | Children support | interestSignals | UNKNOWN_NEEDS_OWNER_REVIEW |
| hearing_support | دعم السمع | Hearing support | interestSignals | CHANGE_LANGUAGE_CANDIDATE |

### Accessibility Signals

| Key | Arabic Label | English Label | Stored Group | Suggested Review Status |
| --- | --- | --- | --- | --- |
| speech_support | مساعدة التخاطب | Speech support | accessibilitySignals | CHANGE_LANGUAGE_CANDIDATE |
| hearing_support | مساعدة السمع | Hearing support | accessibilitySignals | CHANGE_LANGUAGE_CANDIDATE |
| visual_assistance | مساعدة بصرية | Visual help | accessibilitySignals | KEEP_CANDIDATE |
| simplified_content | محتوى مبسط | Simplified content | accessibilitySignals | KEEP_CANDIDATE |

### Communication Signals

| Key | Arabic Label | English Label | Stored Group | Suggested Review Status |
| --- | --- | --- | --- | --- |
| text | نص | Text | communicationSignals | KEEP_CANDIDATE |
| audio | صوت | Audio | communicationSignals | KEEP_CANDIDATE |
| video | فيديو | Video | communicationSignals | KEEP_CANDIDATE |
| visual | مرئي | Visual | communicationSignals | KEEP_CANDIDATE |

## 4. Constitutional Review Questions

| Field ID | Non-clinical? | Avoids Diagnosis? | Avoids Forced Labeling? | Respects User Choice? | Belongs In Registration Or Later Preferences? | Sensitive-Data Caution? |
| --- | --- | --- | --- | --- | --- | --- |
| CLIENT_REG_FIELD_NAME | Yes | Yes | Mostly | Needs chosen-name wording | Registration | Moderate |
| CLIENT_REG_FIELD_EMAIL | Yes | Yes | Yes | Required for account | Registration | High |
| CLIENT_REG_FIELD_PASSWORD | Yes | Yes | Yes | Required for account | Registration | High |
| CLIENT_REG_FIELD_CONFIRM_PASSWORD | Yes | Yes | Yes | Required for account | Registration | High |
| CLIENT_REG_FIELD_AVATAR_ASSET | Yes | Yes | Not fully; current avatar set may imply gender/role | Partial | Registration or profile preferences | Low |
| CLIENT_REG_FIELD_GOAL_SIGNALS | Mostly | Mostly | Partial | Yes if optional | Owner review: registration vs later preferences | Moderate |
| CLIENT_REG_FIELD_INTEREST_SIGNALS | Mixed | Some labels risk diagnostic interpretation | Partial | Yes if optional | Likely later preferences | High |
| CLIENT_REG_FIELD_ACCESSIBILITY_SIGNALS | Yes | Yes | Partial | Yes if optional | Later preferences may be better | High |
| CLIENT_REG_FIELD_COMMUNICATION_SIGNALS | Yes | Yes | Yes | Yes if optional | Registration or later preferences | Moderate |
| CLIENT_REG_FIELD_KEEP_SUPPORT_PRIVATE | Yes | Yes | Yes | Yes | Registration or privacy preferences | High |
| CLIENT_REG_FIELD_USE_PREFS_RECOMMENDATIONS | Yes | Yes | Yes | Yes if explicit consent | Registration or privacy preferences | High |
| CLIENT_REG_FIELD_ROLE | Internal | Yes | Yes | No user choice; system-set | System metadata | Moderate |
| CLIENT_REG_FIELD_SIGNAL_SCHEMA_VERSION | Internal | Yes | Yes | N/A | System metadata | Low |
| CLIENT_REG_FIELD_CREATED_AT | Internal | Yes | Yes | N/A | System metadata | Moderate |
| CLIENT_REG_FIELD_UPDATED_AT | Internal | Yes | Yes | N/A | System metadata | Moderate |
| CLIENT_REG_ACTION_CREATE_ACCOUNT | Yes | Yes | Yes | Yes | Registration | Moderate |
| CLIENT_REG_ACTION_LOGOUT | Yes | Yes | Yes | N/A | Not registration | Low |
| CLIENT_REG_VISUAL_BACKGROUND | Yes | Yes | Yes | N/A | Visual asset review | Low |
