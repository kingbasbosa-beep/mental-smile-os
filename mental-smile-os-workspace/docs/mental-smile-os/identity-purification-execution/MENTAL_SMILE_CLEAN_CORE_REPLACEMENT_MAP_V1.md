# MENTAL_SMILE_CLEAN_CORE_REPLACEMENT_MAP_V1

## Purpose

Map replacement strategy for `mental_smile_clean_core`.

## Replacement Options

| Option | Meaning | Use When |
| --- | --- | --- |
| INLINE_REQUIRED_PARTS | Move minimal required contracts into active OS runtime. | Small stable contracts only. |
| REPLACE_WITH_OS_MODULES | Create OS-owned modules mirroring required behavior. | Preferred for meaningful runtime domains. |
| KEEP_TEMPORARY_WITH_EXPLICIT_EXPIRY | Keep dependency temporarily with documented expiry. | Needed until actual imports are mapped. |
| REMOVE_AFTER_EXTRACTION | Remove package after replacement and validation. | Final target. |

## Recommended Path

1. KEEP_TEMPORARY_WITH_EXPLICIT_EXPIRY.
2. REPLACE_WITH_OS_MODULES for required contracts.
3. INLINE_REQUIRED_PARTS only for tiny value objects/contracts.
4. REMOVE_AFTER_EXTRACTION after validation.

## Forbidden

- Do not blindly copy the entire core package.
- Do not keep dependency without expiry.
- Do not rename dependency as OS without extraction.
- Do not remove dependency before analyzer passes.
