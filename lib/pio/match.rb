require 'bindata'
require 'pio/open_flow'
require 'pio/type/ip_address'
require 'pio/type/mac_address'

module Pio
  # Fields to match against flows
  class Match < BinData::Record
    extend Flags

    def_flags :wildcards,
              in_port: 1 << 0,
              dl_vlan: 1 << 1,
              dl_src: 1 << 2,
              dl_dst: 1 << 3,
              dl_type: 1 << 4,
              nw_proto: 1 << 5,
              tp_src: 1 << 6,
              tp_dst: 1 << 7,
              nw_src_all: 32 << 8,
              nw_dst_all: 32 << 14,
              dl_vlan_pcp: 1 << 20,
              nw_tos: 1 << 21

    endian :big

    wildcards :wildcards
    uint16 :in_port
    mac_address :dl_src
    mac_address :dl_dst
    uint16 :dl_vlan
    uint8 :dl_vlan_pcp
    uint8 :padding1
    hide :padding1
    uint16 :dl_type
    uint8 :nw_tos
    uint8 :nw_proto
    uint16 :padding2
    hide :padding2
    ip_address :nw_src
    ip_address :nw_dst
    uint16 :tp_src
    uint16 :tp_dst
  end
end
