---
layout: post
title: ADRs en sistemas de pagos - por qué documentar decisiones te salva de auditorías, incidentes y reescrituras
modified:
last_modified_at: 2026-06-21T00:00:00-07:00
lang: es
categories: Architecture, Payments, Documentation
excerpt: >
  Por qué los Architecture Decision Records son innegociables cuando manejas dinero, compliance y proveedores externos.
tldr: >
  Después de un incidente que cobró tres veces a un cliente porque alguien añadió retry logic sin idempotency, dejé de escribir ADRs "cuando hay tiempo" y empecé a tratarlos como infraestructura. Este post es el template que uso, el flujo que sigo con el equipo, y dos incidentes reales — un $8,200 en refunds, 47 customers afectados — que documentamos como ADR y nos ahorraron repetir el mismo error. Si manejas dinero en producción, los ADRs no son nice-to-have.
tags: []
image:
feature:
date: 2026-05-07T09:00:00-07:00
faq:
  - q: "¿Qué es un Architecture Decision Record (ADR)?"
    a: "Un ADR es un documento corto (1-3 páginas) que captura una decisión arquitectónica: el contexto en que se tomó, las opciones que se consideraron, la decisión final, y las consecuencias - positivas y negativas - que se aceptaron al elegirla. Vive en el repo junto al código, versionado y con número correlativo."
  - q: "¿Por qué los ADRs son críticos en sistemas de pagos?"
    a: "Porque en pagos toda decisión toca dinero, compliance, o proveedores externos. Cuando un auditor pregunta por qué reintentas tres veces, o cuando un nuevo dev se pregunta por qué hay un timeout específico para Stripe pero no para PayPal, el ADR tiene la respuesta - con el contexto del momento en que se tomó. Sin ADRs, las decisiones críticas se vuelven folklore y se reabren cada seis meses."
  - q: "¿Qué template usas para ADRs?"
    a: "Yo uso el formato MADR: Título, Status (Proposed/Accepted/Deprecated/Superseded), Context (qué problema), Decision (qué hicimos), Consequences (qué aceptamos como trade-off), y Alternatives Considered (qué descartamos y por qué). Lo importante no es el formato sino que captures las alternativas que descartaste - eso es lo que te salva en seis meses."
  - q: "¿Cada cuánto debo escribir un ADR?"
    a: "Cada vez que tomes una decisión que en seis meses alguien va a cuestionar. En payments, casi todo: idempotency strategy, retry policies, gateway routing, error handling, qué loggeas vs qué no, reconciliation cadence, encryption-at-rest decisions. Si te toma más de 30 minutos discutirlo en PR review, escríbelo como ADR antes de mergear."
---

## Introducción: "¿Por qué hicimos esto así?"

Imagínate esta escena: estás en una reunión de incidentes. Producción está cayéndose porque un gateway de pagos respondió con un timeout y el sistema reintentó la transacción tres veces. Resultado: el cliente fue cobrado tres veces.

Alguien pregunta lo inevitable:

> *"¿Por qué reintentamos tres veces sin idempotency key? ¿Quién decidió esto?"*

Silencio incómodo. El que tomó la decisión ya no trabaja en la empresa. El commit dice *"add retry logic"* y no hay más contexto. Nadie sabe si fue una decisión deliberada, un workaround temporal, o simplemente algo que se copió de un tutorial.

Esto, queridos lectores, es exactamente el problema que los **ADRs (Architecture Decision Records)** vienen a resolver. Y en sistemas de pagos, **no tenerlos es jugar a la ruleta con el dinero del negocio**.

En este artículo te explico qué son, por qué en payments son críticos, qué decisiones siempre deberías documentar, y cómo no caer en los errores típicos.

---

## 1. ¿Qué es un ADR (y por qué no es solo "documentación más")?

Un ADR es un documento corto que captura **una decisión arquitectónica importante** junto con su **contexto** y sus **consecuencias**.

La estructura mínima es brutal de simple:

* **Título** — qué se decidió.
* **Estado** — propuesto, aceptado, deprecado, superseded.
* **Contexto** — qué problema o restricción motivó la decisión.
* **Decisión** — qué se eligió hacer.
* **Consecuencias** — qué ganamos y qué perdemos.

> ✅ *La wiki documenta el **qué**. El ADR documenta el **porqué**.*

