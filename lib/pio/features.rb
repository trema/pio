# encoding: utf-8

require 'pio/features/request'
require 'pio/features/format'

module Pio
  # OpenFlow 1.0 Features messages
  class Features
    REQUEST = 5
    REPLY = 6

    # Parses +raw_data+ binary string into a Features message object.
    #
    # @example
    #   Pio::Features.read("\x01\x05\x00\b\x00\x00\x00\x00")
    # @return [Pio::Features::Request]
    # @return [Pio::Features::Reply]
    def self.read(raw_data)
      features = Features::Format.read(raw_data)
      case features.message_type
      when REQUEST
        Features::Request.create_from(features)
      else
        fail ParseError, 'Unknown Features message type.'
      end
    end
  end
end
