# encoding: utf-8

require 'pio/features/request'
require 'pio/features/format'

module Pio
  # OpenFlow 1.0 Features messages
  class Features
    REQUEST = 5
    REPLY = 6

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
