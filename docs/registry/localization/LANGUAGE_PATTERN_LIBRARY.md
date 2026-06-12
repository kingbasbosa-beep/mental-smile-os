# LANGUAGE PATTERN LIBRARY

## Purpose

This library provides constitutional structures for new copy. Patterns are not
finished localization strings. Every placeholder must resolve to registered
terminology, and every output must pass the Language Engine.

## Pattern Contract

Each use declares:

- intent;
- output type;
- owner registry;
- audience;
- approved term IDs;
- factual state;
- English and Arabic output;
- parity result.

Patterns cannot authorize a forbidden concept.

## Button Patterns

| Intent | English Pattern | Arabic Pattern | Boundary |
|---|---|---|---|
| Open destination | `Open {destination}` | `افتح {destination}` | Destination must be registered |
| Explore | `Explore {resources}` | `استكشف {resources}` | No allocation promise |
| View | `View {item}` | `اعرض {item}` | Read-only meaning |
| Save | `Save {destination}` | `احفظ {destination}` | Personal choice only |
| Contact | `Contact {party}` | `تواصل مع {party}` | No booking implication |
| Share signal | `Share this signal` | `شارك هذه الإشارة` | Voluntary and revocable |
| Continue | `Continue` | `متابعة` | Must state consequence nearby |
| Retry | `Try again` | `حاول مرة أخرى` | Recoverable action only |

Never generate `Approve`, `Reject`, `Assign`, `Book`, or `Activate` as active
constitutional actions.

## Page Title Patterns

- English: `{Registered Destination}`
- Arabic: `{Registered Destination in Arabic}`
- English: `{Concept} Observatory`
- Arabic: `مرصد {concept}`
- English: `{Concept} Registry`
- Arabic: `سجل {concept}`
- English: `{Audience} Room`
- Arabic: `غرفة {audience}`

`Room`, `Observatory`, and `Registry` are not interchangeable. The Registry
Resolver must verify the destination's actual constitutional function.

## Card Patterns

### Resource Card

- Title: `{Resource name}`
- Description EN: `{Resource} may support {declared interest}.`
- Description AR: `قد يدعم {resource} {declared interest}.`
- Action EN: `Explore resource`
- Action AR: `استكشف المورد`

### Signal Card

- Title: `{Signal name}`
- Description EN: `A signal you chose to share about {subject}.`
- Description AR: `إشارة اخترت مشاركتها حول {subject}.`
- Boundary: Never describe what the signal proves about the person.

### Readiness Card

- Title EN: `{Entity} readiness`
- Title AR: `جاهزية {entity}`
- State EN: `Ready` or `Incomplete`
- State AR: `جاهز` or `غير مكتمل`
- Detail EN: `{count} required signals are incomplete.`
- Detail AR: `{count} من الإشارات المطلوبة غير مكتملة.`

### Provider or Center Discovery Card

- Description EN: `{entity} declares capabilities in {capabilities}.`
- Description AR: `يعلن {entity} عن قدرات في {capabilities}.`
- Action EN: `View details`
- Action AR: `عرض التفاصيل`
- Boundary: No approval badge, assignment, or guaranteed suitability.

## Tooltip Patterns

- EN: `{Control} {immediate function}.`
- AR: `{control} من أجل {immediate function}.`
- EN: `Shows {observable state}; it does not change it.`
- AR: `يعرض {observable state} دون تغييره.`

Tooltips explain behavior. They do not contain hidden policy or new doctrine.

## Empty-State Patterns

| Context | English | Arabic |
|---|---|---|
| Signals | `No signals have been shared yet.` | `لم تتم مشاركة إشارات حتى الآن.` |
| Saved resources | `No saved destinations yet.` | `لا توجد وجهات محفوظة حتى الآن.` |
| Recommendations | `No recommendations are available from the current signals.` | `لا توجد توصيات متاحة من الإشارات الحالية.` |
| Observatory | `No observable records match these filters.` | `لا توجد سجلات مرصودة تطابق هذه المرشحات.` |
| Messages | `No conversations yet.` | `لا توجد محادثات حتى الآن.` |

An empty state may offer one optional next action. It must not imply failure.

## Error Patterns

### Recoverable

- EN: `We couldn't {action}. Try again.`
- AR: `تعذر {action}. حاول مرة أخرى.`

### Connectivity

- EN: `This information is unavailable right now. Check your connection and try again.`
- AR: `هذه المعلومات غير متاحة الآن. تحقق من الاتصال وحاول مرة أخرى.`

### Permission Boundary

- EN: `This information is not available for this account.`
- AR: `هذه المعلومات غير متاحة لهذا الحساب.`

