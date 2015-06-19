require 'pio/monkey_patch/integer/base_conversions'
require 'pio/monkey_patch/integer/ranges'

# Monkey patch to Ruby's Integer class.
class Integer
  include MonkeyPatch::Integer::BaseConversions
  include MonkeyPatch::Integer::Ranges
end
