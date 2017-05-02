# frozen_string_literal: true

require 'pio/open_flow/action'

module Pio
  module OpenFlow13
    # Sets IP TTL
    class SetIpTtl < OpenFlow::Action
      action_header action_type: 23, action_length: 8
      uint8 :ttl
      string :padding, length: 3

      def initialize(ttl)
        super(ttl: ttl)
      end
    end
  end
end