Do not expose internal roles, rule names, stack details, or historical admin
language.

## Success Patterns

- EN: `{item} was saved.`
- AR: `تم حفظ {item}.`
- EN: `Your declaration was submitted.`
- AR: `تم إرسال إقرارك.`
- EN: `Your preferences were updated.`
- AR: `تم تحديث تفضيلاتك.`

Success confirms the action only. It does not imply approval, visibility, or an
outcome that has not occurred.

## Notification Patterns

### Informational

- EN: `{event}. You can {optional action}.`
- AR: `{event}. يمكنك {optional action}.`

### Readiness Change

- EN: `Readiness is now {state}.`
- AR: `الجاهزية الآن: {state}.`

### New Resource

- EN: `A resource matching signals you chose to share is available.`
- AR: `يتوفر مورد يتوافق مع إشارات اخترت مشاركتها.`

### Safety

- EN: `{verified safety fact}. {proportionate action}.`
- AR: `{verified safety fact}. {proportionate action}.`

Notifications never claim that a person has been assigned, accepted, or
diagnosed.

## Dialog Patterns

### Confirmation

- Title EN: `{Action}?`
- Title AR: `هل تريد {action}؟`
- Body EN: `This will {specific consequence}.`
- Body AR: `سيؤدي ذلك إلى {specific consequence}.`
- Confirm EN: `{Action}`
- Confirm AR: `{action}`
- Cancel EN: `Cancel`
- Cancel AR: `إلغاء`

### Signal Sharing

- Body EN: `You choose whether to share this signal. You can change this preference later.`
- Body AR: `أنت تختار ما إذا كنت تريد مشاركة هذه الإشارة. يمكنك تغيير هذا التفضيل لاحقًا.`

## Discovery Patterns

- EN: `Explore providers by declared capability.`
- AR: `استكشف مقدمي الخدمة حسب القدرات المعلنة.`
- EN: `Explore centers that match your accessibility preferences.`
- AR: `استكشف المراكز التي تتوافق مع تفضيلات إمكانية الوصول لديك.`
- EN: `Save this destination for later.`
- AR: `احفظ هذه الوجهة للرجوع إليها لاحقًا.`

Discovery supports comparison and choice. It does not rank human worth or make
clinical suitability claims.

## Support Patterns

- EN: `Choose how you prefer to receive support.`
- AR: `اختر الطريقة التي تفضلها لتلقي الدعم.`
- EN: `Share a technical support signal.`
- AR: `شارك إشارة دعم فني.`
- EN: `View continuity resources.`
- AR: `اعرض موارد الاستمرارية.`

Support is not case ownership, assignment, or recovery management.

## Recovery Patterns

- EN: `What gives you hope?`
- AR: `ما الذي يمنحك الأمل؟`
- EN: `Choose resources that support your aspirations.`
- AR: `اختر الموارد التي تدعم تطلعاتك.`
- EN: `Continue when you are ready.`
- AR: `تابع عندما تكون مستعدًا.`

Recovery patterns invite expression. They do not assess compliance or promise
results.

## Monitoring Patterns

- EN: `Observing {signal category}`
- AR: `رصد {signal category}`
- EN: `{count} records currently show incomplete readiness.`
- AR: `تُظهر {count} من السجلات جاهزية غير مكتملة حاليًا.`
- EN: `This view is read-only.`
- AR: `هذا العرض للقراءة فقط.`

Monitoring copy must never imply approval, assignment, ownership, or mutation.

## Governance Patterns

- EN: `{policy} applies to {scope}.`
- AR: `تنطبق {policy} على {scope}.`
- EN: `{actor} may observe {data} but may not change {state}.`
- AR: `يجوز لـ {actor} رصد {data} دون تغيير {state}.`
- EN: `This term is forbidden in active constitutional language.`
- AR: `هذا المصطلح ممنوع في اللغة الدستورية الفعالة.`

## Accessibility Patterns

- EN: `Choose your preferred communication format.`
- AR: `اختر صيغة التواصل التي تفضلها.`
- EN: `{format} is available.`
- AR: `تتوفر صيغة {format}.`
- EN: `Describe any access preference you want the system to remember.`
- AR: `صِف أي تفضيل لإمكانية الوصول تريد من النظام تذكره.`

## Marketing Patterns

- EN: `Discover resources, providers, and centers through the signals you choose to share.`
- AR: `اكتشف الموارد ومقدمي الخدمة والمراكز من خلال الإشارات التي تختار مشاركتها.`

Marketing must not use guaranteed recovery, superiority, urgency, approval, or
ownership as persuasion.

