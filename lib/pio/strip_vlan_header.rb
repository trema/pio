require 'bindata'

module Pio
  # An action to strip the 802.1q header.
  class StripVlanHeader < BinData::Record
    endian :big

    uint16 :type, value: 3
    uint16 :message_length, value: 8
    uint32 :padding
    hide :padding

    alias_method :to_binary, :to_binary_s

    def snapshot
      self
    end
  end
end
