# encoding: utf-8

require 'bindata'
require 'pio/open_flow'

module Pio
  class Echo
    # OpenFlow 1.0 Echo request and reply message parser.
    class Format < BinData::Record
      include Pio::OpenFlow::Type

      def message_type
        open_flow_header.message_type
      end

      endian :big

      open_flow_header :open_flow_header
      virtual assert: -> { [ECHO_REQUEST, ECHO_REPLY].include?(message_type) }

      string :body
    end
  end
end
