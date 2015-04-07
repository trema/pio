require 'bindata'
require 'pio/open_flow/transaction_id'
require 'pio/parse_error'

module Pio
  # OpenFlow 1.3 Hello message parser and generator
  class Hello13
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

    # OpenFlow 1.3 Hello message format
    class Format < BinData::Record
      OFP_VERSION = 4

      endian :big

      uint8 :ofp_version, initial_value: OFP_VERSION
      virtual assert: -> { ofp_version == OFP_VERSION }
      uint8 :message_type
      uint16 :message_length, initial_value: :hello_message_length
      transaction_id :transaction_id
      array :elements, type: :element, read_until: :eof

      def xid
        transaction_id
      end

      def supported_versions
        supported_versions_list.map do |each|
          "open_flow1#{each - 1}".to_sym
        end
      end

      alias_method :to_binary, :to_binary_s

      private

      def hello_message_length
        8 + if elements.empty?
              0
            else
              elements.length * 4 + 4
            end
      end

      def supported_versions_list
        (1..32).each_with_object([]) do |each, result|
          result << each if (version_bitmap >> each & 1) == 1
        end
      end

      def version_bitmap
        bitmap = elements.select(&:version_bitmap?).first
        bitmap ? bitmap.element_value : 0
      end
    end

    # Hello13.new argument
    class Options
      def initialize(user_attrs)
        @attrs = { elements: [{ element_type: 1,
                                element_length: 8,
                                element_value: 16 }] }
        @attrs = @attrs.merge(user_attrs)
        @attrs[:transaction_id] = @attrs.fetch(:xid) if @attrs.key?(:xid)
        unknown_keywords = @attrs.keys - [:transaction_id, :xid, :elements]
        return if unknown_keywords.empty?
        fail "Unknown keyword: #{unknown_keywords.first}"
      end

      def to_h
        @attrs
      end
    end

    def self.read(raw_data)
      allocate.tap do |message|
        message.instance_variable_set(:@format, Format.read(raw_data))
      end
    rescue BinData::ValidityError
      raise Pio::ParseError, 'Invalid Hello 1.3 message.'
    end

    def initialize(attrs = {})
      @format = Format.new(Options.new(attrs).to_h)
    end

    def method_missing(method, *args, &block)
      @format.__send__ method, *args, &block
    end
  end
end
