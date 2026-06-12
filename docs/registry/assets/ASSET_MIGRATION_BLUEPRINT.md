# ASSET MIGRATION BLUEPRINT

Phase 2 destination plan for all 297 Phase 1 assets. No migration, rename, deletion, code change, or pubspec change is performed.

## Decision Rules

- Byte-identical active/dormant assets normally share one canonical destination.
- Historical and extinct-runtime source files remain in LEGACY_IMPORTS even when their bytes match an active canonical asset.
- KEEP_SEPARATE duplicate groups retain separate destinations because their semantic roles conflict or platform path identity matters.
- Phase 1 LIBRARY_SYSTEM maps to CITY_SYSTEM/library.
- Phase 1 BACKGROUND_SYSTEM maps to BACKGROUNDS_SYSTEM.
- Unknown assets map to LEGACY_IMPORTS/unclassified_quarantine, never FUTURE_CONCEPTS.
- LEGACY and DEAD destinations are planning classifications, not retention or deletion approvals.

## ASSET-0001

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/client_dashboard/desktop/client_dashboard_desktop_bg.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/client_dashboard/desktop/client_dashboard_desktop_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-001; canonical asset ASSET-0105. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CLIENT_ROOM/backgrounds/desktop/client_dashboard_desktop_bg.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0002

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/client_dashboard/mobile/client_dashboard_mobile_bg.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/client_dashboard/mobile/client_dashboard_mobile_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-002; canonical asset ASSET-0106. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CLIENT_ROOM/backgrounds/mobile/client_dashboard_mobile_bg.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0003

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/client_dashboard/tablet/client_dashboard_tablet_bg.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/client_dashboard/tablet/client_dashboard_tablet_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-003; canonical asset ASSET-0107. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CLIENT_ROOM/backgrounds/tablet/client_dashboard_tablet_bg.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0004

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/library/backgrounds/desktop/library_desktop_bg.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/library/backgrounds/desktop/library_desktop_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-004; canonical asset ASSET-0137. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CITY_SYSTEM/library/backgrounds/desktop/library_desktop_bg.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0005

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/library/backgrounds/mobile/library_mobile_bg.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/library/backgrounds/mobile/library_mobile_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-005; canonical asset ASSET-0138. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CITY_SYSTEM/library/backgrounds/mobile/library_mobile_bg.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0006

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/library/backgrounds/tablet/library_tablet_bg.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/library/backgrounds/tablet/library_tablet_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-006; canonical asset ASSET-0139. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CITY_SYSTEM/library/backgrounds/tablet/library_tablet_bg.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0007

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/library/bedaya_amena/bedaya_amena_card.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/library/bedaya_amena/bedaya_amena_card.png`
- Reason: LEGACY_DUPLICATE member DUP-007; canonical asset ASSET-0140. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CITY_SYSTEM/library/bedaya_amena/bedaya_amena_card.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0008

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/library/hodn_amen/hodn_amen_card.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/library/hodn_amen/hodn_amen_card.png`
- Reason: LEGACY_DUPLICATE member DUP-008; canonical asset ASSET-0141. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CITY_SYSTEM/library/hodn_amen/hodn_amen_card.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0009

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/logo_icon.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/logo_icon.png`
- Reason: KEEP_SEPARATE member DUP-009; canonical asset ASSET-0117. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logo_icon.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0010

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/logo_primary_dark.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/logo_primary_dark.png`
- Reason: KEEP_SEPARATE member DUP-009; canonical asset ASSET-0117. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logo_icon.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0011

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/menu/desktop/menu_desktop_bg.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/menu/desktop/menu_desktop_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-010; canonical asset ASSET-0124. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/BACKGROUNDS_SYSTEM/menu/desktop/menu_desktop_bg.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0012

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/menu/mobile/menu_mobile_bg.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/menu/mobile/menu_mobile_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-011; canonical asset ASSET-0125. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/BACKGROUNDS_SYSTEM/menu/mobile/menu_mobile_bg.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0013

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/menu/tablet/menu_tablet_bg.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/menu/tablet/menu_tablet_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-012; canonical asset ASSET-0126. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/BACKGROUNDS_SYSTEM/menu/tablet/menu_tablet_bg.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0014

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/navigation/back/back_left_gold.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/navigation/back/back_left_gold.png`
- Reason: LEGACY_DUPLICATE member DUP-013; canonical asset ASSET-0127. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/ICONS_SYSTEM/navigation/back/back_left_gold.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0015

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/navigation/back/back_right_gold.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/navigation/back/back_right_gold.png`
- Reason: LEGACY_DUPLICATE member DUP-014; canonical asset ASSET-0128. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/ICONS_SYSTEM/navigation/back/back_right_gold.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0016

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/navigation/logout/logout_gold.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/navigation/logout/logout_gold.png`
- Reason: BRANDING_DUPLICATE member DUP-015; canonical asset ASSET-0129. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logout_gold.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0017

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/centers/desktop/centers_step_1_account.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/centers/desktop/centers_step_1_account.png`
- Reason: LEGACY_DUPLICATE member DUP-016; canonical asset ASSET-0142. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/registration/desktop/centers_step_1_account.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0018

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/centers/desktop/centers_step_2_profile.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/centers/desktop/centers_step_2_profile.png`
- Reason: LEGACY_DUPLICATE member DUP-017; canonical asset ASSET-0143. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/registration/desktop/centers_step_2_profile.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0019

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/centers/desktop/centers_step_3_media.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/centers/desktop/centers_step_3_media.png`
- Reason: LEGACY_DUPLICATE member DUP-018; canonical asset ASSET-0144. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/registration/desktop/centers_step_3_media.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0020

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/centers/desktop/centers_step_4_pricing.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/centers/desktop/centers_step_4_pricing.png`
- Reason: LEGACY_DUPLICATE member DUP-019; canonical asset ASSET-0145. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/registration/desktop/centers_step_4_pricing.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0021

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/centers/desktop/centers_step_5_documents.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/centers/desktop/centers_step_5_documents.png`
- Reason: LEGACY_DUPLICATE member DUP-020; canonical asset ASSET-0146. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/registration/desktop/centers_step_5_documents.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0022

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/centers/desktop/centers_success.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/centers/desktop/centers_success.png`
- Reason: LEGACY_DUPLICATE member DUP-021; canonical asset ASSET-0147. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/WEB_SYSTEM/shell/centers_success.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0023

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/centers/mobile/centers_step_1_account.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/centers/mobile/centers_step_1_account.png`
- Reason: LEGACY_DUPLICATE member DUP-022; canonical asset ASSET-0148. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/registration/mobile/centers_step_1_account.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0024

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/centers/mobile/centers_step_2_profile.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/centers/mobile/centers_step_2_profile.png`
- Reason: LEGACY_DUPLICATE member DUP-023; canonical asset ASSET-0149. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/registration/mobile/centers_step_2_profile.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0025

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/centers/mobile/centers_step_3_media.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/centers/mobile/centers_step_3_media.png`
- Reason: LEGACY_DUPLICATE member DUP-024; canonical asset ASSET-0150. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/registration/mobile/centers_step_3_media.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0026

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/centers/mobile/centers_step_4_pricing.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/centers/mobile/centers_step_4_pricing.png`
- Reason: LEGACY_DUPLICATE member DUP-025; canonical asset ASSET-0151. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/registration/mobile/centers_step_4_pricing.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0027

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/centers/mobile/centers_step_5_documents.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/centers/mobile/centers_step_5_documents.png`
- Reason: LEGACY_DUPLICATE member DUP-026; canonical asset ASSET-0152. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/registration/mobile/centers_step_5_documents.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0028

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/centers/mobile/centers_success.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/centers/mobile/centers_success.png`
- Reason: LEGACY_DUPLICATE member DUP-027; canonical asset ASSET-0153. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/WEB_SYSTEM/shell/centers_success.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0029

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/centers/tablet/centers_step_1_account.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/centers/tablet/centers_step_1_account.png`
- Reason: LEGACY_DUPLICATE member DUP-028; canonical asset ASSET-0154. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/registration/tablet/centers_step_1_account.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0030

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/centers/tablet/centers_step_2_profile.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/centers/tablet/centers_step_2_profile.png`
- Reason: LEGACY_DUPLICATE member DUP-029; canonical asset ASSET-0155. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/registration/tablet/centers_step_2_profile.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0031

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/centers/tablet/centers_step_3_media.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/centers/tablet/centers_step_3_media.png`
- Reason: LEGACY_DUPLICATE member DUP-030; canonical asset ASSET-0156. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/registration/tablet/centers_step_3_media.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0032

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/centers/tablet/centers_step_4_pricing.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/centers/tablet/centers_step_4_pricing.png`
- Reason: LEGACY_DUPLICATE member DUP-031; canonical asset ASSET-0157. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/registration/tablet/centers_step_4_pricing.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0033

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/centers/tablet/centers_step_5_documents.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/centers/tablet/centers_step_5_documents.png`
- Reason: LEGACY_DUPLICATE member DUP-032; canonical asset ASSET-0158. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/registration/tablet/centers_step_5_documents.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0034

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/centers/tablet/centers_success.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/centers/tablet/centers_success.png`
- Reason: LEGACY_DUPLICATE member DUP-033; canonical asset ASSET-0159. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/WEB_SYSTEM/shell/centers_success.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0035

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/clinicians/desktop/clinicians_step_1_account.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/clinicians/desktop/clinicians_step_1_account.png`
- Reason: LEGACY_DUPLICATE member DUP-034; canonical asset ASSET-0160. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/registration/desktop/clinicians_step_1_account.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0036

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/clinicians/desktop/clinicians_step_2_profile.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/clinicians/desktop/clinicians_step_2_profile.png`
- Reason: LEGACY_DUPLICATE member DUP-035; canonical asset ASSET-0161. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/registration/desktop/clinicians_step_2_profile.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0037

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/clinicians/desktop/clinicians_step_3_sessions.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/clinicians/desktop/clinicians_step_3_sessions.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0038

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/clinicians/desktop/clinicians_step_4_documents.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/clinicians/desktop/clinicians_step_4_documents.png`
- Reason: LEGACY_DUPLICATE member DUP-036; canonical asset ASSET-0162. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/registration/desktop/clinicians_step_4_documents.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0039

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/clinicians/desktop/clinicians_success.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/clinicians/desktop/clinicians_success.png`
- Reason: LEGACY_DUPLICATE member DUP-021; canonical asset ASSET-0147. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/WEB_SYSTEM/shell/centers_success.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0040

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/clinicians/mobile/clinicians_step_1_account.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/clinicians/mobile/clinicians_step_1_account.png`
- Reason: LEGACY_DUPLICATE member DUP-037; canonical asset ASSET-0164. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/registration/mobile/clinicians_step_1_account.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0041

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/clinicians/mobile/clinicians_step_2_profile.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/clinicians/mobile/clinicians_step_2_profile.png`
- Reason: LEGACY_DUPLICATE member DUP-038; canonical asset ASSET-0165. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/registration/mobile/clinicians_step_2_profile.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0042

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/clinicians/mobile/clinicians_step_3_sessions.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/clinicians/mobile/clinicians_step_3_sessions.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0043

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/clinicians/mobile/clinicians_step_4_documents.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/clinicians/mobile/clinicians_step_4_documents.png`
- Reason: LEGACY_DUPLICATE member DUP-039; canonical asset ASSET-0166. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/registration/mobile/clinicians_step_4_documents.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0044

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/clinicians/mobile/clinicians_success.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/clinicians/mobile/clinicians_success.png`
- Reason: LEGACY_DUPLICATE member DUP-027; canonical asset ASSET-0153. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/WEB_SYSTEM/shell/centers_success.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0045

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/clinicians/tablet/clinicians_step_1_account.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/clinicians/tablet/clinicians_step_1_account.png`
- Reason: LEGACY_DUPLICATE member DUP-040; canonical asset ASSET-0168. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/registration/tablet/clinicians_step_1_account.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0046

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/clinicians/tablet/clinicians_step_2_profile.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/clinicians/tablet/clinicians_step_2_profile.png`
- Reason: LEGACY_DUPLICATE member DUP-041; canonical asset ASSET-0169. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/registration/tablet/clinicians_step_2_profile.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0047

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/clinicians/tablet/clinicians_step_3_sessions.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/clinicians/tablet/clinicians_step_3_sessions.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0048

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/clinicians/tablet/clinicians_step_4_documents.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/clinicians/tablet/clinicians_step_4_documents.png`
- Reason: LEGACY_DUPLICATE member DUP-042; canonical asset ASSET-0170. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/registration/tablet/clinicians_step_4_documents.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0049

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/branding/web_registration/clinicians/tablet/clinicians_success.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/branding/web_registration/clinicians/tablet/clinicians_success.png`
- Reason: LEGACY_DUPLICATE member DUP-033; canonical asset ASSET-0159. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/WEB_SYSTEM/shell/centers_success.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0050

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/c6_library/brand/logo_mark.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/c6_library/brand/logo_mark.png`
- Reason: BRANDING_DUPLICATE member DUP-043; canonical asset ASSET-0230. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logo_mark.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0051

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/c6_library/brand/logo_wordmark.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/c6_library/brand/logo_wordmark.png`
- Reason: BRANDING_DUPLICATE member DUP-044; canonical asset ASSET-0231. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logo_wordmark.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0052

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/c6_library/categories/cat_articles.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/c6_library/categories/cat_articles.png`
- Reason: LEGACY_DUPLICATE member DUP-045; canonical asset ASSET-0232. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CITY_SYSTEM/library/categories/cat_articles.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0053

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/c6_library/categories/cat_audio.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/c6_library/categories/cat_audio.png`
- Reason: LEGACY_DUPLICATE member DUP-046; canonical asset ASSET-0233. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CITY_SYSTEM/library/categories/cat_audio.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0054

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/c6_library/categories/cat_exercises.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/c6_library/categories/cat_exercises.png`
- Reason: LEGACY_DUPLICATE member DUP-047; canonical asset ASSET-0234. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CITY_SYSTEM/library/categories/cat_exercises.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0055

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/c6_library/categories/cat_saved.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/c6_library/categories/cat_saved.png`
- Reason: LEGACY_DUPLICATE member DUP-048; canonical asset ASSET-0235. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CITY_SYSTEM/library/categories/cat_saved.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0056

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/c6_library/categories/cat_tools.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/c6_library/categories/cat_tools.png`
- Reason: LEGACY_DUPLICATE member DUP-049; canonical asset ASSET-0236. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CITY_SYSTEM/library/categories/cat_tools.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0057

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/c6_library/categories/cat_videos.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/c6_library/categories/cat_videos.png`
- Reason: LEGACY_DUPLICATE member DUP-050; canonical asset ASSET-0237. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CITY_SYSTEM/library/categories/cat_videos.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0058

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/c7_branding/home/hero_art.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/c7_branding/home/hero_art.png`
- Reason: LEGACY_DUPLICATE member DUP-051; canonical asset ASSET-0248. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/BACKGROUNDS_SYSTEM/home/hero_art.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0059

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/c7_branding/home/home_bg.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/c7_branding/home/home_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-052; canonical asset ASSET-0249. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/BACKGROUNDS_SYSTEM/home/home_bg.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0060

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/c7_branding/logo/logo_mark.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/c7_branding/logo/logo_mark.png`
- Reason: BRANDING_DUPLICATE member DUP-043; canonical asset ASSET-0230. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logo_mark.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0061

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/c7_branding/logo/logo_wordmark.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/c7_branding/logo/logo_wordmark.png`
- Reason: BRANDING_DUPLICATE member DUP-044; canonical asset ASSET-0231. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logo_wordmark.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0062

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/avatar_clinician_male.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/avatar_clinician_male.png`
- Reason: LEGACY_DUPLICATE member DUP-053; canonical asset ASSET-0262. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/identity/avatar_clinician_male.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0063

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/backgrounds/specialists_bg_desktop.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/backgrounds/specialists_bg_desktop.png`
- Reason: LEGACY_DUPLICATE member DUP-054; canonical asset ASSET-0263. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/backgrounds/specialists_bg_desktop.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0064

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/backgrounds/specialists_bg_mobile.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/backgrounds/specialists_bg_mobile.png`
- Reason: LEGACY_DUPLICATE member DUP-055; canonical asset ASSET-0264. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/backgrounds/specialists_bg_mobile.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0065

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/backgrounds/specialists_bg_tablet.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/backgrounds/specialists_bg_tablet.png`
- Reason: LEGACY_DUPLICATE member DUP-056; canonical asset ASSET-0265. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/backgrounds/specialists_bg_tablet.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0066

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/center_dashboard/actions/actions/center_active_requests.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/center_dashboard/actions/actions/center_active_requests.png`
- Reason: LEGACY_DUPLICATE member DUP-057; canonical asset ASSET-0280. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/room_components/clinician_open_cases.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0067

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/center_dashboard/actions/actions/center_completed_requests.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/center_dashboard/actions/actions/center_completed_requests.png`
- Reason: LEGACY_DUPLICATE member DUP-058; canonical asset ASSET-0267. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/room_components/center_completed_requests.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0068

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/center_dashboard/actions/actions/center_new_requests.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/center_dashboard/actions/actions/center_new_requests.png`
- Reason: LEGACY_DUPLICATE member DUP-059; canonical asset ASSET-0268. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/room_components/center_new_requests.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0069

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/center_dashboard/actions/actions/center_rejected_requests.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/center_dashboard/actions/actions/center_rejected_requests.png`
- Reason: LEGACY_DUPLICATE member DUP-060; canonical asset ASSET-0269. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/room_components/center_rejected_requests.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0070

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/center_dashboard/actions/actions/center_sessions.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/center_dashboard/actions/actions/center_sessions.png`
- Reason: LEGACY_DUPLICATE member DUP-061; canonical asset ASSET-0087. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/client_dashboard/actions/client_sessions.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0071

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/center_dashboard/actions/actions/center_transferred_chats.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/center_dashboard/actions/actions/center_transferred_chats.png`
- Reason: KEEP_SEPARATE member DUP-062; canonical asset ASSET-0281. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/room_components/clinician_support_request.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0072

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/center_dashboard/actions/actions/center_update_profile.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/center_dashboard/actions/actions/center_update_profile.png`
- Reason: KEEP_SEPARATE member DUP-063; canonical asset ASSET-0271. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/room_components/center_update_profile.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0073

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/center_dashboard/actions/center_active_requests.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/center_dashboard/actions/center_active_requests.png`
- Reason: LEGACY_DUPLICATE member DUP-057; canonical asset ASSET-0280. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/room_components/clinician_open_cases.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0074

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/center_dashboard/actions/center_completed_requests.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/center_dashboard/actions/center_completed_requests.png`
- Reason: LEGACY_DUPLICATE member DUP-058; canonical asset ASSET-0267. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/room_components/center_completed_requests.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0075

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/center_dashboard/actions/center_new_requests.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/center_dashboard/actions/center_new_requests.png`
- Reason: LEGACY_DUPLICATE member DUP-059; canonical asset ASSET-0268. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/room_components/center_new_requests.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0076

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/center_dashboard/actions/center_rejected_requests.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/center_dashboard/actions/center_rejected_requests.png`
- Reason: LEGACY_DUPLICATE member DUP-060; canonical asset ASSET-0269. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/room_components/center_rejected_requests.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0077

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/center_dashboard/actions/center_sessions.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/center_dashboard/actions/center_sessions.png`
- Reason: LEGACY_DUPLICATE member DUP-061; canonical asset ASSET-0087. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/client_dashboard/actions/client_sessions.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0078

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/center_dashboard/actions/center_transferred_chats.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/center_dashboard/actions/center_transferred_chats.png`
- Reason: KEEP_SEPARATE member DUP-062; canonical asset ASSET-0281. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/room_components/clinician_support_request.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0079

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/center_dashboard/actions/center_update_profile.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/center_dashboard/actions/center_update_profile.png`
- Reason: KEEP_SEPARATE member DUP-063; canonical asset ASSET-0271. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/room_components/center_update_profile.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0080

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/centers/center_detox.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/centers/center_detox.png`
- Reason: LEGACY_DUPLICATE member DUP-064; canonical asset ASSET-0272. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/categories/center_detox.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0081

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/centers/center_hospital.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/centers/center_hospital.png`
- Reason: LEGACY_DUPLICATE member DUP-065; canonical asset ASSET-0273. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/categories/center_hospital.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0082

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/centers/center_rehabilitation.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/centers/center_rehabilitation.png`
- Reason: LEGACY_DUPLICATE member DUP-066; canonical asset ASSET-0274. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/categories/center_rehabilitation.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0083

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/centers/center_special_needs.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/centers/center_special_needs.png`
- Reason: LEGACY_DUPLICATE member DUP-067; canonical asset ASSET-0275. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/categories/center_special_needs.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0084

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/client_dashboard/actions/client_bookings.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/client_dashboard/actions/client_bookings.png`
- Reason: LEGACY_DUPLICATE member DUP-068; canonical asset ASSET-0276. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CLIENT_ROOM/tools/client_bookings.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0085

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/client_dashboard/actions/client_follow_up.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/client_dashboard/actions/client_follow_up.png`
- Reason: LEGACY_DUPLICATE member DUP-069; canonical asset ASSET-0277. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CLIENT_ROOM/tools/client_follow_up.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0086

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/client_dashboard/actions/client_payment_proof.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/client_dashboard/actions/client_payment_proof.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0087

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/client_dashboard/actions/client_sessions.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/client_dashboard/actions/client_sessions.png`
- Reason: LEGACY_DUPLICATE member DUP-061; canonical asset ASSET-0087. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/client_dashboard/actions/client_sessions.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0088

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/client_dashboard/actions/client_support.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/client_dashboard/actions/client_support.png`
- Reason: LEGACY_DUPLICATE member DUP-070; canonical asset ASSET-0278. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CLIENT_ROOM/tools/client_support.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0089

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/clinicians_dashboard/actions/clinician_edit_profile.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/clinicians_dashboard/actions/clinician_edit_profile.png`
- Reason: KEEP_SEPARATE member DUP-063; canonical asset ASSET-0271. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/room_components/center_update_profile.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0090

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/clinicians_dashboard/actions/clinician_open_cases.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/clinicians_dashboard/actions/clinician_open_cases.png`
- Reason: LEGACY_DUPLICATE member DUP-057; canonical asset ASSET-0280. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/room_components/clinician_open_cases.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0091

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/clinicians_dashboard/actions/clinician_sessions.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/clinicians_dashboard/actions/clinician_sessions.png`
- Reason: LEGACY_DUPLICATE member DUP-061; canonical asset ASSET-0087. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/client_dashboard/actions/client_sessions.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0092

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/clinicians_dashboard/actions/clinician_support_request.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/clinicians_dashboard/actions/clinician_support_request.png`
- Reason: KEEP_SEPARATE member DUP-062; canonical asset ASSET-0281. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/room_components/clinician_support_request.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0093

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/specialists/specialist_addiction.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/specialists/specialist_addiction.png`
- Reason: LEGACY_DUPLICATE member DUP-071; canonical asset ASSET-0286. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/categories/specialist_addiction.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0094

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/specialists/specialist_coaching.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/specialists/specialist_coaching.png`
- Reason: LEGACY_DUPLICATE member DUP-072; canonical asset ASSET-0287. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/categories/specialist_coaching.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0095

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/specialists/specialist_family.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/specialists/specialist_family.png`
- Reason: LEGACY_DUPLICATE member DUP-073; canonical asset ASSET-0288. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/categories/specialist_family.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0096

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/specialists/specialist_psychology.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/specialists/specialist_psychology.png`
- Reason: LEGACY_DUPLICATE member DUP-074; canonical asset ASSET-0289. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/categories/specialist_psychology.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0097

