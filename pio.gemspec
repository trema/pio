lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pio/version'

Gem::Specification.new do |gem|
  gem.name = 'pio'
  gem.version = Pio::VERSION
  gem.summary = 'Packet parser and generator.'
  gem.description = 'Pure ruby packet parser and generator.'

  gem.license = 'GPL3'

  gem.authors = ['Yasuhito Takamiya']
  gem.email = ['yasuhito@gmail.com']
  gem.homepage = 'http://github.com/trema/pio'

  gem.files = %w(CONTRIBUTING.md LICENSE Rakefile pio.gemspec)
  gem.files += Dir.glob('lib/**/*.rb')
  gem.files += Dir.glob('bin/**/*')
  gem.files += Dir.glob('spec/**/*')
  gem.files += Dir.glob('examples/**/*')

  gem.require_paths = ['lib']

  gem.extra_rdoc_files = %w(README.md CHANGELOG.md LICENSE CONTRIBUTING.md)
  gem.test_files = Dir.glob('spec/**/*')
  gem.test_files += Dir.glob('features/**/*')

  gem.required_ruby_version = '>= 2.0.0'

  gem.add_dependency 'bindata', '~> 2.1.0'
  gem.add_dependency 'activesupport', '~> 4.2', '>= 4.2.4'

  gem.add_development_dependency 'bundler', '~> 1.10.6'
  gem.add_development_dependency 'pry', '~> 0.10.3'
  gem.add_development_dependency 'rake'

  # Guard
  gem.add_development_dependency 'guard', '~> 2.13.0'
  gem.add_development_dependency 'guard-bundler', '~> 2.1.0'
  gem.add_development_dependency 'guard-cucumber', '~> 1.6.0'
  gem.add_development_dependency 'guard-rspec', '~> 4.6.4'
  gem.add_development_dependency 'guard-rubocop', '~> 1.2.0'
  gem.add_development_dependency 'rb-fchange', '~> 0.0.6'
  gem.add_development_dependency 'rb-fsevent', '~> 0.9.6'
  gem.add_development_dependency 'rb-inotify', '~> 0.9.5'
  gem.add_development_dependency 'terminal-notifier-guard', '~> 1.6.4'

  # Docs
  gem.add_development_dependency 'inch', '~> 0.7.0'
  gem.add_development_dependency 'relish', '~> 0.7.1'
  gem.add_development_dependency 'yard', '~> 0.8.7.6'

  # Test
  gem.add_development_dependency 'codeclimate-test-reporter', '~> 0.4.8'
  gem.add_development_dependency 'coveralls', '~> 0.8.3'
  gem.add_development_dependency 'cucumber', '~> 2.1.0'
  gem.add_development_dependency 'flay', '~> 2.6.1'
  gem.add_development_dependency 'flog', '~> 4.3.2'
  gem.add_development_dependency 'reek', '~> 3.6.0'
  gem.add_development_dependency 'rspec', '~> 3.3.0'
  gem.add_development_dependency 'rspec-given', '~> 3.7.1'
  gem.add_development_dependency 'rubocop', '~> 0.34.2'
end
