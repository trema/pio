# encoding: utf-8

require 'bindata'
require 'forwardable'
require 'pio/features/message'

module Pio
  # OpenFlow 1.0 Features messages
  class Features
    # OpenFlow 1.0 Features Reply message
    class Reply < Message
      # Message body of Features Reply
      class Body < BinData::Record
        endian :big

        uint64 :datapath_id
        uint32 :n_buffers
        uint8 :n_tables
        uint24 :padding
        uint32 :capabilities
        uint32 :actions
        array :ports, type: :phy_port, read_until: :eof
      end

      extend Forwardable

      def_delegators :@format, :ofp_version
      def_delegators :@format, :message_type
      def_delegators :@format, :message_length
      def_delegators :@format, :transaction_id
      def_delegator :@format, :transaction_id, :xid
      def_delegators :@format, :body

      def initialize(user_options = {})
        @options = user_options.dup.merge(datapath_id: user_options[:dpid])
        body = Body.new(@options)
        @format = Format.new(@options.merge(message_type: 6,
                                            body: body.to_binary_s))
      end

      def datapath_id
        @body ||= Body.read(@format.body)
        @body.datapath_id
      end
      alias_method :dpid, :datapath_id

      def n_buffers
        @body ||= Body.read(@format.body)
        @body.n_buffers
      end

      def n_tables
        @body ||= Body.read(@format.body)
        @body.n_tables
      end

      def capabilities
        @body ||= Body.read(@format.body)
        @body.capabilities
      end

      def actions
        @body ||= Body.read(@format.body)
        @body.actions
      end

      def ports
        @body ||= Body.read(@format.body)
        @body.ports
      end
    end
  end
end
