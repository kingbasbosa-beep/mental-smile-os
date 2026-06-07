# Residential Monitoring Foundation

Wave M-1 creates the first residential monitoring node foundation for Mental
Smile Federation.

This is not a dashboard, report renderer, Firebase repository, analytics
screen, gateway, or UI surface.

## Sources

Accepted residential sources are clean Signal Federation sources only:

- Client Room signals
- Saved destinations
- Support starts
- Library activity
- Tool slot events when tool signals are introduced

## Aggregates

Residential monitoring aggregates count collective activity only:

- `GoalAggregate` for `goal_selected`
- `InterestAggregate` for `interest_selected`
- `AccessibilityAggregate` for `accessibility_interest`
- `LibraryAggregate` for `library_category_opened`
- `SupportAggregate` for `support_started`
- `SavedDestinationAggregate` for `destination_saved`
- `ToolAggregate` for `tool_added`, `tool_removed`, and `tool_opened`

Aggregates do not contain names, messages, journeys, diagnoses, payments,
assignments, sessions, or individual identity.

## Snapshots

`ResidentialMonitoringSnapshot` groups aggregate summaries:

- goals summary
- interests summary
- accessibility summary
- library summary
- support summary
- saved destinations summary
- tools summary

Snapshots are in-memory/read models only in this wave.

## Analyzers

The foundation defines contracts only:

- `ResidentialSignalAnalyzer`
- `ResidentialTrendAnalyzer`
- `ResidentialGapAnalyzer`
- `ResidentialRecommendationAnalyzer`

No analyzer implementation, AI integration, recommendation runtime, or decision
engine is introduced.

## Reports

`ResidentialMonitoringReport` is a model contract containing:

- aggregates
- trends
- opportunities
- recommendations

No PDF, UI, chart, dashboard, or report rendering is introduced.

## Routing

`ResidentialMonitoringRouter` receives a `SignalPackage` and returns the
residential aggregate lane that should receive it.

Routing is classification only. It does not write Firebase, persist snapshots,
or emit new signals.

## Boundaries

Residential Monitoring must not accept signals from:

- `booking_requests`
- `bookingRequests`
- `sessionRatings`
- payment proof
- payout states
- assignment states
- session states
- admin lifecycle decisions

The boundary delegates to `ForbiddenSignalSourceGuard`.

## Runtime Status

- Firebase writes: disabled
- Collections: none created
- UI: none created
- Reports rendering: none created
- Gateway: none created
- Monitoring storage: not introduced

## Ready For M-2

The residential node now has:

```text
Sources
-> Routing
-> Aggregates
-> Snapshots
-> Report contracts
```

The next wave can build another monitoring foundation or add storage only after
the commercial node is equally separated from legacy authority.
