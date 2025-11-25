# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.7'

# All runtime config comes from the UNIX environment
# but we use dotenv to store that in files for
# development and testing
gem 'dotenv-rails', groups: %i[development test]

# Brakeman analyzes our code for security vulnerabilities
gem 'brakeman'

# bundler-audit checks our dependencies for vulnerabilities
gem 'bundler-audit'

# lograge changes Rails' logging to a more
# traditional one-line-per-event format
gem 'lograge'

# Sidekiq handles background jobs
gem 'sidekiq'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '8.1.1'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 6.4.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use JSON Web Token (JWT) for token based authentication
gem 'jwt'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

group :development, :test do
  # RuboCop is a Ruby static code analyzer (a.k.a. linter) and code formatter
  gem 'rubocop'

  # An opinionated language server for Ruby
  gem 'ruby-lsp'

  # We use Factory Both in place of fixtures
  # to generate realistic test data
  gem 'factory_bot_rails'

  # Foreman runs all processes for local development
  gem 'foreman'

  # We use Faker to generate values for attributes
  # in each factor
  gem 'faker'

  gem 'rspec-rails', '~> 6.1.2'

  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows], require: false
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # for better debugging experience [https://github.com/deivid-rodriguez/pry-byebug]
  # use by adding `binding.pry` in your code as the breakpoint
  gem 'pry-byebug'
end
