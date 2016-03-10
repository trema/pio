require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/string/inflections'

module Pio
  module OpenFlow
    # Error message parser
    module ErrorMessage
      mattr_reader(:type) { 1 }

      # rubocop:disable AbcSize
      def read(binary)
        body = OpenFlow::OpenFlowHeaderParser.read(binary).body
        error = const_get(:BodyParser).read(body)
        klass = error_classes.find do |each|
          each.name.split('::').last.underscore == error.error_type.to_s
        end
        unless klass
          raise 'Unknown error message '\
               "(type=#{error.error_type}, code=#{error.error_code})"
        end
        klass.read binary
      end
      # rubocop:enable AbcSize

      def error_classes
        OpenFlow::Message.descendants.select do |each|
          each.parents.include? parent.const_get(:Error)
        end
      end
    end
  end
end
