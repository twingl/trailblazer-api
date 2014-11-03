source 'https://rubygems.org'

ruby '2.1.2'

gem 'rails', '~> 4.1.1'
gem 'pg'
gem 'foreman'
gem 'puma'
gem 'skylight'

# Query helpers
gem 'squeel'

# Config, Utility
gem 'figaro'
gem 'guard'
gem 'guard-livereload'
gem 'rails_12factor', :group => :production

group :development, :test do
  gem 'pry',     '~> 0.9.12'
  gem 'pry-nav', '~> 0.2.3'
end

# DCI
gem 'playhouse', '~> 0.1.1', :github => 'enspiral/playhouse'

# Assets
gem 'sass-rails',   '~> 4.0.3'
gem 'uglifier',     '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'

# Testing
group :development, :test do
  gem 'rspec-rails', '~> 3.0.1'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'shoulda-matchers', '~> 2.6.1'
end

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# External Auth
gem 'omniauth',               '~> 1.2.1'
gem 'omniauth-google-oauth2', '~> 0.2.4'

# has_secure_password
gem 'bcrypt-ruby', '~> 3.1.5'

# Internal Authorization
gem 'cancancan', '~> 1.8.4'

# External APIs
gem 'google-api-client', '~> 0.7.1', :require => 'google/api_client'
gem 'sendgrid'
gem 'embedly'

# Browser API provider
gem 'doorkeeper', '~> 1.3.1'
gem 'rack-cors',  '~> 0.2.9' # Allow cross origin requests

# Worker model
gem 'resque', '~> 1.25.2'
