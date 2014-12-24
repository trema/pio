require 'pio/open_flow'
require 'pio/parse_error'

module Pio
  module OpenFlow
    # OpenFlow message parser interface.
    module Parser
      # This method smells of :reek:TooManyStatements
      # This method smells of :reek:FeatureEnvy
      def read(raw_data)
        header = Pio::Type::OpenFlow::OpenFlowHeader.read(raw_data)
        klass = const_get(:KLASS).fetch(header.message_type)
        format = klass.const_get(:Format).read(raw_data)
        message = klass.allocate
        message.instance_variable_set :@format, format
        message
      rescue KeyError
        raise Pio::ParseError, 'Invalid OpenFlow message.'
      end
    end
  end
end
