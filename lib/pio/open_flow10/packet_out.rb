require 'pio/open_flow/message'
require 'pio/open_flow10/actions'

module Pio
  module OpenFlow10
    # OpenFlow 1.0 Packet-Out message
    class PacketOut < OpenFlow::Message
      open_flow_header version: 1,
                       type: 13,
                       length: -> { 16 + actions_length + raw_data.length }
      uint32 :buffer_id
      uint16 :in_port
      uint16 :actions_length, initial_value: -> { actions.binary.length }
      actions10 :actions, length: -> { actions_length }
      rest :raw_data
    end
  end
end
