# frozen_string_literal: true

require 'pio/open_flow/action'

module Pio
  module OpenFlow13
    # Copies TTL "inwards" -- from outermost to next-to-outermost
    class CopyTtlInwards < OpenFlow::Action
      action_header action_type: 12, action_length: 8
      string :padding, length: 4

      def initialize
        super({})
      end
    end
  end
end
