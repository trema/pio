require 'bindata'
require 'pio/open_flow/flags'
require 'pio/type/mac_address'

module Pio
  module OpenFlow10
    # Description of a physical port
    class PhyPort16 < BinData::Record
      extend OpenFlow::Flags

      endian :big

      uint16 :number
      mac_address :mac_address
      string :name, length: 16, trim_padding: true
      flags_32bit :config,
                  [:port_down,
                   :no_stp,
                   :no_receive,
                   :no_receive_stp,
                   :no_flood,
                   :no_forward,
                   :no_packet_in]
      flags_32bit :state,
                  link_down: 1 << 0,
                  stp_listen: 0 << 8,
                  stp_learn: 1 << 8,
                  stp_forward: 2 << 8,
                  stp_block: 3 << 8

      define_flags_32bit :port_feature,
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
      port_feature :curr
      port_feature :advertised
      port_feature :supported
      port_feature :peer

      cattr_reader(:length) { 48 }

      attr_accessor :datapath_id
      alias dpid datapath_id
      alias dpid= datapath_id=

      def up?
        !down?
      end

      def down?
        config.include?(:port_down) || state.include?(:link_down)
      end

      def local?
        number == OpenFlow10::Port16.reserved_port_number(:local)
      end
    end
  end
end
