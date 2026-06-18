# Mental Smile Governance Drift Story V1

## Executive Narrative

This report records the historical story behind the governance drift identified in `docs/audits/MENTAL_SMILE_RUNTIME_VS_ARCHIVE_TRUTH_AUDIT_V1.md`.

The evidence shows that Mental Smile did not fail because one actor made one incorrect decision. The drift came from a repeated separation between five states that must remain distinct:

- Decision made
- Decision documented
- Decision implemented
- Decision verified
- Decision governed

The original doctrine moved the platform toward governed, role-specific, signal-aware surfaces. Later federation, signal, owner, monitoring, archive, and safety doctrines became stronger and more explicit. However, parts of the runtime did not move at the same speed as the documentation.

As a result, the system could look healthy in reports, route checks, build checks, and asset audits while still preserving older runtime behavior. The clearest evidence is the Client Registration case: documentation classified the old registration experience for removal and recreation, but the active `/register/client` route continued to render the old heavy registration screen.

This is a governance memory report. It does not assign blame to Codex, the Owner, or old implementation. It preserves the lesson that a governed platform must track not only what was decided, but whether that decision reached runtime, was verified in runtime, and was governed as doctrine.

## The Blind Truth Problem

The blind truth problem was not that Mental Smile lacked documentation. The opposite was true: the documentation became increasingly detailed, constitutional, and specific.

The problem was that documentation truth and runtime truth were allowed to diverge.

Several reports correctly described architectural direction, source classification, archive status, or route health inside their own scope. But those scopes did not always prove that the live user-facing runtime matched doctrine. A page could be documented as removed, deprecated, simplified, or awaiting recreation while still being reachable through an active route.

The blind spot was therefore procedural:

- A doctrine decision could be documented.
- A card could classify a surface.
- A report could pass its scoped checks.
- The active runtime could still contain the old behavior.

This created a gap where the platform had strong governance language, but not always equally strong runtime confirmation.

## Documentation vs Runtime

The runtime audit found that Mental Smile had multiple forms of documentary truth:

- Archive cards
- Source classification reports
- Recreation prompt cards
- Route inventories
- Snapshot reports
- Operational registry entries
- Feature foundation reports

These records were valuable. They created institutional memory and clarified intended direction.

However, the audit also showed that documentation did not always equal execution. The strongest example is Client Registration.

The documentation trail stated that old client registration should be removed and rebuilt into a lighter account-creation surface. The recreation prompt described a simplified registration flow without name, avatar, interests, accessibility preferences, communication preferences, privacy preference capture, or pre-account profile enrichment.

Runtime evidence showed a different state. The active `/register/client` route still mapped to `ClientRegisterPage`, and that page still collected profile-like data, avatar selection, goals, interests, accessibility interests, communication preferences, privacy and recommendation switches, then wrote these values into Firebase Auth and Firestore.

That means the documentation decision existed, but implementation was not completed.

## Why The System Looked Healthy

The system looked healthy because many checks were truthful within limited boundaries.

A route health check can confirm that a route renders successfully. It does not prove that the rendered screen matches current doctrine.

An asset audit can confirm that archived assets are not directly referenced, or that intentional survivors are bounded. It does not prove that all older UX concepts have been removed.

A build or analyzer pass can confirm technical consistency. It does not prove that the platform has completed a doctrine transition.

A report can accurately document a migration plan, source classification, or intended future surface. It does not prove the old surface has been removed from runtime.

Therefore, earlier success language was not necessarily false. It was often scoped success. The drift appeared when scoped success was read as total governance success.

## Why The Runtime Was Not Fully Aligned

The runtime was not fully aligned because several transitions were documented before they were fully executed.

The audit identified these main causes:

- Documentation-first governance created strong records before runtime changes were completed.
- Some old routes and widgets remained active after being classified for removal or replacement.
- Some reports focused on architecture, assets, route existence, or inventory rather than doctrine-level runtime behavior.
- Transitional naming, especially provider versus clinician, continued to appear in routes, localization keys, repositories, portal copy, and signal names.
- Some scaffold work moved beyond planning into implementation before full owner review and governance approval.
- Build and analyzer checks were not designed to detect doctrine mismatch.

This means the runtime was not broken in a narrow technical sense. It was misaligned in a governance sense.

## The Client Registration Evidence

Client Registration is the strongest evidence of governance drift.

The documented decision path said:

- Old client registration was classified for removal.
- A new registration experience should be recreated.
- The new account creation flow should be simple.
- The simplified flow should avoid pre-account profile and preference collection.

The runtime evidence showed:

- `/#/register/client` remained active.
- The route still mapped to `Routes.clientRegister`.
- The route still rendered `ClientRegisterPage`.
- The active screen still collected name, email, password, confirm password, avatars, goals, interests, accessibility interests, communication preferences, privacy preferences, and recommendation preferences.
- The page still wrote to Firebase Auth and Firestore under `clients/{uid}`.
- The stored client document still included values such as `avatarAsset`, `clientSignals`, `privacyPreferences`, `signalSchemaVersion`, and timestamps.
- The page still emitted signals from `signalSource: client_registration`.
- Downstream surfaces such as the client dashboard and personal space still read registration-origin fields including avatar and client signals.

