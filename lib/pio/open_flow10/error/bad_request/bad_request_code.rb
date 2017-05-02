# frozen_string_literal: true

require 'bindata'

module Pio
  module OpenFlow10
    module Error
      class BadRequest < OpenFlow::Message
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
          }.freeze

          endian :big
          uint16 :error_code

          def get
            ERROR_CODES.invert.fetch(error_code)
          end

          def set(value)
            self.error_code = ERROR_CODES.fetch(value)
          end
        end
      end
    end
  end
end
