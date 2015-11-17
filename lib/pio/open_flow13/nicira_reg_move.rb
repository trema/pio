require 'active_support/core_ext/string/inflections'
require 'pio/open_flow/action'

module Pio
  module OpenFlow13
    # NXAST_REG_MOVE action
    class NiciraRegMove < OpenFlow::Action
      action_header action_type: 0xffff, action_length: 24
      uint32 :experimenter_id, value: 0x2320
      uint16 :experimenter_type, value: 6
      uint16 :n_bits, initial_value: -> { source_oxm_length * 8 }
      uint16 :source_offset, value: 0
      uint16 :destination_offset, value: 0
      uint16 :source_oxm_class
      bit7 :source_oxm_field
      bit1 :source_oxm_hasmask, value: 0
      uint8 :source_oxm_length
      uint16 :destination_oxm_class
      bit7 :destination_oxm_field
      bit1 :destination_oxm_hasmask, value: 0
      uint8 :destination_oxm_length

      attr_reader :from
      attr_reader :to

      # rubocop:disable AbcSize
      def initialize(options)
        @from = options.fetch(:from)
        @to = options.fetch(:to)
        from_klass = Match.const_get(@from.to_s.classify)
        to_klass = Match.const_get(@to.to_s.classify)
        super(source_oxm_class: from_klass.superclass.const_get(:OXM_CLASS),
              source_oxm_field: from_klass.const_get(:OXM_FIELD),
              source_oxm_length: from_klass.new.length,
              destination_oxm_class: to_klass.superclass.const_get(:OXM_CLASS),
              destination_oxm_field: to_klass.const_get(:OXM_FIELD),
              destination_oxm_length: to_klass.new.length)
      end
      # rubocop:enable AbcSize
    end
  end
end
