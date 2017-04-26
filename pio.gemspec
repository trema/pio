lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pio/version'

Gem::Specification.new do |gem|
  gem.name = 'pio'
  gem.version = Pio::VERSION
  gem.summary = 'Packet parser and generator.'
  gem.description = 'Pure ruby packet parser and generator.'

  gem.licenses = %w(GPLv2 MIT)

  gem.authors = ['Yasuhito Takamiya']
  gem.email = ['yasuhito@gmail.com']
  gem.homepage = 'http://github.com/trema/pio'

  gem.files = %w(CONTRIBUTING.md LICENSE Rakefile pio.gemspec)
  gem.files += Dir.glob('lib/**/*.rb')
  gem.files += Dir.glob('spec/**/*')

  gem.require_paths = ['lib']

  gem.extra_rdoc_files = %w(README.md CHANGELOG.md LICENSE CONTRIBUTING.md)
  gem.test_files = Dir.glob('spec/**/*')
  gem.test_files += Dir.glob('features/**/*')

  gem.required_ruby_version = '>= 2.2.2'

  gem.add_dependency 'bindata', '~> 2.1.0'
  gem.add_dependency 'activesupport', '~> 5.0.2'
end
