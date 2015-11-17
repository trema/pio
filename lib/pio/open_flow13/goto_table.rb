require 'bindata'
require 'forwardable'

# Base module.
module Pio
  # Resubmit to the table_id
  class GotoTable
    # OpenFlow 1.3.4 OFPIT_GOTO_TABLE instruction format
    class Format < BinData::Record
      endian :big

      uint16 :instruction_type, value: 1
      uint16 :instruction_length, value: 8
      uint8 :table_id
      bit24 :padding
      hide :padding
    end

    def self.read(raw_data)
      allocate.tap do |goto_table|
        goto_table.instance_variable_set :@format, Format.read(raw_data)
      end
    end

    extend Forwardable

    def_delegators :@format, :instruction_type
    def_delegators :@format, :instruction_length
    def_delegators :@format, :table_id
    def_delegators :@format, :to_binary_s
    def_delegator :@format, :to_binary_s, :to_binary

    def initialize(table_id)
      @format = Format.new(table_id: table_id)
    end
  end
end
