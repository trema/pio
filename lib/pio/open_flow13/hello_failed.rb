require 'pio/open_flow/hello_failed_code'
require 'pio/open_flow/format'
require 'pio/open_flow/message'

# Base module.
module Pio
  # OpenFlow 1.3 messages
  module OpenFlow13
    # Error Message (Hello Failed).
    class HelloFailed < OpenFlow::Message
      # Error Message (Hello Failed) format.
      class Format < BinData::Record
        # Error Message (Hello Failed) body.
        class Body < BinData::Record
          # enum ofp_error_type
          class ErrorType13 < BinData::Primitive
            ERROR_TYPES = {
              hello_failed: 0,
              bad_request: 1,
              bad_action: 2,
              bad_instruction: 3,
              bad_match: 4,
              flow_mod_failed: 5,
              group_mod_failed: 6,
              port_mod_failed: 7,
              table_mod_failed: 8,
              queue_operation_failed: 9,
              switch_config_failed: 10,
              role_request_failed: 11,
              meter_mod_failed: 12,
              table_features_failed: 13,
              experimenter: 0xffff
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

          error_type13 :error_type
          hello_failed_code :error_code
          rest :description

          def length
            4 + description.length
          end
        end

        extend OpenFlow::Format

        header version: 4, message_type: 1
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
