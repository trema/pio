require 'pio/open_flow'

module Pio
  module OpenFlow13
    # OpenFlow 1.3 Hello message parser and generator
    class Hello < OpenFlow::Message
      VERSION_BITMAP = 1

      # ofp_hello_elem_header and value
      class Element < BinData::Record
        endian :big

        uint16 :element_type
        uint16 :element_length
        choice :element_value, selection: :chooser do
          string 'unknown', read_length: -> { element_length - 4 }
          uint32 'version_bitmap'
        end

        def version_bitmap?
          element_type == VERSION_BITMAP
        end

        private

        def chooser
          version_bitmap? ? 'version_bitmap' : 'unknown'
        end
      end

      # OpenFlow 1.3 Hello message body.
      class Body < BinData::Record
        array :elements, type: :element, read_until: :eof

        def length
          if elements.empty?
            0
          else
            elements.length * 4 + 4
          end
        end
      end

      open_flow_header version: 4, message_type: 0
      body :body

      def elements
        body.elements
      end

      def supported_versions
        supported_versions_list.map do |each|
          "open_flow1#{each - 1}".to_sym
        end
      end

      private

      def supported_versions_list
        (1..32).each_with_object([]) do |each, result|
          result << each if (version_bitmap >> each & 1) == 1
        end
      end

      def version_bitmap
        bitmap = elements.detect(&:version_bitmap?)
        bitmap ? bitmap.element_value : 0
      end

      def initialize(user_options = {})
        validate_user_options user_options
        body_options = { elements: [{ element_type: VERSION_BITMAP,
                                      element_length: 8,
                                      element_value: 0b10000 }] }
        @format = Format.new(user_options.merge(body: body_options))
      end
    end
  end
end
