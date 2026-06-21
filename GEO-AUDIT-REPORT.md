# GEO Audit Report: adancondori.github.io

**Audit Date:** 2026-06-20
**URL:** https://adancondori.github.io/
**Business Type:** Personal Brand / Technical Publisher (Engineering Portfolio)
**Pages Analyzed:** Homepage, CV, 4 representative blog posts (multi-gateway architecture, triage engineer, ADRs en pagos, 3DS security) + sitemap (26 URLs)

---

## Executive Summary

**Overall GEO Score: 51/100 (Poor — Borderline Fair)**

The site has unusually strong raw material — first-person, incident-grounded technical writing with concrete metrics (MTTR 4h→45min, $5M+ transactions handled, 15+ gateway integrations) and consistent 2026 publishing cadence. Content E-E-A-T scores in the top quartile for personal tech blogs. **The gap is mechanical, not editorial:** zero structured data, no llms.txt, and almost no entity-recognition footprint outside GitHub. AI engines can't yet confidently identify "Adan Condori" as the payments-engineering authority the content proves him to be. The good news: every critical fix is template-level (one `_layouts/post.html` edit ships schema to all 17 posts at once).

### Score Breakdown

| Category | Score | Weight | Weighted Score |
|---|---|---|---|
| AI Citability | 65/100 | 25% | 16.25 |
| Brand Authority | 22/100 | 20% | 4.40 |
| Content E-E-A-T | 82/100 | 20% | 16.40 |
| Technical GEO | 68/100 | 15% | 10.20 |
| Schema & Structured Data | 5/100 | 10% | 0.50 |
| Platform Optimization | 34/100 | 10% | 3.40 |
| **Overall GEO Score** | | | **51/100** |

**One-line diagnosis:** Strong content, invisible entity. Ship schema + llms.txt + LinkedIn/dev.to footprint and this site jumps to 70+ within a quarter.

---

## Critical Issues (Fix Immediately)

| # | Issue | Where | Fix |
|---|---|---|---|
| C1 | **Zero JSON-LD anywhere on the site** | Homepage + every post | Add `Person` + `WebSite` schema in `_layouts/home.html`; add `BlogPosting` schema in `_layouts/post.html` (templates below in Schema section) |
| C2 | **No `sameAs` entity linking** | All pages | Without sameAs to LinkedIn / GitHub / Scholar / Twitter, AI models cannot disambiguate "Adan Condori" from unrelated namesakes |
| C3 | **`og:type` is `article` on homepage** | `_includes/head.html` | Change to `profile` (or `website`) for the homepage |

## High Priority Issues (Fix Within 1 Week)

| # | Issue | Where | Fix |
|---|---|---|---|
| H1 | **No `/llms.txt`** (404) | Site root | Deploy the draft in the Citability section — single file, immediate AI-discovery win |
| H2 | **No `<meta name="description">` on homepage** | `_includes/head.html` | Add a 150-char description; surfaces in SERP and AI snippets |
| H3 | **Comma-separated category URLs** (`/architecture,/payments,/software/design,/patterns/...`) | `_config.yml` permalink + post front matter | Switch to clean slugs (`/posts/<slug>/`); add 301 redirects from old paths via Jekyll redirect_from |
| H4 | **No outbound citations in long-form posts** | All posts | Add 3–5 authoritative outbound links per post (Stripe docs, PCI-DSS, EMVCo 3DS spec, Brandur/Fowler) — Perplexity and AIO reward primary-source citing |
| H5 | **No author bio block on posts** | `_layouts/post.html` | Append a 2-3 line "About Adan" with link to `/cv/` |
| H6 | **Brand entity gap** — no Wikipedia, almost no Reddit/StackOverflow/YouTube footprint | External | Activate LinkedIn (2 posts/month, cross-post existing content); answer 5-10 SO questions on payments/Stripe/3DS; mirror top 3 posts on dev.to / Hashnode in English |

## Medium Priority Issues (Fix Within 1 Month)

| # | Issue | Fix |
|---|---|---|
| M1 | No question-style H2s (`¿Qué es...?`, `How does...?`) | Rewrite section openers as questions on top 5 posts |
| M2 | No TL;DR / answer-target block at top of posts | Insert a 40-60 word summary after H1 |
| M3 | Missing `og:description` and complete Twitter Card | Add defaults in `_includes/head.html` |
| M4 | No `dateModified` / "Last updated" | Add `last_modified_at` to front matter; surface in post header |
| M5 | Missing `BreadcrumbList` schema | Add to post layout |
| M6 | No `/about`, `/privacy`, `/editorial-policy` pages | One paragraph each materially boosts Trustworthiness |
| M7 | No `Content-Signal` directive in robots.txt | Add `Content-Signal: search=yes, ai-train=yes, ai-retrieval=yes` |
| M8 | Render-blocking Google Fonts + duplicate analytics (GTM + gtag + legacy analytics.js) | Add `preconnect` + `font-display: swap`; drop one analytics stack |
| M9 | Spanish/English content mixed without per-post `lang` | Add `lang` to post front matter, set on `<html>` |

