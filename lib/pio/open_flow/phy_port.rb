require 'bindata'
require 'pio/type/mac_address'

module Pio
  module Type
    module OpenFlow
      # enum ofp_port_config
      class PortConfig < BinData::Primitive
        extend Flags

        endian :big

        flags :config,
              port_down: 1 << 0,
              no_stp: 1 << 1,
              no_recv: 1 << 2,
              no_recv_stp: 1 << 3,
              no_flood: 1 << 4,
              no_fwd: 1 << 5,
              no_packet_in: 1 << 6
      end

      # enum ofp_port_state
      class PortState < BinData::Primitive
        extend Flags

        endian :big

        flags :state,
              link_down: 1 << 0,
              stp_listen: 0 << 8,
              stp_learn: 1 << 8,
              stp_forward: 2 << 8,
              stp_block: 3 << 8
      end

      # enum ofp_port_features
      class PortFeature < BinData::Primitive
        extend Flags

        endian :big

        flags :features,
              port_10mb_hd: 1 << 0,
              port_10mb_fd: 1 << 1,
              port_100mb_hd: 1 << 2,
              port_100mb_fd: 1 << 3,
              port_1gb_hd: 1 << 4,
              port_1gb_fd: 1 << 5,
              port_10gb_fd: 1 << 6,
              port_copper: 1 << 7,
              port_fiber: 1 << 8,
              port_autoneg: 1 << 9,
              port_pause: 1 << 10,
              port_pause_asym: 1 << 11
      end

      # Description of a physical port
      class PhyPort < BinData::Record
        endian :big

        uint16 :port_no
        mac_address :hardware_address
        string :name, length: 16, trim_padding: true
        port_config :config
        port_state :state
        port_feature :curr
        port_feature :advertised
        port_feature :supported
        port_feature :peer
      end
    end
  end
end
