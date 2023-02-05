# Basic API-only Rails back end for User Auth
This repo is a template for a very basic but sustainable back end rails app with user auth already established. I created this because I kept looking for guides on how to make such a back end to get apps started and could not find one that I liked. Most use the [Devise gem](https://github.com/heartcombo/devise), which is great for non-API-only Rails apps, but has [issues](https://github.com/waiting-for-dev/devise-jwt/issues/235#issuecomment-1214414894) when the back end is API-only.

This repo is inspired by this [BlueBash.co](https://www.bluebash.co/blog/rails-6-7-api-authentication-with-jwt/) article. However, I have included extra gems, files, and commands to keep this back end sustainable. Overall structure is inspired (not 100% copied, just... mostly) by the ideology of [davetron5000](https://github.com/davetron5000)'s book: [Sustainable Web Development With Ruby on Rails: Practical Tips for Building Web Applications that Last](https://sustainable-rails.com/).

Strongly recommended that you have [Postgres.app](https://postgresapp.com/), [Homebrew](https://brew.sh/), and [Redis](https://redis.io/) installed on your system for best results as this is setup to take advantage of them.

**Note**: This is still a work in progress and I will be adding more to it in the coming weeks/months. Will be trying to keep it up to date as best I can.
- Current Top Level Tech Verisons:
  - Ruby: 3.2.0
  - Rails: 7.0.4.2
  - PostgreSQL: 14
  - Postgres.app: 2.5.12
## Tech
### `gem "dotenv-rails"` - [GitHub Page](https://github.com/bkeepers/dotenv)
- All runtime config comes from the UNIX environment but we use dotenv to store that in files for development and testing
- Shim to load environment variables from `.env` into `ENV` in development.
### `gem "pg"` - [GitHub Page](https://github.com/ged/ruby-pg)
- Because PostgreSQL. Use it. Love it.
### `gem "jwt"` - [GitHub Page](https://github.com/jwt/ruby-jwt)
- Quickly adds secure token-based authentication to Ruby projects.
### `gem "bcrypt"` - [GitHub Page](https://github.com/bcrypt-ruby/bcrypt-ruby)
- An easy way to keep your users' passwords secure.
- Use Active Model [has_secure_password](https://guides.rubyonrails.org/active_model_basics.html#securepassword)
### `gem "brakeman"` - [GitHub Page](https://github.com/presidentbeef/brakeman)
- Brakeman analyzes our code for security vulnurabilities.
### `gem "bundler-audit"` - [GitHub Page](https://github.com/rubysec/bundler-audit)
- Bundler-audit checks our dependencies for vulnurabilities.
### `gem "factory_bot_rails"` - [GitHub Page](https://github.com/thoughtbot/factory_bot_rails)
- We use Factory Bot in place of fixtures.
### `gem "foreman"` - [GitHub Page](https://github.com/ddollar/foreman)
- Foreman runs all processes for local development.
### `gem "faker"` - [GitHub Page](https://github.com/faker-ruby/faker)
- We use Faker to generate values for attributes in each factory.

## Setup
1. Pull down the app from version control
2. Make sure you have PostgreSQL running
3. `bin/setup`

## Running The Back End
### All-in-one command (useful for when you're only doing front end work)
- Make sure PostgreSQL is up and running
- `brew services start redis` - to first get Redis working, then
- `bin/run` - will run everything else for you, for easier debugging run things individually
### For a debugging/development experience, in a terminal tab/window each:
#### Rails server:
`rails s` - this is your rails server
#### Run Redis & Sidekiq for Background Jobs
- `brew services start redis` - Will start Redis
- `redis-cli ping` - test to see if Redis is running, expected output: `PONG`
- `bin/sidekiq` - Will start Sidekiq (for background jobs), will not start without Redis running
###### To stop Sidekiq & Redis
- `Ctrl+C` - to exit Sidekiq
- `brew services stop redis` - to stop Redis

### MailCatcher - For When You Want to Send Out Emails
- Do not add MailCatcher to your `Gemfile`, this will cause problems
- `gem install mailcatcher` as a system gem instead
- Add this to your `config/development.rb` file:
```
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = { :address => '127.0.0.1', :port => 1025 }
config.action_mailer.raise_delivery_errors = false
```

- See [MailCatcher](https://mailcatcher.me/) for more details
- Start MailCatcher with `mailcatcher`

## Tests and CI

1. `bin/ci` contains all the tests and checks for the app
2. `tmp/test.log` will use the production logging format *not* the development one
