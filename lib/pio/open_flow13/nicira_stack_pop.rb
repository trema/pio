# frozen_string_literal: true

require 'pio/open_flow/nicira_action'
require 'pio/open_flow13/match'

module Pio
  module OpenFlow13
    # NXAST_STACK_POP action
    class NiciraStackPop < OpenFlow::NiciraAction
      nicira_action_header action_type: 0xffff,
                           action_length: 24,
                           subtype: 28
      uint16 :_offset
      struct :field do
        uint16 :oxm_class
        bit7 :oxm_field
        bit1 :oxm_hasmask, value: 0
        uint8 :oxm_length
      end
      uint16 :_n_bits
      string :padding, length: 6
      hide :padding

      def initialize(field, options = {})
        @field = field
        super(_offset: options[:offset] || 0,
              _n_bits: (options[:n_bits] || oxm_length * 8) + 1,
              field: { oxm_class: field_oxm_class.const_get(:OXM_CLASS),
                       oxm_field: field_oxm_class.const_get(:OXM_FIELD),
                       oxm_length: oxm_length })
      end

      attr_reader :field
      alias offset _offset

      def n_bits
        _n_bits - 1
      end

      private

      def oxm_length
        field_oxm_class.new.length
      end

      def field_oxm_class
        Match.const_get(@field.to_s.split('_').map(&:capitalize).join)
      end
    end
  end
end
