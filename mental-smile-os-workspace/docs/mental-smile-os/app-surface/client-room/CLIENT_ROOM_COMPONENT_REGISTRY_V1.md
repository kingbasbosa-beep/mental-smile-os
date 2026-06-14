# Client Room Component Registry V1

Status: ACTIVE_COMPONENT_REGISTRY
Screen: CLIENT_ROOM_SCREEN
Prompt Asset: PROMPT_ASSET_024
Latest Binding Prompt: PROMPT_ASSET_025
Latest Dynamic Governance Prompt: PROMPT_ASSET_026

## Registered Components

| Component ID | Purpose | Description | Allowed Actions | Forbidden Actions | Ownership | Signals | Dependencies | Related Screens | Future Expansion Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| CLIENT_ROOM_BACKGROUND | Room identity surface | Calm personal-space background. | Display room setting. | Store data, trigger actions, imply diagnosis. | Client owns room presence; Mental Smile OS owns screen package. | None. | Client Room definition. | CLIENT_ROOM_SCREEN | May receive approved visual asset later. |
| CLIENT_TOOL_BOARD | Tool Selection Surface | Board where client selects tools. Tools act as magnets. | Client selects tools; emit preference signals. | Store recommendations; perform matching; diagnose; prescribe. | Client owns choices; OS owns board package. | Tool Selection Signals. | Future Library/Tools compatibility declarations. | CLIENT_ROOM_SCREEN, LIBRARY_WEB_ZONE | Tool compatibility may expand through content declarations. |
| CLIENT_TV_PANEL | Notification and Recommendation Screen | Screen for notifications and recommendation display. | Show notifications, recommendations, announcements, sponsored content, educational highlights. | Diagnosis, clinical claims, treatment promises. | OS owns panel package; content ownership stays separate. | Notification Signals. | Client Room definition; future content package. | CLIENT_ROOM_SCREEN, LIBRARY_WEB_ZONE | Can support governed content slots later. |
| CLIENT_PICTURE_FRAME | Personal Picture Display | Personal decoration image frame. | Client may upload image after registration; display image. | Identity verification; biometric claim; forced avatar. | Client owns personal image; OS owns frame package. | Picture Update Signals. | Future upload/privacy rules. | CLIENT_ROOM_SCREEN | Needs privacy and storage review before implementation. |
| CLIENT_NOTE_WIDGET | Motivation Display | Shows preset or optional personal motivational message. | Display preset messages; optionally display personal message. | Clinical advice, diagnosis, treatment promise, emergency claim. | Client owns personal note if created; OS owns widget. | Motivation Update Signals. | Approved message library. | CLIENT_ROOM_SCREEN | Preset library may expand after language review. |
| CLIENT_EXIT_CUP | Exit Action | Exit object for leaving the room. | Exit room only. | Logout, delete account, emergency exit, admin action. | OS owns control package. | Room Exit Signals. | App topology. | CLIENT_ROOM_SCREEN, APP_HOME_SCREEN | May route to Home later after runtime authorization. |
| CLIENT_LEFT_SWITCHER | Cycle Room Cards | Left switcher for cycling tool board / room cards. | Cycle cards. | Hidden actions, matching, data mutation. | OS owns control package. | Card Cycle Signals. | Tool/card state. | CLIENT_ROOM_SCREEN | May support accessible labels later. |
| CLIENT_RIGHT_SWITCHER | Cycle Room Cards | Right switcher for cycling tool board / room cards. | Cycle cards. | Hidden actions, matching, data mutation. | OS owns control package. | Card Cycle Signals. | Tool/card state. | CLIENT_ROOM_SCREEN | May support accessible labels later. |

## Component Rule

No component may create admin functions, operational complexity, or hidden legacy dashboard behavior.

## Fixed Asset Binding

| Component ID | Fixed Asset ID | Source Evidence | Asset Binding Status |
| --- | --- | --- | --- |
| CLIENT_ROOM_BACKGROUND | ms_os_client_room_background_v1 | C:/Users/kingb/Downloads/غرفه العميل.png | BOUND |
| CLIENT_TOOL_BOARD | ms_os_client_room_tool_board_v1 | C:/Users/kingb/Downloads/غرفه العميل.png | BOUND |
| CLIENT_TV_PANEL | ms_os_client_room_notification_panel_v1 | C:/Users/kingb/Downloads/غرفه العميل.png | BOUND |
| CLIENT_PICTURE_FRAME | ms_os_client_room_picture_frame_v1 | C:/Users/kingb/Downloads/غرفه العميل.png | BOUND |
| CLIENT_NOTE_WIDGET | ms_os_client_room_motivation_note_v1 | C:/Users/kingb/Downloads/غرفه العميل.png | BOUND |
| CLIENT_EXIT_CUP | ms_os_client_room_exit_cup_v1 | C:/Users/kingb/Downloads/غرفه العميل.png | BOUND |
| CLIENT_LEFT_SWITCHER | ms_os_client_room_left_switcher_v1 | C:/Users/kingb/Downloads/غرفه العميل.png | BOUND |
| CLIENT_RIGHT_SWITCHER | ms_os_client_room_right_switcher_v1 | C:/Users/kingb/Downloads/غرفه العميل.png | BOUND |

## Fixed Asset Boundary

Asset binding remains documentation-only. It does not create Flutter, runtime, Firebase, tool logic, recommendation logic, signal runtime, or implementation behavior.

## Dynamic Tool Slot Components

| Slot ID | Parent Component | Classification | Description | Allowed Occupant | Forbidden Role | Status |
| --- | --- | --- | --- | --- | --- | --- |
| CLIENT_TOOL_SLOT_01 | CLIENT_TOOL_BOARD | CLIENT_ROOM_DYNAMIC_SLOT | First visual placement location inside Tool Board. | CLIENT_SELECTED_TOOL_CARD | Tool, content, recommendation logic, profile setting. | REGISTERED |
| CLIENT_TOOL_SLOT_02 | CLIENT_TOOL_BOARD | CLIENT_ROOM_DYNAMIC_SLOT | Second visual placement location inside Tool Board. | CLIENT_SELECTED_TOOL_CARD | Tool, content, recommendation logic, profile setting. | REGISTERED |
| CLIENT_TOOL_SLOT_03 | CLIENT_TOOL_BOARD | CLIENT_ROOM_DYNAMIC_SLOT | Third visual placement location inside Tool Board. | CLIENT_SELECTED_TOOL_CARD | Tool, content, recommendation logic, profile setting. | REGISTERED |
| CLIENT_TOOL_SLOT_04 | CLIENT_TOOL_BOARD | CLIENT_ROOM_DYNAMIC_SLOT | Fourth visual placement location inside Tool Board. | CLIENT_SELECTED_TOOL_CARD | Tool, content, recommendation logic, profile setting. | REGISTERED |
| CLIENT_TOOL_SLOT_05 | CLIENT_TOOL_BOARD | CLIENT_ROOM_DYNAMIC_SLOT | Fifth visual placement location inside Tool Board. | CLIENT_SELECTED_TOOL_CARD | Tool, content, recommendation logic, profile setting. | REGISTERED |

## Dynamic Slot Boundary

Dynamic slot registration defines selectable placement only. It does not implement tool execution, recommendation engines, Firebase storage, profile configuration, interests, avatars, or signal runtime.
