require 'bindata'
require 'forwardable'
require 'pio/open_flow'
require 'pio/parse_error'

# Base module.
module Pio
  remove_const :Hello

  # OpenFlow 1.3 Hello message parser and generator
  class Hello
    # ofp_hello_elem_header and value
    class Element < BinData::Record
      VERSION_BITMAP = 1

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

    # OpenFlow 1.3 Hello message format
    class Format < BinData::Record
      extend Forwardable

      endian :big

      open_flow_header :open_flow_header,
                       ofp_version_value: 4, message_type_value: 0
      body :body

      def_delegators :open_flow_header, :ofp_version
      def_delegators :open_flow_header, :message_type
      def_delegators :open_flow_header, :message_length
      def_delegators :open_flow_header, :transaction_id
      def_delegator :open_flow_header, :transaction_id, :xid
      def_delegators :body, :elements

      def supported_versions
        supported_versions_list.map do |each|
          "open_flow1#{each - 1}".to_sym
        end
      end

      alias_method :to_binary, :to_binary_s

      private

      def supported_versions_list
        (1..32).each_with_object([]) do |each, result|
          result << each if (version_bitmap >> each & 1) == 1
        end
      end

      def version_bitmap
        bitmap = elements.find(&:version_bitmap?)
        bitmap ? bitmap.element_value : 0
      end
    end

    def self.read(raw_data)
      allocate.tap do |message|
        message.instance_variable_set(:@format, Format.read(raw_data))
      end
    rescue BinData::ValidityError
      raise Pio::ParseError, 'Invalid Hello 1.3 message.'
    end

    def initialize(user_attrs = {})
      unknown_keywords = user_attrs.keys - [:transaction_id, :xid]
      unless unknown_keywords.empty?
        fail "Unknown keyword: #{unknown_keywords.first}"
      end

      header_attrs = OpenFlowHeader::Options.parse(user_attrs)
      body_attrs = { elements: [{ element_type: 1,
                                  element_length: 8,
                                  element_value: 16 }] }
      @format = Format.new(open_flow_header: header_attrs,
                           body: body_attrs)
    end

    def method_missing(method, *args, &block)
      @format.__send__ method, *args, &block
    end
  end
end