- Current Path: `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/assets/images/specialists/specialist_speech.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/immutable_snapshots/2026-05-25/assets/images/specialists/specialist_speech.png`
- Reason: LEGACY_DUPLICATE member DUP-075; canonical asset ASSET-0290. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/categories/specialist_speech.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0098

- Current Path: `android/app/src/main/res/drawable/background.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/removal_review/android__app__src__main__res__drawable__background.png`
- Reason: REMOVE_CANDIDATE member DUP-076; canonical asset ASSET-0098. Removal review candidate; no consumer was proven.
- Status: **DEAD**

## ASSET-0099

- Current Path: `android/app/src/main/res/drawable-v21/background.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/removal_review/android__app__src__main__res__drawable-v21__background.png`
- Reason: REMOVE_CANDIDATE member DUP-076; canonical asset ASSET-0098. Removal review candidate; no consumer was proven.
- Status: **DEAD**

## ASSET-0100

- Current Path: `android/app/src/main/res/mipmap-hdpi/ic_launcher.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/removal_review/android__app__src__main__res__mipmap-hdpi__ic_launcher.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Removal review candidate; no consumer was proven.
- Status: **DEAD**

## ASSET-0101

- Current Path: `android/app/src/main/res/mipmap-mdpi/ic_launcher.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/removal_review/android__app__src__main__res__mipmap-mdpi__ic_launcher.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Removal review candidate; no consumer was proven.
- Status: **DEAD**

