# Library District Boundary Model V1

Status: ACTIVE_DISTRICT_BOUNDARY_MODEL
Zone ID: LIBRARY_WEB_ZONE
Prompt Asset: PROMPT_ASSET_036

## District Boundaries

Districts may:

- Communicate internally.
- Reference cards from other districts.
- Send outbound packages to LIBRARY_WEB_ZONE_GATEWAY.
- Receive inbound packages from LIBRARY_WEB_ZONE_GATEWAY.

Districts may not:

- Communicate directly with external zones.
- Own users.
- Own rooms.
- Own registrations.
- Own profiles.
- Own runtime identity.
- Execute tools.
- Run recommendations.
- Mutate foreign district ownership.
- Create orphan cards.

## External Communication Rule

All external communication only through LIBRARY_WEB_ZONE_GATEWAY.

