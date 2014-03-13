# -*- coding: utf-8 -*-
require 'pio/arp/frame'
require 'pio/arp/request'
require 'pio/arp/reply'
require 'pio/message_type_selector'

module Pio
  # ARP parser and generator.
  class Arp
    extend MessageTypeSelector

    message_type Request::OPERATION => Request, Reply::OPERATION => Reply
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
