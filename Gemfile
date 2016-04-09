source 'https://rubygems.org'

gem 'rails',                  '~> 4.2.5.1'
gem 'puma',                   '~> 2.16.0'
gem 'rails_12factor',         '~> 0.0.3',   group: :production

# Run locally using Procfile
gem 'foreman',                '~> 0.78.0',  group: :development

# Stats, measurements, reporting
gem 'skylight',               '~> 0.10.3',  group: :production
gem 'newrelic_rpm',           '~> 3.14.2',  group: :production
gem 'sentry-raven',           '~> 0.15.4',  group: :production

# DB, Query helpers
gem 'pg',                     '~> 0.18.4'
gem 'squeel',                 '~> 1.2.3'

# Worker model within a single process
gem 'sucker_punch',           '~> 2.0.0'

# DCI
gem 'playhouse',              '~> 0.1.1',   github: 'enspiral/playhouse'

# Assets
gem 'coffee-rails',           '~> 4.1.1'
gem 'jquery-rails',           '~> 4.1.0'
gem 'uglifier',               '~> 2.7.2'

gem 'sass-rails',             '~> 5.0.4'
gem 'autoprefixer-rails',     '~> 6.3.1'
gem 'materialize-sass',       '~> 0.97.5'

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

# Auth against external parties
gem 'omniauth',               '~> 1.3.1'
gem 'omniauth-google-oauth2', '~> 0.3.1'

# has_secure_password
gem 'bcrypt',                 '~> 3.1.10'

# Internal Authorization
gem 'cancancan',              '~> 1.13.1'

# Consuming external APIs
gem 'google-api-client',      '~> 0.9.1'
gem 'sendgrid',               '~> 1.2.4'
gem 'embedly',                '~> 1.9.1'

# Providing our API
gem 'doorkeeper',             '~> 3.1.0'
gem 'rack-cors',              '~> 0.4.0' # Allow cross origin requests
