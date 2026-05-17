# EX-119 Adapter Boundary Mapping

## Adapter Boundary

`AiProviderAdapter.complete` is the clearest execution boundary in the inspected
runtime surface.

## Adapter Responsibilities

- receive runtime request
- invoke or represent provider completion
- return runtime result
- expose provider capabilities
- block disabled providers

## Classification

| Adapter concept | Classification |
| --- | --- |
| `AiProviderAdapter` | permanently blocked from passive package exposure |
| `complete` | backend/runtime host-only |
| `AiRuntimeRequest` | backend/runtime host-only |
| `AiRuntimeResponse` | backend/runtime host-only |
| `AiRuntimeResult.success` | backend/runtime host-only |
| `DisabledAiProviderAdapter` | internal fallback scaffold, not public guarantee |

## Blocked Meanings

- adapter execution proof
- AI completion guarantee
- provider success guarantee
- validated output guarantee
- runtime execution guarantee
- client-side provider invocation

## Adapter Verdict

The adapter boundary must remain isolated. It is not a passive diagnostic surface
and should not be included in package contracts or public exports.
