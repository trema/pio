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

        struct :body do
          uint64 :datapath_id
          uint32 :n_buffers
          uint8 :n_tables
          uint24 :padding
          uint32 :capabilities
          uint32 :actions
          array :ports, type: :phy_port, read_until: :eof
        end
      end

      def_delegators :@format, :body
      def_delegators :body, :datapath_id
      def_delegator :body, :datapath_id, :dpid
      def_delegators :body, :n_buffers
      def_delegators :body, :n_tables
      def_delegators :body, :capabilities
      def_delegators :body, :actions
      def_delegators :body, :ports

      def initialize(user_options = {})
        body_options =
          {
            datapath_id: user_options[:dpid],
            n_buffers: user_options[:n_buffers],
            n_tables: user_options[:n_tables],
            capabilities: user_options[:capabilities],
            actions: user_options[:actions],
            ports: user_options[:ports]
          }
        @format = Format.new(user_options.merge(body: body_options))
      end
    end
  end
end
