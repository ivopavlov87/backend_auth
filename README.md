# Basic API-only Rails back end for User Auth
This repo is a template for a very basic but sustainable back end rails app with user auth already established. I created this because I kept looking for guides on how to make such a back end to get apps started and could not find one that I liked. Most use the [Devise gem](https://github.com/heartcombo/devise), which is great for non-API-only Rails apps, but has [issues](https://github.com/waiting-for-dev/devise-jwt/issues/235#issuecomment-1214414894) when the back end is API-only.

This repo is inspired by this [BlueBash.co](https://www.bluebash.co/blog/rails-6-7-api-authentication-with-jwt/) article. However, I have included extra gems, files, and commands to keep this back end sustainable. Overall structure is inspired (not 100% copied, just... mostly) by the ideology of [davetron5000](https://github.com/davetron5000)'s book: [Sustainable Web Development With Ruby on Rails: Practical Tips for Building Web Applications that Last](https://sustainable-rails.com/).

Strongly recommended that you have [Postgres.app](https://postgresapp.com/), [Homebrew](https://brew.sh/), and [Redis](https://redis.io/) installed on your system for best results as this is configured to take advantage of them.

**Note**: This is not a complete work, and this is meant to be a template. Feel free to clone this repo and use it as boiler-plate code.

##### Current Top Level Tech Verisons:
  - Ruby: 3.3.0
  - Rails: 7.1.3.3
  - PostgreSQL: 16
  - Postgres.app: 2.7.3
## Notable Gems
### `dotenv-rails` - [GitHub Page](https://github.com/bkeepers/dotenv)
- All runtime config comes from the UNIX environment but we use dotenv to store that in files for development and testing
- Shim to load environment variables from `.env` into `ENV` in development.
### `pg` - [GitHub Page](https://github.com/ged/ruby-pg)
- Because PostgreSQL. Use it. Love it. The gold standard of SQL.
### `jwt` - [GitHub Page](https://github.com/jwt/ruby-jwt)
- Quickly adds secure token-based authentication to Ruby projects.
### `bcrypt` - [GitHub Page](https://github.com/bcrypt-ruby/bcrypt-ruby)
- An easy way to keep your users' passwords secure.
- Use Active Model [has_secure_password](https://guides.rubyonrails.org/active_model_basics.html#securepassword)
### `brakeman` - [GitHub Page](https://github.com/presidentbeef/brakeman)
- Brakeman analyzes our code for security vulnurabilities.
### `bundler-audit` - [GitHub Page](https://github.com/rubysec/bundler-audit)
- Bundler-audit checks our dependencies for vulnurabilities.
### `factory_bot_rails` - [GitHub Page](https://github.com/thoughtbot/factory_bot_rails)
- We use Factory Bot in place of fixtures.
### `foreman` - [GitHub Page](https://github.com/ddollar/foreman)
- Foreman runs all processes for local development.
### `faker` - [GitHub Page](https://github.com/faker-ruby/faker)
- We use Faker to generate values for attributes in each factory.
### `rspec-rails` - [GitHub Page](https://github.com/rspec/rspec-rails)
- We use RSpec to run the tests.
### `ruby-lsp` - [GitHub Page](https://github.com/Shopify/ruby-lsp)
- An opinionated language server for Ruby. Used to improve rich features in editors.

## Setup
1. Pull down the app from version control
2. Make sure you have PostgreSQL running
3. Run `bin/setup` - this will:
  a. Perform `bundle check || bundle install` for gems
  b. Get your development database up and running, and migrated
  c. Seed your database from `seeds.rb`
  d. Setup test database
4. To overwrite environment variables, make a `.env.<environment_name>.local` file at the top-level and define them in there.


## Running The Back End
### All-in-one command (useful for when you're only doing front end work)
- Make sure PostgreSQL is up and running, then run `bin/run`
- This will:
  - Re/build the [Procfile.dev](https://judoscale.com/guides/six-tips-for-mastering-your-procfile)
  - Check if Redis is running and if not, start Redis (`brew start services redis`)
  - start Sidekiq (`bin/sidekiq`) via the generated Profile
- To shut things down and exit, use `Ctrl+C`
- `brew services stop redis` - to stop Redis as last step
### For a debugging/development experience
- Make sure Postgres is running, next step will fail if not.
- For code, breakpoint is `binding.pry` (preferred), or `debugger`
- To use request logging:
  - add `require "logging/logs"` to a file at the top
  - add `include Logging::Logs` to the class
  - example: `log @user.as_json, "something happened"`
  - **Caution**: leaving this in your deployed/production code could expose sensitive information
#### In a terminal tab/window each:
##### Rails server:
- `rails s` - this starts your rails server
- `Ctrl+C` - to stop the server
##### Run Redis & Sidekiq for Background Jobs
- `brew services start redis` - Will start Redis
- `redis-cli ping` - test to see if Redis is running, expected output: `PONG`
- `bin/sidekiq` - Will start Sidekiq (for background jobs), will not start without Redis running
- `Ctrl+C` - to exit Sidekiq
- `brew services stop redis` - to stop Redis

### MailCatcher - For When You Want to Send Out Emails
- Do not add MailCatcher to your `Gemfile`, this will cause problems
- `gem install mailcatcher` as a system gem instead
- See [MailCatcher](https://mailcatcher.me/) for more details
- Start MailCatcher with `mailcatcher`
- Access MailCatcher by going to `http://127.0.0.1:1080/` in your browser
- Quit/Stop MailCatcher via the User Interface

## Tests and CI

1. `bin/ci` contains all the tests and checks for the app
2. `tmp/test.log` will use the production logging format *not* the development one
3. To run just RSpec tests, use `bundle exec rspec`
