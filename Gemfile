source 'https://rubygems.org'

# Jekyll - Latest stable version
gem 'jekyll', '~> 4.3.4'

# GitHub Pages supported plugins
gem 'jekyll-sitemap', '~> 1.4'
gem 'jekyll-feed', '~> 0.17'
gem 'jekyll-seo-tag', '~> 2.8'
gem 'jekyll-paginate', '~> 1.1'

# Required for Jekyll 4+ with Ruby 3+
gem 'webrick', '~> 1.8'

# Development dependencies
group :development do
  # Jekyll 4+ has built-in livereload support
  gem 'eventmachine', '~> 1.2', platforms: [:ruby]
  gem 'jekyll-include-cache', '~> 0.2'  # Solo para desarrollo local
end

# Windows and JRuby compatibility
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

# Performance booster for watching directories on Windows
gem "wdm", "~> 0.1", :platforms => [:mingw, :x64_mingw, :mswin]

# Lock `http_parser.rb` gem to `v0.6.x` on JRuby builds
gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]