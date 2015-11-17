require 'pio/open_flow/action'

module Pio
  module OpenFlow13
    # NXAST_OUTPUT_REG action
    class NiciraSendOutPort < OpenFlow::Action
      action_header action_type: 0xffff, action_length: 24
      uint32 :experimenter_id, value: 0x2320
      uint16 :experimenter_type, value: 15
      bit10 :offset_internal, value: 0
      bit6 :n_bits_internal
      uint32 :source_internal
      uint16 :max_length, value: 0
      string :zero, length: 6

      attr_reader :source

      # rubocop:disable AbcSize
      # rubocop:disable LineLength
      def initialize(source)
        @source = source
        oxm_klass = Match.const_get(source.to_s.split('_').map(&:capitalize).join)
        super(n_bits_internal: oxm_klass.new.length * 8 - 1,
              source_internal: ((oxm_klass.superclass.const_get(:OXM_CLASS) << 16) | (oxm_klass.const_get(:OXM_FIELD) << 9) | oxm_klass.new.length))
      end
      # rubocop:enable AbcSize
      # rubocop:enable LineLength

      def offset
        offset_internal
      end

      def n_bits
        n_bits_internal + 1
      end
    end
  end
end
