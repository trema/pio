# frozen_string_literal: true

require 'bindata'
require 'pio/ethernet_header'
require 'pio/ipv4_header'
require 'pio/udp_header'

module Pio
  # UDP packet format
  class Udp < BinData::Record
    include Ethernet
    include IPv4
    include UdpHeader

    endian :big
    ethernet_header ether_type: Ethernet::Type::IPV4
    ipv4_header ip_protocol: ProtocolNumber::UDP
    udp_header
    rest :udp_payload
  end
end
