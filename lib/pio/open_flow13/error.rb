require 'pio/open_flow13/error/error_type13'

module Pio
  module OpenFlow13
    # Error message parser
    module Error
      # Error message body parser.
      class BodyParser < BinData::Record
        endian :big
        error_type13 :error_type
        uint16 :error_code
      end

      # rubocop:disable MethodLength
      def self.read(binary)
        body = OpenFlowHeaderParser.read(binary).body
        error = BodyParser.read(body).snapshot
        klass = case error.error_type
                when :hello_failed
                  HelloFailed
                when :bad_request
                  BadRequest
                else
                  # Not implemented yet
                  fail 'Unknown error message '\
                       "(type=#{error.error_type}, code=#{error.error_code})"
                end
        klass.read binary
      end
      # rubocop:enable MethodLength
    end
  end
end
