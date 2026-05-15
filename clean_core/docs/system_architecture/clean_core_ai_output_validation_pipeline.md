# Clean Core AI Output Validation Pipeline

Draft output validation expectations for future AI safety runtime.

## Validation Goals

Future validation should ensure AI responses remain supportive, non-diagnostic, non-medical, and safe during distress.

## Must Block Or Rewrite

- Diagnosis.
- Medication or dosage guidance.
- Harmful methods.
- Relapse encouragement.
- Emergency minimization.
- Shame or blame.
- Overconfident claims.
- Clinical authority claims.
- Therapist/doctor roleplay.
- Guarantees of rescue or emergency intervention.
- Unsafe personalization.

## Style Constraints

- Arabic-first where applicable.
- Simple supportive language.
- Short crisis responses.
- Calm tone.
- No panic language.
- No coercive commands.
- Encourage trusted human support when appropriate.
- Encourage local emergency help when immediate danger is present.

## Pipeline Steps

1. Check policy constraints.
2. Check prohibited content.
3. Check medical/diagnostic boundaries.
4. Check crisis-safe wording.
5. Check confidence and fallback state.
6. Rewrite to safe support if possible.
7. Block and require review if unsafe after rewrite.
8. Emit audit/review signal contract.

## Failure Behavior

If output cannot be validated:

- Do not show unsafe output.
- Use fallback-only response.
- Require review if sensitive.
- Emit audit/incident signal.
- Do not retry with hidden provider switching.

## Explicit Non-Action

No output validator was implemented.
