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
              :port_down,
              :no_stp,
              :no_recv,
              :no_recv_stp,
              :no_flood,
              :no_fwd,
              :no_packet_in
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
              :port_10mb_hd,
              :port_10mb_fd,
              :port_100mb_hd,
              :port_100mb_fd,
              :port_1gb_hd,
              :port_1gb_fd,
              :port_10gb_fd,
              :port_copper,
              :port_fiber,
              :port_autoneg,
              :port_pause,
              :port_pause_asym
      end

      # Description of a physical port
      class PhyPort < BinData::Record
        endian :big

        uint16 :port_no
        mac_address :hardware_address
        string :name, read_length: 16, trim_padding: true
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
