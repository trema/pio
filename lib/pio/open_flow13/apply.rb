require 'bindata'
require 'forwardable'

module Pio
  # An instruction to apply a list of actions to a packet in-order.
  class Apply
    # Actions not yet implemented.
    class UnsupportedAction < BinData::Record
      endian :big

      uint16 :action_type
      uint16 :action_length
    end

    # Actions list of actions-apply instruction.
    class Actions < BinData::Primitive
      mandatory_parameter :length

      endian :big

      string :binary, read_length: :length

      def set(value)
        self.binary = [value].flatten.map(&:to_binary).join
      end

      # rubocop:disable MethodLength
      def get
        actions = []
        tmp = binary
        while tmp.length > 0
          action = case BinData::Uint16be.read(tmp)
                   when 0
                     SendOutPort.read(tmp)
                   else
                     UnsupportedAction.read(tmp)
                   end
          tmp = tmp[action.action_length..-1]
          actions << action
        end
        actions
      end
      # rubocop:enable MethodLength
    end

    # OpenFlow 1.3.4 OFPIT_APPLY_ACTIONS instruction format.
    class Format < BinData::Record
      endian :big

      uint16 :instruction_type, value: 4
      uint16 :instruction_length,
             initial_value: -> { 8 + actions.binary.length }
      string :padding, length: 4
      actions :actions, length: -> { instruction_length - 8 }
    end

    def self.read(raw_data)
      allocate.tap do |apply|
        apply.instance_variable_set :@format, Format.read(raw_data)
      end
    end

    extend Forwardable

    def_delegators :@format, :instruction_type
    def_delegators :@format, :instruction_length
    def_delegators :@format, :actions
    def_delegators :@format, :to_binary_s

    def initialize(actions = [])
      @format = Format.new(actions: actions)
    end
  end
end
