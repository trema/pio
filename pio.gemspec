lib = File.expand_path( "../lib", __FILE__ )
$LOAD_PATH.unshift( lib ) unless $LOAD_PATH.include?( lib )
require "pio/version"


Gem::Specification.new do | gem |
  gem.name = "pio"
  gem.version = Pio::VERSION
  gem.summary = "Packet parser and generator."
  gem.description = "Pure ruby packet parser and generator."

  gem.license = "GPL3"

  gem.authors = [ "Yasuhito Takamiya" ]
  gem.email = [ "yasuhito@gmail.com" ]
  gem.homepage = "http://github.com/trema/pio"

  gem.files = `git ls-files`.split( "\n" )

  gem.require_paths = [ "lib" ]

  gem.extra_rdoc_files = [ "README.md" ]
  gem.test_files = `git ls-files -- {spec,features}/*`.split( "\n" )

  gem.add_dependency "bindata", "~> 1.6.0"
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
