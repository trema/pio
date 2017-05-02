# frozen_string_literal: true

require 'pio/open_flow/action'

module Pio
  module OpenFlow13
    # Copies TTL "outwards" -- from next-to-outermost to outermost
    class CopyTtlOutwards < OpenFlow::Action
      action_header action_type: 11, action_length: 8
      string :padding, length: 4

      def initialize
        super({})
      end
    end
  end
end
