require 'pio/open_flow10/match'

module Pio
  module OpenFlow10
    # Pio::MatchFormat wrapper.
    class Match10 < BinData::Primitive
      endian :big

      string :match,
             read_length: 40,
             initial_value: Pio::OpenFlow10::Match.new.to_binary_s

      def set(object)
        self.match = object.to_binary_s
      end

      def get
        Pio::OpenFlow10::Match.read match
      end
    end
  end
end
