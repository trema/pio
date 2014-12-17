require 'pio/features/reply'
require 'pio/features/request'
require 'pio/open_flow'
require 'pio/parse_error'

module Pio
  # OpenFlow 1.0 Features messages
  class Features
    include Pio::OpenFlow::Type

    # @reek This method smells of :reek:TooManyStatements
    def self.read(raw_data)
      header = Pio::Type::OpenFlow::OpenFlowHeader.read(raw_data)
      klass = { FEATURES_REQUEST => Request,
                FEATURES_REPLY => Reply }.fetch(header.message_type)
      format = klass.const_get(:Format).read(raw_data)
      message = klass.allocate
      message.instance_variable_set :@format, format
      message
    rescue KeyError
      raise Pio::ParseError, 'Invalid features request/reply message.'
    end
  end
end
