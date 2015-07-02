module MonkeyPatch
  module Integer
    # Defines Integer#nbit? methods.
    module Ranges
      def unsigned_8bit?
        _within_range? 8
      end

      def unsigned_16bit?
        _within_range? 16
      end

      def unsigned_32bit?
        _within_range? 32
      end

      def unsigned_64bit?
        _within_range? 64
      end

      def _within_range?(nbit)
        (0 <= self) && (self < 2**nbit)
      end
    end
  end
end
