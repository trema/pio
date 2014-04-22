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

      def_delegators :@features, :version
      def_delegators :@features, :message_type
      def_delegators :@features, :message_length
      def_delegators :@features, :transaction_id
      def_delegator :@features, :transaction_id, :xid
      def_delegators :@features, :body

      def initialize(user_options = {})
        @user_options = user_options.dup
      end

      def datapath_id
        @body ||= Body.read(@features.body)
        @body.datapath_id
      end

      def n_buffers
        @body ||= Body.read(@features.body)
        @body.n_buffers
      end

      def n_tables
        @body ||= Body.read(@features.body)
        @body.n_tables
      end

      def capabilities
        @body ||= Body.read(@features.body)
        @body.capabilities
      end

      def actions
        @body ||= Body.read(@features.body)
        @body.actions
      end

      def ports
        @body ||= Body.read(@features.body)
        @body.ports
      end
    end
  end
end
