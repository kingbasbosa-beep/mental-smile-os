# Engineering Problems And Solutions Guide V1

Result: ENGINEERING_GUIDE_COMPLETE

Scope: Mental Smile OS only. This is not generic software advice. Every problem below is extracted from actual project history, execution reports, governance records, audits, and release-candidate evidence.

## Purpose

This guide turns Mental Smile OS project pain into reusable engineering knowledge.

The project did not fail because of one bug. It accumulated historical identities, mixed authority models, placeholder-heavy surfaces, documentation drift, runtime contamination, and public-experience gaps. Generation 1 became viable only after those issues were named, classified, and separated.

## Top Project-Specific Problems

### ENG-PROB-001

Problem ID: ENG-PROB-001

Title: Legacy Admin Authority Survived Longer Than Product Identity

Era: Admin Era / Firebase Purification Era

Symptoms:
- References to `admin`, `admins`, admin collections, admin claims, or administrative authority appeared in rules, docs, and historical surfaces.
- Storage rules required Admin Zero cleanup.
- Firestore and Storage authority needed separate reality audits.

Root Cause:
- Earlier project phases used admin-style authority as a practical shortcut.
- Later governance moved to Owner authority, but old terms and fallbacks remained.

Impact:
- Production authority model was mixed.
- Public trust risk increased.
- Firebase activation could not be treated as clean until Admin Zero was audited.

Resolution:
- Replace legacy admin authority with owner-compatible authority.
- Remove admin collection fallback where found in active rules.
- Audit Firestore and Storage separately.

Replacement:
- Owner custom-claim authority.
- Explicit monitoring separation.
- No god-mode admin authority.

Lessons Learned:
- Authority words are not harmless labels.
- If a project changes governance, rules and code must be audited by reality, not intention.

Educational Signals:
- `admin` appears in rules or runtime code.
- Firestore document fallback grants elevated access.
- Role names are mixed between owner/admin/operator.

Prevention Strategy:
- Keep a forbidden authority registry.
- Add Admin Zero checks to release gates.
- Require owner authority audit before deploy.

Status: RESOLVED_WITH_WATCHLIST

### ENG-PROB-002

Problem ID: ENG-PROB-002

Title: Booking, Payment, and Session Residue Polluted the New OS Shape

Era: Booking Era / Federation Era

Symptoms:
- Booking, payment, and session language appeared in historical docs, Firebase planning, and forbidden component registries.
- The system repeatedly had to state "not a booking/payment/session platform."

Root Cause:
- Older product assumptions treated the app as an operational marketplace.
- Generation 1 repositioned the product as discovery/support, but old business-flow vocabulary remained.

Impact:
- Confused public positioning.
- Increased Firebase and route risk.
- Created compliance and expectation risk.

Resolution:
- Explicitly forbid booking/payment/session authority in Generation 1.
- Classify old booking/payment/session items as historical evidence or removal candidates.

Replacement:
- Discovery paths.
- Support signals.
- Provider/center public visibility without transactional authority.

Lessons Learned:
- Business model residue can be as dangerous as code residue.

Educational Signals:
- Routes or collections named booking, payment, proof_of_payment, session.
- Public copy suggests appointment, payment, treatment, or session management.

Prevention Strategy:
- Keep public "what it is not" copy close to user actions.
- Check route, collection, localization, and asset names before release.

Status: REMOVED_FROM_ACTIVE_DOCTRINE

### ENG-PROB-003

Problem ID: ENG-PROB-003

Title: Technical Identity Drift

Era: Identity Purification Era

Symptoms:
- `flutterprojects` remained as Dart package identity.
- `Mental Key` remained as visible/legacy label.
- Android namespace used `com.mentalkey.app.flutterprojects`.
- Runtime host folder remained `mental-smile-app-clean2`.

Root Cause:
- Flutter template identity and earlier app identities were allowed to remain while architecture evolved.

Impact:
- Public identity looked unfinished.
- Runtime was harder to reason about.
- Release readiness required identity cleanup waves.

