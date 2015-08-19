require 'pio/open_flow10/error/error_type10'

module Pio
  module OpenFlow10
    # Error message parser
    module Error
      # Error message body parser.
      class BodyParser < BinData::Record
        endian :big
        error_type10 :error_type
        uint16 :error_code
      end

      def self.read(binary)
        body = OpenFlowHeaderParser.read(binary).body
        klass = case BodyParser.read(body).snapshot.error_type
                when :hello_failed
                  HelloFailed
                when :bad_request
                  BadRequest
                else
                  fail 'Unknown error message.'
                end
        klass.read binary
      end
    end
  end
end
