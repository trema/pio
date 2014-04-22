# encoding: utf-8

require 'pio/features/format'
require 'pio/features/reply'
require 'pio/features/request'
require 'pio/message_type_selector'

module Pio
  # OpenFlow 1.0 Features messages
  class Features
    extend MessageTypeSelector

    REQUEST = 5
    REPLY = 6

    message_type REQUEST => Request, REPLY => Reply
  end
end
