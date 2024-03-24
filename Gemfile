source "https://rubygems.org"

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
gem "pg_party", "~> 1.6"
gem 'pg_search'

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

gem "view_component"
gem "haml-rails", "~> 2.0"
gem "html2haml"

gem "devise", "~> 4.9"

# Pagination
gem "pagy", "~> 6.4"

# Payment
gem "stripe", "~> 10.2"

# Sidekiq
gem "sidekiq", "~> 7.2"
gem "sidekiq-failures", "~> 1.0"
gem "sidekiq-scheduler", "~> 5.0"
gem "sidekiq-limit_fetch", "~> 4.4"

# Comunication
gem 'httparty'

# Data Analysis
gem 'chartkick'
gem 'groupdate'
gem 'i18n_data'

# Translations
gem 'i18n-js'


group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]

  # Email Tester
  gem "letter_opener"
  gem 'letter_opener_web', '~> 2.0'

  #Data
  gem 'faker'

  gem 'dotenv'
end

group :development do
  gem "web-console"
  gem 'i18n-tasks', '~> 1.0.13'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end
