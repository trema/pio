require 'pio/open_flow/message'
require 'pio/open_flow13/error/error_type13'

module Pio
  module OpenFlow13
    module Error
      # Bad request error.
      class BadRequest < OpenFlow::Message
        # enum ofp_bad_request_code
        class BadRequestCode < BinData::Primitive
          ERROR_CODES = {
            bad_version: 0,
            bad_type: 1,
            bad_multipart: 2,
            bad_experimenter: 3,
            bad_experimenter_type: 4,
            permissions_error: 5,
            bad_length: 6,
            buffer_empty: 7,
            buffer_unknown: 8,
            bad_table_id: 9,
            controller_is_slave: 10,
            bad_port: 11,
            bad_packet: 12,
            multipart_buffer_overflow: 13
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

        open_flow_header version: 4,
                         message_type: 1,
                         message_length: -> { 12 + raw_data.length }
        error_type13 :error_type, value: -> { :bad_request }
        bad_request_code :error_code
        rest :raw_data
      end
    end
  end
end
