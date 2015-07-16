require 'pio/open_flow'
require 'pio/open_flow10/actions'

# Base module.
module Pio
  # This module smells of :reek:UncommunicativeModuleName
  module OpenFlow10
    # OpenFlow 1.0 Packet-Out message
    class PacketOut < OpenFlow::Message
      # OpenFlow 1.0 Flow Mod message format.
      class Format < BinData::Record
        # Message body of Packet-Out
        class Body < BinData::Record
          endian :big

          uint32 :buffer_id
          uint16 :in_port
          uint16 :actions_len, initial_value: -> { actions.binary.length }
          actions :actions, length: -> { actions_len }
          rest :raw_data

          def empty?
            false
          end

          def length
            8 + actions_len + raw_data.length
          end
        end

        extend OpenFlow::Format

        header version: 1, message_type: 13
        body :body
      end

      body_option :buffer_id
      body_option :in_port
      body_option :actions
      body_option :raw_data
    end
  end
end
