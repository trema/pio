# encoding: utf-8

require 'English'

module Pio
  # Macros for defining message types.
  module MessageTypeSelector
    def message_type(options)
      const_set(:MESSAGE_TYPE, options)
    end

    def read(raw_data)
      begin
        frame = const_get(:Frame).read(raw_data)
      rescue
        raise Pio::ParseError, $ERROR_INFO.message
      end

      const_get(:MESSAGE_TYPE)[frame.message_type].create_from frame
    end
  end
end
