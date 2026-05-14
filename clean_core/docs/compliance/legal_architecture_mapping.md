# Legal Architecture Mapping

## Status

Draft documentation only. Requires legal, compliance, security, and product review before production use.

## Mapping Summary

| Foundation | Safety Value | Privacy Value | Auditability Value | Store/Compliance Value |
| --- | --- | --- | --- | --- |
| Legal consent foundation | Makes user acknowledgements explicit | Limits consent payloads to minimal metadata | Versioned records support traceability | Supports informed disclosure |
| AI governance placeholders | Prevents accidental runtime AI authority | Avoids raw prompts and unsafe profiling by design | Defines event, incident, trace, policy snapshot shapes | Shows safety architecture before enabling AI |
| AI safety core skeleton | Fails closed for unknown/low-confidence states | Keeps runtime behavior out of client code | Creates future policy/result contracts | Demonstrates non-diagnostic safety posture |
| Crisis-safe UX copy | Encourages calm human support and emergency resources | Avoids collecting crisis details in copy components | Provides reusable approved language surface | Helps avoid emergency-service claims |
| Backend boundaries | Separates client writes from governance decisions | Keeps protected fields server-owned | Defines future trusted operation contracts | Supports deny-by-default review narrative |
| Deny-by-default Firestore posture | Reduces unauthorized state transitions | Limits direct access to protected data | Makes server-owned decisions clearer | Supports platform trust and abuse prevention |

## Key Product Claims

Mental Smile is wellness/support/awareness software. It is not a diagnosis tool, therapy replacement, emergency service, or medical authority.

## AI Status

Runtime AI is not enabled. Current AI-related work is foundational architecture for future safety, governance, compliance, and review.
