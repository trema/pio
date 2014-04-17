# encoding: utf-8

require 'bindata'

module Pio
  module Type
    # OpenFlow 1.0 format.
    module OpenFlow
      def openflow_header
        endian :big
        class_eval do
          uint8 :version, value: 1
          uint8 :message_type
          uint16 :message_length, value: -> { 8 + body.length }
          uint32 :transaction_id, initial_value: 0
        end
      end
    end
  end
end
