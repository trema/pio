# -*- coding: utf-8 -*-
require 'pio/icmp/frame'
require 'pio/icmp/reply'
require 'pio/icmp/request'
require 'pio/message_type_selector'

# Packet parser and generator library.
module Pio
  # Icmp parser and generator.
  class Icmp
    extend MessageTypeSelector
    message_type Request::TYPE => Request, Reply::TYPE => Reply
  end
  ICMP = Icmp
end
