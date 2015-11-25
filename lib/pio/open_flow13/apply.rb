require 'bindata'
require 'forwardable'
require 'pio/open_flow/instruction'
require 'pio/open_flow13/actions'

module Pio
  module OpenFlow13
    # An instruction to apply a list of actions to a packet in-order.
    class Apply < OpenFlow::Instruction
      # OpenFlow 1.3.4 OFPIT_APPLY_ACTIONS instruction format.
      class Format < BinData::Record
        endian :big

        uint16 :instruction_type, value: 4
        uint16 :instruction_length,
               initial_value: -> { 8 + actions.binary.length }
        string :padding, length: 4
        actions13 :actions, length: -> { instruction_length - 8 }
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
end
