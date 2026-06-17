# Surface Link Model V1

Status: ACTIVE_CONNECTION_MODEL
Connection Type: SURFACE_LINK

## 1. Purpose

Surface Link is a deliberate navigation connection between semi-independent Mental Smile OS surfaces.

It allows movement without merging route logic or creating one giant navigation system.

## 2. Required Fields

- Surface Link ID.
- Source Surface.
- Target Surface.
- Link Purpose.
- Allowed Entry Context.
- Forbidden Entry Context.
- Required Label.
- Access Boundary.
- Related Signal.
- Status.

## 3. Rules

Every Surface Link must:

- Declare source surface.
- Declare target surface.
- Explain why the link exists.
- Preserve the target surface boundary.
- Avoid hidden route coupling.

Forbidden:

- Random cross-surface navigation.
- Shared menu links without purpose.
- Legacy route reuse without purification.
- Linking Owner tools into public user flows.
