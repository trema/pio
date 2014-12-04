# encoding: utf-8

require 'bindata'
require 'pio/features/message'
require 'pio/open_flow'

module Pio
  # OpenFlow 1.0 Features messages
  class Features
    # OpenFlow 1.0 Features Reply message
    class Reply < Pio::OpenFlow::Message
      # OpenFlow 1.0 Features request message.
      class Format < BinData::Record
        include Pio::OpenFlow::Type

        endian :big

        open_flow_header :open_flow_header, message_type_value: FEATURES_REPLY
        virtual assert: -> { open_flow_header.message_type == FEATURES_REPLY }

        string :body
      end

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

      def initialize(user_options = {})
        @options = user_options.dup.merge(datapath_id: user_options[:dpid])
        body = Body.new(@options)
        @format = Format.new(@options.merge(body: body.to_binary_s))
        @format.open_flow_header.assign(@options.merge(message_type_value: 6))
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
