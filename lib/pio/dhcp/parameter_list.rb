require 'bindata'

module Pio
  class Dhcp
    # DHCP ParameterList Format.
    class ParameterList < BinData::Primitive
      array :octets,
            type: :uint8,
            initial_length: :tlv_info_length

      def set(value)
        self.octets = value
      end

      def get
        octets
      end
    end
  end
end
