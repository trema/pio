require "pio/type/mac_address"


module Pio
  module Type
    module EthernetHeader
      def ethernet_header options
        class_eval do
          mac_address :destination_mac
          mac_address :source_mac
          uint16 :ether_type, :value => options[ :ether_type ]
        end
      end
    end
  end
end
