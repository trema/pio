require 'bindata'

module Pio
  # LLDP frame parser and generator.
  class Lldp
    # Chassis ID TLV
    class ChassisIdTlv < BinData::Primitive
      endian :big

      bit7 :tlv_type, value: 1
      bit9(:tlv_info_length,
           value: -> { subtype.num_bytes + chassis_id.length })
      uint8 :subtype, initial_value: 7
      string(:chassis_id,
             read_length: -> { tlv_info_length - subtype.num_bytes })

      def get
        tmp_chassis_id = chassis_id

        case subtype
        when 4
          mac_address
        when 7
          BinData::Uint64be.read tmp_chassis_id
        else
          tmp_chassis_id
        end
      end

      def set(value)
        self.chassis_id = if subtype == 7
                            BinData::Uint64be.new(value).to_binary_s
                          else
                            value
                          end
      end

      private

      def mac_address
        chassis_id.unpack('C6').map do |each|
          format '%02x', each
        end.join('').hex
      end
    end
  end
end
