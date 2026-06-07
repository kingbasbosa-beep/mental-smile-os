# Tool Meter Foundation

## Scope

Wave M-12 adds the federation usage, value, and impact foundation.

This foundation does not create billing, payments, marketplace pricing,
dashboards, UI, Firebase writes, Firestore collections, or analytics runtime.

## Philosophy

Tool Meter measures:

- Usage
- Value
- Impact
- Trust
- Adoption

It does not measure money first and does not measure clinical outcomes.

## Metered Assets

- tool
- service
- knowledge_resource
- library_content
- external_app
- campaign
- provider_resource
- center_resource

## Usage

`UsageAggregate` contains:

- views
- opens
- engagements
- completions

## Adoption

`AdoptionAggregate` contains:

- newUsers
- returningUsers
- retentionIndicator

## Trust

`TrustAggregate` aligns with Public Reputation and contains:

- ratingScore
- commentIndicator
- reputationWeight

## Impact

`ImpactAggregate` contains:

- guidanceInteractions
- resourceInteractions
- followThroughIndicator

It contains no clinical outcomes.

## Scorecards

`ToolMeterScorecard` combines:

- usage
- adoption
- trust
- impact
- overallScore

No calculations are implemented in this wave.

## Categories

- healthy
- growing
- stable
- declining
- inactive

## Signals

Signal names only:

- tool_viewed
- tool_opened
- tool_completed
- resource_opened
- campaign_opened
- guidance_interacted
- reputation_viewed

No signal emission runtime is added.

## Commercial Mapping

`CommercialMeterMapping` links:

- Demand to Usage
- Supply to Adoption
- Gap to Impact
- Opportunity to Trust

## Monitoring Mapping

`MonitoringMeterMapping` links:

- Residential Monitoring
- Commercial Monitoring
- Operational Monitoring

to Tool Meter dimensions.

## Report And Archive Alignment

The report category registry now includes:

- tool_meter_report

The archive export package registry now includes:

- tool_meter_pack

## Boundaries

Tool Meter must not use:

- session success
- treatment success
- clinical outcome
- booking conversion
- payment conversion
- admin performance

Tool Meter is not a clinical surveillance or admin performance system.

## Federation Separation Readiness

### Localization Ready

YES

### Naming Ready

YES

### Monitoring Ready

YES

### Archive Ready

YES

### Visual Identity Ready

YES

### Accessibility Ready

YES

### Separation Ready

YES
