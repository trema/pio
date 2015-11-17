require 'pio/open_flow/nicira_action'
require 'pio/open_flow13/match'

module Pio
  module OpenFlow13
    # NXAST_REG_MOVE action
    class NiciraRegMove < OpenFlow::NiciraAction
      nicira_action_header action_type: 0xffff,
                           action_length: 24,
                           subtype: 6
      uint16 :n_bits, initial_value: -> { _source[:oxm_length] * 8 }
      uint16 :source_offset, initial_value: 0
      uint16 :destination_offset, initial_value: 0
      struct :_source do
        uint16 :oxm_class
        bit7 :oxm_field
        bit1 :oxm_hasmask, value: 0
        uint8 :oxm_length
      end
      struct :_destination do
        uint16 :oxm_class
        bit7 :oxm_field
        bit1 :oxm_hasmask, value: 0
        uint8 :oxm_length
      end

      # rubocop:disable MethodLength
      def initialize(arguments)
        @source = arguments.fetch(:source)
        @destination = arguments.fetch(:destination)
        registers = { _source: { oxm_class: source_oxm_class,
                                 oxm_field: source_oxm_field,
                                 oxm_length: source_oxm_length },
                      _destination: { oxm_class: destination_oxm_class,
                                      oxm_field: destination_oxm_field,
                                      oxm_length: destination_oxm_length } }
        options = [:n_bits,
                   :source_offset,
                   :destination_offset].each_with_object({}) do |each, opts|
          opts[each] = arguments[each] if arguments[each]
        end
        super registers.merge(options)
      end
      # rubocop:enable MethodLength

      attr_reader :source
      attr_reader :destination

      private

      def source_oxm_class
        source_class.const_get(:OXM_CLASS)
      end

      def source_oxm_field
        source_class.const_get(:OXM_FIELD)
      end

      def source_oxm_length
        source_class.new.length
      end

      def source_class
        Match.const_get(@source.to_s.split('_').map(&:capitalize).join)
      end

      def destination_oxm_class
        destination_class.const_get(:OXM_CLASS)
      end

      def destination_oxm_field
        destination_class.const_get(:OXM_FIELD)
      end

      def destination_oxm_length
        destination_class.new.length
      end

      def destination_class
        Match.const_get(@destination.to_s.split('_').map(&:capitalize).join)
      end
    end
  end
end
