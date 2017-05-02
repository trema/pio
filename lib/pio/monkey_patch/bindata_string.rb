# frozen_string_literal: true

module BinData
  # Add BinData::String#to_bytes
  class String
    def to_bytes
      to_s.unpack('H*').pop.scan(/[0-9a-f]{2}/).map do |each|
        "0x#{each}"
      end.join(', ')
    end
  end
end
