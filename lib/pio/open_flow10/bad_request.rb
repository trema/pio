require 'bindata'
require 'pio/open_flow/format'
require 'pio/open_flow/message'
require 'pio/open_flow10/error_type10'

module Pio
  module OpenFlow10
    module Error
      # Bad request error.
      class BadRequest < OpenFlow::Message
        # Bad request error format.
        class Format < BinData::Record
          # Bad request error body.
          class Body < BinData::Record
            # enum ofp_bad_request_code
            class BadRequestCode < BinData::Primitive
              ERROR_CODES = {
                bad_version: 0,
                bad_type: 1,
                bad_stats: 2,
                bad_vendor: 3,
                bad_subtype: 4,
                permissions_error: 5,
                bad_length: 6,
                buffer_empty: 7,
                buffer_unknown: 8
              }

              endian :big
              uint16 :error_code

              def get
                ERROR_CODES.invert.fetch(error_code)
              end

              def set(value)
                self.error_code = ERROR_CODES.fetch(value)
              end
            end

            endian :big

            error_type10 :error_type, value: -> { :bad_request }
            bad_request_code :error_code
            rest :raw_data

            def length
              4 + raw_data.length
            end
          end

          extend OpenFlow::Format

          header version: 1, message_type: 1
          body :body

          def length
            8 + body.length
          end
        end

        body_option :raw_data
      end
    end
  end
end
