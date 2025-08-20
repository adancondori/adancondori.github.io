# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Jekyll-based personal blog/portfolio website for Adan Condori, hosted on GitHub Pages. The site uses the Minimal Mistakes theme and contains technical blog posts about software architecture, design patterns, payment gateways, and development practices.

## Development Commands

### Local Development with Docker (Recommended)
```bash
# Start the project with Docker Compose
docker compose up

# Run in detached mode
docker compose up -d

# View logs
docker logs adancondorigithubio-jekyll-1

# Stop containers
docker compose down

# Site will be available at http://localhost:4000
```

**Note**: The Dockerfile uses Ruby 2.7 and installs Jekyll within the container. There may be platform compatibility issues (linux/amd64 vs linux/arm64).

### Local Development without Docker
```bash
# Install dependencies
bundle install

# Run Jekyll server locally
bundle exec jekyll serve --host 0.0.0.0

# Site will be available at http://127.0.0.1:4000
```

### Build Tasks (Grunt)
```bash
# Install Node dependencies
npm install

# Run Grunt tasks (JS minification, image optimization, etc.)
grunt

# Available Grunt tasks:
# - grunt-contrib-uglify: JS minification
# - grunt-contrib-imagemin: Image optimization
# - grunt-svgmin: SVG optimization
# - grunt-contrib-watch: File watching
```

## Architecture & Structure

### Jekyll Site Structure
- **_posts/**: Blog posts in Markdown format (YYYY-MM-DD-title.md naming convention)
  - Recent topics: Payment gateways (Stripe, PayPal), 3DS security, AWS migration, Clean Code, Linux, Design Patterns
- **_layouts/**: Page templates
  - `home.html`: Homepage layout
  - `post.html`: Blog post layout
  - `post-index.html`: Blog listing page
  - `page.html`: Generic page layout
  - `project-index.html`: Projects listing
- **_includes/**: Reusable HTML components
  - `_about.html`, `_author-bio.html`, `_contact.html`
  - `_skills.html`, `_work.html`, `_education.html`
  - `_projects.html`, `_awards.html`, `_references.html`
  - Navigation, footer, scripts, and analytics components
- **_data/**: YAML data files for site content
  - `navigation.yml`: Site navigation structure
  - `authors.yml`: Author information
  - `projects.yml`: Portfolio projects
  - `skills.yml` & `skill_captions.yml`: Technical skills
  - `work.yml`: Work experience
  - `edu.yml`: Education history
  - `social.yml`: Social media links
  - `contact.yml`: Contact information
- **_sass/**: SCSS stylesheets organized by component
  - Core styles: `normalize.scss`, `variables.scss`, `mixins.scss`
  - Layout: `page.scss`, `grid.scss`, `elements.scss`
  - Syntax highlighting: `pygments.scss`, `coderay.scss`
  - Typography and forms
- **assets/**: Static assets
  - `css/main.scss`: Main stylesheet entry point
  - `js/`: JavaScript files and vendor libraries
  - `fonts/`: FontAwesome icon fonts
  - Third-party: jQuery, Magnific Popup, FitVids
- **images/**: Image assets
  - `banners/`: Banner images for posts
  - `post/`: Post-specific images
  - Profile and CV images
- **cv/**: PDF resume files
- **files/**: Additional downloadable resources
- **_site/**: Generated static site (do not edit directly - gitignored)

### Key Configuration
- **_config.yml**: Main Jekyll configuration
  - Site URL: https://adancondori.github.io
  - Owner: Adan Condori C.
  - Theme: Minimal Mistakes (mint skin)
  - Markdown processor: kramdown
  - Syntax highlighter: rouge
  - Plugins: jekyll-sitemap
  - Disqus comments enabled (shortname: acondori)
  - Social profiles: GitHub, Twitter, LinkedIn, etc.

### Docker Configuration
- **docker-compose.yml**: Simple setup with Jekyll service
  - Builds from local Dockerfile
  - Mounts current directory to `/app`
  - Exposes port 4000
- **Dockerfile**: Ruby 2.7 base image
  - Installs Node.js for asset compilation
  - Runs `bundle install` for Jekyll dependencies
  - Default command: `jekyll serve --host 0.0.0.0`

### Dependencies
- **Ruby Gems** (Gemfile):
  - jekyll: Static site generator
  - jekyll-sitemap: SEO sitemap generation
  - octopress: Additional Jekyll tools
  - webrick: Web server for Ruby 3+
- **Node Packages** (package.json):
  - Grunt and various plugins for asset optimization

### Content Management
- Blog posts must follow Jekyll front matter format:
  ```yaml
  ---
  layout: post
  title: Post Title
  categories: Category1, Category2
  excerpt: Brief description
  tags: []
  date: YYYY-MM-DDTHH:MM:SS-TZ:00
  ---
  ```
- Images for posts go in `images/post/`
- CV files are stored in `cv/` directory
- The site supports Disqus comments (configured in _config.yml)

### Theme Customization
- Based on Minimal Mistakes theme
- Custom SCSS in `_sass/` directory
- JavaScript in `assets/js/` (minified to scripts.min.js)
- Responsive design with mobile-first approach
- Available theme skins: mint (current), air, aqua, contrast, dark, dirt, neon, plum, sunrise

### Common Issues & Solutions

1. **Docker Container Exits**: Check logs with `docker logs adancondorigithubio-jekyll-1`
2. **SCSS Compilation Errors**: May be related to sass-embedded gem compatibility
3. **Platform Warnings**: The Docker image is built for linux/amd64, may show warnings on ARM64 (M1/M2 Macs)
4. **Port Already in Use**: Ensure no other service is using port 4000

### Testing & Validation
```bash
# Check for broken links
bundle exec jekyll build
bundle exec htmlproofer ./_site

# Validate HTML
bundle exec jekyll build
bundle exec htmlproofer ./_site --check-html
```

## Important Instructions
- Do what has been asked; nothing more, nothing less
- NEVER create files unless they're absolutely necessary for achieving your goal
- ALWAYS prefer editing an existing file to creating a new one
- NEVER proactively create documentation files (*.md) or README files unless explicitly requested
- The _site directory is auto-generated - never edit files there directly
- Follow existing code style and conventions when making changes
- Use existing components and layouts when adding new features