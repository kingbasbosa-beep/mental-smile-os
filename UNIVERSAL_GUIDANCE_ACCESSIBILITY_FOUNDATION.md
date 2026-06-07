# Universal Guidance & Accessibility Foundation

Wave M-8 creates one guidance and accessibility foundation for Mental Smile
Federation.

This foundation does not create UI, widgets, screens, dashboards, exports, PDF,
Excel, video, audio generation, Firebase, Firestore, collections, or writes.

## Guidance Philosophy

```text
What is not understood should not be selected.
```

Every future choice should be explainable before it is selected.

## Guidance Card

`UniversalGuidanceCard` supports:

- guidance id
- target type
- target id
- localized title
- localized short text
- localized easy text
- visual icon key
- audio label
- screen reader label
- learn more reference
- accessibility profile
- identity profile
- guidance category

No UI is introduced.

## Target Types

`GuidanceTargetTypeRegistry` supports:

- tool
- service
- provider
- center
- external app
- library content
- specialization
- department
- report
- work card
- campaign
- complaint path
- support path

## Guidance Categories

`GuidanceCategoryRegistry` supports:

- definition
- how it helps
- when to use
- limits
- safety notice
- complaint guidance
- accessibility guidance
- sponsored knowledge
- department instruction
- operational instruction

## Micro Guidance

`MicroGuidanceContract` provides short, easy, audio-label-ready, and
screen-reader-ready explanations beside future choices.

## More Info Guidance

`MoreInfoGuidanceContract` explains:

- what it is
- who may benefit
- what it does
- what it does not do
- limits
- learn more reference

Its text must remain non-clinical, non-diagnostic, and non-pressuring.

## Sponsored Knowledge Rules

`SponsoredGuidancePolicy` establishes that sponsored residential content:

- appears as knowledge, opportunity, or guidance
- does not go directly to sale or booking
- passes through guidance or info card first
- avoids commercial pressure language
- avoids treatment promises
- avoids diagnosis and sensitive targeting

## Accessibility Modes

`AccessibilityMode` supports:

- standard
- easy reading
- audio assisted
- visual assisted
- screen reader
- high visibility

## Accessibility Preference

`AccessibilityPreference` supports:

- mode
- preferred text complexity
- audio enabled
- visual icons enabled
- screen reader optimized
- large text preferred

No UI binding is introduced.

## Placement Rules

`GuidancePlacementRegistry` supports future placement in:

- registration option
- tool slot
- ad card
- library card
- provider profile
- center profile
- support page
- complaint page
- department work card
- report section

## Guidance Signals

`GuidanceSignalRegistry` defines signal names only:

- `guidance_opened`
- `guidance_learn_more_opened`
- `guidance_audio_requested`
- `guidance_easy_mode_selected`
- `guidance_dismissed`
- `accessibility_mode_selected`

No emission runtime is introduced.

## Complaint Guidance

`ComplaintGuidanceCard` supports:

- complaint type
- internal platform path
- external authority name
- external authority contact
- external authority link
- safety notice

## Department Guidance

`DepartmentGuidanceCard` supports:

- department id
- work context
- instruction
- easy instruction
- screen reader instruction
- related report code

## Universal Info Card Alignment

`InfoCardGuidanceAlignment` links:

- universal info card contract id
- localized title
- department visual identity
- accessibility visual profile
- guidance reference

No rendering is introduced.

## Forbidden Content

New guidance must reject:

- diagnosis
- treatment
- medication prescription
- treatment promises
- commercial pressure
- booking
- session request
- payment proof
- admin approval
- assignment
- commission
- Arabic equivalents for the same legacy or unsafe concepts

## Federation Separation Readiness

Localization Ready: YES

Naming Ready: YES

Monitoring Ready: YES

Archive Ready: YES

Visual Identity Ready: YES

Accessibility Ready: YES

Separation Ready: YES

## Success State

Every federation element can later become explainable:

```text
Tool
Service
Provider
Center
Content
Department
Report
Work Card
Complaint Path
```

in a format that is:

```text
Short
Easy
Visual
Audio-label-ready
Screen-reader-ready
```
