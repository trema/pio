require 'forwardable'
require 'pio/open_flow'
require 'pio/open_flow10/message'

module Pio
  # OpenFlow 1.0 Features Request and Reply message.
  class Features
    # OpenFlow 1.0 Features Request message.
    class Request
      # OpenFlow 1.0 Features Request message
      class Format < BinData::Record
        endian :big

        open_flow_header :header,
                         ofp_version_value: 1,
                         message_type_value: OpenFlow::FEATURES_REQUEST
        virtual assert: -> { header.message_type == OpenFlow::FEATURES_REQUEST }

        string :body
      end

      extend Forwardable

      def_delegators :@format, :snapshot
      def_delegators :snapshot, :header
      def_delegators :header, :ofp_version
      def_delegators :header, :message_type
      def_delegators :header, :message_length
      def_delegators :header, :transaction_id
      def_delegator :header, :transaction_id, :xid

      def_delegators :snapshot, :body
      def_delegator :snapshot, :body, :user_data
      def_delegator :@format, :to_binary_s, :to_binary

      def self.read(raw_data)
        allocate.tap do |message|
          message.instance_variable_set(:@format, Format.read(raw_data))
        end
      rescue BinData::ValidityError
        raise Pio::ParseError, 'Invalid Features Request message.'
      end

      def initialize(user_options = {})
        header_options = OpenFlowHeader::Options.parse(user_options)
        body_options = user_options[:body] || user_options[:user_data] || ''
        @format = Format.new(header: header_options, body: body_options)
      end
    end

    # OpenFlow 1.0 Features Reply message.
    class Reply
      # Message body of features reply.
      class Body < BinData::Record
        extend OpenFlow::Flags

        # enum ofp_capabilities
        flags_32bit :capabilities,
                    [:flow_stats,
                     :table_stats,
                     :port_stats,
                     :stp,
                     :reserved,
                     :ip_reasm,
                     :queue_stats,
                     :arp_match_ip]

        # enum ofp_action_type
        flags_32bit :actions_flag,
                    [:output,
                     :set_vlan_vid,
                     :set_vlan_pcp,
                     :strip_vlan,
                     :set_ether_source_address,
                     :set_ether_destination_address,
                     :set_ip_source_address,
                     :set_ip_destination_address,
                     :set_ip_tos,
                     :set_transport_source_port,
                     :set_transport_destination_port,
                     :enqueue]

        endian :big

        datapath_id :datapath_id
        uint32 :n_buffers
        uint8 :n_tables
        uint24 :padding
        hide :padding
        capabilities :capabilities
        actions_flag :actions
        array :ports, type: :phy_port, read_until: :eof

        def empty?
          false
        end

        def length
          24 + ports.to_binary_s.length
        end
      end
    end

    OpenFlow::Message.factory(Reply, OpenFlow::FEATURES_REPLY) do
      def_delegators :body, :datapath_id
      def_delegator :body, :datapath_id, :dpid
      def_delegators :body, :n_buffers
      def_delegators :body, :n_tables
      def_delegators :body, :capabilities
      def_delegators :body, :actions

      def ports
        @format.snapshot.body.ports.map do |each|
          each.instance_variable_set :@datapath_id, datapath_id
          each
        end
      end

      def physical_ports
        ports.select do |each|
          each.port_no <= PortNumber::MAX
        end
      end
    end
  end
end
