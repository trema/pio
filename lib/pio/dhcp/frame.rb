require 'pio/type/ethernet_header'
require 'pio/type/ipv4_header'
require 'pio/type/udp_header'
require 'pio/dhcp/dhcp_field'
require 'pio/dhcp/field_util'
module Pio
  class Dhcp
    # Dhcp frame parser.
    class Frame < BinData::Record
      extend Type::EthernetHeader
      extend Type::IPv4Header
      extend Type::UdpHeader
      include FieldUtil

      DHCP_OPTION_FIELD_LENGTH = 60

      endian :big

      ethernet_header ether_type: Type::EthernetHeader::ETHER_TYPE_IP
      ipv4_header ip_protocol: Type::IPv4Header::IP_PROTOCOL_UDP,
                  ip_total_length: -> { ip_header_length * 4 + udp_length  }
      udp_header
      dhcp_field :dhcp

      def udp_payload
        dhcp.to_binary_s + trail_data
      end

      def to_binary
        to_binary_s + trail_data
      end

      private

      def should_padding?
        option_length < DHCP_OPTION_FIELD_LENGTH
      end

      def option_length
        dhcp.optional_tlvs.num_bytes + 1
      end

      def trail_data
        if should_padding?
          end_of_pdu + padding
        else
          end_of_pdu
        end
      end

      def end_of_pdu
        [0xff].pack('C*')
      end

      def padding
        [0x00].pack('C*') * padding_length
      end

      def padding_length
        DHCP_OPTION_FIELD_LENGTH - option_length
      end
    end
  end
end
