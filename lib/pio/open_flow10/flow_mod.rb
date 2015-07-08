require 'pio/open_flow'
require 'pio/open_flow10/actions'
require 'pio/open_flow10/match'

# Base module.
module Pio
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
      actions :actions, length: -> { header.message_length - 72 }

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

      header version: 1, message_type: OpenFlow::FLOW_MOD
      body :body
    end

    # rubocop:disable MethodLength
    def initialize(user_options = {})
      header_options = parse_header_options(user_options)
      body_options = if user_options.respond_to?(:fetch)
                       user_options.delete :transaction_id
                       user_options.delete :xid
                       dpid = user_options[:dpid]
                       user_options[:datapath_id] = dpid if dpid
                       user_options
                     else
                       ''
                     end
      @format = Format.new(header: header_options, body: body_options)
    end
    # rubocop:enable MethodLength
  end
end
