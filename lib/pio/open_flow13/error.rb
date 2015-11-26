require 'pio/open_flow/error_message'
require 'pio/open_flow13/error/bad_request'
require 'pio/open_flow13/error/error_type13'
require 'pio/open_flow13/error/hello_failed'

module Pio
  module OpenFlow13
    # Error message parser
    module Error
      extend OpenFlow::ErrorMessage

      # Error message body parser.
      class BodyParser < BinData::Record
        endian :big
        error_type13 :error_type
        uint16 :error_code
      end
    end
  end
end
