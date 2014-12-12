require 'pio/type/mac_address'

module Pio
  class Dhcp
    # Dhcp Client Id Format
    class ClientId < BinData::Primitive
      bit8 :hardwaretype, value: 1
      mac_address :mac

      def get
        mac
      end

      def set(value)
        self.mac = value
      end
    end
  end
end