## Low Priority Issues

| # | Issue | Fix |
|---|---|---|
| L1 | Images missing explicit width/height | Causes minor CLS — add dimensions |
| L2 | FAQ-format Q&A blocks absent | Quote-ready for AI answer engines |
| L3 | Inconsistent URL casing (`Linux-basic` vs lowercase) | Normalize to lowercase-kebab |
| L4 | Sitemap `<lastmod>` only ~57% coverage | Ensure every entry has lastmod |

---

## Category Deep Dives

### AI Citability (65/100)

**Strong.** Sampled passages scored well above average for technical blogs:

| Page | Passage Score | Why |
|---|---|---|
| Homepage hero | 85/100 | Self-contained, dense with concrete metrics ($5M+ transactions, 40% success-rate lift, 800ms latency, 65% fraud reduction) |
| Arquitectura Multi-Gateway intro | 82/100 | 15+ gateways credentialed, 7 anti-patterns enumerated, 8 canonical flows, ASCII diagrams, tables, code |
| Guardia del Sprint | 80/100 | Concrete MTTR delta (4h→45min), sprint completion (65%→85%), SLA tables |
| ADRs en pagos | 74/100 | Real incident numbers ($8,200 refund, 47 customers), full ADR template; intro defers definition slightly |

**Bottlenecks lowering the composite to 65:**
- llms.txt 404 (zero discovery signal)
- No FAQ-formatted Q&A blocks
- Spanish-language content limits English LLM citation frequency
- No schema to disambiguate entities

**Recommended `/llms.txt` (ready to deploy):**

```
# Adan Condori

> Senior Engineering Leader, 10+ years building payment systems. Currently leading payment integrations at Playbypoint. Blog covers payment gateway architecture, 3DS, ADRs, design patterns, and engineering leadership (mostly Spanish, some English).

## About
- [Homepage / Bio](https://adancondori.github.io/): Profile, skills, work history, achievements
- [CV (PDF)](https://adancondori.github.io/cv/): Full curriculum vitae

## Payment Systems
- [Arquitectura Multi-Gateway](https://adancondori.github.io/architecture,/payments,/software/design,/patterns/Arquitectura-Base-Sistema-Pagos-Multi-Gateway/): 6-layer architecture, capability registry, idempotency, 15+ gateways
- [ADRs en sistemas de pagos](https://adancondori.github.io/architecture,/payments,/documentation/ADRs-en-sistemas-de-pagos/): Architecture Decision Records for payments
- [Seguridad 3DS](https://adancondori.github.io/3ds,/card,/payments/Seguridad_en_Transacciones_3DS/)
- [Integration with Multiple Payment Gateways](https://adancondori.github.io/payments,/stripe,paypal/Integration-with-Multiple-Payment-Gateways/)

## Engineering Practices
- [Guardia del Sprint / Triage Engineer](https://adancondori.github.io/agile,/devops,/engineering/guardia-del-sprint-triage-engineer/)
- [Definition of Ready / Done](https://adancondori.github.io/agile,/software/engineering,/best/practices/definition-of-ready-definition-of-done/)
- [Clean Code Tips](https://adancondori.github.io/refactoring/clean-code-tips/)

## Architecture & Design
- [A Good Software Architecture](https://adancondori.github.io/a-good-architecture/)
- [Success Skills for Architects (EN)](https://adancondori.github.io/Success-Skills-for-Architects-English/)
- [Design Patterns](https://adancondori.github.io/desing-patterns/)

## Optional
- [GitHub](https://github.com/adancondori)
- [LinkedIn](https://www.linkedin.com/in/adancondori)
```

### Brand Authority (22/100) — Critical Gap

| Platform | Status | Notes |
|---|---|---|
| Wikipedia | Absent | No entity. Top "Adan Condori" search hits are unrelated (Bolivian assembly, films) |
| Reddit | Absent | Zero brand mentions |
| YouTube | Absent | No channel or video mentions |
| Stack Overflow | Absent | No identifiable profile in search |
| LinkedIn | Minimal | Only one Pulse article ("A good Software Architecture", Jun 2021) surfaces |
| GitHub | Present | github.com/adancondori — active profile, real signal for code-context queries |
| dev.to / Medium / Hashnode | Absent | No syndication footprint |

**This is the #1 leverage point for AI visibility.** Content quality is already excellent; the AI models simply don't know this entity exists. LinkedIn + dev.to syndication is the fastest, cheapest, highest-impact path.

### Content E-E-A-T (82/100) — Strongest Category

