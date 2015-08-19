require 'pio/open_flow/hello_failed_code'
require 'pio/open_flow/format'
require 'pio/open_flow/message'

# Base module.
module Pio
  # OpenFlow 1.3 messages
  module OpenFlow13
    module Error
      # Hello Failed error message
      class HelloFailed < OpenFlow::Message
        # Hello Failed error format.
        class Format < BinData::Record
          # Hello Failed error body.
          class Body < BinData::Record
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
end
