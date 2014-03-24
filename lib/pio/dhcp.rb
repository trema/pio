# -*- coding: utf-8 -*-
require 'bindata'

require 'pio/dhcp/discover'
require 'pio/dhcp/offer'
require 'pio/dhcp/request'
require 'pio/dhcp/ack'

require 'pio/util'

# Packet parser and generator library.
module Pio
  # Dhcp parser and generator.
  class Dhcp
    MESSAGE_TYPE = {
      Discover::TYPE => Discover,
      Offer::TYPE => Offer,
      Request::TYPE => Request,
      Ack::TYPE => Ack
    }
    class << self
      include Util
    end
  end
  DHCP = Dhcp
end
