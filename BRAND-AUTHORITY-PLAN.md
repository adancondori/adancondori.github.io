# Brand Authority Action Plan — Off-Site Execution

**Goal:** Move Brand Authority score from 38 → 70+ over 90 days. This category cannot be moved from code — it requires content distribution and entity creation on platforms AI engines use for citation grounding.

**Why this matters:** Ahrefs research (Dec 2025) shows brand mentions correlate **3× stronger** than backlinks with AI citation rates. ChatGPT, Perplexity, Gemini, and AIO weight third-party platform presence heavily when deciding whether to cite an entity.

---

## Current State Audit

| Platform | Status | Authority Weight |
|---|---|---|
| GitHub | Active (github.com/adancondori) | Strong for code-context queries |
| LinkedIn | Profile exists, 1 Pulse article from 2021 | Underutilized |
| Google Scholar | Profile present | Strong but niche |
| Twitter / X (@AdanCondori) | Account exists | Activity level unknown |
| Wikipedia / Wikidata | **NOT FOUND** | Critical gap |
| dev.to | Absent | Major content distribution gap |
| Medium / Hashnode | Absent | Major content distribution gap |
| Reddit | Absent | Community signal gap |
| Stack Overflow | Search shows nothing identifiable | Technical authority gap |
| YouTube | Absent | Multimodal AI gap |
| Industry newsletters (Pragmatic Engineer, etc.) | No guest appearances | Authority signal gap |

---

## Tier 1: This Week (Highest ROI, ~3 hours total)

### 1.1 Cross-post the multi-gateway article to dev.to (60 min)

**Why:** dev.to is heavily scraped by LLM training pipelines. Engineering content with concrete metrics performs exceptionally well there.

**How:**
- Create dev.to account: dev.to/adancondori
- Publish an **English summary** (~1,500 words) of the multi-gateway architecture article
- Use the dev.to canonical_url field to point back to `https://adancondori.github.io/architecture,/payments,/software/design,/patterns/Arquitectura-Base-Sistema-Pagos-Multi-Gateway/` — preserves SEO equity, no duplicate-content penalty
- Tags: `#payments`, `#architecture`, `#stripe`, `#fintech`, `#systemdesign`

**Expected impact:** +5-8 brand authority points within 4 weeks if it gets 50+ reactions.

### 1.2 Publish 2 LinkedIn articles using existing pillar content (90 min)

**Why:** LinkedIn is the #1 winnable entity signal for an individual engineer. AI engines weight LinkedIn presence heavily for professional identity resolution.

**How:**
- Article #1 (this week): "How I think about multi-gateway payment architecture after 15+ integrations" — based on the Spanish original
- Article #2 (next week): "The triage-engineer role: how we dropped MTTR from 4h to 45min"
- Both end with: "Full version on my blog: [link]"
- Pin both to your LinkedIn profile

**Expected impact:** +3-5 brand authority points within 6 weeks. Sustained cadence (1-2/month) compounds.

### 1.3 Answer 5 Stack Overflow questions tagged Stripe / 3DS / payments (30 min)

**Why:** SO is one of the most heavily scraped sources in LLM training data. Even 5 high-quality answers create durable, AI-cited footprints.

**How:**
- Filter SO by tags: `[stripe-payments]`, `[3d-secure]`, `[payment-processing]`
- Find 5 questions with low-quality accepted answers and provide a better one (linking your blog as supporting reference if relevant)
- Profile bio: "Senior Engineering Leader | Payment systems at Playbypoint | adancondori.github.io"

**Expected impact:** +2-4 brand authority points; SO answers index in Google permanently.

---

## Tier 2: Next 30 Days (~6 hours total)

### 2.1 Create a Wikidata entry (90 min)

**Why:** Wikidata is the structured-data backbone that feeds Wikipedia, Google Knowledge Graph, and most AI entity-resolution systems. Even a stub with `sameAs` to your existing profiles creates a canonical entity AI engines can resolve to.

**How:**
- Go to wikidata.org and create account
- Search "Adan Condori" — confirm no existing entity
- Create new item:
  - Label (en): "Adan Condori"
  - Description (en): "Bolivian software engineer specializing in payment systems"
  - Statements: `instance of` → human, `occupation` → software engineer, `employer` → Playbypoint, `educated at` → UAGRM
  - **External identifiers**: GitHub username, LinkedIn slug, Twitter handle, Google Scholar ID, ORCID (if any)