Resolution:
- Rename Dart package to `mental_smile_os`.
- Replace package imports.
- Rename Android namespace to `com.mentalsmile.os`.
- Preserve applicationId temporarily for continuity.

Replacement:
- Public identity: Mental Smile / Mental Smile OS.
- Technical package identity: `mental_smile_os`.
- Deferred Android applicationId decision.

Lessons Learned:
- Identity cleanup must be staged because package name, namespace, applicationId, Firebase project, and public branding are separate systems.

Educational Signals:
- Product name and package name disagree.
- Old app names appear in user-facing labels.
- ApplicationId is treated as branding instead of continuity infrastructure.

Prevention Strategy:
- Maintain an identity matrix.
- Never rename all identity layers in one wave.

Status: PARTIALLY_RESOLVED

### ENG-PROB-004

Problem ID: ENG-PROB-004

Title: Source Repository Became Active Dependency

Era: Clean Core Era / Extraction Era

Symptoms:
- `mental_smile_clean_core` existed as an active dependency.
- Core usage needed an audit before removal.
- Test proof files referenced old core symbols.

Root Cause:
- The source repository was useful, so it stayed connected longer than it should.

Impact:
- Mental Smile OS could not be considered fully independent.
- Source evidence and runtime dependency were blurred.

Resolution:
- Audit all imports and references.
- Remove `mental_smile_clean_core` as an active dependency.
- Preserve the folder as source evidence only.

Replacement:
- OS-owned runtime modules.
- Local test fixtures where needed.

Lessons Learned:
- A source mine is not a runtime dependency.

Educational Signals:
- Path dependency to legacy/source package.
- Tests importing old source symbols.
- "Core" package used as convenience layer.

Prevention Strategy:
- Require source candidate cards before importing anything from source repositories.
- Remove dependencies only after symbol-level audit.

Status: RESOLVED_AS_ACTIVE_DEPENDENCY

### ENG-PROB-005

Problem ID: ENG-PROB-005

Title: Documentation Outpaced Runtime Reality

Era: Constitution Era / Execution Era

Symptoms:
- Constitutional packages declared complete systems.
- Runtime audits later found partial, scaffold, or placeholder surfaces.
- Tool Center doctrine existed before a working Tool Center.

Root Cause:
- Architecture definition moved faster than executable implementation.

Impact:
- Release readiness looked stronger on paper than in runtime.
- Product experience needed a separate human journey audit.

Resolution:
- Introduce reality audits: route readiness, launch gap, human journey, tool center readiness.
- Separate "constitutional complete" from "runtime complete."

Replacement:
- Execution-only gates.
- Reality > Documentation rule.

Lessons Learned:
- Documentation can be accurate and still not mean the product is ready.

Educational Signals:
- Docs say READY while runtime says placeholder.
- High-level model exists with no route, no UI, or no validation.

Prevention Strategy:
- Every release gate must include executable evidence.
- Keep separate matrices for doctrine, runtime, and human experience.

Status: CONTROLLED_BY_AUDITS

### ENG-PROB-006

Problem ID: ENG-PROB-006

Title: Placeholder Surfaces Looked Like Product Features

Era: Runtime Candidate Era

Symptoms:
- Owner, monitoring, city tools, and personal space surfaces contained placeholder language.
- Tool Center readiness audit scored 22/100.
- Client dashboard tool cards used "coming soon" behavior.

Root Cause:
- Scaffold screens were registered before their user value was implemented.

Impact:
- Users could reach areas that did not produce useful outcomes.
- Public launch risk increased.

Resolution:
- Classify routes as active, partial, scaffold, legacy, or dead.
- Mark Tool Center as not release-ready.

Replacement:
- Honest feature states.
- Narrow execution waves before public exposure.

Lessons Learned:
- A route is not a feature.
- A card is not a tool.

Educational Signals:
- `_showSoon`, placeholder copy, "not connected yet."
- Public routes pointing to future surfaces.

