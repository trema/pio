require 'pio/echo/reply'
require 'pio/echo/request'
require 'pio/open_flow/parser'

module Pio
  # OpenFlow 1.0 Echo Request and Reply message parser.
  module Echo
    extend Pio::OpenFlow::Parser
  end
end