- The Wikidata Q-number then goes into your `sameAs` in JSON-LD (add to `_includes/_jsonld.html`)

**Expected impact:** +6-10 brand authority points. This is the single highest-leverage off-site action.

### 2.2 Submit a guest post to Pragmatic Engineer or one of these newsletters (3-4h)

**Why:** Single newsletter mention from an authoritative source is worth dozens of self-published posts in AI training corpora.

**Targets (rank by likelihood + relevance):**
- [The Pragmatic Engineer](https://newsletter.pragmaticengineer.com/) — accepts guest posts on engineering practice
- [Payments Engineer Playbook](https://newsletter.paymentsengineer.com/) — direct topic fit
- [High Scalability](http://highscalability.com/) — submit pitch via Twitter DM
- [InfoQ](https://www.infoq.com/) — submit article via their submission form
- [The Newsletter of Stripe Press](https://press.stripe.com/) — long shot but topic fit is perfect

**Pitch template:**
> Hi [editor], I've spent 10 years building payment systems and have written a long-form piece on multi-gateway architecture: [link]. It's gotten [X] traction on dev.to/LinkedIn. Would a 2,000-word adaptation be a fit for [newsletter]?

**Expected impact:** +8-15 brand authority points if accepted by one. Worth multiple attempts.

### 2.3 Record a 5-min YouTube explainer of multi-gateway architecture (90 min)

**Why:** Gemini specifically privileges entities with YouTube presence (Google ecosystem). Even a single video creates a multimodal signal.

**How:**
- Record screen + voice walking through the ASCII architecture diagram from the post
- Upload to YouTube as "Multi-Gateway Payment Architecture: A 5-Minute Walkthrough"
- Description: full transcript + link to blog post
- Add YouTube URL to `sameAs` array in `_includes/_jsonld.html`

**Expected impact:** +3-5 brand authority points; opens Gemini citation path.

### 2.4 Reddit cross-post (45 min)

**How:**
- Post English summary in r/programming with link to canonical
- Post in r/fintech, r/PaymentSystems if relevant
- Engage in comments — Reddit signals are about discussion, not just submission

**Expected impact:** +2-5 brand authority points; very visible in Perplexity citations.

---

## Tier 3: Quarterly (Sustained Authority Compounding)

| Action | Cadence | Expected Lift / Quarter |
|---|---|---|
| LinkedIn articles | 2/month | +4-6 pts |
| dev.to posts (English versions) | 1/month | +3-5 pts |
| Stack Overflow answers | 5/month | +2-4 pts |
| Guest posts / podcast appearances | 1/quarter | +5-10 pts |
| Conference talk (PaymentsHack, NerdsUnited, local meetup) | 1/quarter | +5-10 pts |

---

## Tracking Progress

After each Tier 1 action ships, re-run `/geo brands https://adancondori.github.io/` to measure the Brand Authority delta. Target trajectory:

| Milestone | Brand Authority Score |
|---|---|
| Baseline (today) | 38 |
| +Tier 1 (week 2) | 50 |
| +Tier 2 (week 6) | 65 |
| +Tier 3 (quarter 1 end) | 75+ |

---

## What NOT to Do

- **Don't pay for "press release distribution" services.** They generate low-quality syndication noise that AI engines deweight.
- **Don't auto-post identical content to 10 platforms.** Each platform needs adapted framing. Dev.to ≠ Medium ≠ Hashnode ≠ LinkedIn.
- **Don't ghost-write or use AI to manufacture engagement.** Reddit, SO, and LinkedIn detect this; it can permanently damage entity trust.

---

## Once Wikidata Entry Exists

After Tier 2.1 ships and Wikidata assigns a Q-number (e.g., `Q123456789`), add it to your JSON-LD `sameAs`:

```diff
 "sameAs": [
   "https://github.com/adancondori",
   "https://www.linkedin.com/in/adancondori",
   "https://twitter.com/AdanCondori",
-  "https://scholar.google.com/citations?user=adancondori"
+  "https://scholar.google.com/citations?user=adancondori",
+  "https://www.wikidata.org/wiki/Q123456789"
 ]
```

This single change has outsized impact on ChatGPT and Perplexity citation rates — those models actively reconcile entities through Wikidata.
