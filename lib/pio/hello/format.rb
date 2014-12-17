require 'bindata'
require 'pio/open_flow'

module Pio
  class Hello < Pio::OpenFlow::Message
    # OpenFlow 1.0 Hello message parser and generator.
    class Format < BinData::Record
      include Pio::OpenFlow::Type

      endian :big

      open_flow_header :open_flow_header, message_type_value: HELLO
      virtual assert: -> { open_flow_header.message_type == HELLO }

      string :body  # ignored
    end
  end
end