## ASSET-0102

- Current Path: `android/app/src/main/res/mipmap-xhdpi/ic_launcher.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/removal_review/android__app__src__main__res__mipmap-xhdpi__ic_launcher.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Removal review candidate; no consumer was proven.
- Status: **DEAD**

## ASSET-0103

- Current Path: `android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/removal_review/android__app__src__main__res__mipmap-xxhdpi__ic_launcher.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Removal review candidate; no consumer was proven.
- Status: **DEAD**

## ASSET-0104

- Current Path: `android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/removal_review/android__app__src__main__res__mipmap-xxxhdpi__ic_launcher.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Removal review candidate; no consumer was proven.
- Status: **DEAD**

## ASSET-0105

- Current Path: `assets/branding/client_dashboard/desktop/client_dashboard_desktop_bg.png`
- Suggested Registry: **CLIENT_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CLIENT_ROOM/backgrounds/desktop/client_dashboard_desktop_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-001; canonical asset ASSET-0105. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0106

- Current Path: `assets/branding/client_dashboard/mobile/client_dashboard_mobile_bg.png`
- Suggested Registry: **CLIENT_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CLIENT_ROOM/backgrounds/mobile/client_dashboard_mobile_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-002; canonical asset ASSET-0106. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0107

- Current Path: `assets/branding/client_dashboard/tablet/client_dashboard_tablet_bg.png`
- Suggested Registry: **CLIENT_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CLIENT_ROOM/backgrounds/tablet/client_dashboard_tablet_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-003; canonical asset ASSET-0107. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0108

- Current Path: `assets/branding/language/en_gold.png`
- Suggested Registry: **AUTH_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/AUTH_SYSTEM/other/en_gold.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0109

- Current Path: `assets/branding/library/backgrounds/desktop/library_desktop_bg.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/backgrounds/desktop/library_desktop_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-004; canonical asset ASSET-0137. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0110

