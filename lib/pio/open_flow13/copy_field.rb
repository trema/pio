require 'active_support/core_ext/string/inflections'
require 'pio/open_flow/action'

module Pio
  module OpenFlow13
    # Copy-field action (ONF extension 320)
    class CopyField < OpenFlow::Action
      action_header action_type: 0xffff, action_length: 32
      uint32 :experimenter_id, value: 0x4f4e4600
      uint16 :experimenter_type, value: 3200
      string :padding1, length: 2
      hide :padding1
      uint16 :n_bits
      uint16 :source_offset, value: 0
      uint16 :destination_offset, value: 0
      string :padding2, length: 2
      hide :padding2
      array :oxm_ids, initial_length: 2 do
        uint16 :oxm_class, value: Match::OXM_CLASS_OPENFLOW_BASIC
        bit7 :oxm_field
        bit1 :oxm_hasmask, value: 0
        uint8 :oxm_length
      end
      string :padding3, length: 4
      hide :padding3

      attr_reader :from
      attr_reader :to

      def initialize(options)
        @from = options.fetch(:from)
        @to = options.fetch(:to)
        from_klass = Match.const_get(@from.to_s.classify)
        to_klass = Match.const_get(@to.to_s.classify)
        super(oxm_ids: [{ oxm_field: from_klass.const_get(:OXM_FIELD),
                          oxm_length: from_klass.new.length },
                        { oxm_field: to_klass.const_get(:OXM_FIELD),
                          oxm_length: to_klass.new.length }])
      end
    end
  end
end
