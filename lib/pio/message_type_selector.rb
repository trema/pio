require 'English'
require 'pio/parse_error'

module Pio
  # Macros for defining message types.
  module MessageTypeSelector
    def message_type(options)
      const_set(:MESSAGE_TYPE, options)
    end

    def read(raw_data)
      format = const_get(:Format).read(raw_data)
      message = const_get(:MESSAGE_TYPE)[format.message_type].allocate
      message.instance_variable_set :@format, format
      message
    rescue
      raise Pio::ParseError, $ERROR_INFO.message
    end
  end
end
