require 'pio/open_flow/hello_failed_code'
require 'pio/open_flow/format'
require 'pio/open_flow/message'

module Pio
  module OpenFlow10
    # Error Message (Hello Failed).
    class HelloFailed < OpenFlow::Message
      # Error Message (Hello Failed) format.
      class Format < BinData::Record
        # OpenFlow 1.0 Error Message (Hello Failed) body.
        class Body < BinData::Record
          # enum ofp_error_type
          class ErrorType10 < BinData::Primitive
            ERROR_TYPES = {
              hello_failed: 0,
              bad_request: 1,
              bad_action: 2,
              flow_mod_failed: 3,
              port_mod_failed: 4,
              queue_operation_failed: 5
            }

            endian :big
            uint16 :error_type

            def get
              ERROR_TYPES.invert.fetch(error_type)
            end

            def set(value)
              self.error_type = ERROR_TYPES.fetch(value)
            end
          end

          endian :big

          error_type10 :error_type
          hello_failed_code :error_code
          rest :description

          def length
            4 + description.length
          end
        end

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
