module BinData
  # Add BinData::String#to_hex
  class String
    def to_hex
      to_s.unpack('H*').pop.scan(/[0-9a-f]{2}/).map do |each|
        "0x#{each}"
      end.join(', ')
    end
  end
end
