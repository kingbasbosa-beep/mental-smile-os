# LANGUAGE ENGINE V1

## Status

Design foundation. No runtime implementation is defined by this document.

## Mission

The Constitutional Language Engine produces governed Mental Smile copy. It does
not translate arbitrary source text. It resolves meaning from the Language
Registry, composes equivalent Arabic and English expressions, and rejects
language that introduces forbidden doctrine or unregistered terminology.

## Governing Inputs

1. `LANGUAGE_REGISTRY_V1.md`
2. `TERM_CARD_REGISTRY.md`
3. `FORBIDDEN_TERMS_REGISTRY.md`
4. `TRANSITIONAL_TERMS_REGISTRY.md`
5. `ARABIC_LANGUAGE_CONSTITUTION.md`
6. `ENGLISH_LANGUAGE_CONSTITUTION.md`
7. `LANGUAGE_PATTERN_LIBRARY.md`
8. `AI_LANGUAGE_GENERATION_RULES.md`

If these sources conflict, the lifecycle and meaning declared by the term card
take precedence. A conflict between cards is a governance failure and blocks
generation.

## Constitutional Contract

Every generated language unit must declare:

- intent;
- output type;
- audience;
- owning registry;
- approved term IDs;
- source meaning;
- Arabic expression;
- English expression;
- lifecycle result;
- doctrine validation result;
- parity validation result.

Copy without this declaration is ungoverned.

## Generation Request

A valid generation request contains:

| Field | Required | Meaning |
|---|---|---|
| Intent | Yes | The human purpose of the copy |
| Output Type | Yes | Button, title, description, message, or other governed type |
| Audience | Yes | Client, provider, center, owner, observer, or public |
| Context | Yes | Route, card, room, flow, or policy destination |
| Desired Action | When applicable | What the person may choose to do |
| State | When applicable | Readiness, safety, visibility, or processing fact |
| Source Term IDs | Yes | Registry concepts permitted in the output |
| Safety Sensitivity | Yes | Normal, sensitive, or urgent |
| Length Constraint | When applicable | Surface-specific limit |

Requests that provide only a legacy phrase to rewrite must first be converted
into a constitutional intent. The legacy phrase cannot be the source of truth.

## Intent Layer

| Intent | Primary Registry | Permitted Supporting Registries | Boundary |
|---|---|---|---|
| Navigation | Owning destination registry | Branding, Accessibility | Names a destination; does not promise an outcome |
| Support | Client or Recovery | Accessibility, Knowledge, Policy | Offers support without ownership |
| Discovery | Marketplace | Provider, Center, Accessibility | Supports choice; does not allocate |
| Recovery | Recovery | Client, Knowledge, Accessibility | Person-led and non-diagnostic |
| Monitoring | Monitoring | Governance, Policy, Safety vocabulary when governed | Observes; does not control |
| Governance | Governance | Federation, Policy | Declares boundaries, not operational power |
| Accessibility | Accessibility | Any destination owner | Expresses preference and access, not deficit |
| Provider | Provider | Marketplace, Accessibility, Governance | Declares identity and capability |
| Center | Center | Marketplace, Accessibility, Governance | Declares place and capability |
| Marketplace | Marketplace | Provider, Center, Client | Enables discovery and contact, not booking |
| Knowledge | Knowledge | Recovery, Accessibility, Policy | Informs without diagnosing |

An intent may have one primary owner only. Supporting registries supply terms
but do not gain ownership of the copy's central meaning.

## Registry Resolver

The resolver:

1. extracts the central concept from the requested intent;
2. finds term cards whose definitions match that concept;
3. verifies the intended context against `Allowed Contexts`;
4. rejects candidates whose `Forbidden Contexts` include the destination;
5. selects exactly one primary owner registry;
6. records supporting term IDs separately;
7. blocks generation if ownership is missing, duplicated, or contradictory.

The resolver must never assign ownership based only on a route name, feature
folder, historical key name, or the wording supplied by a requester.

## Vocabulary Resolver

The vocabulary resolver applies lifecycle rules:

| Lifecycle | Generation Rule |
|---|---|
| ACTIVE | May be generated within allowed contexts |
| TRANSITIONAL | May validate existing copy; may not be selected for new copy unless an explicit migration exception exists |
| DEPRECATED | Must be replaced before generation |
| FORBIDDEN | Blocks the output |
| FUTURE | Blocks active output until the term becomes ACTIVE |

When a replacement is declared, the resolver returns the replacement term to
the Registry Resolver. Replacement is semantic, not a blind word substitution.

## Doctrine Validator

The validator rejects language that:

- grants human approval, activation, or visibility authority;
- assigns ownership of a person, journey, conversation, or support need;
- restores booking, payment, payout, accounting, or session-control doctrine;
- converts monitoring into intervention or operational control;
- treats readiness as a manual decision rather than a derived state;
- presents signals as diagnosis, identity, or certainty;
- turns recommendations into commands or allocations;
- treats accessibility as deficiency;
- claims recovery outcomes or ownership;
- uses unregistered terminology as a constitutional concept;
- hides forbidden doctrine behind a new synonym.

Validation is conceptual. Passing a word-list scan does not prove compliance.

## Language Composer

