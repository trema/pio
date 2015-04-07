require 'bindata'
require 'pio/open_flow/transaction_id'

module Pio
  # OpenFlow 1.0 format.
  module OpenFlow
    # OpenFlow 1.0 message header format.
    class OpenFlowHeader < BinData::Record
      endian :big
      uint8 :ofp_version, value: 1
      uint8 :message_type, initial_value: :message_type_value
      uint16 :message_length, initial_value: -> { 8 + body.length }
      transaction_id :transaction_id, initial_value: 0

      # parse header options
      class Options
        def self.parse(options)
          xid = if options.respond_to?(:to_i)
                  options.to_i
                elsif options.respond_to?(:fetch)
                  options[:transaction_id] || options[:xid] || 0
                else
                  fail TypeError
                end
          { transaction_id: xid }
        end
      end
    end
  end
end
