source "https://rubygems.org"

ruby "3.2.2"

# Rails framework
gem "rails", "~> 7.1.3", ">= 7.1.3.3"

# Asset pipeline
gem "sprockets-rails"

# Database
gem "sqlite3", "~> 1.4"

# Web server
gem "puma", ">= 5.0"

# JavaScript
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

# JSON APIs
gem "jbuilder"

# UI frameworks
gem 'bootstrap', '~> 5.1'
gem 'jquery-rails'

# Stylesheets
gem 'sassc-rails'

# Faker for generating fake data
gem 'faker'

# Pry for debugging
gem 'pry'

# Password encryption
gem "bcrypt", "~> 3.1.7"

# Windows timezone data
gem "tzinfo-data", platforms: %i[windows jruby]

# Speed up boot times
gem "bootsnap", require: false

group :development, :test do
  # RSpec for testing
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'database_cleaner'

  # Web console for debugging
  gem "web-console"

  # Rack mini profiler for speed badges
  # gem "rack-mini-profiler"

  # Spring for speeding up commands
  # gem "spring"
end

group :test do
  # Capybara for system testing
  gem "capybara"
  gem "selenium-webdriver"
end
