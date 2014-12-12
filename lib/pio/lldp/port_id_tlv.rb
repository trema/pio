require 'bindata'

module Pio
  class Lldp
    # Port ID TLV
    class PortIdTlv < BinData::Primitive
      endian :big

      bit7 :tlv_type, value: 2
      bit9 :tlv_info_length, initial_value: -> { port_id.num_bytes + 1 }
      uint8 :subtype, initial_value: 7
      string :port_id, read_length: -> { tlv_info_length - 1 }

      def get
        tmp_id = port_id

        if subtype == 7
          BinData::Uint32be.read tmp_id
        else
          tmp_id
        end
      end

      def set(value)
        self.port_id = if subtype == 7
                         BinData::Uint32be.new(value).to_binary_s
                       else
                         value
                       end
      end
    end
  end
end
