# encoding: utf-8

require 'pio/echo/format'
require 'pio/echo/reply'
require 'pio/echo/request'
require 'pio/message_type_selector'

module Pio
  # OpenFlow Echo Request and Reply message parser.
  class Echo
    extend MessageTypeSelector

    REQUEST = 2
    REPLY = 3

    message_type REQUEST => Request, REPLY => Reply
  end
end
