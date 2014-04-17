# encoding: utf-8

require 'pio/echo/format'
require 'pio/echo/reply'
require 'pio/echo/request'

module Pio
  # OpenFlow Echo Request and Reply message parser.
  class Echo
    REQUEST = 2
    REPLY = 3

    # Parses +raw_data+ binary string into a Echo message object.
    #
    # @example
    #   Pio::Echo.read("\x01\x02\x00\b\x00\x00\x00\x00")
    # @return [Pio::Echo::Request]
    # @return [Pio::Echo::Reply]
    def self.read(raw_data)
      echo = Echo::Format.read(raw_data)
      case echo.message_type
      when REQUEST
        Echo::Request.create_from(echo)
      when REPLY
        Echo::Reply.create_from(echo)
      else
        fail ParseError, 'Unknown Echo message type.'
      end
    end
  end
end
