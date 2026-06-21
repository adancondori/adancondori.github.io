# GEO Audit Report (V2 — Post-Fix): adancondori.github.io

**Audit Date:** 2026-06-21
**URL:** https://adancondori.github.io/
**Business Type:** Personal Brand / Technical Publisher (Engineering Portfolio)
**Baseline audit date:** 2026-06-20 (previous score: 51/100)

---

## Executive Summary

**Overall GEO Score: 70/100 (Fair — Borderline Good) — Δ +19 vs. baseline**

In a single deploy cycle the site went from "AI-invisible despite great content" to a near-complete GEO foundation. Every mechanical gap from the V1 audit is now closed: schema is live and valid, llms.txt is comprehensive, robots.txt explicitly allows 18 AI crawlers with the IETF Content-Signal directive, og:type is correct per page, and `/about/` + `/privacy/` ground the entity. The biggest remaining gap is **off-site** — entity recognition outside GitHub — not on-site engineering.

### Score Delta

| Category | V1 Score | V2 Score | Δ | Weight | V2 Weighted |
|---|---|---|---|---|---|
| AI Citability | 65 | 75 | **+10** | 25% | 18.75 |
| Brand Authority | 22 | 38 | **+16** | 20% | 7.60 |
| Content E-E-A-T | 82 | 88 | **+6** | 20% | 17.60 |
| Technical GEO | 68 | 79 | **+11** | 15% | 11.85 |
| Schema & Structured Data | 5 | 78 | **+73** | 10% | 7.80 |
| Platform Optimization | 34 | 68 | **+34** | 10% | 6.80 |
| **Overall** | **51** | **70** | **+19** | | **70.40** |

The Schema jump (+73) and Platform jump (+34) carry most of the weighted impact — fixes that AI engines actually parse, not just human-facing polish.

---

## What Changed Between Audits

| Fix | Status | Impact |
|---|---|---|
| `/llms.txt` deployed (39 lines, topic-grouped) | LIVE | AI discovery file present; major Citability lift |
| `/robots.txt` with 18 explicit AI crawler User-agents | LIVE | Removes any ambiguity for GPTBot, ClaudeBot, PerplexityBot, etc. |
| `Content-Signal: search=yes, ai-train=yes, ai-retrieval=yes` | LIVE | Forward-compatible IETF AI Preferences signal |
| Person + WebSite + ProfilePage JSON-LD on homepage | LIVE | Entity now resolvable: name + jobTitle + worksFor + knowsAbout + sameAs |
| BlogPosting JSON-LD on every post | LIVE | Author Person with sameAs propagates to all 17+ posts |
| `<meta name="description">` + `<meta name="author">` | LIVE | SERP + AI snippet eligibility |
| `og:type` correct per page (profile / article / website) | LIVE | Was incorrectly `article` everywhere |
| Google Fonts: preconnect + display=swap | LIVE | Reduces render-blocking, modest LCP/CWV win |
| `/about/` page (first-person bio + editorial policy) | LIVE | Major Trustworthiness signal |
| `/privacy/` page (clear data practices) | LIVE | Closes the most-cited E-E-A-T gap |
| `article:published_time` / `article:modified_time` / `article:tag` | LIVE | Better social + AI parsing |

---

## High Priority Issues Remaining

| # | Issue | Where | Fix |
|---|---|---|---|
| H1 | **`articleSection` array is broken in BlogPosting JSON-LD** — commas baked in from category slugs (`["Architecture,","Payments,",...]`) | `_includes/_jsonld.html` | Strip trailing commas in the Liquid map before jsonify |
| H2 | **`publisher` in BlogPosting is a Person, not an Organization** | `_includes/_jsonld.html` | Add a self Organization (`@id: /#organization`) with logo ImageObject (≥600×60) and reference it as publisher — required for Google Article rich results |
| H3 | **Comma-separated category URLs** (`/architecture,/payments,/...`) | `_config.yml` permalink + post front matter | Switch to clean slugs `/posts/<slug>/` with `redirect_from` on each post |
| H4 | **No outbound primary-source citations** in long-form posts | All posts | Add 3-5 authoritative outbound links per post (Stripe docs, PCI-DSS, EMVCo 3DS spec, Brandur/Fowler) — your `/about/` editorial policy *promises* this; deliver on it |
| H5 | **Brand entity gap** — Wikipedia, dev.to/Medium, Reddit, StackOverflow, YouTube still empty | External | Cross-post top 3 articles to dev.to (English) with canonical → site; answer 5-10 SO questions on Stripe/3DS/payments |
| H6 | **No BreadcrumbList schema** on posts | `_layouts/post.html` | Easy win, post URLs already have category structure |

