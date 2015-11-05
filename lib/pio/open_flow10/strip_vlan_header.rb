require 'pio/open_flow/action'

module Pio
  module OpenFlow10
    # An action to strip the 802.1q header.
    class StripVlanHeader < OpenFlow::Action
      action_header action_type: 3, action_length: 8
      string :padding, length: 4
      hide :padding

      def initialize
        super({})
      end
    end
  end
end
