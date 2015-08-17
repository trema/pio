require 'pio/open_flow/format'
require 'pio/open_flow/message'

module Pio
  module OpenFlow10
    # OpenFlow 1.0 Error Message (Hello Failed).
    class HelloFailed < OpenFlow::Message
      # enum ofp_error_type
      class ErrorType < BinData::Primitive
        ERROR_TYPES = { hello_failed: 0 }

        endian :big
        uint16 :error_type

        def get
          ERROR_TYPES.invert.fetch(error_type)
        end

        def set(value)
          self.error_type = ERROR_TYPES.fetch(value)
        end
      end

      # enum ofp_hello_failed_code
      class HelloFailedCode < BinData::Primitive
        ERROR_CODES = { incompatible: 0, permissions_error: 1 }

        endian :big
        uint16 :error_code

        def get
          ERROR_CODES.invert.fetch(error_code)
        end

        def set(value)
          self.error_code = ERROR_CODES.fetch(value)
        end
      end

      # OpenFlow 1.0 Error Message (Hello Failed) body.
      class Body < BinData::Record
        endian :big

        error_type :error_type
        hello_failed_code :error_code
        rest :description

        def length
          4 + description.length
        end
      end

      # OpenFlow 1.0 Error Message (Hello Failed) format.
      class Format < BinData::Record
        extend OpenFlow::Format

        header version: 1, message_type: 1
        body :body

        def length
          8 + body.length
        end
      end

      body_option :error_code
      body_option :description
    end
  end
end
