# Use Ruby 3.3 Alpine for smaller image size and better security
FROM ruby:3.3-alpine

# Install dependencies for Jekyll and native extensions
RUN apk add --no-cache \
    build-base \
    git \
    nodejs \
    npm \
    libffi-dev \
    libxml2-dev \
    libxslt-dev

# Set working directory
WORKDIR /app

# Copy Gemfile first
COPY Gemfile ./

# Create empty Gemfile.lock if it doesn't exist
RUN touch Gemfile.lock

# Install Ruby dependencies
RUN bundle install --jobs 4 --retry 3

# Copy package.json for Node dependencies (if needed)
COPY package*.json ./

# Install Node dependencies (if package-lock.json exists, otherwise skip)
RUN if [ -f "package-lock.json" ]; then npm ci; elif [ -f "package.json" ]; then npm install; fi

# Copy the rest of the application
COPY . .

# Expose Jekyll default port
EXPOSE 4000

# Run Jekyll with live reload and host binding
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--livereload", "--force_polling", "--config", "_config.yml,_config.dev.yml"]