| Dimension | Score | Evidence |
|---|---|---|
| Experience | 23/25 | First-person throughout, named incidents with metrics, 15+ gateway integrations, weekly incident logs |
| Expertise | 20/25 | Master's degree, 13 years documented history, 8+ named employers, university professor role, deep technical depth (ASCII diagrams, Ruby/JS code, state machines) |
| Authoritativeness | 17/25 | CV page + PDF, Google Scholar profile, sameAs links present in social — but no external media mentions or industry awards |
| Trustworthiness | 22/25 | HTTPS, visible email, every post dated, real employer names (Playbypoint, Banco Fassil, NETACTICA), Disqus comments |

**Gaps:** No outbound citations on long-form posts, no per-post author bio, no `last_modified_at`, no `/about` or `/privacy` pages, certifications (if any) not listed.

### Technical GEO (68/100)

| Subcategory | Status |
|---|---|
| SSR (Jekyll static) | PASS — full HTML delivered, no JS dependency for crawlers |
| Mobile / Viewport | PASS |
| Sitemap | PARTIAL — 26 URLs, ~57% lastmod coverage |
| Robots.txt | OK but bare — only Sitemap directive |
| Meta description | MISSING on homepage |
| JSON-LD | MISSING |
| Security headers (HSTS, CSP, X-Frame-Options) | Not emitted by GitHub Pages (unfixable without Cloudflare proxy) |
| CWV risk (LCP, INP, CLS) | MEDIUM — render-blocking fonts, redundant analytics, no img dimensions |
| URL structure | POOR — comma-separated category paths |

### Schema & Structured Data (5/100) — Critical

**Zero JSON-LD detected.** Open Graph and Twitter Card tags are present but are not a substitute for Schema.org markup.

**Template #1 — Person + WebSite (add to `_layouts/home.html` or `_includes/head.html`):**

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "Person",
      "@id": "https://adancondori.github.io/#person",
      "name": "Adan Condori",
      "alternateName": "Adan Condori C.",
      "url": "https://adancondori.github.io/",
      "image": "https://adancondori.github.io/images/perfil-cv.jpeg",
      "jobTitle": "Senior Full Stack Engineer — Payment Systems Lead",
      "description": "Senior Engineering Leader with 10+ years building scalable payment systems and fintech solutions.",
      "worksFor": {
        "@type": "Organization",
        "name": "Playbypoint",
        "url": "https://playbypoint.com"
      },
      "alumniOf": {
        "@type": "CollegeOrUniversity",
        "name": "Gabriel René Moreno Autonomous University"
      },
      "knowsAbout": [
        "Payment Gateways", "Stripe", "PayPal", "3DS 2.0",
        "Ruby on Rails", "React", "AWS", "Software Architecture",
        "Fintech", "Distributed Systems"
      ],
      "sameAs": [
        "https://github.com/adancondori",
        "https://www.linkedin.com/in/adancondori",
        "https://twitter.com/AdanCondori",
        "https://scholar.google.com/citations?user=adancondori"
      ]
    },
    {
      "@type": "WebSite",
      "@id": "https://adancondori.github.io/#website",
      "url": "https://adancondori.github.io/",
      "name": "Adan Condori",
      "publisher": { "@id": "https://adancondori.github.io/#person" },
      "inLanguage": ["en", "es"]
    },
    {
      "@type": "ProfilePage",
      "@id": "https://adancondori.github.io/#profilepage",
      "mainEntity": { "@id": "https://adancondori.github.io/#person" }
    }
  ]
}
</script>
```

**Template #2 — BlogPosting (add to `_layouts/post.html`):**

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "BlogPosting",
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "{{ page.url | absolute_url }}"
  },
  "headline": {{ page.title | jsonify }},
  "description": {{ page.excerpt | strip_html | strip_newlines | truncate: 200 | jsonify }},
  "image": "{{ site.url }}{% if page.image %}{{ page.image }}{% else %}/images/banners/default.jpg{% endif %}",
  "datePublished": "{{ page.date | date_to_xmlschema }}",
  "dateModified": "{{ page.last_modified_at | default: page.date | date_to_xmlschema }}",
  "author": {
    "@type": "Person",
    "name": "Adan Condori",
    "url": "{{ site.url }}/",
    "sameAs": [
      "https://github.com/adancondori",
      "https://www.linkedin.com/in/adancondori",
      "https://twitter.com/AdanCondori"
    ]
  },
  "publisher": {
    "@type": "Person",
    "name": "Adan Condori",
    "url": "{{ site.url }}/"
  },
  "articleSection": {{ page.categories | jsonify }},
  "keywords": {{ page.tags | jsonify }},
  "inLanguage": "{{ page.lang | default: 'es' }}",
  "wordCount": "{{ content | number_of_words }}",
  "speakable": {
    "@type": "SpeakableSpecification",
    "cssSelector": ["h1", ".post-excerpt", "article p:first-of-type"]
  }
}
</script>
```

