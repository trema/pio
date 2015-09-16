require 'pio/open_flow'
require 'pio/open_flow10/actions'
require 'pio/open_flow10/match'

# Base module.
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

      # Message body of FlowMod.
      class Body < BinData::Record
        extend OpenFlow::Flags

        flags_16bit :flags,
                    [:send_flow_rem,
                     :check_overwrap,
                     :emerg]

        endian :big

        match10 :match
        uint64 :cookie
        command :command
        uint16 :idle_timeout
        uint16 :hard_timeout
        uint16 :priority
        uint32 :buffer_id
        uint16 :out_port
        flags :flags
        actions :actions, length: -> { header.length - 72 }

        def empty?
          false
        end

        def length
          64 + actions.binary.length
        end
      end

      # OpenFlow 1.0 Flow Mod message format.
      class Format < BinData::Record
        extend OpenFlow::Format

        header version: 1, message_type: 14
        body :body
      end

      body_option :actions
      body_option :buffer_id
      body_option :command
      body_option :cookie
      body_option :flags
      body_option :hard_timeout
      body_option :idle_timeout
      body_option :match
      body_option :out_port
      body_option :priority
    end
  end
end
