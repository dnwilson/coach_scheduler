source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.6"

gem "jsonapi-serializer"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rack-cors"

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "faker"
  gem "factory_bot_rails"
  gem "guard-rspec"
  gem "pry-byebug"
  gem "rspec-rails"
end