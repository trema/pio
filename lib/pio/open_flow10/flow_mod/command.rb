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
        }.freeze

        endian :big
        uint16 :command

        def get
          COMMANDS.invert.fetch(command)
        end

        def set(value)
          self.command = COMMANDS.fetch(value)
        end
      end
    end
  end
end
