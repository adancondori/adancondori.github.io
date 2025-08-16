# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Jekyll-based personal blog/portfolio website for Adan Condori, hosted on GitHub Pages. The site uses the Minimal Mistakes theme and contains technical blog posts about software architecture, design patterns, and development practices.

## Development Commands

### Local Development
```bash
# Install dependencies
bundle install

# Run Jekyll server locally
bundle exec jekyll serve

the proyect is dockerize start proyect with:
docker compose up

# Site will be available at http://127.0.0.1:4000
```

### Build Tasks (if using Grunt)
```bash
# Install Node dependencies
npm install

# Run Grunt tasks (JS minification, image optimization, etc.)
grunt
```

## Architecture & Structure

### Jekyll Site Structure
- **_posts/**: Blog posts in Markdown format (YYYY-MM-DD-title.md naming convention)
- **_layouts/**: Page templates (home, post, post-index, page, project-index)
- **_includes/**: Reusable HTML components
- **_data/**: YAML data files for site content (navigation, authors, projects, skills, etc.)
- **_sass/**: SCSS stylesheets organized by component
- **assets/**: Static assets (CSS, JS, fonts, images)
- **_site/**: Generated static site (do not edit directly)

### Key Configuration
- **_config.yml**: Main Jekyll configuration and site metadata
- Site URL: https://adancondori.github.io
- Uses kramdown markdown processor with rouge syntax highlighting
- Includes jekyll-sitemap plugin for SEO

### Content Management
- Blog posts should follow Jekyll front matter format
- Images for posts go in `images/post/`
- CV files are stored in `cv/` directory
- The site supports Disqus comments (configured in _config.yml)

### Theme Customization
- Based on Minimal Mistakes theme
- Custom SCSS in `_sass/` directory
- JavaScript in `assets/js/` (minified to scripts.min.js)
- Responsive design with mobile-first approach
