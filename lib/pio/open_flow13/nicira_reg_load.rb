require 'active_support/core_ext/string/inflections'
require 'pio/open_flow/action'

module Pio
  module OpenFlow13
    # NXAST_REG_LOAD action
    class NiciraRegLoad < OpenFlow::Action
      action_header action_type: 0xffff, action_length: 24
      uint32 :experimenter_id, value: 0x2320
      uint16 :experimenter_type, value: 7
      bit10 :offset_internal, initial_value: 0
      bit6 :n_bits_internal
      uint32 :destination_internal
      uint64 :value_internal

      attr_reader :destination

      # rubocop:disable AbcSize
      # rubocop:disable LineLength
      def initialize(value, destination, options = {})
        @destination = destination
        oxm_klass = Match.const_get(destination.to_s.split('_').map(&:capitalize).join)
        super(value_internal: value,
              offset_internal: options[:offset] || 0,
              n_bits_internal: options[:n_bits] ? options[:n_bits] - 1 : oxm_klass.new.length * 8 - 1,
              destination_internal: ((oxm_klass.superclass.const_get(:OXM_CLASS) << 16) | (oxm_klass.const_get(:OXM_FIELD) << 9) | oxm_klass.new.length))
      end
      # rubocop:enable AbcSize
      # rubocop:enable LineLength

      def offset
        offset_internal
      end

      def n_bits
        n_bits_internal + 1
      end

      def value
        value_internal
      end
    end
  end
end
