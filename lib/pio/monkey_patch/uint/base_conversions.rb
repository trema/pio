module MonkeyPatch
  module Uint
    # Uintxxbe#to_hex
    module BaseConversions
      def to_hex
        /Uint(\d+)be$/=~ self.class.name
        nbyte = Regexp.last_match(1).to_i / 4
        format("%0#{nbyte}x", to_i).scan(/.{1,2}/).map do |each|
          '0x' + each
        end.join(', ')
      end
    end
  end
end
