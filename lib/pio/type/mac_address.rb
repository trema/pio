# frozen_string_literal: true

require 'bindata'
require 'pio/mac'
require 'pio/monkey_patch/integer'
require 'pio/monkey_patch/uint'

module Pio
  module Type
    # MAC address
    class MacAddress < BinData::Primitive
      array :octets, type: :uint8, initial_length: 6

      def set(value)
        self.octets = Mac.new(value).to_a
      end

      def get
        Mac.new(octets.reduce('') do |str, each|
                  str + format('%02x', each)
                end.hex)
      end

      def to_bytes
        octets.map(&:to_hex).join(', ')
      end

      def inspect
        %("#{get}")
      end
    end
  end
end
