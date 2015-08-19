require 'pio/open_flow/format'
require 'pio/open_flow/hello_failed_code'
require 'pio/open_flow/message'
require 'pio/open_flow10/error/error_type10'

module Pio
  module OpenFlow10
    module Error
      # Hello failed error.
      class HelloFailed < OpenFlow::Message
        # Hello Failed error format.
        class Format < BinData::Record
          # Hello Failed error body.
          class Body < BinData::Record
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
end
