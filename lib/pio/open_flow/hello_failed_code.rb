require 'bindata'

module Pio
  module OpenFlow
    # enum ofp_hello_failed_code
    class HelloFailedCode < BinData::Primitive
      ERROR_CODES = { incompatible: 0, permissions_error: 1 }

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
