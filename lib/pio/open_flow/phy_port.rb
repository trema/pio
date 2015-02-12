require 'bindata'
require 'pio/type/mac_address'

module Pio
  module Type
    module OpenFlow
      # Description of a physical port
      class PhyPort < BinData::Record
        extend Flags

        # enum ofp_port_config
        flags_32bit :port_config,
                    [:port_down,
                     :no_stp,
                     :no_recv,
                     :no_recv_stp,
                     :no_flood,
                     :no_fwd,
                     :no_packet_in]

        # enum ofp_port_state
        flags_32bit :port_state,
                    link_down: 1 << 0,
                    stp_listen: 0 << 8,
                    stp_learn: 1 << 8,
                    stp_forward: 2 << 8,
                    stp_block: 3 << 8

        # enum ofp_port_features
        flags_32bit :port_feature,
                    [:port_10mb_hd,
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
                     :port_pause_asym]

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

        attr_accessor :datapath_id
        alias_method :dpid, :datapath_id

        def number
          port_no
        end

        def mac_address
          hardware_address
        end

        def up?
          !down?
        end

        def down?
          config.include?(:port_down) || state.include?(:link_down)
        end

        def local?
          port_no == PortNumber::NUMBERS[:local]
        end
      end
    end
  end
end
