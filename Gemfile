source 'https://rubygems.org'

gem 'rails',                  '~> 4.2'
gem 'puma'
gem 'rails_12factor',                       group: :production

# Run locally using Procfile
gem 'foreman',                              group: :development

# Stats, measurements, reporting
gem 'sentry-raven',                         group: :production

# DB, Query helpers
gem 'pg'
gem 'squeel'

# Worker model within a single process
gem 'sucker_punch'

# DCI
gem 'playhouse',              '~> 0.1.1',   github: 'enspiral/playhouse'

# Assets
gem 'coffee-rails'
gem 'jquery-rails'
gem 'uglifier'

gem 'sass-rails'
gem 'autoprefixer-rails'
gem 'materialize-sass'

# Breadcrumbs for the web UI
gem 'gretel',                 '~> 3.0.8'

# Custom error pages
gem 'gaffe',                  '~> 1.0.2'

# Testing, Config, Utility
group :development, :test do
  gem 'dotenv-rails',         '~> 2.1.0'
  gem 'guard',                '~> 2.13.0'
  gem 'guard-livereload',     '~> 2.5.2'

  gem 'rspec-rails',          '~> 3.4.2'
  gem 'factory_girl_rails',   '~> 4.6.0'
  gem 'shoulda-matchers',     '~> 3.1.1'
  gem 'pry',                  '~> 0.10.3'
  gem 'pry-nav',              '~> 0.2.4'
end

gem 'database_cleaner', group: :test

# Auth against external parties
gem 'omniauth',               '~> 1.3.1'
gem 'omniauth-google-oauth2', '~> 0.3.1'

# has_secure_password
gem 'bcrypt',                 '~> 3.1.10'

# Internal Authorization
gem 'cancancan',              '~> 1.13.1'

# Consuming external APIs
gem 'sendgrid',               '~> 1.2.4'
gem 'embedly',                '~> 1.9.1'

# Providing our API
gem 'doorkeeper',             '~> 3.1.0'
gem 'rack-cors',              '~> 0.4.0' # Allow cross origin requests
