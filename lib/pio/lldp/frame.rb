require "rubygems"
require "bindata"

require "pio/lldp/chassis_id_tlv"
require "pio/lldp/optional_tlv"
require "pio/lldp/port_id_tlv"
require "pio/lldp/ttl_tlv"
require "pio/type/ethernet_header"


module Pio
  class Lldp
    # LLDP frame
    class Frame < BinData::Record
      extend Type::EthernetHeader

      endian :big

      ethernet_header :ether_type => 0x88cc
      chassis_id_tlv :chassis_id
      port_id_tlv :port_id
      ttl_tlv :ttl, :initial_value => 120
      array :optional_tlv, :type => :optional_tlv, :read_until => lambda { element.end_of_lldpdu? }


      def dpid
        chassis_id.to_i
      end


      def port_description
        get_tlv_field 4, "port_description"
      end


      def system_name
        get_tlv_field 5, "system_name"
      end


      def system_description
        get_tlv_field 6, "system_description"
      end


      def system_capabilities
        get_tlv 7
      end


      def management_address
        get_tlv_field 8, "management_address"
      end


      def organizationally_specific
        get_tlv 127
      end


      ##########################################################################
      private
      ##########################################################################


      def get_tlv tlv_type
        tlv = optional_tlv.find do | each |
          each[ "tlv_type" ] == tlv_type
        end
        tlv[ "tlv_value" ] if tlv
      end


      def get_tlv_field tlv_type, name
        tlv = get_tlv( tlv_type )
        tlv[ name ] if tlv
      end
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
