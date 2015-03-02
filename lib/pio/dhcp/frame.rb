require 'pio/dhcp/dhcp_field'
require 'pio/dhcp/field_util'
require 'pio/ipv4_header'
require 'pio/ethernet_header'
require 'pio/udp_header'

module Pio
  class Dhcp
    # Dhcp frame parser.
    class Frame < BinData::Record
      include FieldUtil

      OPTION_FIELD_LENGTH = 60

      include EthernetHeader
      include IPv4Header
      include UdpHeader

      endian :big
      ethernet_header ether_type: EtherType::IPV4
      ipv4_header ip_protocol: ProtocolNumber::UDP
      udp_header
      dhcp_field :dhcp
      string :padding, read_length: 0, initial_value: :ff_and_padding

      def to_binary
        to_binary_s
      end

      private

      def ff_and_padding
        padding_length = OPTION_FIELD_LENGTH - dhcp.optional_tlvs.num_bytes - 1
        "\xFF" + (padding_length > 0 ? "\x00" * padding_length : '')
      end
    end
  end
end