Esa diferencia es la que cambia todo. Un nuevo dev puede leer el código y entender qué hace. Pero solo un ADR le dice **por qué se hizo así y qué alternativas se descartaron**.

---

## 2. ¿Por qué los sistemas de pagos son un caso especial?

He trabajado con sistemas de logística, e-commerce, reservas y pagos. Te lo digo con honestidad: **payments es donde más caro pagas la falta de ADRs**. Y aquí está el porqué:

* 💰 **El costo de equivocarse se mide en dinero real.** Un retry mal implementado es un chargeback. Un webhook mal documentado es una transacción perdida. No es un bug cosmético, es revenue.

* 🔒 **El compliance manda.** PCI-DSS, SCA (Strong Customer Authentication), PSD2, 3DS v2. Los auditores **te van a preguntar por qué tu sistema hace X**, y "porque sí" no es una respuesta válida.

* 🔌 **Dependes de terceros.** Stripe, PayPal, Adyen, Braintree. Cuando ellos cambian su API, tú tienes que reaccionar. Si no documentaste por qué elegiste un flow en particular, **vas a estar reverse-engineering tus propias decisiones**.

* ⏳ **Las decisiones envejecen rápido.** Lo que era óptimo hace dos años hoy es deuda técnica. Sin ADRs, no sabes qué decisiones revisar.

---

## 3. Las 5 decisiones que SIEMPRE deberías documentar como ADR

No todo merece un ADR. Pero en payments, estas cinco categorías son innegociables:

### 3.1 Elección y estrategia de payment gateway
¿Single gateway o multi-gateway? ¿Por qué Stripe sobre Adyen para ese mercado? ¿Qué criterios pesaron — fees, cobertura geográfica, soporte 3DS, time-to-market?

### 3.2 Estrategia de reintentos e idempotencia
¿Cuántos reintentos? ¿Con qué backoff? ¿Cómo se garantiza idempotencia? Este ADR solo te puede salvar de un incidente como el de la introducción.

### 3.3 Manejo de 3DS / SCA
¿Qué flow se usa — challenge obligatorio, frictionless, fallback? ¿Qué exenciones aplican (low-value, trusted beneficiary)? Aquí el compliance se mezcla con UX, y las decisiones son polémicas.

### 3.4 Tokenización y almacenamiento de datos sensibles
¿Vault propio o del provider? ¿Qué scope de PCI te queda (SAQ-A vs SAQ-D)? Esta decisión define **literalmente qué tan caro es tu compliance anual**.

### 3.5 Webhooks y reconciliación
¿Entrega garantizada o eventual consistency? ¿Cómo se manejan los duplicados? ¿Hay reconciliación batch además del stream de eventos? Aquí es donde la realidad de los sistemas distribuidos te golpea más fuerte.

---

## 4. Anatomía de un ADR real (ejemplo)

Veamos cómo se vería un ADR concreto para el caso de la introducción:

```markdown
# ADR-007: Adoptar idempotency keys en todas las llamadas a gateways

## Estado
Aceptado — 2026-03-15

## Contexto
El 12 de marzo tuvimos un incidente: un timeout en el gateway X
disparó el retry automático de nuestro cliente HTTP. La transacción
se procesó tres veces. Impacto: 47 clientes cobrados duplicado,
~USD 8.200 en refunds y soporte.

Las llamadas actuales no envían un identificador único que permita
al gateway deduplicar.

## Decisión
Todas las llamadas a gateways de pago deberán incluir un header
`Idempotency-Key` con un UUID v4 generado en el momento de crear
la intención de pago, no en el momento del retry.

La clave se persiste en la tabla `payment_attempts` y se reutiliza
en todos los reintentos del mismo intento de pago.

## Consecuencias
+ Eliminamos cobros duplicados por reintentos.
+ Cumplimos con la recomendación oficial de Stripe y Adyen.
- Requiere migración de los servicios existentes (ver ADR-008).
- Aumenta ligeramente el tamaño de la tabla `payment_attempts`.

## Alternativas consideradas
- Deshabilitar reintentos automáticos: rechazada, degrada UX.
- Locks distribuidos: rechazada, complejidad operativa innecesaria.
```

¿Ves? **Corto, contextual, accionable.** Cualquier dev que llegue en seis meses entiende qué pasó, por qué se hizo así, y qué no se debe romper.