Prevention Strategy:
- Hide inactive surfaces from public navigation.
- Add placeholder budget and expiry.

Status: OPEN_RELEASE_WARNING

### ENG-PROB-007

Problem ID: ENG-PROB-007

Title: Signal Federation Was Defined Before Full Signal Runtime

Era: Signal Federation Era

Symptoms:
- Signal doctrine, gateways, capsules, and pipes were well documented.
- Runtime had signal packages and support signals, but full zone gateway execution was partial.

Root Cause:
- Federation model was designed constitutionally before full operational implementation.

Impact:
- Signal language risked sounding complete while execution remained partial.
- Monitoring and archive routing required more runtime validation.

Resolution:
- Treat signal federation as doctrine plus partial runtime until validated.
- Create signal readiness and runtime validation packs.

Replacement:
- Stepwise signal runtime validation.
- No direct cross-zone mutation.

Lessons Learned:
- Signal governance and signal execution are different layers.

Educational Signals:
- Signal registries exist but gateway code is partial.
- Reports mention signal routing without executable validation.

Prevention Strategy:
- Require signal emit, route, retention, and archive tests per signal family.

Status: PARTIAL_RUNTIME

### ENG-PROB-008

Problem ID: ENG-PROB-008

Title: Handoff Drift Created Unclear Post-Checkpoint Reality

Era: Post-Handoff / Forensic Audit

Symptoms:
- User requested forensic audit after chat handoff.
- Need arose to inspect what changed after `PROMPT_ASSET_063`.
- Firebase, YAML, runtime, authority, route, and legacy reintroduction risks had to be checked.

Root Cause:
- Long-running generation work crossed multiple chats and execution phases.
- Memory and documentation were not enough to prove repository state.

Impact:
- Activation could not proceed safely without reality reconstruction.

Resolution:
- Create forensic audit package.
- Inspect actual files and changes.
- Distinguish expected, acceptable, suspicious, unplanned, and violation-class changes.

Replacement:
- Release gates based on actual git and file state.

Lessons Learned:
- Handoffs are not trustworthy without a forensic baseline.

Educational Signals:
- "I think it was done" replaces file evidence.
- Multiple execution packs exist without current diff review.

Prevention Strategy:
- Create a checkpoint before every wave.
- Require file-level change logs after every wave.

Status: CONTROLLED_BY_FORENSIC_AUDIT

### ENG-PROB-009

Problem ID: ENG-PROB-009

Title: Public Story Was Cleaner Than Product Experience

Era: Public Showcase / Human Journey Era

Symptoms:
- README and public landing became strong and safe.
- Human journey audit found runtime experience partial.
- First-time user still lacked a simple "start here" path.

Root Cause:
- Public explanation was improved faster than actual journey design.

Impact:
- Visitors could understand the mission but not know what to do next.
- Launch risk moved from trust to usability.

Resolution:
- Create human journey audit.
- Identify top 20 experience gaps.

Replacement:
- Journey selector.
- Support expectation clarity.
- Tool honesty.

Lessons Learned:
- Clear messaging is not the same as a clear journey.

Educational Signals:
- Strong README but weak first minute in app.
- User-facing CTAs lead to partial features.

Prevention Strategy:
- Test seven human scenarios before launch.
- Score first-minute experience separately.

Status: OPEN_PRODUCT_GAP

### ENG-PROB-010

Problem ID: ENG-PROB-010

Title: Archive Grew Into Navigation Noise

Era: Archive Finalization Era

Symptoms:
- `mental-smile-os-workspace` had 979 files and 99 directories.
- Most were Markdown historical/governance artifacts.
- Archive finalization found 27 archive card candidates and 16 lesson candidates.

Root Cause:
- The project preserved evidence correctly, but did not yet package completed eras into archive cards.

Impact:
- Active reference material became harder to navigate.
- Deletion could not be safely authorized because lessons and archive cards were missing.

