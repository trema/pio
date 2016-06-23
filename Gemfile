source 'https://rubygems.org'

gemspec

# Rake 11.0.0 is broken
gem 'rake', '10.5.0'

group :development do
  gem 'pry', require: false
end

group :test do
  gem 'aruba', require: false
  gem 'cucumber', require: false
  gem 'rspec', require: false
  gem 'rspec-given', require: false
end

group :guard do
  gem 'guard', require: false
  gem 'guard-bundler', require: false
  gem 'guard-cucumber', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false
  gem 'terminal-notifier-guard', require: false
  # To support Ruby 2.1; Listen 3.1.0 or later does not run on Ruby 2.1
  gem 'listen', '< 3.1.0', require: false
end

group :metrics do
  gem 'codeclimate-test-reporter', require: false
  gem 'coveralls', require: false
  gem 'flay', require: false
  gem 'flog', require: false
  # Reek dropped Ruby2.0 compatibility
  gem 'reek', require: false, platforms: [:ruby_21, :ruby_22, :ruby_23]
  gem 'rubocop', require: false
end

group :doc do
  gem 'inch', require: false
  gem 'relish', require: false
  gem 'yard', require: false
end