---

## 5. Errores comunes al escribir ADRs en payments

Después de ver decenas de ADRs (algunos míos, algunos heredados), estos son los errores más frecuentes:

* ❌ **Escribirlos después del incidente.** El ADR debería ser parte del proceso de decisión, no el postmortem. Si lo escribes después, es un *Incident Report* con otro nombre.

* ❌ **Escribir novelas de 20 páginas.** Si un ADR no se lee en 5 minutos, nadie lo va a leer. Punto.

* ❌ **No marcar como *superseded*.** Cuando una decisión cambia, el ADR viejo debe quedar marcado y enlazar al nuevo. De lo contrario, conviven dos verdades.

* ❌ **Mezclar ADR con runbook o spec de producto.** El ADR no explica *cómo operar* el sistema ni *qué funcionalidad* tiene. Solo *por qué se decidió* así.

* ❌ **No referenciarlos desde el código o los PRs.** Un ADR que nadie linkea es un ADR que nadie encuentra.

---

## 6. ¿Dónde viven los ADRs?

Mi recomendación, simple y probada:

1. **Carpeta `/docs/adr/` en el mismo repo.** Numeración secuencial: `0001-payment-gateway-selection.md`, `0002-retry-strategy.md`, etc.
2. **Referenciados desde los PRs.** Toda decisión arquitectónica nueva debe linkear al ADR correspondiente.
3. **Vinculados a la documentación de alto nivel.** Si tienes documentación en capas (executive, approach, detail), los ADRs son la capa más profunda — donde viven las decisiones reales.
4. **Indexados en un README** dentro de la carpeta, con título, estado y fecha.

No necesitas Confluence, no necesitas Notion. **Markdown plano, versionado con el código, revisable por PR.** Esa es la magia.

---

## Conclusión: Los ADRs no son burocracia, son seguros de vida

He visto equipos que evitaban los ADRs porque "no tenemos tiempo". Y luego he visto a esos mismos equipos perder **semanas** intentando entender por qué un sistema de pagos hace lo que hace, en medio de una auditoría PCI o de un cambio de gateway.

Los ADRs te protegen:

* Ante **auditorías de compliance** — puedes mostrar el *porqué* de cada decisión.
* Ante **el onboarding de nuevos devs** — dejan de hacer las mismas preguntas una y otra vez.
* Ante **ti mismo en seis meses** — porque sí, vas a olvidar por qué hiciste eso.

En sistemas de pagos, donde cada decisión toca dinero, compliance y proveedores externos, los ADRs no son un *nice-to-have*. Son **infraestructura para que tu arquitectura sobreviva al tiempo**.

> *Si vas a tomar una decisión que en seis meses alguien va a cuestionar — y en payments **todas** lo son — escríbela como ADR. Tu yo futuro te lo va a agradecer.*

---

## Referencias y fuentes

Si vas a empezar con ADRs y quieres ir más profundo:

- [Michael Nygard — Documenting Architecture Decisions](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions) — el post original de 2011 que arrancó toda la práctica de ADRs. Si lees uno solo, que sea este.
- [adr.github.io](https://adr.github.io/) — colección de templates (MADR, Nygard, Y-Statements) y patrones. El MADR template es el que yo uso.
- [ThoughtWorks Technology Radar — ADRs](https://www.thoughtworks.com/radar/techniques/lightweight-architecture-decision-records) — por qué los lightweight ADRs están en "Adopt" desde hace años.
- [adr-tools (Nat Pryce)](https://github.com/npryce/adr-tools) — CLI para crear y mantener ADRs con número correlativo. Lo uso en todos mis repos.
- [Architecture Decision Records in Action — Industrial Logic](https://industriallogic.com/blog/architecture-decision-records-in-action/) — un walkthrough práctico con ejemplos reales.
- [Stripe API — Idempotent Requests](https://docs.stripe.com/api/idempotent_requests) — referencia técnica que cito en el ejemplo de ADR sobre retry logic.

Y si manejas pagos y todavía no tienes ADRs, [escríbeme](mailto:adan.condoric@gmail.com). Te ayudo a montar los primeros tres — son los más difíciles, después se vuelve hábito.

---

*En el próximo post de esta serie hablaremos de cómo comunicar arquitectura de payments a stakeholders no técnicos — el arte de pasar de diagramas a decisiones.*
