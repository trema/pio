$LOAD_PATH.unshift File.join( File.dirname( __FILE__ ), "..", "lib" )

require "rubygems"

require "simplecov"
SimpleCov.start

require "rspec"
require "rspec/autorun"


RSpec.configure do | config |
  config.expect_with :rspec do | c |
    c.syntax = :expect
  end
end


# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[ "#{ File.dirname( __FILE__ ) }/support/**/*.rb" ].each do | each |
  require File.expand_path( each )
end


if ENV[ "TRAVIS" ]
  require "coveralls"
  Coveralls.wear!
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
