# Master Surface Guide V1

Status: GUIDE_DRAFT  
Runtime effect: none

## 1. Surface Doctrine

A surface is a governed visible or operational area. Routes and screens are runtime objects; this guide records governance ownership, language class, card families, signals, collections, and drift.

## 2. Surface Registry State

| Registry need | Runtime state |
| --- | --- |
| Surface registry | MISSING_RUNTIME_SURFACE_REGISTRY |
| Route registry | `Routes` constants exist |
| Route implementation | `AppRouter` switch exists |
| Surface docs | Product/topology docs exist |
| Surface language policy | Exists for Residential, Commercial, Administrative |

## 3. Current Surfaces

| Surface ID | Route group | Screen(s) | Owner | Language class | Status | Classification |
| --- | --- | --- | --- | --- | --- | --- |
| surface.public.portal | `/`, `/about`, `/request/*`, `/contact` | Portal skeleton pages | Public/web unknown | Commercial/Public | Routed skeleton | TRANSITIONAL |
| surface.public.city | `/s/city/*` | SCityDistrictPage, SWebSurfacePage | Public/commercial unknown | Commercial/Public | Active placeholders | TRANSITIONAL |
| surface.residential.client_dashboard | `/client/dashboard` | ClientDashboardPage | client | Residential | Active | ACTIVE |
| surface.residential.personal_space | `/s/personal-space` | SPersonalSpacePage | client | Residential | Active | ACTIVE |
| surface.residential.library | `/module/library`, `/web/library`, `/library` | LibraryPage | content owner unknown | Residential/Public | Active | ACTIVE |
| surface.commercial.specialists | `/module/specialists*` | Specialists pages | provider/commercial | Commercial | Active | ACTIVE |
| surface.commercial.centers | `/module/centers*` | Centers pages | center/commercial | Commercial | Active | ACTIVE |
| surface.registration | `/register/*`, `/web/*/register` | registration pages | declaration/commercial | Commercial/Admin | Active | ACTIVE |
| surface.provider.clinician_room | `/clinician/*` | ClinicianRoom, inbox | clinician | Residential internal / Commercial provider | Active | ACTIVE |
| surface.center.room | `/center/*` | CenterDashboard, CenterRoom | center | Residential internal / Commercial center | Active | ACTIVE |
| surface.support.chat | `/chat*` | ChatPage, escalation pages | support observer | Residential/Administrative | Active | ACTIVE |
| surface.admin.support_room | `/s/support-room` | SSupportRoomPage | support_observer/owner | Administrative | Active | ACTIVE |
| surface.admin.registry_room | `/s/registry-room` | SRegistryRoomPage | registry_steward/owner | Administrative | Active | ACTIVE |
| surface.admin.declaration_review | `/s/declaration-review-room` | SDeclarationReviewRoomPage | declaration_reviewer/owner | Administrative | Active | ACTIVE |
| surface.monitoring.capital | `/s/capital*` | SCapitalOperationsOffice, SSignalMonitoringRoom | monitoring_operator/admin | Administrative | Active UI | ACTIVE/TRANSITIONAL |
| surface.owner | `/s/owner*` | SOwnerDistrictPage | owner | Administrative/Owner | Active | ACTIVE |

## 4. Surface Relationship Map

| Domain | Guide | Registry | Card | Signal/Tool/Surface | Consumer | Report | Action |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Residential | Surface guide | Routes, missing surface registry | client/personal cards | client dashboard, personal space, library | client | Residential surface report | validate language and signals |
| Commercial | Surface guide | Routes, missing surface registry | provider/center cards | specialists, centers, registration | public/client/provider/center | Commercial surface report | validate attribution |
| Administrative | Surface guide | Routes, role sets, Firestore rules | support/registry/declaration cards | S rooms | admin roles | Admin surface report | verify authority limits |
| Owner | Surface guide | Routes, role sets | owner cards | owner district | owner | Owner guide report | authorize |
| Monitoring | Surface guide | monitoring registries | monitoring cards | signal room, analytics | monitoring operator | Monitoring report | verify drift |
| Legal & Governance | Language guide | language docs | compliance cards | policy surfaces | all domains | language report | interpret |
| Technical | Surface guide | runtime routes | implementation cards FUTURE | app routes/screens | developers | implementation report | execute later |

## 5. Surface Language Class

| Surface | Primary policy | Important constraint |
| --- | --- | --- |
| Client dashboard | Residential | No platform-owned treatment, session, case, booking, assignment, diagnosis language. |
| Personal space | Residential | Signals are preferences/declarations, not diagnosis. |
| Library | Residential/Public | Content is resource/education/support, not treatment direction. |
| Specialist/center discovery | Commercial | Provider/center declared data is allowed with attribution; no Mental Smile booking or endorsement. |
| Registration | Commercial/Admin | Readiness and declaration language only; avoid approval/acceptance authority. |
| Support/safety | Administrative/Residential | Safety escalation may report risk but must not own treatment. |
| Monitoring | Administrative | May analyze/report; cannot become operational treatment authority. |
| Owner | Administrative/Owner | Authorizes doctrine, not individual treatment. |

