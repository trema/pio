# encoding: utf-8

require 'bindata'

module Pio
  class Hello
    # OpenFlow 1.0 Hello message
    class Format < BinData::Record
      endian :big

      uint8 :version, value: 1
      uint8 :message_type, value: 0
      uint16 :message_length, initial_value: 8
      uint32 :transaction_id
      string :body  # ignored
    end
  end
end
