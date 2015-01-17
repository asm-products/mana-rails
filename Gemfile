source 'https://rubygems.org'
ruby "2.1.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.7'
gem 'rails-api'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0.beta1'
gem 'susy'
gem 'compass-rails', '~> 2.0.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'


# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc
# SLIM view template engine
gem 'slim'

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# API rete limiter
gem 'rack-throttle'

# Roles/Permissions
gem 'cancancan', '~> 1.9'

# Bachround Jobs
gem 'resque'

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'guard-rspec', require: false
end

group :test do
  gem 'machinist'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'shoulda-matchers'
end

group :production do
  gem 'pg',             '0.17.1'
  gem 'rails_12factor', '0.0.2'
  gem 'unicorn',        '4.8.3'
end

# Semver versioning for the api
gem 'semver2'

# Normalize phone numbers
# NOTE: this gem must come after mongoid
gem 'phony_rails'

# Pagination
gem 'will_paginate', '~> 3.0.6'

