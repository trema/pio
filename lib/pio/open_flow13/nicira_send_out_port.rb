require 'pio/open_flow/nicira_action'
require 'pio/open_flow13/match'
require 'pio/open_flow13/send_out_port'

module Pio
  module OpenFlow13
    # NXAST_OUTPUT_REG action
    class NiciraSendOutPort < OpenFlow::NiciraAction
      nicira_action_header action_type: 0xffff,
                           action_length: 24,
                           subtype: 15
      bit10 :_offset
      bit6 :_n_bits
      struct :_source do
        uint16 :oxm_class
        bit7 :oxm_field
        bit1 :oxm_hasmask, value: 0
        bit8 :oxm_length
      end
      uint16 :max_length
      string :zero, length: 6

      def initialize(source, options = {})
        @source = source
        super(_n_bits: (options[:n_bits] || oxm_length * 8) - 1,
              _offset: options[:offset] || 0,
              _source: { oxm_class: source_oxm_class.const_get(:OXM_CLASS),
                         oxm_field: source_oxm_class.const_get(:OXM_FIELD),
                         oxm_length: oxm_length },
              max_length: options[:max_length] || SendOutPort::NO_BUFFER)
      end

      attr_reader :source

      def offset
        _offset
      end

      def n_bits
        _n_bits + 1
      end

      private

      def oxm_length
        source_oxm_class.new.length
      end

      def source_oxm_class
        Match.const_get(@source.to_s.split('_').map(&:capitalize).join)
      end
    end
  end
end