This revealed that the documented decision had not crossed into completed runtime execution.

The Client Registration case also revealed a deeper governance issue: downstream surfaces can preserve old runtime assumptions even after the source surface has been classified for removal. Removing or replacing one screen is not enough if other screens still depend on its old data shape.

## The Role of Cards and Archives

Cards and archives served an important role. They documented decisions, classified sources, preserved history, and clarified what should be retained, removed, or recreated.

However, the audit shows that cards and archives must not be treated as runtime removal by themselves.

An archive card can say that a surface is removed from doctrine. A source classification can mark a screen as obsolete. A recreation prompt can define the intended replacement. But none of those actions automatically removes an active route, replaces an active widget, changes stored data contracts, or verifies downstream dependencies.

The historical lesson is that cards are governance instruments, not runtime mutations.

They are necessary evidence of decision. They are not sufficient evidence of execution.

## The Difference Between Decision and Execution

Mental Smile must preserve a strict distinction between decision and execution.

Decision means the Owner or governance doctrine has chosen a direction.

Documentation means that direction has been recorded in a card, report, registry, or plan.

Execution means code, routes, models, assets, localization, signals, storage, and downstream consumers have actually changed.

Verification means the changed runtime was tested against the intended doctrine, not only checked for build success.

Governance means the verified outcome has been registered, classified, and accepted under the platform's constitutional process.

The drift occurred when documented decisions were sometimes treated as if they had already become executed and governed runtime facts.

## The Difference Between Archive and Removal

Archive and removal are not the same.

Archive means old material is preserved as historical evidence, lineage, or inactive reference. It may remain on disk if it is clearly bounded and not active in runtime.

Removal means the old behavior is no longer reachable, no longer used by active routes, no longer driving storage contracts, no longer referenced by active screens, and no longer producing signals.

The audit found examples where archive boundaries were mostly respected, such as intentionally retained C6 category card imagery and retained client chat avatar lineage. It also found cases where runtime still carried old behavior, such as active registration avatar selection and registration-origin signal capture.

The lesson is that archive survival can be healthy when intentional and bounded. Runtime survival is different and must be explicitly governed.

## The Difference Between Passing Build and Passing Doctrine

A passing build proves the project can compile or run within technical constraints.

Passing doctrine requires more.

Technical success means the code is syntactically and structurally valid.

Runtime success means the intended route, page, data flow, and user experience are actually active in the running product.

Governance success means the implemented runtime has been reviewed, approved, classified, and registered under the correct constitutional status.

Doctrine success means the runtime behavior matches the platform's current principles, not merely its old implementation or transitional state.

The audit showed that Mental Smile can pass technical checks while still failing doctrine alignment. That is not a contradiction. It means technical checks and governance checks measure different truths.

## Lessons Learned

The first lesson is that governance must track state transitions, not only final labels.

A surface should not move from documented decision to completed foundation without evidence that runtime has changed and been verified.

The second lesson is that route-level verification must inspect what a route renders, not only whether it renders.

The third lesson is that downstream consumers matter. If a deprecated screen created data that dashboards, personal spaces, or signals still consume, then the old doctrine may remain alive indirectly.

The fourth lesson is that transitional aliases need expiration. Provider, clinician, admin, session, booking, and payment language can remain useful during migration, but each survivor must have a status: active, transitional, archived, intentional exception, or drift.

The fifth lesson is that scaffold execution must be classified honestly. The Accessibility Directory Layer V1 case showed that a requested plan can become scaffold, route, and signal integration. That kind of work may be technically useful, but governance must hold it for Owner review until formatting, analyze, scope review, and approval are complete.

## Future Governance Rule

Future cards must separate five states explicitly:

- Decision requested
- Decision approved
- Implementation executed
- Runtime verified
- Governance registered

A card must not imply feature completion unless all five states are satisfied.

Every future removal, recreation, archive, or doctrine transition should include a runtime verification checklist covering:

- Active routes
- Rendered pages
- Data models
- Firestore collections and fields
- Signal sources and signal names
- Localization keys and visible copy
- Assets and bundled runtime references
- Downstream consumers
- Registry and index status

If a card documents intent but runtime remains unchanged, the correct status is not completed. The correct status is documented, pending execution, pending verification, or held for Owner review.

## Final Historical Record

The historical record is that Mental Smile entered a mature governance phase before all runtime surfaces had fully caught up.

The federation, signal, owner, monitoring, archive, and accessibility doctrines strengthened the constitutional shape of the platform. They clarified what Mental Smile should become. But some old runtime surfaces remained active, especially Client Registration, provider/clinician naming residue, public placeholder surfaces, pricing/session language, and accessibility scaffold work awaiting Owner review.

The Client Registration case proved the central lesson: a decision can be correct, a document can be clear, and a report can be useful, while runtime reality still preserves the old system.

Mental Smile's future governance must therefore protect the full chain:

- Decision made
- Decision documented
- Decision implemented
- Decision verified
- Decision governed

Only when all five are true should the platform describe a doctrine transition as complete.
