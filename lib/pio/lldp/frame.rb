require "rubygems"
require "bindata"

require "pio/lldp/chassis-id-tlv"
require "pio/lldp/mac-address"
require "pio/lldp/optional-tlv"
require "pio/lldp/port-id-tlv"
require "pio/lldp/ttl-tlv"


module Pio
  class Lldp
    # LLDP frame
    class Frame < BinData::Record
      endian :big

      mac_address :destination_mac
      mac_address :source_mac
      uint16 :ethertype, :value => 0x88cc
      chassis_id_tlv :chassis_id
      port_id_tlv :port_id
      ttl_tlv :ttl, :initial_value => 120
      array :optional_tlv, :type => :optional_tlv, :read_until => lambda { element.end_of_lldpdu? }


      def dpid
        chassis_id
      end
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
