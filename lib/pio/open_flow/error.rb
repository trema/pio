module Pio
  module OpenFlow
    # Error message parser
    class Error
      def self.read(binary)
        version = OpenFlowHeaderParser.read(binary).ofp_version
        error_parser = case version
                       when 1
                         Pio::OpenFlow10::Error
                       when 4
                         Pio::OpenFlow13::Error
                       else
                         fail "Unsupported OpenFlow version: #{version}"
                       end
        error_parser.read binary
      end
    end
  end
end
