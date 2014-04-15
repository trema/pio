# encoding: utf-8

require 'pio/echo/format'
require 'pio/echo/reply'
require 'pio/echo/request'

module Pio
  # OpenFlow Echo Request and Reply message parser.
  class Echo
    REQUEST = 2
    REPLY = 3

    def self.read(raw_data)
      echo = Echo::Format.read(raw_data)
      case echo.message_type
      when REQUEST
        Echo::Request.create_from(echo)
      when REPLY
        Echo::Reply.create_from(echo)
      else
        fail 'Unknown Echo message type.'
      end
    end
  end
end
