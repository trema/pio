# frozen_string_literal: true

module MonkeyPatch
  module Uint
    # Uint8#to_bytes, Uintxxbe#to_bytes
    module BaseConversions
      def to_bytes
        /Uint(8|\d+be)$/=~ self.class.name
        nbyte = Regexp.last_match(1).to_i / 4
        format("%0#{nbyte}x", to_i).scan(/.{1,2}/).map do |each|
          '0x' + each
        end.join(', ')
      end
    end
  end
end
