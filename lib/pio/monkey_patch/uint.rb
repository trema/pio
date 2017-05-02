# frozen_string_literal: true

require 'bindata'
require 'pio/monkey_patch/uint/base_conversions'

# BinData's base module
module BinData
  Uint8.__send__ :include, MonkeyPatch::Uint::BaseConversions
  Uint16be.__send__ :include, MonkeyPatch::Uint::BaseConversions
  Uint32be.__send__ :include, MonkeyPatch::Uint::BaseConversions
end
