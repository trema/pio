# encoding: utf-8

require 'pio/echo/format'
require 'pio/echo/message'

module Pio
  # OpenFlow Echo Request and Reply message parser.
  class Echo
    # OpenFlow 1.0 Echo Request message.
    class Request < Message
      def initialize(user_options = {})
        super REQUEST, user_options
      end
    end
  end
end
