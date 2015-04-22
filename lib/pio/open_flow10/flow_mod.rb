require 'pio/open_flow'
require 'pio/open_flow10/match'

# Base module.
module Pio
  # OpenFlow 1.0 Flow Mod message.
  class FlowMod
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
      # Pio::MatchFormat wrapper.
      class Match < BinData::Primitive
        endian :big

        string :match, read_length: 40

        def set(object)
          self.match = object.to_binary_s
        end

        def get
          Pio::Match.read match
        end
      end

      extend OpenFlow::Flags

      flags_16bit :flags,
                  [:send_flow_rem,
                   :check_overwrap,
                   :emerg]

      endian :big

      match :match
      uint64 :cookie
      command :command
      uint16 :idle_timeout
      uint16 :hard_timeout
      uint16 :priority
      uint32 :buffer_id
      uint16 :out_port
      flags :flags
      actions :actions, length: -> { open_flow_header.message_length - 72 }

      def empty?
        false
      end

      def length
        64 + actions.binary.length
      end
    end
  end

  OpenFlow::Message.factory(FlowMod, OpenFlow::FLOW_MOD) do
    def_delegators :body, :match
    def_delegators :body, :cookie
    def_delegators :body, :command
    def_delegators :body, :idle_timeout
    def_delegators :body, :hard_timeout
    def_delegators :body, :priority
    def_delegators :body, :buffer_id
    def_delegators :body, :out_port
    def_delegators :body, :flags
    def_delegators :body, :actions
  end
end
