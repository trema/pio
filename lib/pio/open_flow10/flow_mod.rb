require 'pio/open_flow'
require 'pio/open_flow10/actions'
require 'pio/open_flow10/match10'

module Pio
  module OpenFlow10
    # OpenFlow 1.0 Flow Mod message.
    class FlowMod < OpenFlow::Message
      # enum ofp_flow_mod_command
      class Command < BinData::Primitive
        COMMANDS = {
          add: 0,
          modify: 1,
          modify_strict: 2,
          delete: 3,
          delete_strict: 4
        }

        endian :big
        uint16 :command

        def get
          COMMANDS.invert.fetch(command)
        end

        def set(value)
          self.command = COMMANDS.fetch(value)
        end
      end

      extend OpenFlow::Flags

      flags_16bit :flags,
                  [:send_flow_rem,
                   :check_overwrap,
                   :emerg]

      open_flow_header version: 1,
                       message_type: 14,
                       message_length: -> { 72 + actions.binary.length }
      match10 :match
      uint64 :cookie
      command :command
      uint16 :idle_timeout
      uint16 :hard_timeout
      uint16 :priority
      uint32 :buffer_id
      uint16 :out_port
      flags :flags
      actions :actions, length: -> { message_length - 72 }
    end
  end
end
