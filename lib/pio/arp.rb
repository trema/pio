require 'pio/arp/format'
require 'pio/arp/request'
require 'pio/arp/reply'
require 'pio/message_type_selector'

# Packet parser and generator library.
module Pio
  # ARP parser and generator.
  class Arp
    extend MessageTypeSelector
    message_type Request::OPERATION => Request, Reply::OPERATION => Reply
  end
  ARP = Arp
end
