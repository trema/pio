require 'pio/open_flow'
require 'pio/open_flow/flags'
require 'pio/open_flow10/actions'
require 'pio/open_flow10/flow_mod/command'
require 'pio/open_flow10/match10'

module Pio
  module OpenFlow10
    # OpenFlow 1.0 Flow Mod message.
    class FlowMod < OpenFlow::Message
      extend OpenFlow::Flags

      flags_16bit :flags,
                  [:send_flow_rem,
                   :check_overwrap,
                   :emerg]

      open_flow_header version: 1,
                       type: 14,
                       length: -> { 72 + actions.binary.length }
      match10 :match
      uint64 :cookie
      command :command
      uint16 :idle_timeout
      uint16 :hard_timeout
      uint16 :priority
      uint32 :buffer_id
      uint16 :out_port
      flags :flags
      actions10 :actions, length: -> { length - 72 }
    end
  end
end
