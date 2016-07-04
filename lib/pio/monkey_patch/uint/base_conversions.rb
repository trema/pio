module MonkeyPatch
  module Uint
    # to_hex etc.
    module BaseConversions
      def to_hex
        format('%04x', to_i).scan(/.{1,2}/).map { |each| '0x' + each }.join(', ')
      end
    end
  end
end
