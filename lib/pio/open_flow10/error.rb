require 'pio/open_flow/error_message'
require 'pio/open_flow10/error/bad_request'
require 'pio/open_flow10/error/error_type10'
require 'pio/open_flow10/error/hello_failed'

module Pio
  module OpenFlow10
    # Error message parser
    module Error
      extend OpenFlow::ErrorMessage

      # Error message body parser.
      class BodyParser < BinData::Record
        endian :big
        error_type10 :error_type
        uint16 :error_code
      end
    end
  end
end
