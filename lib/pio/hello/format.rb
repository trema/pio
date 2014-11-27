# encoding: utf-8

require 'bindata'
require 'pio/open_flow/type'

module Pio
  class Hello
    # OpenFlow 1.0 Hello message
    class Format < BinData::Record
      endian :big

      uint8 :ofp_version, value: 1
      uint8 :message_type,
            initial_value: OpenFlow::Type::HELLO,
            assert: -> { value == OpenFlow::Type::HELLO }
      uint16 :message_length, initial_value: 8
      uint32 :transaction_id
      string :body  # ignored
    end
  end
end
