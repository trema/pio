# -*- coding: utf-8 -*-
require 'pio/arp'
require 'pio/lldp'
require 'pio/icmp'

module Pio
  # Raised when the packet data is in wrong format.
  class ParseError < StandardError; end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
