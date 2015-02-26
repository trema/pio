require 'bindata'
require 'pio/type/ethernet_header'
require 'pio/type/ipv4_header'
require 'pio/type/udp_header'

module Pio
  # UDP packet format
  class Udp < BinData::Record
    extend Type::EthernetHeader
    extend Type::IPv4Header
    extend Type::UdpHeader

    endian :big

    ethernet_header ether_type: Type::EthernetHeader::ETHER_TYPE_IP
    ipv4_header ip_protocol: Type::IPv4Header::IP_PROTOCOL_UDP,
                ip_total_length: -> { ip_header_length * 4 + udp_length }
    udp_header
    rest :udp_payload
  end
end
