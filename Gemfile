# encoding: utf-8

source 'https://rubygems.org'

gem 'rake', '~> 10.2.2'

group :docs do
  gem 'inch', '~> 0.3.3'
  gem 'yard', '~> 0.8.7.4'
end

group :development do
  gem 'byebug', '~> 2.7.0', platforms: :ruby_20
  gem 'guard', '~> 2.6.0'
  gem 'guard-bundler', '~> 2.0.0'
  gem 'guard-cucumber', '~> 1.4.1'
  gem 'guard-rspec', '~> 4.2.8'
  gem 'guard-rubocop', '~> 1.0.2'
  gem 'pry', '~> 0.9.12.6'
  gem 'rb-fchange', '~> 0.0.6', require: false
  gem 'rb-fsevent', '~> 0.9.4', require: false
  gem 'rb-inotify', '~> 0.9.3', require: false
  gem 'terminal-notifier-guard', '~> 1.5.3'
end

group :test do
  gem 'coveralls', '~> 0.7.0', require: false
  gem 'cucumber', '~> 1.3.14'
  gem 'flay', '~> 2.4.0'
  gem 'flog', '~> 4.2.0'
  gem 'fuubar', '~> 1.3.2'
  gem 'reek', '~> 1.3.7'
  gem 'rspec', '~> 2.14.1'
  gem 'rspec-given', '~> 3.5.4'
  gem 'rubocop', '~> 0.19.1', platforms: [:ruby_19, :ruby_20, :ruby_21]
end

gemspec
