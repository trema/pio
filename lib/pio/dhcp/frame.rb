# -*- coding: utf-8 -*-

require 'pio/dhcp/const'
require 'pio/type/ethernet_header'
require 'pio/type/ipv4_header'
require 'pio/type/udp_header'
require 'pio/dhcp/dhcp_field'
require 'pio/dhcp/field_util'
require 'pio/dhcp/csum_util'

module Pio
  class Dhcp
    # Dhcp frame parser.
    class Frame < BinData::Record
      extend Type::EthernetHeader
      extend Type::IPv4Header
      extend Type::UdpHeader
      include Consts
      include FieldUtil
      include CsumUtil

      endian :big

      ethernet_header ether_type: ETHER_TYPE_IP
      ipv4_header     ip_protocol: IP_PROTOCOL_UDP,
                      ip_header_checksum: -> { ip_sum },
                      ip_total_length: -> { ip_len }
      udp_header      udp_length: -> { udp_len },
                      udp_checksum: -> { udp_sum }
      dhcp_field      :dhcp

      def ip_sum
        ~((ip_csum & 0xffff) + (ip_csum >> 16)) & 0xffff
      end

      def udp_sum
        ~((udp_csum & 0xffff) + (udp_csum >> 16)) & 0xffff
      end

      def ip_len
        IP_HEADER_LENGTH + udp_len
      end

      def udp_len
        UDP_HEADER_LENGTH + dhcp_len
      end

      def to_binary
        to_binary_s + trail_data
      end

      private

      def dhcp_len
        dhcp.num_bytes + trail_data.bytesize
      end

      def dhcp_binary
        dhcp.to_binary_s
      end

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
