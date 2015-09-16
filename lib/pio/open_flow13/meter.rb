require 'forwardable'

# Base module.
module Pio
  # Apply meter (rate limiter)
  class Meter
    # OpenFlow 1.3.4 OFPIT_METER instruction format
    class Format < BinData::Record
      endian :big

      uint16 :instruction_type, value: 6
      uint16 :instruction_length, value: 8
      uint32 :meter_id
    end

    def self.read(raw_data)
      allocate.tap do |meter|
        meter.instance_variable_set :@format, Format.read(raw_data)
      end
    end

    extend Forwardable

    def_delegators :@format, :instruction_type
    def_delegators :@format, :instruction_length
    def_delegators :@format, :meter_id
    def_delegators :@format, :to_binary_s

    def initialize(meter_id)
      @format = Format.new(meter_id: meter_id)
    end
  end
end
