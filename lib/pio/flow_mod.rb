require 'pio/match'
require 'pio/open_flow'

module Pio
  # OpenFlow 1.0 flow setup and teardown message.
  class FlowMod < OpenFlow::Message.factory(OpenFlow::Type::FLOW_MOD)
    # enum ofp_flow_mod_command
    class Command < BinData::Primitive
      COMMANDS = { add: 0 }

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
    class FlowModBody < BinData::Record
      extend Flags

      def_flags16 :flags,
                  [:send_flow_rem,
                   :check_overwrap,
                   :emerg]

      endian :big

      match :match, read_length: 40
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
