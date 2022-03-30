# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'dotenv', '~> 2.1'

group :development, :test do
  gem 'rspec', '~> 3.11'
  gem 'vcr', '~> 3.0', '>= 3.0.1'
  gem 'webmock', '~> 3.14'
end

group :development do
  gem 'rubocop', '~> 1.17', require: false
end

group :test do
  gem 'simplecov'
end