- Current Path: `assets/branding/library/backgrounds/mobile/library_mobile_bg.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/backgrounds/mobile/library_mobile_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-005; canonical asset ASSET-0138. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0111

- Current Path: `assets/branding/library/backgrounds/tablet/library_tablet_bg.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/backgrounds/tablet/library_tablet_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-006; canonical asset ASSET-0139. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0112

- Current Path: `assets/branding/library/bedaya_amena/bedaya_amena_card.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/bedaya_amena/bedaya_amena_card.png`
- Reason: LEGACY_DUPLICATE member DUP-007; canonical asset ASSET-0140. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0113

- Current Path: `assets/branding/library/hodn_amen/hodn_amen_card.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/hodn_amen/hodn_amen_card.png`
- Reason: LEGACY_DUPLICATE member DUP-008; canonical asset ASSET-0141. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0114

- Current Path: `assets/branding/login/login_mobile_v1.png`
- Suggested Registry: **AUTH_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/AUTH_SYSTEM/other/login_mobile_v1.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0115

- Current Path: `assets/branding/login/login_tablet_v1.png`
- Suggested Registry: **AUTH_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/AUTH_SYSTEM/other/login_tablet_v1.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0116

- Current Path: `assets/branding/login/login_web_v1.png`
- Suggested Registry: **AUTH_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/AUTH_SYSTEM/other/login_web_v1.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0117

- Current Path: `assets/branding/logo_icon.png`
- Suggested Registry: **BRANDING_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logo_icon.png`
- Reason: KEEP_SEPARATE member DUP-009; canonical asset ASSET-0117. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0118

- Current Path: `assets/branding/logo_icon_light.png`
- Suggested Registry: **BRANDING_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logo_icon_light.png`
- Reason: BRANDING_DUPLICATE member DUP-077; canonical asset ASSET-0118. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0119

- Current Path: `assets/branding/logo_light.png`
- Suggested Registry: **BRANDING_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logo_light.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0120

- Current Path: `assets/branding/logo_marketing_glow.png`
- Suggested Registry: **BRANDING_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logo_marketing_glow.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0121

- Current Path: `assets/branding/logo_primary.png`
- Suggested Registry: **BRANDING_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logo_primary.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0122

- Current Path: `assets/branding/logo_primary_dark.png`
- Suggested Registry: **BRANDING_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logo_primary_dark.png`
- Reason: KEEP_SEPARATE member DUP-009; canonical asset ASSET-0117. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0123

- Current Path: `assets/branding/logo_transparent.png`
- Suggested Registry: **BRANDING_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logo_icon_light.png`
- Reason: BRANDING_DUPLICATE member DUP-077; canonical asset ASSET-0118. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0124

- Current Path: `assets/branding/menu/desktop/menu_desktop_bg.png`
- Suggested Registry: **BACKGROUNDS_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BACKGROUNDS_SYSTEM/menu/desktop/menu_desktop_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-010; canonical asset ASSET-0124. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0125

- Current Path: `assets/branding/menu/mobile/menu_mobile_bg.png`
- Suggested Registry: **BACKGROUNDS_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BACKGROUNDS_SYSTEM/menu/mobile/menu_mobile_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-011; canonical asset ASSET-0125. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0126

- Current Path: `assets/branding/menu/tablet/menu_tablet_bg.png`
- Suggested Registry: **BACKGROUNDS_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BACKGROUNDS_SYSTEM/menu/tablet/menu_tablet_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-012; canonical asset ASSET-0126. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0127

- Current Path: `assets/branding/navigation/back/back_left_gold.png`
- Suggested Registry: **ICONS_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/ICONS_SYSTEM/navigation/back/back_left_gold.png`
- Reason: LEGACY_DUPLICATE member DUP-013; canonical asset ASSET-0127. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0128

- Current Path: `assets/branding/navigation/back/back_right_gold.png`
- Suggested Registry: **ICONS_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/ICONS_SYSTEM/navigation/back/back_right_gold.png`
- Reason: LEGACY_DUPLICATE member DUP-014; canonical asset ASSET-0128. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0129

- Current Path: `assets/branding/navigation/logout/logout_gold.png`
- Suggested Registry: **BRANDING_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logout_gold.png`
- Reason: BRANDING_DUPLICATE member DUP-015; canonical asset ASSET-0129. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0130

- Current Path: `assets/branding/shared/logo/logo_primary_dark.png`
- Suggested Registry: **BRANDING_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logo_primary_dark.png`
- Reason: KEEP_SEPARATE member DUP-009; canonical asset ASSET-0117. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0131

- Current Path: `assets/branding/shared/navigation/back/back_left_gold.png`
- Suggested Registry: **ICONS_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/ICONS_SYSTEM/navigation/back/back_left_gold.png`
- Reason: LEGACY_DUPLICATE member DUP-013; canonical asset ASSET-0127. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0132

- Current Path: `assets/branding/shared/navigation/back/back_right_gold.png`
- Suggested Registry: **ICONS_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/ICONS_SYSTEM/navigation/back/back_right_gold.png`
- Reason: LEGACY_DUPLICATE member DUP-014; canonical asset ASSET-0128. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0133

- Current Path: `assets/branding/shared/navigation/logout/logout_gold.png`
- Suggested Registry: **BRANDING_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logout_gold.png`
- Reason: BRANDING_DUPLICATE member DUP-015; canonical asset ASSET-0129. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0134

- Current Path: `assets/branding/splash/splash_mobile_v1.jpg`
- Suggested Registry: **AUTH_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/AUTH_SYSTEM/background/splash_mobile_v1.jpg`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0135

- Current Path: `assets/branding/splash/splash_tablet_v1.jpg`
- Suggested Registry: **AUTH_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/AUTH_SYSTEM/background/splash_tablet_v1.jpg`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0136

- Current Path: `assets/branding/splash/splash_web_v1.jpg`
- Suggested Registry: **AUTH_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/AUTH_SYSTEM/background/splash_web_v1.jpg`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0137

- Current Path: `assets/branding/web/library/backgrounds/desktop/library_desktop_bg.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/backgrounds/desktop/library_desktop_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-004; canonical asset ASSET-0137. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0138

- Current Path: `assets/branding/web/library/backgrounds/mobile/library_mobile_bg.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/backgrounds/mobile/library_mobile_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-005; canonical asset ASSET-0138. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0139

