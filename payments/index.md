---
layout: page
permalink: /payments/
title: "Payment Systems — Adan Condori"
description: "Engineering notes on payment gateways, multi-gateway architectures, 3DS 2.0, ADRs, idempotency, reconciliation, Stripe, PayPal, and Adyen. 10+ years of production payments experience."
lang: en
---

I've spent the last decade building, breaking, and re-architecting payment systems — from small Stripe integrations to multi-gateway platforms handling $5M+ in transactions across 25+ currencies. This page collects everything I've written about payments in one place, organized by topic.

## What I cover here

**The work I do every day:** designing payment systems that integrate Stripe, PayPal, Adyen, and other gateways without becoming an unmaintainable mess; debugging 3DS 2.0 flows when something fails at 2 AM; writing ADRs so the next engineer doesn't have to re-learn what I already learned; and building the engineering practices that make all of this shippable.

**Why this matters:** payments code is the rare place where a bad decision shows up as a refund queue, a chargeback rate, or a regulator's letter — not just a slow test suite. I write here because I wish I'd had this content when I was learning.

---

## Architecture

### [Arquitectura base de un sistema de pagos multi-gateway](/architecture,/payments,/software/design,/patterns/Arquitectura-Base-Sistema-Pagos-Multi-Gateway/)
*June 2026 · Spanish · 8,500+ words*

The pillar post. Six-layer architecture, capability registry, idempotency keys, 15+ gateways integrated, 7 anti-patterns I've seen in production, and 8 canonical flows from intent to settlement. ASCII diagrams, code, and the patterns I'd defend in any architecture review.

### [ADRs en sistemas de pagos](/architecture,/payments,/documentation/ADRs-en-sistemas-de-pagos/)
*May 2026 · Spanish*

Architecture Decision Records, applied to payments. Why I write them, what template I use, and real incidents that became ADRs ($8,200 refund event, 47 customers affected — and what changed because of it).

### [Integration with Multiple Payment Gateways](/payments,/stripe,paypal/Integration-with-Multiple-Payment-Gateways/)
*January 2025 · English*

How I think about integrating Stripe and PayPal in the same codebase without one bleeding into the other. Abstraction layers, fallback strategies, and the gateway-specific quirks that ruin clean architecture if you don't account for them.

---

## 3D Secure (3DS)

### [Trazabilidad en Transacciones 3DS](/3ds/card/payments/Trazabilidad_en_Transacciones_3DS/)
*June 2025 · Spanish*

Observability and tracing for 3DS 2.0 flows. Why most 3DS implementations are black boxes when they fail, and what I instrument to make them debuggable in production.

### [Seguridad en Transacciones 3DS](/3ds,/card,/payments/Seguridad_en_Transacciones_3DS/)
*January 2025 · Spanish*

The 3DS 2.0 security model: what the issuer, acquirer, ACS, and DS each do, where the friction goes, and how SCA exemptions work in practice.

---

## Engineering Practices for Payments Teams

### [Guardia del Sprint / Triage Engineer](/agile,/devops,/engineering/guardia-del-sprint-triage-engineer/)
*October 2025 · Spanish*

The triage-engineer role. MTTR dropped from 4 hours to 45 minutes, sprint completion from 65% to 85%. SLA tables, the exact responsibilities, and what I'd change about it.

### [Definition of Ready / Definition of Done](/agile,/software/engineering,/best/practices/definition-of-ready-definition-of-done/)
*August 2025 · Spanish*

DoR and DoD when the cost of "almost done" is a refund queue. The criteria I actually use, not the wiki version.

### [Clean Code Tips](/refactoring/clean-code-tips/)
*August 2023 · Spanish*

Refactoring lessons from payments codebases.

---

## Cloud & Infrastructure

### [Migration from IBM Cloud to AWS](/aws,/ibm,/cloud/migration-ibm-aws/)
*December 2023 · Spanish*

A real cloud migration for a payments-adjacent workload. What broke, what was easier than expected, and what I'd do differently.

---

## What I'm working on next

- Reconciliation pipelines that actually scale (writing now)
- A deeper look at how to model refunds, partial captures, and disputes without state-machine pain
- Real-world numbers from running a payments-engineering on-call rotation

If you're building something payments-related and any of this is useful, [reach out](mailto:adan.condoric@gmail.com) — I'm always happy to compare notes with other payments engineers.

---

*Want the full corpus in machine-readable form? See [llms.txt](/llms.txt) and [llms-full.txt](/llms-full.txt).*