The composer creates Arabic and English from the same approved meaning object.
Neither language is translated from the other as the authoritative original.

The meaning object contains:

- intent;
- actor;
- voluntary action;
- object or destination;
- known state;
- uncertainty;
- prohibited implications;
- approved term IDs;
- tone;
- urgency;
- output constraints.

The composer must:

1. preserve agency;
2. state only known facts;
3. avoid diagnosis and stigma;
4. use the approved registry vocabulary;
5. use the pattern assigned to the output type;
6. keep urgency proportional to the actual safety state;
7. produce natural Arabic and natural English with equivalent force.

## Output Validator

An output passes only when all checks are true:

| Check | Pass Condition |
|---|---|
| Ownership | One primary registry is declared |
| Term resolution | Every doctrine-bearing term maps to an approved card |
| Lifecycle | No FORBIDDEN, DEPRECATED, or unactivated FUTURE term is generated |
| Context | Card permissions allow the destination |
| Doctrine | No forbidden authority model is implied |
| Agency | The person retains choice unless immediate safety wording requires direction |
| Evidence | No unsupported fact or outcome is asserted |
| Arabic quality | Arabic Constitution is satisfied |
| English quality | English Constitution is satisfied |
| Parity | Meaning, agency, urgency, and uncertainty match |
| Pattern | Output-type structure is respected |

Failure returns a reason code, not alternative ungoverned copy.

## Validation Reason Codes

- `REGISTRY_OWNER_MISSING`
- `REGISTRY_OWNER_CONFLICT`
- `TERM_NOT_REGISTERED`
- `TERM_CONTEXT_FORBIDDEN`
- `TERM_LIFECYCLE_BLOCKED`
- `FORBIDDEN_DOCTRINE`
- `TRANSITIONAL_EXCEPTION_REQUIRED`
- `SEMANTIC_PARITY_FAILURE`
- `AGENCY_FAILURE`
- `DIAGNOSTIC_CLAIM`
- `STIGMATIZING_LANGUAGE`
- `UNSUPPORTED_OUTCOME`
- `ACCESSIBILITY_FAILURE`
- `OUTPUT_PATTERN_FAILURE`

## Output Type Rules

### Button Text

- Begin with a clear voluntary action.
- Describe the immediate result.
- Avoid vague authority verbs such as approve, assign, activate, or control.
- Do not use a noun label when an action is required.

### Page Titles

- Name the room, destination, resource, or activity.
- Do not imply ownership of people or outcomes.
- Use registered destination terms.

### Card Titles

- Name one concept or opportunity.
- Avoid conclusions about the person.
- Keep signal cards descriptive, not diagnostic.

### Card Descriptions

- Explain relevance and available choice.
- Distinguish observed facts from recommendations.
- Avoid promises and commands.

### Notifications

- State what occurred, where, and what the person can do next.
- Do not imply assignment, approval, or hidden human judgment.
- Identify uncertainty when processing is incomplete.

### Dialogs

- Explain consequence before confirmation.
- Give clear confirm and cancel choices.
- Avoid coercive urgency except for verified safety conditions.

### Tooltips

- Name the control's immediate function.
- Do not introduce doctrine or policy that is absent from the visible surface.

### Empty States

- Describe what is currently absent.
- Offer an optional next action.
- Never blame the person or imply failure.

### Errors

- Describe the failed action, not a defect in the person.
- Separate recoverable action from technical detail.
- Do not expose internal authority or legacy lifecycle vocabulary.

### Success Messages

- Confirm the completed action precisely.
- Do not promise visibility, acceptance, recovery, or service outcomes.

### Accessibility Copy

- Lead with preference, available format, or access support.
- Avoid deficit-first identity.
- State control behavior explicitly when needed.

### Marketing Copy

- Describe capabilities and opportunities truthfully.
- No guaranteed recovery, clinical superiority, or platform-owned journey.
- Recommendations remain choices.

### Governance Copy

- Name authority, boundary, source, and consequence precisely.
- Avoid friendly euphemisms that conceal control.
- Distinguish observation, safety intervention, and governance.

## Parity Model

Parity is measured across five dimensions:

1. **Intent parity:** both languages perform the same function.
2. **Agency parity:** both preserve the same degree of choice.
3. **State parity:** readiness, visibility, safety, and uncertainty match.
4. **Tone parity:** neither language is more commanding, stigmatizing, or promotional.
5. **Consequence parity:** both describe the same result of an action.

Literal word equality is not required. Constitutional meaning equality is.

## Existing Copy Validation

Validation of existing copy follows the same pipeline:

1. infer intent and output type;
2. identify doctrine-bearing terms;
3. resolve ownership;
4. classify each term lifecycle;
5. detect implied authority;
6. compare Arabic and English meaning;
7. return `PASS`, `REVISE`, or `BLOCK`.

`PASS` means constitutionally valid. `REVISE` means the intended concept is
valid but wording is not. `BLOCK` means the underlying doctrine is forbidden or
has no registry authority.

## Engine Boundary

The engine does not:

- create localization keys;
- edit ARB files;
- generate runtime code;
- activate FUTURE terms;
- approve new doctrine;
- infer policy from existing copy;
- preserve legacy meaning for compatibility;
- decide safety or clinical outcomes.