- Current Path: `assets/branding/web/library/backgrounds/tablet/library_tablet_bg.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/backgrounds/tablet/library_tablet_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-006; canonical asset ASSET-0139. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0140

- Current Path: `assets/branding/web/library/bedaya_amena/bedaya_amena_card.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/bedaya_amena/bedaya_amena_card.png`
- Reason: LEGACY_DUPLICATE member DUP-007; canonical asset ASSET-0140. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0141

- Current Path: `assets/branding/web/library/hodn_amen/hodn_amen_card.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/hodn_amen/hodn_amen_card.png`
- Reason: LEGACY_DUPLICATE member DUP-008; canonical asset ASSET-0141. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0142

- Current Path: `assets/branding/web/registration/centers/desktop/centers_step_1_account.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/desktop/centers_step_1_account.png`
- Reason: LEGACY_DUPLICATE member DUP-016; canonical asset ASSET-0142. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0143

- Current Path: `assets/branding/web/registration/centers/desktop/centers_step_2_profile.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/desktop/centers_step_2_profile.png`
- Reason: LEGACY_DUPLICATE member DUP-017; canonical asset ASSET-0143. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0144

- Current Path: `assets/branding/web/registration/centers/desktop/centers_step_3_media.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/desktop/centers_step_3_media.png`
- Reason: LEGACY_DUPLICATE member DUP-018; canonical asset ASSET-0144. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0145

- Current Path: `assets/branding/web/registration/centers/desktop/centers_step_4_pricing.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/desktop/centers_step_4_pricing.png`
- Reason: LEGACY_DUPLICATE member DUP-019; canonical asset ASSET-0145. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0146

- Current Path: `assets/branding/web/registration/centers/desktop/centers_step_5_documents.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/desktop/centers_step_5_documents.png`
- Reason: LEGACY_DUPLICATE member DUP-020; canonical asset ASSET-0146. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0147

- Current Path: `assets/branding/web/registration/centers/desktop/centers_success.png`
- Suggested Registry: **WEB_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/WEB_SYSTEM/shell/centers_success.png`
- Reason: LEGACY_DUPLICATE member DUP-021; canonical asset ASSET-0147. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0148

- Current Path: `assets/branding/web/registration/centers/mobile/centers_step_1_account.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/mobile/centers_step_1_account.png`
- Reason: LEGACY_DUPLICATE member DUP-022; canonical asset ASSET-0148. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0149

- Current Path: `assets/branding/web/registration/centers/mobile/centers_step_2_profile.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/mobile/centers_step_2_profile.png`
- Reason: LEGACY_DUPLICATE member DUP-023; canonical asset ASSET-0149. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0150

- Current Path: `assets/branding/web/registration/centers/mobile/centers_step_3_media.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/mobile/centers_step_3_media.png`
- Reason: LEGACY_DUPLICATE member DUP-024; canonical asset ASSET-0150. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0151

- Current Path: `assets/branding/web/registration/centers/mobile/centers_step_4_pricing.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/mobile/centers_step_4_pricing.png`
- Reason: LEGACY_DUPLICATE member DUP-025; canonical asset ASSET-0151. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0152

- Current Path: `assets/branding/web/registration/centers/mobile/centers_step_5_documents.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/mobile/centers_step_5_documents.png`
- Reason: LEGACY_DUPLICATE member DUP-026; canonical asset ASSET-0152. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0153

- Current Path: `assets/branding/web/registration/centers/mobile/centers_success.png`
- Suggested Registry: **WEB_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/WEB_SYSTEM/shell/centers_success.png`
- Reason: LEGACY_DUPLICATE member DUP-027; canonical asset ASSET-0153. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0154

- Current Path: `assets/branding/web/registration/centers/tablet/centers_step_1_account.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/tablet/centers_step_1_account.png`
- Reason: LEGACY_DUPLICATE member DUP-028; canonical asset ASSET-0154. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0155

- Current Path: `assets/branding/web/registration/centers/tablet/centers_step_2_profile.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/tablet/centers_step_2_profile.png`
- Reason: LEGACY_DUPLICATE member DUP-029; canonical asset ASSET-0155. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0156

- Current Path: `assets/branding/web/registration/centers/tablet/centers_step_3_media.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/tablet/centers_step_3_media.png`
- Reason: LEGACY_DUPLICATE member DUP-030; canonical asset ASSET-0156. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0157

- Current Path: `assets/branding/web/registration/centers/tablet/centers_step_4_pricing.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/tablet/centers_step_4_pricing.png`
- Reason: LEGACY_DUPLICATE member DUP-031; canonical asset ASSET-0157. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0158

- Current Path: `assets/branding/web/registration/centers/tablet/centers_step_5_documents.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/tablet/centers_step_5_documents.png`
- Reason: LEGACY_DUPLICATE member DUP-032; canonical asset ASSET-0158. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0159

- Current Path: `assets/branding/web/registration/centers/tablet/centers_success.png`
- Suggested Registry: **WEB_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/WEB_SYSTEM/shell/centers_success.png`
- Reason: LEGACY_DUPLICATE member DUP-033; canonical asset ASSET-0159. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0160

- Current Path: `assets/branding/web/registration/clinicians/desktop/clinicians_step_1_account.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/registration/desktop/clinicians_step_1_account.png`
- Reason: LEGACY_DUPLICATE member DUP-034; canonical asset ASSET-0160. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0161

- Current Path: `assets/branding/web/registration/clinicians/desktop/clinicians_step_2_profile.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/registration/desktop/clinicians_step_2_profile.png`
- Reason: LEGACY_DUPLICATE member DUP-035; canonical asset ASSET-0161. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0162

- Current Path: `assets/branding/web/registration/clinicians/desktop/clinicians_step_4_documents.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/registration/desktop/clinicians_step_4_documents.png`
- Reason: LEGACY_DUPLICATE member DUP-036; canonical asset ASSET-0162. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0163

- Current Path: `assets/branding/web/registration/clinicians/desktop/clinicians_success.png`
- Suggested Registry: **WEB_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/WEB_SYSTEM/shell/centers_success.png`
- Reason: LEGACY_DUPLICATE member DUP-021; canonical asset ASSET-0147. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0164

- Current Path: `assets/branding/web/registration/clinicians/mobile/clinicians_step_1_account.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/registration/mobile/clinicians_step_1_account.png`
- Reason: LEGACY_DUPLICATE member DUP-037; canonical asset ASSET-0164. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0165

- Current Path: `assets/branding/web/registration/clinicians/mobile/clinicians_step_2_profile.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/registration/mobile/clinicians_step_2_profile.png`
- Reason: LEGACY_DUPLICATE member DUP-038; canonical asset ASSET-0165. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0166

- Current Path: `assets/branding/web/registration/clinicians/mobile/clinicians_step_4_documents.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/registration/mobile/clinicians_step_4_documents.png`
- Reason: LEGACY_DUPLICATE member DUP-039; canonical asset ASSET-0166. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0167

- Current Path: `assets/branding/web/registration/clinicians/mobile/clinicians_success.png`
- Suggested Registry: **WEB_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/WEB_SYSTEM/shell/centers_success.png`
- Reason: LEGACY_DUPLICATE member DUP-027; canonical asset ASSET-0153. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0168

- Current Path: `assets/branding/web/registration/clinicians/tablet/clinicians_step_1_account.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/registration/tablet/clinicians_step_1_account.png`
- Reason: LEGACY_DUPLICATE member DUP-040; canonical asset ASSET-0168. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0169

- Current Path: `assets/branding/web/registration/clinicians/tablet/clinicians_step_2_profile.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/registration/tablet/clinicians_step_2_profile.png`
- Reason: LEGACY_DUPLICATE member DUP-041; canonical asset ASSET-0169. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0170

- Current Path: `assets/branding/web/registration/clinicians/tablet/clinicians_step_4_documents.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/registration/tablet/clinicians_step_4_documents.png`
- Reason: LEGACY_DUPLICATE member DUP-042; canonical asset ASSET-0170. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0171

