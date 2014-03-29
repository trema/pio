# encoding: utf-8

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

  gem.files = %w[CONTRIBUTING.md LICENSE Rakefile pio.gemspec]
  gem.files += Dir.glob('lib/**/*.rb')
  gem.files += Dir.glob('bin/**/*')
  gem.files += Dir.glob('spec/**/*')

  gem.require_paths = ['lib']

  gem.extra_rdoc_files = ['README.md']
  gem.test_files = Dir.glob('spec/**/*')

  gem.required_ruby_version = '>= 1.9.3'
  gem.add_dependency 'bindata', '~> 2.0.0'
  gem.add_development_dependency 'bundler', '~> 1.6.0'
end
