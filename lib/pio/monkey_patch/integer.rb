require 'pio/monkey_patch/integer/ranges'

# Monkey patch to Ruby's Integer class.
class Integer
  include MonkeyPatch::Integer::Ranges
end
