# frozen_string_literal: true

require 'active_support/core_ext/object/try'
require 'pio/open_flow'
require 'pio/open_flow13/match'
require 'pio/parser'

module Pio
  module OpenFlow13
    # OpenFlow 1.3 PacketIn message parser and generator
    class PacketIn < OpenFlow::Message
      # Why is this packet being sent to the controller?
      # (enum ofp_packet_in_reason)
      # rubocop:disable LineLength
      class Reason < BinData::Primitive
        REASONS = { no_match: 0, action: 1, invalid_ttl: 2 }.freeze

        uint8 :reason

        def get
          REASONS.invert.fetch(reason)
        end

        def set(value)
          self.reason = REASONS.fetch(value)
        end
      end

      open_flow_header(version: 4, type: 10,
                       length: lambda do
                         24 + match.length + padding.length + raw_data.length
                       end)
      uint32 :buffer_id
      uint16 :total_len, initial_value: -> { raw_data.length }
      reason :reason
      uint8 :table_id
      uint64 :cookie
      oxm :match
      string :padding, length: 2
      hide :padding
      string :raw_data, read_length: -> { length - header_length - (16 + match.length + 2) }

      attr_accessor :datapath_id
      alias dpid datapath_id
      alias dpid= datapath_id=

      def data
        @data ||= Pio::Parser.read(raw_data)
      end

      def in_port
        match.in_port
      end

      def method_missing(method, *args)
        bindata_value = data.__send__(method, *args)
        bindata_value.try(:snapshot) || bindata_value
      end
      # rubocop:enable LineLength
    end
  end
end
