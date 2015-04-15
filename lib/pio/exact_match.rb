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
          ether_src_addr: packet_in.source_mac,
          ether_dst_addr: packet_in.destination_mac,
          dl_vlan: data.vlan_vid,
          dl_vlan_pcp: data.vlan_pcp,
          ether_type: data.ether_type,
          nw_tos: data.ip_type_of_service,
          nw_proto: data.ip_protocol,
          nw_src: data.ip_source_address,
          nw_dst: data.ip_destination_address,
          tp_src: data.transport_source_port,
          tp_dst: data.transport_destination_port
        }
      when Arp::Request
        options = {
          in_port: packet_in.in_port,
          ether_src_addr: packet_in.source_mac,
          ether_dst_addr: packet_in.destination_mac,
          dl_vlan: data.vlan_vid,
          dl_vlan_pcp: data.vlan_pcp,
          ether_type: data.ether_type,
          nw_tos: 0,
          nw_proto: data.operation,
          nw_src: data.sender_protocol_address,
          nw_dst: data.target_protocol_address,
          tp_src: 0,
          tp_dst: 0
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
