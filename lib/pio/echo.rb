# encoding: utf-8

require 'pio/echo/format'
require 'pio/echo/reply'
require 'pio/echo/request'
require 'pio/message_type_selector'
require 'pio/open_flow/type'

module Pio
  # OpenFlow Echo Request and Reply message parser.
  class Echo
    extend MessageTypeSelector

    message_type Pio::OpenFlow::Type::ECHO_REQUEST => Request,
                 Pio::OpenFlow::Type::ECHO_REPLY => Reply
  end
end