- Current Path: `assets/branding/web/registration/clinicians/tablet/clinicians_success.png`
- Suggested Registry: **WEB_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/WEB_SYSTEM/shell/centers_success.png`
- Reason: LEGACY_DUPLICATE member DUP-033; canonical asset ASSET-0159. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0172

- Current Path: `assets/branding/web_registration/centers/desktop/centers_step_1_account.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/desktop/centers_step_1_account.png`
- Reason: LEGACY_DUPLICATE member DUP-016; canonical asset ASSET-0142. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0173

- Current Path: `assets/branding/web_registration/centers/desktop/centers_step_2_profile.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/desktop/centers_step_2_profile.png`
- Reason: LEGACY_DUPLICATE member DUP-017; canonical asset ASSET-0143. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0174

- Current Path: `assets/branding/web_registration/centers/desktop/centers_step_3_media.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/desktop/centers_step_3_media.png`
- Reason: LEGACY_DUPLICATE member DUP-018; canonical asset ASSET-0144. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0175

- Current Path: `assets/branding/web_registration/centers/desktop/centers_step_4_pricing.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/desktop/centers_step_4_pricing.png`
- Reason: LEGACY_DUPLICATE member DUP-019; canonical asset ASSET-0145. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0176

- Current Path: `assets/branding/web_registration/centers/desktop/centers_step_5_documents.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/desktop/centers_step_5_documents.png`
- Reason: LEGACY_DUPLICATE member DUP-020; canonical asset ASSET-0146. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0177

- Current Path: `assets/branding/web_registration/centers/desktop/centers_success.png`
- Suggested Registry: **WEB_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/WEB_SYSTEM/shell/centers_success.png`
- Reason: LEGACY_DUPLICATE member DUP-021; canonical asset ASSET-0147. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0178

- Current Path: `assets/branding/web_registration/centers/mobile/centers_step_1_account.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/mobile/centers_step_1_account.png`
- Reason: LEGACY_DUPLICATE member DUP-022; canonical asset ASSET-0148. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0179

- Current Path: `assets/branding/web_registration/centers/mobile/centers_step_2_profile.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/mobile/centers_step_2_profile.png`
- Reason: LEGACY_DUPLICATE member DUP-023; canonical asset ASSET-0149. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0180

- Current Path: `assets/branding/web_registration/centers/mobile/centers_step_3_media.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/mobile/centers_step_3_media.png`
- Reason: LEGACY_DUPLICATE member DUP-024; canonical asset ASSET-0150. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0181

- Current Path: `assets/branding/web_registration/centers/mobile/centers_step_4_pricing.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/mobile/centers_step_4_pricing.png`
- Reason: LEGACY_DUPLICATE member DUP-025; canonical asset ASSET-0151. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0182

- Current Path: `assets/branding/web_registration/centers/mobile/centers_step_5_documents.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/mobile/centers_step_5_documents.png`
- Reason: LEGACY_DUPLICATE member DUP-026; canonical asset ASSET-0152. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0183

- Current Path: `assets/branding/web_registration/centers/mobile/centers_success.png`
- Suggested Registry: **WEB_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/WEB_SYSTEM/shell/centers_success.png`
- Reason: LEGACY_DUPLICATE member DUP-027; canonical asset ASSET-0153. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0184

- Current Path: `assets/branding/web_registration/centers/tablet/centers_step_1_account.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/tablet/centers_step_1_account.png`
- Reason: LEGACY_DUPLICATE member DUP-028; canonical asset ASSET-0154. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0185

- Current Path: `assets/branding/web_registration/centers/tablet/centers_step_2_profile.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/tablet/centers_step_2_profile.png`
- Reason: LEGACY_DUPLICATE member DUP-029; canonical asset ASSET-0155. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0186

- Current Path: `assets/branding/web_registration/centers/tablet/centers_step_3_media.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/tablet/centers_step_3_media.png`
- Reason: LEGACY_DUPLICATE member DUP-030; canonical asset ASSET-0156. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0187

- Current Path: `assets/branding/web_registration/centers/tablet/centers_step_4_pricing.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/tablet/centers_step_4_pricing.png`
- Reason: LEGACY_DUPLICATE member DUP-031; canonical asset ASSET-0157. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0188

- Current Path: `assets/branding/web_registration/centers/tablet/centers_step_5_documents.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/registration/tablet/centers_step_5_documents.png`
- Reason: LEGACY_DUPLICATE member DUP-032; canonical asset ASSET-0158. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0189

- Current Path: `assets/branding/web_registration/centers/tablet/centers_success.png`
- Suggested Registry: **WEB_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/WEB_SYSTEM/shell/centers_success.png`
- Reason: LEGACY_DUPLICATE member DUP-033; canonical asset ASSET-0159. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0190

- Current Path: `assets/branding/web_registration/clients/desktop/client_register.png`
- Suggested Registry: **CLIENT_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CLIENT_ROOM/branding/web_registration/clients/desktop/client_register.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0191

- Current Path: `assets/branding/web_registration/clients/mobile/client_register.png`
- Suggested Registry: **CLIENT_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CLIENT_ROOM/branding/web_registration/clients/mobile/client_register.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0192

- Current Path: `assets/branding/web_registration/clients/tablet/client_register.png`
- Suggested Registry: **CLIENT_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CLIENT_ROOM/branding/web_registration/clients/tablet/client_register.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0193

- Current Path: `assets/branding/web_registration/clinician/clinician_step_1_account.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/branding/web_registration/clinician/clinician_step_1_account.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0194

- Current Path: `assets/branding/web_registration/clinician/clinician_step_2_profile.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/branding/web_registration/clinician/clinician_step_2_profile.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0195

- Current Path: `assets/branding/web_registration/clinician/clinician_step_4_documents.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/branding/web_registration/clinician/clinician_step_4_documents.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0196

- Current Path: `assets/branding/web_registration/clinician/clinician_success.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/branding/web_registration/clinician/clinician_success.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0197

- Current Path: `assets/branding/web_registration/clinicians/desktop/clinicians_step_1_account.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/registration/desktop/clinicians_step_1_account.png`
- Reason: LEGACY_DUPLICATE member DUP-034; canonical asset ASSET-0160. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0198

- Current Path: `assets/branding/web_registration/clinicians/desktop/clinicians_step_2_profile.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/registration/desktop/clinicians_step_2_profile.png`
- Reason: LEGACY_DUPLICATE member DUP-035; canonical asset ASSET-0161. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0199

- Current Path: `assets/branding/web_registration/clinicians/desktop/clinicians_step_4_documents.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/registration/desktop/clinicians_step_4_documents.png`
- Reason: LEGACY_DUPLICATE member DUP-036; canonical asset ASSET-0162. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0200

- Current Path: `assets/branding/web_registration/clinicians/desktop/clinicians_success.png`
- Suggested Registry: **WEB_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/WEB_SYSTEM/shell/centers_success.png`
- Reason: LEGACY_DUPLICATE member DUP-021; canonical asset ASSET-0147. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0201

- Current Path: `assets/branding/web_registration/clinicians/mobile/clinicians_step_1_account.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/registration/mobile/clinicians_step_1_account.png`
- Reason: LEGACY_DUPLICATE member DUP-037; canonical asset ASSET-0164. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0202

- Current Path: `assets/branding/web_registration/clinicians/mobile/clinicians_step_2_profile.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/registration/mobile/clinicians_step_2_profile.png`
- Reason: LEGACY_DUPLICATE member DUP-038; canonical asset ASSET-0165. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0203

- Current Path: `assets/branding/web_registration/clinicians/mobile/clinicians_step_4_documents.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/registration/mobile/clinicians_step_4_documents.png`
- Reason: LEGACY_DUPLICATE member DUP-039; canonical asset ASSET-0166. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0204

- Current Path: `assets/branding/web_registration/clinicians/mobile/clinicians_success.png`
- Suggested Registry: **WEB_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/WEB_SYSTEM/shell/centers_success.png`
- Reason: LEGACY_DUPLICATE member DUP-027; canonical asset ASSET-0153. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0205

- Current Path: `assets/branding/web_registration/clinicians/tablet/clinicians_step_1_account.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/registration/tablet/clinicians_step_1_account.png`
- Reason: LEGACY_DUPLICATE member DUP-040; canonical asset ASSET-0168. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0206

- Current Path: `assets/branding/web_registration/clinicians/tablet/clinicians_step_2_profile.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/registration/tablet/clinicians_step_2_profile.png`
- Reason: LEGACY_DUPLICATE member DUP-041; canonical asset ASSET-0169. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0207