## Medium Priority

| # | Issue | Fix |
|---|---|---|
| M1 | `image` in JSON-LD is a bare URL, not ImageObject with width/height | Wrap as `{"@type":"ImageObject","url":"...","width":1200,"height":630}` |
| M2 | No `alumniOf` on Person schema (UAGRM master's) | Add `EducationalOrganization` reference |
| M3 | No TL;DR / answer-target block at top of posts | Insert 40-60 word summary div under H1 |
| M4 | No question-style H2s (`¿Qué es...?`, `How does...?`) on top posts | Rewrite section openers as questions (AIO/ChatGPT/Bing love this pattern) |
| M5 | No `last_modified_at` front matter on most posts → dateModified == datePublished | Add to front matter, surface "Updated:" in post header |
| M6 | No author-bio content block in post body footer (only sidebar via `_author-bio.html`) | Add ~60-word bio + photo + sameAs links at post end |
| M7 | Duplicate analytics (GTM + gtag + legacy `analytics.js`) | Pick GTM, drop the rest — INP win |
| M8 | Sitemap `<lastmod>` coverage ~57% | Backfill remaining 43% |
| M9 | Missing image `width`/`height` causes minor CLS | Add dimensions to inline `<img>` |
| M10 | Description on homepage 190 chars (slightly long) | Trim to 150-160 |
| M11 | No Bing Webmaster verification (`msvalidate.01`) + IndexNow key | Easy Bing Copilot win |

## Low Priority

| # | Issue | Fix |
|---|---|---|
| L1 | No `potentialAction` SearchAction in WebSite schema | Add when on-site search is wired |
| L2 | No Wikidata anchor in `sameAs` | Create after entity has more independent references |
| L3 | Inconsistent URL casing (`Linux-basic` vs lowercase) | Normalize to lowercase-kebab |
| L4 | FAQPage / HowTo schema unused | Optional — Google has deprecated FAQ rich snippets for most sites |

---

## Category Deep Dives

### AI Citability (75/100) — was 65

Crawler access went from "implicit allow" to "explicit best-in-class allowlist + IETF Content-Signal". llms.txt jumped from 404 to a 39-line, topic-grouped, summary-prefixed resource. Per-post BlogPosting + Person sameAs means every post now carries verifiable author identity — entity grounding for ChatGPT/Perplexity citations improves measurably even before any content rewrites.

**What didn't move:** content blocks themselves. Statistical density and answer-block structure remain mid-tier. JSON-LD helps machines understand *who* wrote it; passage rewrites would help them understand *what each passage answers*.

### Brand Authority (38/100) — was 22

Modest lift comes from `sameAs` declarations: AI models can now reconcile Adan Condori → GitHub + LinkedIn + Twitter + Google Scholar as one entity. Wikipedia: still NOT FOUND. Reddit/dev.to/Medium/SO/YouTube: still empty. **No further on-site work moves this needle** — the next +30 points are off-site: cross-posting on dev.to (English versions), LinkedIn article cadence, SO answers, and eventually a Wikidata stub.

### Content E-E-A-T (88/100) — was 82

| Dimension | V1 | V2 | Why |
|---|---|---|---|
| Experience | 23/25 | 23/25 | — |
| Expertise | 20/25 | 22/25 | `/about/` exposes credentials previously buried |
| Authoritativeness | 17/25 | 20/25 | `sameAs` to Scholar + LinkedIn + GitHub propagates per-post |
| Trustworthiness | 22/25 | 23/25 | `/privacy/` page + editorial policy close the visible-trust gap |

**Remaining drag:** No outbound citations to primary sources (your editorial policy promises them but posts don't deliver yet). No `last_modified_at`. No certifications listed.

### Technical GEO (79/100) — was 68

| Category | V1 | V2 | Note |
|---|---|---|---|
| SSR | 100 | 100 | — |
| Meta tags | 55 | 90 | description + author + og:* fixed |
| Crawlability | 65 | 88 | robots + Content-Signal + sitemap intact |
| Security headers | 30 | 25 | Still missing — GitHub Pages platform limit |
| CWV risk | 55 | 70 | Fonts optimized; image dims and analytics duplication still present |
| Mobile | 90 | 95 | — |
| URL structure | 50 | 60 | Unchanged (comma URLs still in place) |

### Schema & Structured Data (78/100) — was 5 **(+73)**

The biggest single delta in the audit. All three homepage entities (Person/WebSite/ProfilePage) cross-reference correctly via `@id`. BlogPosting is valid JSON, server-rendered, includes author Person + sameAs + speakable + inLanguage.

**Bugs to fix in your JSON-LD include:**
1. `articleSection` array contains commas: `["Architecture,","Payments,","Software","Design,","Patterns"]` — should be `["Architecture","Payments","Software Design","Patterns"]`
2. `publisher` should be Organization (with logo ImageObject) for Article rich result eligibility, not Person

### Platform Optimization (68/100) — was 34

| Platform | V1 | V2 | Notes |
|---|---|---|---|
| Google AI Overviews | 38 | 62 | Schema + author entity strong; still no question-H2/TL;DR pattern |
| ChatGPT Web Search | 35 | 74 | Strongest now — full crawler allowlist + Person/sameAs |
| Perplexity | 32 | 64 | Crawler + dateModified visible; community signals still flat |
| Gemini | 36 | 66 | Scholar sameAs propagated; no YouTube, no Knowledge Panel |
| Bing Copilot | 30 | 72 | Schema + meta lift; needs IndexNow + msvalidate.01 |

---

## Next 7 Days: High-ROI Punch List

1. **Fix the two BlogPosting schema bugs** (`articleSection` commas + Person→Organization publisher) — 10 min Liquid edit
2. **Add BreadcrumbList to post layout** — 15 min, pure win
3. **Add 3-5 outbound citations to your multi-gateway article** (Stripe docs, EMVCo 3DS spec, PCI-DSS) — 30 min, biggest single-post citability lift
4. **Set up Bing Webmaster Tools verification + IndexNow** — 20 min, only Bing Copilot fix you can ship before content work
5. **Cross-post the multi-gateway article to dev.to** (English summary + canonical link to original) — biggest brand-authority ROI

---

## Next 30 Days: Sustained Lift

### Week 1: Schema polish + URL cleanup discussion
- [ ] Fix the two BlogPosting bugs
- [ ] Add BreadcrumbList
- [ ] Convert `image` to ImageObject with width/height
- [ ] Decide on URL migration strategy (clean slugs + `redirect_from`)

### Week 2: Content depth
- [ ] Add TL;DR (40-60 words) under H1 on top 5 posts
- [ ] Convert top 3 H2s per post to question form ("¿Qué es idempotency en pagos?")
- [ ] Add 3-5 outbound citations per long-form post
- [ ] Add `last_modified_at` to front matter; surface "Updated:" in post header

### Week 3: Brand footprint
- [ ] Cross-post top 2 articles to dev.to (English) with canonical → site
- [ ] Publish 2 LinkedIn articles using existing pillar posts as basis
- [ ] Answer 3-5 Stack Overflow questions on Stripe/3DS/payments tagged with profile link
- [ ] Verify Bing Webmaster Tools + IndexNow key file

### Week 4: Platform polish
- [ ] Build `/payments/` topic hub page linking all payment posts (Gemini ecosystem lift)
- [ ] Consolidate analytics to GTM-only
- [ ] Add image width/height to top 5 most-trafficked posts
- [ ] Backfill `<lastmod>` on remaining sitemap entries
- [ ] Re-audit: target 80+ composite

---

## Appendix: V1 → V2 Verification

| Asset | V1 | V2 | Status |
|---|---|---|---|
| `/llms.txt` | 404 | 200, 39 lines | ✓ Live |
| `/robots.txt` user-agents | 0 explicit | 18 explicit | ✓ Live |
| `Content-Signal` directive | Absent | Present | ✓ Live |
| Homepage JSON-LD blocks | 0 | 1 (Person+WebSite+ProfilePage @graph) | ✓ Valid |
| Post JSON-LD blocks | 0 | 1 (BlogPosting) | ✓ Valid (2 minor bugs) |
| `<meta name="description">` on home | Missing | Present | ✓ Live |
| `og:type` correctness | Always "article" | Per-page (profile/article/website) | ✓ Live |
| Google Fonts loading | Render-blocking | preconnect + display=swap | ✓ Live |
| `/about/` page | 404 | 200 | ✓ Live |
| `/privacy/` page | Did not exist as site-level | 200 | ✓ Live |
| `sameAs` entity links | None | GitHub, LinkedIn, Twitter, Scholar | ✓ Live |
