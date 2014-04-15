# encoding: utf-8

require 'bindata'

module Pio
  class Echo
    # OpenFlow 1.0 Echo message format.
    class Format < BinData::Record
      endian :big

      uint8 :version, value: 1
      uint8 :message_type
      uint16 :message_length, value: -> { 8 + data.length }
      uint32 :transaction_id, initial_value: 0
      string :data
    end
  end
end
