require 'pio/open_flow'
require 'pio/open_flow13/buffer_id'
require 'pio/open_flow13/match'

module Pio
  module OpenFlow13
    # OpenFlow 1.3 FlowMod message parser and generator
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

        uint8 :command

        def get
          COMMANDS.invert.fetch(command)
        end

        def set(value)
          self.command = COMMANDS.fetch(value)
        end
      end

      # For delete commands, require matching entries to include this as
      # an output port.
      class OutPort < BinData::Primitive
        ANY = 0xffffffff

        endian :big
        uint32 :out_port, initial_value: ANY

        def get
          (out_port == ANY) ? :any : out_port
        end

        def set(value)
          self.out_port = (value == :any ? ANY : value)
        end
      end

      # For delete commands, require matching entries to include this as
      # an output group.
      class OutGroup < BinData::Primitive
        ANY = 0xffffffff

        endian :big
        uint32 :out_group, initial_value: ANY

        def get
          (out_group == ANY) ? :any : out_group
        end

        def set(value)
          self.out_group = (value == :any ? ANY : value)
        end
      end

      # OpenFlow 1.3 instructions
      class Instructions < BinData::Primitive
        endian :big

        count_bytes_remaining :instructions_length
        string :instructions, read_length: :instructions_length

        def set(instructions)
          self.instructions = Array(instructions).map(&:to_binary_s).join
        end

        # rubocop:disable MethodLength
        def get
          list = []
          tmp = instructions
          while tmp.length > 0
            instruction_type = BinData::Uint16be.read(tmp)
            instruction = case instruction_type
                          when 1
                            GotoTable.read(tmp)
                          when 2
                            WriteMetadata.read(tmp)
                          when 4
                            Apply.read(tmp)
                          when 6
                            Meter.read(tmp)
                          else
                            fail "Unsupported instruction #{instruction_type}"
                          end
            tmp = tmp[instruction.instruction_length..-1]
            list << instruction
          end
          list
        end
        # rubocop:enable MethodLength

        def length
          instructions.length
        end
      end

      extend OpenFlow::Flags

      flags_16bit :flags,
                  [:send_flow_rem,
                   :check_overwrap,
                   :reset_counts,
                   :no_packet_counts,
                   :no_byte_counts]

      open_flow_header(version: 4,
                       message_type: 14,
                       message_length: lambda do
                         48 + match.length + instructions.length
                       end)
      uint64 :cookie
      uint64 :cookie_mask
      uint8 :table_id
      command :command
      uint16 :idle_timeout
      uint16 :hard_timeout
      uint16 :priority, initial_value: 0xffff
      buffer_id :buffer_id
      out_port :out_port
      out_group :out_group
      flags :flags
      string :padding, length: 2
      hide :padding
      oxm :match
      instructions :instructions
    end
  end
end