Resolution:
- Archive finalization audit classified package groups.
- Immediate deletion count remained zero.

Replacement:
- Archive cards.
- Lesson extraction.
- Freeze precheck.

Lessons Learned:
- Preservation without packaging becomes clutter.

Educational Signals:
- Hundreds of reports with no current index.
- Multiple wave reports superseded but not archived.

Prevention Strategy:
- Every completed wave must produce an archive card and lesson summary.

Status: READY_FOR_ARCHIVE_FREEZE_PRECHECK

### ENG-PROB-011

Problem ID: ENG-PROB-011

Title: Release Readiness Required Owner Decisions Beyond Technical Passes

Era: Release Candidate Era

Symptoms:
- Analyze/build could pass but release gate still returned `READY_WITH_OWNER_DECISIONS`.
- `.firebase`, untracked runtime roots, forensic docs, staging scope, first commit message, and tag name required Owner decisions.

Root Cause:
- Release is not only a build event; it is a governance and packaging event.

Impact:
- Commit/tag/push could not proceed automatically.

Resolution:
- First release governance gate separated technical readiness from Owner staging decisions.

Replacement:
- Owner release gate.
- Explicit commit/tag strategy.

Lessons Learned:
- Passing validation does not authorize release.

Educational Signals:
- Untracked artifacts exist.
- Staging scope unclear.
- Tag name not approved.

Prevention Strategy:
- Keep release decision matrix separate from validation scorecard.

Status: READY_WITH_OWNER_DECISIONS

### ENG-PROB-012

Problem ID: ENG-PROB-012

Title: Human Support Path Was Present But Operational Expectation Was Unclear

Era: Human Journey / Support Signal Era

Symptoms:
- Support signal routes and support rooms existed.
- Human journey audit found unclear "what happens next" after support signal submission.

Root Cause:
- Structured support signals were implemented as system events before the user-facing expectation layer was complete.

Impact:
- Vulnerable users might misunderstand response timing or support scope.

Resolution:
- Identify support expectation as a launch blocker.

Replacement:
- Post-submit explanation.
- Global emergency boundary copy.
- Clear non-clinical support scope.

Lessons Learned:
- Support features need expectation design, not only data submission.

Educational Signals:
- User submits a signal and only receives a generic success message.
- No response time, escalation path, or emergency boundary near action.

Prevention Strategy:
- Add safety copy and next-step copy to every support action.

Status: OPEN_LAUNCH_BLOCKER

## Top Architectural Mistakes

1. Mixing old operational marketplace assumptions with the new discovery/support OS.
2. Allowing admin authority language to survive after owner authority became doctrine.
3. Treating registered routes and cards as if they were working product features.
4. Letting source repository dependencies remain active.
5. Building federation doctrine before proving each runtime path.

## Top Governance Mistakes

1. Too many artifacts stayed active after their era ended.
2. Handoff state relied on memory until forensic audit forced reality checks.
3. Release decisions initially blurred technical validation and Owner approval.
4. Archive preservation happened before archive packaging.
5. Public promises and runtime readiness were not scored separately early enough.

## Top Successful Decisions

1. Admin Zero doctrine.
2. Owner authority replacing legacy admin authority.
3. Separation of provider registration from provider public presentation.
4. Separation of center registration from center public presentation.
5. Preserving source repositories as evidence instead of deleting them.
6. Staged identity cleanup.
7. Keeping applicationId unchanged while namespace changed.
8. Human journey audit before public launch.
9. Tool Center reality audit before creating more tools.
10. Archive finalization audit before deletion.

## Top Reusable Lessons

1. Reality beats documentation.
2. A route is not a feature.
3. A card is governance, not runtime.
4. A source repository is not a dependency.
5. Authority words are production behavior.
6. Public copy must not outrun product capability.
7. Technical identity is layered: package, namespace, app id, Firebase project, branding.
8. Handoff requires forensic proof.
9. No deletion before archive card and lesson extraction.
10. Release requires Owner decision even after build success.
