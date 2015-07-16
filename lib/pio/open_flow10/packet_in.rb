require 'pio/ethernet_header'
require 'pio/ipv4_header'
require 'pio/open_flow'
require 'pio/parse_error'
require 'pio/parser'

# Base module.
module Pio
  # This module smells of :reek:UncommunicativeModuleName
  module OpenFlow10
    # OpenFlow 1.0 Packet-In message
    class PacketIn < OpenFlow::Message
      # Why is this packet being sent to the controller?
      # (enum ofp_packet_in_reason)
      class Reason < BinData::Primitive
        REASONS = { no_match: 0, action: 1 }

        uint8 :reason

        def get
          REASONS.invert.fetch(reason)
        end

        def set(value)
          self.reason = REASONS.fetch(value)
        end
      end

      # Message body of Packet-In.
      class Body < BinData::Record
        endian :big

        uint32 :buffer_id
        uint16 :total_len, value: -> { raw_data.length }
        uint16 :in_port
        reason :reason
        uint8 :padding
        hide :padding
        string :raw_data, read_length: :total_len

        def data
          @data ||= Pio::Parser.read(raw_data)
        end

        def empty?
          false
        end

        def length
          10 + raw_data.length
        end

        def lldp?
          data.is_a? Lldp
        end

        def method_missing(method, *args)
          data.__send__(method, *args).snapshot
        end
      end

      # OpenFlow 1.0 Flow Mod message format.
      class Format < BinData::Record
        extend OpenFlow::Format

        header version: 1, message_type: 10
        body :body
      end

      attr_accessor :datapath_id
      alias_method :dpid, :datapath_id
      alias_method :dpid=, :datapath_id=

      body_option :buffer_id
      body_option :in_port
      body_option :reason
      body_option :raw_data
    end
  end
end