- Current Path: `assets/branding/web_registration/clinicians/tablet/clinicians_step_4_documents.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/registration/tablet/clinicians_step_4_documents.png`
- Reason: LEGACY_DUPLICATE member DUP-042; canonical asset ASSET-0170. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0208

- Current Path: `assets/branding/web_registration/clinicians/tablet/clinicians_success.png`
- Suggested Registry: **WEB_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/WEB_SYSTEM/shell/centers_success.png`
- Reason: LEGACY_DUPLICATE member DUP-033; canonical asset ASSET-0159. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0209

- Current Path: `assets/c5/avatars/avatar_client.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/avatars/avatar_client.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0210

- Current Path: `assets/c5/avatars/avatar_clinician_f.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/avatars/avatar_clinician_f.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0211

- Current Path: `assets/c5/avatars/avatar_clinician_m.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/avatars/avatar_clinician_m.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0212

- Current Path: `assets/c5/icons/icon_approved.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/icons/icon_approved.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0213

- Current Path: `assets/c5/icons/icon_booking.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/icons/icon_booking.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0214

- Current Path: `assets/c5/icons/icon_inbox.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/icons/icon_inbox.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0215

- Current Path: `assets/c5/icons/icon_my_requests.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/icons/icon_my_requests.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0216

- Current Path: `assets/c5/icons/icon_pending.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/icons/icon_pending.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0217

- Current Path: `assets/c5/icons/icon_rejected.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/icons/icon_rejected.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0218

- Current Path: `assets/c5/sheet/c5_sheet.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/sheet/c5_sheet.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0219

- Current Path: `assets/c5/ui/badges/badge_new.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/ui/badges/badge_new.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0220

- Current Path: `assets/c5/ui/badges/badge_verified.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/ui/badges/badge_verified.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0221

- Current Path: `assets/c5/ui/buttons/button_primary.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/ui/buttons/button_primary.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0222

- Current Path: `assets/c5/ui/buttons/button_secondary.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/ui/buttons/button_secondary.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0223

- Current Path: `assets/c5/ui/gradients/gradient_ribbon_1.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/ui/gradients/gradient_ribbon_1.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0224

- Current Path: `assets/c5/ui/gradients/gradient_ribbon_2.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/ui/gradients/gradient_ribbon_2.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0225

- Current Path: `assets/c5/ui/ornaments/ornament_divider_1.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/ui/ornaments/ornament_divider_1.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0226

- Current Path: `assets/c5/ui/status_dots/dot_approved.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/ui/status_dots/dot_approved.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0227

- Current Path: `assets/c5/ui/status_dots/dot_online.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/ui/status_dots/dot_online.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0228

- Current Path: `assets/c5/ui/status_dots/dot_pending.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/ui/status_dots/dot_pending.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0229

- Current Path: `assets/c5/ui/status_dots/dot_rejected.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/c5/ui/status_dots/dot_rejected.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0230

- Current Path: `assets/c6_library/brand/logo_mark.png`
- Suggested Registry: **BRANDING_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logo_mark.png`
- Reason: BRANDING_DUPLICATE member DUP-043; canonical asset ASSET-0230. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0231

- Current Path: `assets/c6_library/brand/logo_wordmark.png`
- Suggested Registry: **BRANDING_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logo_wordmark.png`
- Reason: BRANDING_DUPLICATE member DUP-044; canonical asset ASSET-0231. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0232

- Current Path: `assets/c6_library/categories/cat_articles.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/categories/cat_articles.png`
- Reason: LEGACY_DUPLICATE member DUP-045; canonical asset ASSET-0232. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0233

- Current Path: `assets/c6_library/categories/cat_audio.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/categories/cat_audio.png`
- Reason: LEGACY_DUPLICATE member DUP-046; canonical asset ASSET-0233. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0234

- Current Path: `assets/c6_library/categories/cat_exercises.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/categories/cat_exercises.png`
- Reason: LEGACY_DUPLICATE member DUP-047; canonical asset ASSET-0234. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0235

- Current Path: `assets/c6_library/categories/cat_saved.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/categories/cat_saved.png`
- Reason: LEGACY_DUPLICATE member DUP-048; canonical asset ASSET-0235. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0236

- Current Path: `assets/c6_library/categories/cat_tools.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/categories/cat_tools.png`
- Reason: LEGACY_DUPLICATE member DUP-049; canonical asset ASSET-0236. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0237

- Current Path: `assets/c6_library/categories/cat_videos.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/categories/cat_videos.png`
- Reason: LEGACY_DUPLICATE member DUP-050; canonical asset ASSET-0237. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0238

- Current Path: `assets/c6_library/hero/library_hero.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/hero/library_hero.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0239

- Current Path: `assets/c6_library/states/empty_library.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/states/empty_library.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0240

- Current Path: `assets/c6_library/states/locked_clinicians.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/c6_library/states/locked_clinicians.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0241

- Current Path: `assets/c6_library/ui/badges/badge_new.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/ui/badges/badge_new.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0242

- Current Path: `assets/c6_library/ui/badges/badge_pro.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/ui/badges/badge_pro.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0243

- Current Path: `assets/c6_library/ui/buttons/btn_primary.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/ui/buttons/btn_primary.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0244

- Current Path: `assets/c6_library/ui/buttons/btn_secondary.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/ui/buttons/btn_secondary.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0245

- Current Path: `assets/c6_library/ui/ornaments/ornament_divider_1.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/library/ui/ornaments/ornament_divider_1.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0246

- Current Path: `assets/c7_branding/buttons/primary_button.png`
- Suggested Registry: **BRANDING_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BRANDING_SYSTEM/promotional/primary_button.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0247

- Current Path: `assets/c7_branding/buttons/secondary_button.png`
- Suggested Registry: **BRANDING_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BRANDING_SYSTEM/promotional/secondary_button.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0248

- Current Path: `assets/c7_branding/home/hero_art.png`
- Suggested Registry: **BACKGROUNDS_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BACKGROUNDS_SYSTEM/home/hero_art.png`
- Reason: LEGACY_DUPLICATE member DUP-051; canonical asset ASSET-0248. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0249

- Current Path: `assets/c7_branding/home/home_bg.png`
- Suggested Registry: **BACKGROUNDS_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BACKGROUNDS_SYSTEM/home/home_bg.png`
- Reason: LEGACY_DUPLICATE member DUP-052; canonical asset ASSET-0249. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0250

- Current Path: `assets/c7_branding/logo/logo_mark.png`
- Suggested Registry: **BRANDING_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logo_mark.png`
- Reason: BRANDING_DUPLICATE member DUP-043; canonical asset ASSET-0230. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0251

- Current Path: `assets/c7_branding/logo/logo_wordmark.png`
- Suggested Registry: **BRANDING_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/BRANDING_SYSTEM/logos/logo_wordmark.png`
- Reason: BRANDING_DUPLICATE member DUP-044; canonical asset ASSET-0231. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0252

- Current Path: `assets/c7_branding/splash/splash_bg.png`
- Suggested Registry: **AUTH_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/AUTH_SYSTEM/background/splash_bg.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0253

- Current Path: `assets/c7_branding/splash/splash_logo_ar.png`
- Suggested Registry: **AUTH_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/AUTH_SYSTEM/background/splash_logo_ar.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0254

- Current Path: `assets/c7_branding/splash/splash_logo_en.png`
- Suggested Registry: **AUTH_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/AUTH_SYSTEM/background/splash_logo_en.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0255

- Current Path: `assets/images/addiction/addiction_contact_support.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/images/addiction/addiction_contact_support.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0256

- Current Path: `assets/images/addiction/addiction_explore_centers.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/images/addiction/addiction_explore_centers.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0257

- Current Path: `assets/images/addiction/addiction_find_specialist.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/images/addiction/addiction_find_specialist.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0258

- Current Path: `assets/images/addiction/addiction_library.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/images/addiction/addiction_library.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0259

- Current Path: `assets/images/avatar_client_fmale.png`
- Suggested Registry: **CLIENT_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CLIENT_ROOM/images/avatar_client_fmale.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0260

- Current Path: `assets/images/avatar_client_male.png`
- Suggested Registry: **CLIENT_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CLIENT_ROOM/images/avatar_client_male.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0261

