require 'bindata'
require 'pio/monkey_patch/uint/base_conversions'

# BinData's base module
module BinData
  Uint8.include MonkeyPatch::Uint::BaseConversions
  Uint16be.include MonkeyPatch::Uint::BaseConversions
  Uint32be.include MonkeyPatch::Uint::BaseConversions
end
