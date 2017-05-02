# frozen_string_literal: true

module MonkeyPatch
  module Integer
    # to_hex etc.
    module BaseConversions
      def to_hex
        format '0x%02x', self
      end
    end
  end
end
