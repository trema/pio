# encoding: utf-8

require 'English'

module Pio
  # Macros for defining message types.
  module MessageTypeSelector
    def message_type(options)
      const_set(:MESSAGE_TYPE, options)
    end

    def read(raw_data)
      parsed = const_get(:Format).read(raw_data)
      const_get(:MESSAGE_TYPE)[parsed.message_type].create_from parsed
    rescue
      raise Pio::ParseError, $ERROR_INFO.message
    end
  end
end