- Current Path: `assets/images/avatar_clinician_fmale.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/identity/avatar_clinician_fmale.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0262

- Current Path: `assets/images/avatar_clinician_male.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/identity/avatar_clinician_male.png`
- Reason: LEGACY_DUPLICATE member DUP-053; canonical asset ASSET-0262. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0263

- Current Path: `assets/images/backgrounds/specialists_bg_desktop.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/backgrounds/specialists_bg_desktop.png`
- Reason: LEGACY_DUPLICATE member DUP-054; canonical asset ASSET-0263. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0264

- Current Path: `assets/images/backgrounds/specialists_bg_mobile.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/backgrounds/specialists_bg_mobile.png`
- Reason: LEGACY_DUPLICATE member DUP-055; canonical asset ASSET-0264. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0265

- Current Path: `assets/images/backgrounds/specialists_bg_tablet.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/backgrounds/specialists_bg_tablet.png`
- Reason: LEGACY_DUPLICATE member DUP-056; canonical asset ASSET-0265. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0266

- Current Path: `assets/images/center_dashboard/actions/center_active_requests.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/images/center_dashboard/actions/center_active_requests.png`
- Reason: LEGACY_DUPLICATE member DUP-057; canonical asset ASSET-0280. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/room_components/clinician_open_cases.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0267

- Current Path: `assets/images/center_dashboard/actions/center_completed_requests.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/images/center_dashboard/actions/center_completed_requests.png`
- Reason: LEGACY_DUPLICATE member DUP-058; canonical asset ASSET-0267. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/room_components/center_completed_requests.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0268

- Current Path: `assets/images/center_dashboard/actions/center_new_requests.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/images/center_dashboard/actions/center_new_requests.png`
- Reason: LEGACY_DUPLICATE member DUP-059; canonical asset ASSET-0268. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/room_components/center_new_requests.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0269

- Current Path: `assets/images/center_dashboard/actions/center_rejected_requests.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/images/center_dashboard/actions/center_rejected_requests.png`
- Reason: LEGACY_DUPLICATE member DUP-060; canonical asset ASSET-0269. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CENTER_ROOM/room_components/center_rejected_requests.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0270

- Current Path: `assets/images/center_dashboard/actions/center_transferred_chats.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/images/center_dashboard/actions/center_transferred_chats.png`
- Reason: KEEP_SEPARATE member DUP-062; canonical asset ASSET-0281. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/room_components/clinician_support_request.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0271

- Current Path: `assets/images/center_dashboard/actions/center_update_profile.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/room_components/center_update_profile.png`
- Reason: KEEP_SEPARATE member DUP-063; canonical asset ASSET-0271. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0272

- Current Path: `assets/images/centers/center_detox.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/categories/center_detox.png`
- Reason: LEGACY_DUPLICATE member DUP-064; canonical asset ASSET-0272. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0273

- Current Path: `assets/images/centers/center_hospital.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/categories/center_hospital.png`
- Reason: LEGACY_DUPLICATE member DUP-065; canonical asset ASSET-0273. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0274

- Current Path: `assets/images/centers/center_rehabilitation.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/categories/center_rehabilitation.png`
- Reason: LEGACY_DUPLICATE member DUP-066; canonical asset ASSET-0274. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0275

- Current Path: `assets/images/centers/center_special_needs.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/categories/center_special_needs.png`
- Reason: LEGACY_DUPLICATE member DUP-067; canonical asset ASSET-0275. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0276

- Current Path: `assets/images/client_dashboard/actions/client_bookings.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/images/client_dashboard/actions/client_bookings.png`
- Reason: LEGACY_DUPLICATE member DUP-068; canonical asset ASSET-0276. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CLIENT_ROOM/tools/client_bookings.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0277

- Current Path: `assets/images/client_dashboard/actions/client_follow_up.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/images/client_dashboard/actions/client_follow_up.png`
- Reason: LEGACY_DUPLICATE member DUP-069; canonical asset ASSET-0277. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/CLIENT_ROOM/tools/client_follow_up.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0278

- Current Path: `assets/images/client_dashboard/actions/client_support.png`
- Suggested Registry: **CLIENT_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CLIENT_ROOM/tools/client_support.png`
- Reason: LEGACY_DUPLICATE member DUP-070; canonical asset ASSET-0278. May sleep only with owner, intended consumer, and review date.
- Status: **DORMANT**

## ASSET-0279

- Current Path: `assets/images/clinicians_dashboard/actions/clinician_edit_profile.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/room_components/clinician_edit_profile.png`
- Reason: KEEP_SEPARATE member DUP-063; canonical asset ASSET-0271. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0280

- Current Path: `assets/images/clinicians_dashboard/actions/clinician_open_cases.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/extinct_runtime/images/clinicians_dashboard/actions/clinician_open_cases.png`
- Reason: LEGACY_DUPLICATE member DUP-057; canonical asset ASSET-0280. Historical source remains isolated; canonical content target is ASSIST_LIBRARY/PROVIDER_ROOM/room_components/clinician_open_cases.png. Runtime reuse is not authorized.
- Status: **LEGACY**

## ASSET-0281

- Current Path: `assets/images/clinicians_dashboard/actions/clinician_support_request.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/room_components/clinician_support_request.png`
- Reason: KEEP_SEPARATE member DUP-062; canonical asset ASSET-0281. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0282

- Current Path: `assets/images/family_support/family_contact_support.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/images/family_support/family_contact_support.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0283

- Current Path: `assets/images/family_support/family_explore_centers.png`
- Suggested Registry: **CENTER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/CENTER_ROOM/images/family_support/family_explore_centers.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0284

- Current Path: `assets/images/family_support/family_find_specialist.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/images/family_support/family_find_specialist.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0285

- Current Path: `assets/images/family_support/family_library.png`
- Suggested Registry: **CITY_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/CITY_SYSTEM/images/family_support/family_library.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0286

- Current Path: `assets/images/specialists/specialist_addiction.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/categories/specialist_addiction.png`
- Reason: LEGACY_DUPLICATE member DUP-071; canonical asset ASSET-0286. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0287

- Current Path: `assets/images/specialists/specialist_coaching.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/categories/specialist_coaching.png`
- Reason: LEGACY_DUPLICATE member DUP-072; canonical asset ASSET-0287. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0288

- Current Path: `assets/images/specialists/specialist_family.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/categories/specialist_family.png`
- Reason: LEGACY_DUPLICATE member DUP-073; canonical asset ASSET-0288. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0289

- Current Path: `assets/images/specialists/specialist_psychology.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/categories/specialist_psychology.png`
- Reason: LEGACY_DUPLICATE member DUP-074; canonical asset ASSET-0289. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0290

- Current Path: `assets/images/specialists/specialist_speech.png`
- Suggested Registry: **PROVIDER_ROOM**
- Suggested Destination: `ASSIST_LIBRARY/PROVIDER_ROOM/categories/specialist_speech.png`
- Reason: LEGACY_DUPLICATE member DUP-075; canonical asset ASSET-0290. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0291

- Current Path: `flutter_01.png`
- Suggested Registry: **LEGACY_IMPORTS**
- Suggested Destination: `ASSIST_LIBRARY/LEGACY_IMPORTS/unclassified_quarantine/flutter_01.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Quarantined until ownership is proven.
- Status: **ORPHAN**

## ASSET-0292

- Current Path: `web/favicon.png`
- Suggested Registry: **WEB_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/WEB_SYSTEM/platform/web/favicon.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0293

- Current Path: `web/icons/Icon-192.png`
- Suggested Registry: **WEB_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/WEB_SYSTEM/platform/web/icons/Icon-192.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0294

- Current Path: `web/icons/Icon-512.png`
- Suggested Registry: **WEB_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/WEB_SYSTEM/platform/web/icons/Icon-512.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0295

- Current Path: `web/icons/Icon-maskable-192.png`
- Suggested Registry: **WEB_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/WEB_SYSTEM/platform/web/icons/Icon-maskable-192.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0296

- Current Path: `web/icons/Icon-maskable-512.png`
- Suggested Registry: **WEB_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/WEB_SYSTEM/platform/web/icons/Icon-maskable-512.png`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**

## ASSET-0297

- Current Path: `windows/runner/resources/app_icon.ico`
- Suggested Registry: **WEB_SYSTEM**
- Suggested Destination: `ASSIST_LIBRARY/WEB_SYSTEM/platform/windows/runner/resources/app_icon.ico`
- Reason: Unique discovered content hash; destination follows semantic owner and current path context. Active consumer was proven in Phase 1.
- Status: **ACTIVE**
