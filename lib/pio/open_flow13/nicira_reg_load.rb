# frozen_string_literal: true

require 'pio/open_flow/nicira_action'
require 'pio/open_flow13/match'

module Pio
  module OpenFlow13
    # NXAST_REG_LOAD action
    class NiciraRegLoad < OpenFlow::NiciraAction
      nicira_action_header action_type: 0xffff,
                           action_length: 24,
                           subtype: 7
      bit10 :_offset, initial_value: 0
      bit6 :_n_bits
      struct :_destination do
        uint16 :oxm_class
        bit7 :oxm_field
        bit1 :oxm_hasmask, value: 0
        bit8 :oxm_length
      end
      uint64 :_value

      def initialize(value, destination, options = {})
        @destination = destination
        super(_value: value,
              _offset: options[:offset] || 0,
              _n_bits: (options[:n_bits] || oxm_length * 8) - 1,
              _destination: { oxm_class: oxm_class,
                              oxm_field: oxm_field,
                              oxm_length: oxm_length })
      end

      attr_reader :destination

      def offset
        _offset
      end

      def n_bits
        _n_bits + 1
      end

      def value
        _value
      end

      private

      def oxm_class
        destination_oxm_class.const_get(:OXM_CLASS)
      end

      def oxm_field
        destination_oxm_class.const_get(:OXM_FIELD)
      end

      def oxm_length
        destination_oxm_class.new.length
      end

      def destination_oxm_class
        Match.const_get(@destination.to_s.split('_').map(&:capitalize).join)
      end
    end
  end
end
