# -*- coding: utf-8 -*-
require 'pio/icmp/frame'
require 'pio/icmp/reply'
require 'pio/icmp/request'
require 'pio/message_type_selector'

module Pio
  # Icmp parser and generator.
  class Icmp
    extend MessageTypeSelector

    message_type Request::TYPE => Request, Reply::TYPE => Reply
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
