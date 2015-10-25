require 'pio/open_flow'
require 'pio/open_flow10/actions'

# Base module.
module Pio
  module OpenFlow10
    # OpenFlow 1.0 Packet-Out message
    class PacketOut < OpenFlow::Message
      open_flow_header version: 1,
                       message_type: 13,
                       message_length: -> { 16 + actions_len + raw_data.length }
      uint32 :buffer_id
      uint16 :in_port
      uint16 :actions_len, initial_value: -> { actions.binary.length }
      actions :actions, length: -> { actions_len }
      rest :raw_data
    end
  end
end