### Platform Optimization (34/100)

| Platform | Score | Strongest Lever |
|---|---|---|
| Google AI Overviews | 38/100 | Article + FAQPage schema; question-style H2s; TL;DR blocks |
| ChatGPT Web Search | 35/100 | Person schema + sameAs (Wikipedia stub); author bylines |
| Perplexity | 32/100 | Outbound primary-source citations (RFC, PCI-DSS, vendor docs) |
| Gemini | 36/100 | Organization schema linking Scholar + LinkedIn + GitHub |
| Bing Copilot | 30/100 | IndexNow key file, Bing Webmaster verification, schema |

The same handful of fixes (schema, llms.txt, citations, question-style H2s) move all five platforms together — there isn't much per-platform specialization needed at this stage.

---

## Quick Wins (Implement This Week)

1. **Deploy `/llms.txt`** — copy the draft above to the site root, commit, ship. ~5 minutes.
2. **Add Person + WebSite JSON-LD to `_layouts/home.html`** — Template #1 above. ~15 minutes.
3. **Add BlogPosting JSON-LD to `_layouts/post.html`** — Template #2 above. Applies to all 17 posts in one commit. ~15 minutes.
4. **Add `<meta name="description">` and fix `og:type`** in `_includes/head.html` — homepage description + change `og:type` from `article` → `profile`. ~10 minutes.
5. **Activate LinkedIn distribution** — cross-post the multi-gateway architecture article (the strongest pillar) as a LinkedIn article this week, tagging payments/fintech topics. Highest brand-authority ROI on the list.

---

## 30-Day Action Plan

### Week 1: Structural Foundations (Mechanical Fixes)
- [ ] Ship `/llms.txt` (root of repo)
- [ ] Add Person + WebSite JSON-LD in `_layouts/home.html`
- [ ] Add BlogPosting JSON-LD in `_layouts/post.html`
- [ ] Add homepage `<meta name="description">`
- [ ] Fix `og:type` → `profile` on homepage
- [ ] Validate everything in [Schema Markup Validator](https://validator.schema.org/) and [Google Rich Results Test](https://search.google.com/test/rich-results)

### Week 2: URLs, Bios, Citations
- [ ] Switch permalink config away from comma-separated category paths; add `redirect_from` in front matter of affected posts
- [ ] Append standardized author-bio block to `_layouts/post.html` (3 lines + link to `/cv/`)
- [ ] Add 3–5 outbound citations to the multi-gateway and 3DS posts (Stripe docs, EMVCo 3DS spec, PCI-DSS)
- [ ] Add `lang` to post front matter (`es` for Spanish posts, `en` for English)

### Week 3: Brand Footprint
- [ ] Publish LinkedIn article #1: multi-gateway architecture (English summary + Spanish original link)
- [ ] Publish LinkedIn article #2: Guardia del Sprint
- [ ] Mirror top 2 posts to dev.to or Hashnode in English with canonical link back
- [ ] Answer 3 Stack Overflow questions on Stripe/3DS/payments with profile linking to site

### Week 4: Content Polish
- [ ] Add TL;DR / answer-target block (40–60 words) to top 5 posts
- [ ] Convert section H2s to question form on top 5 posts (e.g., "¿Qué es un capability registry?")
- [ ] Add `last_modified_at` to front matter; surface "Updated: YYYY-MM-DD" in post header
- [ ] Publish minimal `/about` and `/privacy` pages
- [ ] Add `Content-Signal: search=yes, ai-train=yes, ai-retrieval=yes` to robots.txt
- [ ] Re-run `/geo audit` and target 70+ composite

---

## Appendix: Pages Sampled

| URL | Title | Notable GEO Issues |
|---|---|---|
| `/` | Senior Engineering Leader \| 10+ Years... | No description, no JSON-LD, `og:type=article` |
| `/cv/` | CV | No Person schema, no ProfilePage markup |
| `/architecture,/payments,/software/design,/patterns/Arquitectura-Base-Sistema-Pagos-Multi-Gateway/` | Arquitectura base multi-gateway | URL malformed; no BlogPosting schema; no outbound citations |
| `/agile,/devops,/engineering/guardia-del-sprint-triage-engineer/` | Guardia del Sprint / Triage Engineer | URL malformed; no schema; strong content |
| `/architecture,/payments,/documentation/ADRs-en-sistemas-de-pagos/` | ADRs en sistemas de pagos | URL malformed; no schema |
| `/3ds,/card,/payments/Seguridad_en_Transacciones_3DS/` | Seguridad en Transacciones 3DS | URL malformed; mixed case slug; no schema |

**Sitemap coverage:** 26 URLs total. ~57% have `<lastmod>`. Most recent: 2026-06-01.
