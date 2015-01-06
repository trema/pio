require 'pio/echo/reply'
require 'pio/echo/request'
require 'pio/open_flow'
require 'pio/open_flow/parser'

module Pio
  # OpenFlow 1.0 Echo Request and Reply message parser.
  class Echo
    KLASS = { Pio::OpenFlow::Type::ECHO_REQUEST => Pio::Echo::Request,
              Pio::OpenFlow::Type::ECHO_REPLY => Pio::Echo::Reply }

    extend Pio::OpenFlow::Parser
  end
end
