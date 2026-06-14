# Active Runtime Route Registry V1

Status: ROUTE_REGISTRY_DEFINED
Prompt Asset: PROMPT_ASSET_052

## Purpose

Define approved runtime routes conceptually.

No routes are implemented by this registry.

## Route Registry

| Route ID | Conceptual Route | Zone | Screen Or District | Owner | Status | Allowed Signals | Forbidden Signals |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ROUTE_APP_SPLASH | /app/splash | APP_ROOM_ZONE | APP_SPLASH_SCREEN | Mental Smile OS | APPROVED_CONCEPT | SPLASH_UI_SIGNALS | Auth, payment, booking |
| ROUTE_APP_LOGIN | /app/login | APP_ROOM_ZONE | APP_LOGIN_SCREEN | Mental Smile OS | APPROVED_CONCEPT | LOGIN_UI_SIGNALS | Admin, payment, booking |
| ROUTE_APP_HOME | /app/home | APP_ROOM_ZONE | APP_HOME_SCREEN | Mental Smile OS | APPROVED_CONCEPT | HOME_NAVIGATION_SIGNALS | Cross-zone direct mutation |
| ROUTE_CLIENT_REGISTRATION | /app/client-registration | APP_ROOM_ZONE | APP_CLIENT_REGISTRATION_SCREEN | Mental Smile OS | APPROVED_CONCEPT | REGISTRATION_SIGNALS | Profile/tool selection signals |
| ROUTE_CLIENT_ROOM | /app/client-room | APP_ROOM_ZONE | APP_CLIENT_ROOM_SCREEN | Mental Smile OS | APPROVED_CONCEPT | ROOM_ACTIVITY_SIGNALS, TOOL_SELECTION_SIGNALS | Recommendation execution |
| ROUTE_PROVIDER_ROOM | /app/provider-room | APP_ROOM_ZONE | APP_PROVIDER_ROOM_SCREEN | Mental Smile OS | APPROVED_CONCEPT | RESEARCH_DESK_SIGNALS, ASSISTANT_USAGE_SIGNALS | General AI execution |
| ROUTE_CENTER_ROOM | /app/center-room | APP_ROOM_ZONE | APP_CENTER_ROOM_SCREEN | Mental Smile OS | APPROVED_CONCEPT | ROOM_ACTIVITY_SIGNALS | Contract/payment execution |
| ROUTE_EXIT_SOCIAL_LINKS | /app/exit-social-links | APP_ROOM_ZONE | APP_EXIT_SOCIAL_LINKS_SCREEN | Mental Smile OS | APPROVED_CONCEPT | EXIT_ACTION_SIGNALS | Private account or admin signals |
| ROUTE_LIBRARY_ROOT | /library | LIBRARY_WEB_ZONE | LIBRARY_DISTRICTS | Library Web Zone | APPROVED_CONCEPT | LIBRARY_DISCOVERY_SIGNALS | Direct app mutation |
| ROUTE_PROVIDER_REGISTRATION_ROOT | /providers/register | PROVIDER_REGISTRATION_WEB_ZONE | PROVIDER_ONBOARDING_DISTRICT | Provider Registration Zone | APPROVED_CONCEPT | PROVIDER_ONBOARDING_SIGNALS | Public ranking signals |
| ROUTE_PROVIDER_PUBLIC_ROOT | /providers | PROVIDER_PUBLIC_WEB_ZONE | PROVIDER_PUBLIC_DISTRICTS | Provider Public Zone | APPROVED_CONCEPT | PROVIDER_DISCOVERY_SIGNALS | Private document signals |
| ROUTE_CENTER_REGISTRATION_ROOT | /centers/register | CENTER_REGISTRATION_WEB_ZONE | CENTER_ONBOARDING_DISTRICT | Center Registration Zone | APPROVED_CONCEPT | CENTER_ONBOARDING_SIGNALS | Public ranking signals |
| ROUTE_CENTER_PUBLIC_ROOT | /centers | CENTER_PUBLIC_WEB_ZONE | CENTER_PUBLIC_DISTRICTS | Center Public Zone | APPROVED_CONCEPT | CENTER_DISCOVERY_SIGNALS | Private document signals |
| ROUTE_OWNER_ROOT | /owner | OWNER_ZONE | OWNER_ZONE | Owner Zone | APPROVED_CONCEPT | OWNER_AUTHORITY_SIGNALS | Unregistered admin bypass |
| ROUTE_MONITORING_ROOT | /monitoring | MONITORING_ZONE | MONITORING_ZONE | Monitoring Zone | APPROVED_CONCEPT | MONITORING_SIGNALS | Authorization signals |
| ROUTE_STRATEGIC_ROOT | /strategic-intelligence | STRATEGIC_INTELLIGENCE_ZONE | STRATEGIC_INTELLIGENCE_ZONE | Strategic Intelligence Zone | APPROVED_CONCEPT | STRATEGIC_SUMMARY_SIGNALS | Runtime mutation signals |
| ROUTE_ARCHIVE_ROOT | /smart-archive | SMART_ARCHIVE_ZONE | SMART_ARCHIVE_ZONE | Smart Archive Zone | APPROVED_CONCEPT | ARCHIVE_SIGNALS | Source-zone mutation |

## Forbidden Routes

- Booking routes.
- Session routes.
- Payment routes.
- Legacy admin god mode routes.
- Direct cross-zone mutation routes.

