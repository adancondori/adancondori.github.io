# Cloudflare Setup — Closing the Security-Header Gap

## Why

GitHub Pages does not emit security headers (HSTS, CSP, X-Frame-Options, X-Content-Type-Options, Referrer-Policy, Permissions-Policy). This costs ~10 points in the Technical GEO category and ~5 points in Platform Optimization (Bing Copilot weights security signals).

The only way to fix this on GitHub Pages without moving to a different host is to put Cloudflare in front of `adancondori.github.io` as a reverse proxy. Cloudflare's free tier supports everything below.

Estimated time: **30 minutes one-time**.

---

## Steps

### 1. Sign up at https://dash.cloudflare.com/sign-up

Free tier. No credit card required.

### 2. Add a site — Custom Domain Required

Cloudflare requires a custom domain (it won't proxy `adancondori.github.io` directly). If you don't already have a custom domain, register one (e.g., `adancondori.dev` or `condori.engineer`) — Cloudflare Registrar sells at-cost (~$10/year for .dev).

### 3. Point custom domain at GitHub Pages via DNS

In the Cloudflare DNS panel, add:

```
Type   Name   Content                        Proxy
CNAME  @      adancondori.github.io          Proxied (orange cloud)
CNAME  www    adancondori.github.io          Proxied
```

### 4. Add CNAME file to repo

```bash
echo "adancondori.dev" > CNAME
git add CNAME && git commit -m "Add custom domain CNAME"
git push
```

GitHub Pages will detect this and serve the site at `adancondori.dev`. The `*.github.io` URL stays valid (Pages redirects).

### 5. Configure Cloudflare → SSL/TLS

- **Encryption mode:** Full (Strict)
- **Always Use HTTPS:** On
- **HTTP Strict Transport Security (HSTS):** Enable (preload-eligible: max-age=31536000, include subdomains, preload)

### 6. Configure Cloudflare → Rules → Transform Rules → Modify Response Header

Add a rule for the entire site (`hostname matches "adancondori.dev"`) with these headers:

| Header | Value |
|---|---|
| `Strict-Transport-Security` | `max-age=31536000; includeSubDomains; preload` |
| `X-Frame-Options` | `SAMEORIGIN` |
| `X-Content-Type-Options` | `nosniff` |
| `Referrer-Policy` | `strict-origin-when-cross-origin` |
| `Permissions-Policy` | `camera=(), microphone=(), geolocation=(), interest-cohort=()` |
| `Content-Security-Policy` | See below |

### 7. CSP value

Start with this report-only policy. Move to enforced after a week of monitoring.

```
default-src 'self'; img-src 'self' https: data:; script-src 'self' https://www.googletagmanager.com https://www.google-analytics.com 'unsafe-inline'; style-src 'self' https://fonts.googleapis.com 'unsafe-inline'; font-src 'self' https://fonts.gstatic.com data:; connect-src 'self' https://www.google-analytics.com; frame-src https://disqus.com https://*.disqus.com; base-uri 'self'; form-action 'self'
```

Use `Content-Security-Policy-Report-Only` first; if no errors after 7 days, switch to `Content-Security-Policy`.

### 8. Cloudflare → Speed → Optimization

- **Auto Minify** (HTML/CSS/JS): Enable
- **Brotli:** Enable
- **Early Hints:** Enable
- **Rocket Loader:** Off (interferes with Jekyll-rendered analytics)

### 9. Update site URLs

After custom domain is live, update `_config.yml`:

```yaml
url: https://adancondori.dev   # was: https://adancondori.github.io
```

And update `sameAs`, `llms.txt`, and `BRAND-AUTHORITY-PLAN.md` to use the new canonical.

GitHub Pages will continue redirecting `adancondori.github.io` → `adancondori.dev` permanently. SEO equity transfers via 301.

### 10. Submit new domain to Google / Bing Search Console

- Google Search Console: add the new property + verify via Cloudflare DNS TXT
- Bing Webmaster Tools: same, plus paste the `msvalidate.01` code into `_config.yml` `site.owner.bing-verify:`

---

## Expected Impact

| Category | Before | After Cloudflare |
|---|---|---|
| Technical GEO | 85 | 95+ |
| Platform Optimization | 82 | 88 |
| Composite | 80 | 82-83 |

Plus CDN performance: ~30% faster TTFB outside Brazil/US East.

---

## What if you don't want a custom domain?

Then security headers stay missing. The Technical GEO ceiling is ~85 without Cloudflare in front. That's a real but capped cost — every other category can still hit its on-site max.
