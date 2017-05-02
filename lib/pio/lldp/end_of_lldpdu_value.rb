# frozen_string_literal: true

require 'bindata'

module Pio
  class Lldp
    # End Of LLDPDU
    class EndOfLldpduValue < BinData::Record
      endian :big

      stringz :tlv_info_string, length: 0, value: ''
    end
  end
end
