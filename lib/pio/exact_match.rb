require 'pio/match'

module Pio
  # OpenFlow 1.0 exact match
  class ExactMatch
    # rubocop:disable MethodLength
    # rubocop:disable AbcSize
    def initialize(packet_in)
      data = packet_in.data
      case data
      when PacketIn::DataParser::IPv4Packet
        options = {
          in_port: packet_in.in_port,
          ether_source_address: packet_in.source_mac,
          ether_destination_address: packet_in.destination_mac,
          dl_vlan: data.vlan_vid,
          dl_vlan_pcp: data.vlan_pcp,
          ether_type: data.ether_type,
          ip_tos: data.ip_type_of_service,
          ip_protocol: data.ip_protocol,
          ip_source_address: data.ip_source_address,
          ip_destination_address: data.ip_destination_address,
          transport_source_port: data.transport_source_port,
          transport_destination_port: data.transport_destination_port
        }
      when Arp::Request
        options = {
          in_port: packet_in.in_port,
          ether_source_address: packet_in.source_mac,
          ether_destination_address: packet_in.destination_mac,
          dl_vlan: data.vlan_vid,
          dl_vlan_pcp: data.vlan_pcp,
          ether_type: data.ether_type,
          ip_tos: 0,
          ip_protocol: data.operation,
          ip_source_address: data.sender_protocol_address,
          ip_destination_address: data.target_protocol_address,
          transport_source_port: 0,
          transport_destination_port: 0
        }
      end
      @match = Pio::Match.new(options)
    end
    # rubocop:enable MethodLength
    # rubocop:enable AbcSize

    def method_missing(method, *args, &block)
      @match.__send__ method, *args, &block
    end
  end
end
