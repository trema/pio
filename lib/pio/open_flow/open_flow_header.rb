require 'bindata'
require 'pio/open_flow/transaction_id'

module Pio
  # OpenFlow message header.
  class OpenFlowHeader < BinData::Record
    endian :big

    uint8 :ofp_version, value: :ofp_version_value
    virtual assert: -> { ofp_version == ofp_version_value }
    uint8 :message_type, value: :message_type_value
    virtual assert: -> { message_type == message_type_value }
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
